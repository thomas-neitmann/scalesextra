#' @export
scale_x_pretty <- function(...) {
  ggplot2::scale_x_continuous(..., labels = pretty)
}

#' @export
scale_y_pretty <- function(...) {
  ggplot2::scale_y_continuous(..., labels = pretty)
}

pretty <- function(x) {
  prettyNum(x, big.mark = ",", decimal.mark = ".", scientific = FALSE)
}

#' @export
scale_x_pretty2 <- function(...) {
  ggplot2::scale_x_continuous(..., labels = pretty2)
}

#' @export
scale_y_pretty2 <- function(...) {
  ggplot2::scale_y_continuous(..., labels = pretty2)
}

pretty2 <- function(x, digits = 0) {
  prettyNum(x, big.mark = " ", decimal.mark = ",", scientific = FALSE)
}
