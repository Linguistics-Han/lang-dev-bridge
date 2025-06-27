library(targets)
tar_source()
tar_option_set(
  packages = "tidyverse",
  controller = crew::crew_controller_local(workers = 8)
)

list(
  tarchetypes::tar_file_read(
    vars_config,
    "data/groups.csv",
    read = read_csv(!!.x, show_col_types = FALSE)
  ),
  tar_target(file_data, "data/written.xlsx"),
  tar_target(data, load_all_sheets(file_data)),
  tar_target(data_clean, clean_data(data)),
  tar_target(
    avg_perf,
    data_clean |>
      summarise(
        across(all_of(vars_config$variable), mean),
        .by = c(time, SID)
      )
  )
)
