
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

# db <- DBI::dbConnect(RSQLite::SQLite(), dbname="database/prod.sqlite")


# Get data to map over ----------------------------------------------------

# input_data <- DBI::dbReadTable(conn = db,
#                                name = "financials") %>% 
#   dplyr::select(branch) %>% 
#   dplyr::distinct()
