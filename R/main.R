# 환경설정 ------------------------------------------------------

source(here::here("R/setup.R"))

# Iterator functions ------------------------------------------------------

create_reports <- function(...) {
  
  current <- tibble::tibble(...)
  
  loc <- here::here("R/rmarkdown/report_master.Rmd")
  
  rmarkdown::render(
    input = loc,
    output_file = paste0("report_", current$name,".pdf"),
    # output_file = "report_ver_1.pdf",
    output_dir = paste0("finished_reports"),
    intermediates_dir = glue::glue("{here::here()}/temp"),
    clean = TRUE,
    params = list(customer_name = current$name)
  )
  
}

# Wrap our fn in the possibly function, to catch errors

maybe_create_reports <- purrr::possibly(.f = create_reports, otherwise = NULL)

# Main iterator -----------------------------------------------------------

# maybe_create_reports()

customer_input %>%
  purrr::pwalk(maybe_create_reports)