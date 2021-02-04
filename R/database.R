# Fake 데이터를 생성하고 이를 정제하여 RDBMS에 저장하는 역할 수행.

# 라이브러리 환경설정

library(DBI)
library(glue)
library(here)
library(janitor)
library(kableExtra)
library(lubridate)
library(maps)
library(RSQLite)
library(scales)
library(sf)
library(tidyverse)
library(reticulate)


# 데이터 생성 -------------------------------------------------

## 파이썬 라이브러리 데이터 생성
source_python('R/create_customer.py')
source_python('R/create_stock.py')

## 데이터 정제작업
### 고객 정보
customer_tbl <- read_delim("database/customer.csv", delim = "|") %>% 
  select(name, job, ssn, sex, address, mail, company)

samsung_tbl <- read_delim("database/stock_samsung.csv", delim = "|")
apple_tbl   <- read_delim("database/stock_apple.csv", delim = "|")
aws_tbl     <- read_delim("database/stock_aws.csv", delim = "|")

### 주가정보
stock_tbl <- samsung_tbl %>% 
  select(date = Date, samsung = Open) %>% 
  left_join(
    apple_tbl %>% 
      select(date = Date, apple = Open)
  ) %>% 
  left_join(
    aws_tbl %>% 
      select(date = Date, aws = Open)
  )

stock_tbl <- stock_tbl %>% 
  pivot_longer(cols = -date, names_to = "stock", values_to = "price")

### 주식 보유현황
set.seed(777)
investment_tbl <- tibble(name    = customer_tbl %>% select(name) %>% pull,
                         samsung = runif(nrow(customer_tbl), 0, 100) %>% round(., digits =0),
                         apple   = runif(nrow(customer_tbl), 0, 100) %>% round(., digits =0),
                         aws     = runif(nrow(customer_tbl), 0, 100) %>% round(., digits =0)) %>% 
  mutate(samsung = ifelse(samsung < 70, 0, samsung),
         apple   = ifelse(apple   < 70, 0, apple),
         aws     = ifelse(aws     < 70, 0, aws))

investment_tbl <- investment_tbl %>% 
  pivot_longer(cols = -name, names_to = "stock", values_to = "shares")


# 데이터베이스 입력 ----------------------------------------------------

## 데이터베이스 생성 ---------------------------------------------------------------

conn <- dbConnect(SQLite(), dbname="database/report_database.sqlite")

# 테이블 넣기 ---------------------------------------------------------------

DBI::dbWriteTable(conn = conn, name = "customer",  value = customer_tbl, overwrite = TRUE)
DBI::dbWriteTable(conn = conn, name = "stock",     value = stock_tbl, overwrite = TRUE)
DBI::dbWriteTable(conn = conn, name = "investment", value = investment_tbl, overwrite = TRUE)

dbDisconnect(conn)