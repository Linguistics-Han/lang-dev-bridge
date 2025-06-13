create_graphs <- function(data, trans = c("rel", "abs")) {
  calc_dist <- switch(
    trans,
    rel = \(x) sqrt(1 - cor(x)),
    abs = \(x) sqrt(1 - cor(x)^2),
  )
  as_graph <- function(x) {
    igraph::graph_from_adjacency_matrix(
      x,
      mode = "undirected",
      weighted = TRUE,
      diag = FALSE
    )
  }
  data |>
    select(-SID) |>
    nest(.by = time) |>
    mutate(data = map(data, calc_dist)) |>
    mutate(graph = map(data, as_graph))
}
