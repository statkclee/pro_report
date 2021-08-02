# 라이브러리 환경설정

library(DBI)
library(glue)
library(here)
library(janitor)
library(kableExtra)
library(lubridate)
library(RSQLite)
library(scales)
library(tidyverse)


# 1. 외부 BMI 데이터 -------------------------------------------------

bmi_tbl <- read_csv("database/500_Person_Gender_Height_Weight_Index.csv")

# 2. 데이터베이스 생성 ----------------------------------------------------

conn <- dbConnect(SQLite(), dbname="database/bmi_database.sqlite")

# 3. 테이블 넣기 ---------------------------------------------------------------

DBI::dbWriteTable(conn = conn, name = "bmi",  value = bmi_tbl, overwrite = TRUE)

dbDisconnect(conn)

# 4. DB 테스트 ---------------------------------------------------------------

# BMI db 연결 -------------------------------------------------

conn <- DBI::dbConnect(RSQLite::SQLite(), dbname = glue::glue("{here::here()}/database/bmi_database.sqlite"))


# 성별 데이터 입력값 추출 ----------------------------------------------------

gender_input <- DBI::dbReadTable(conn = conn,
                                   name = "bmi") %>%
  dplyr::select(Gender) %>%
  dplyr::distinct()

dbDisconnect(conn)

