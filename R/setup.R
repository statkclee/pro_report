
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

conn <- DBI::dbConnect(RSQLite::SQLite(), dbname = glue::glue("{here::here()}/database/report_database.sqlite"))


# Get data to map over ----------------------------------------------------

customer_input <- DBI::dbReadTable(conn = conn,
                               name = "customer") %>%
  dplyr::select(name) %>%
  dplyr::distinct()


# input_data <- DBI::dbReadTable(conn = db,
#                                name = "financials") %>% 
#   dplyr::select(branch) %>% 
#   dplyr::distinct()
