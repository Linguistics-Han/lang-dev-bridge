load_all_sheets <- function(file_xlsx) {
  readxl::excel_sheets(file_xlsx) |>
    sapply(
      readxl::read_excel,
      path = file_xlsx,
      na = c("", "NA"),
      simplify = FALSE,
      USE.NAMES = TRUE
    ) |>
    list_rbind(names_to = "time")
}

clean_data <- function(data) {
  data |>
    filter(!if_all(!c(time, IID, SID), is.na)) |>
    mutate(
      across(!c(time, IID, SID), \(x) coalesce(x, 0)),
      time = parse_number(time)
    )
}
