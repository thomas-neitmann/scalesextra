#' @export
scale_x_pct <- function(...) {
  ggplot2::scale_x_continuous(..., labels = pct)
}

#' @export
scale_y_pct <- function(...) {
  ggplot2::scale_y_continuous(..., labels = pct)
}

pct <- function() {
  scales::percent_format(scale = 1, accuracy = 1)
}
