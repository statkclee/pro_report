
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


# Set up connection to db -------------------------------------------------

bmi_database <- DBI::dbConnect(RSQLite::SQLite(), dbname = glue::glue("{here::here()}/database/bmi_database.sqlite"))


# 성별 데이터 입력값 추출 ----------------------------------------------------

gender_input <- DBI::dbReadTable(conn = bmi_database,
                                 name = "bmi") %>%
  dplyr::select(Gender) %>%
  dplyr::distinct()


