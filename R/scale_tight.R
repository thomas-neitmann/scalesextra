#' @export
scale_x_tight <- function(...) {
  ggplot2::scale_x_continuous(..., expand = tight())
}

#' @export
scale_y_tight <- function(...) {
  ggplot2::scale_y_continuous(..., expand = tight())
}

tight <- function() {
  ggplot2::expand_scale(mult = c(0, .05))
}
