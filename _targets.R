library(targets)
tar_source()
tar_option_set(
  packages = "tidyverse",
  controller = crew::crew_controller_local(workers = 8)
)

list(
  tar_target(file_data, "data/written.xlsx"),
  tar_target(data, load_all_sheets(file_data)),
  tar_target(data_clean, clean_data(data)),
  tar_target(
    avg_perf,
    data_clean |>
      summarise(
        across(T长度:type短语结构类型, mean),
        .by = c(time, SID)
      )
  ),
  tarchetypes::tar_map(
    tibble::tibble(name = c("rel", "abs")),
    tar_target(
      graphs,
      create_graphs(avg_perf, trans = name)
    )
  )
)
