library(targets)
tar_source()
tar_option_set(
  packages = "tidyverse",
  controller = crew::crew_controller_local(workers = 8)
)

list(
  tar_target(file_data, "data/written.xlsx"),
  tar_target(data, load_all_sheets(file_data)),
  tar_target(data_clean, clean_data(data))
)
