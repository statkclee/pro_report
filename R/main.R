# 환경설정 ------------------------------------------------------

source(here::here("R/setup.R"))

# Iterator functions ------------------------------------------------------

create_reports <- function(...) {
  
  current <- tibble::tibble(...)
  
  loc <- here::here("R/rmarkdown/report_master.Rmd")
  
  rmarkdown::render(
    input = loc,
    output_dir = paste0("finished_reports"),
    output_file = glue::glue("bmi_report.pdf"),
    intermediates_dir = glue::glue("{here::here()}/temp"),
    clean = TRUE
  )
}

# Wrap our fn in the possibly function, to catch errors

maybe_create_reports <- purrr::possibly(.f = create_reports, otherwise = NULL)

# Main iterator -----------------------------------------------------------

# maybe_create_reports()

gender_input %>%
  purrr::pwalk(maybe_create_reports)
