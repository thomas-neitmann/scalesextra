#' @export
scale_x_pct <- function(...) {
  ggplot2::scale_x_continuous(..., labels = pct)
}

#' @export
scale_y_pct <- function(...) {
  ggplot2::scale_y_continuous(..., labels = pct)
}

pct <- function(x) {
  r <- range(x, na.rm = TRUE)
  if (r[1] < 0 || r[2] > 100) {
    rlang::abort("Values must be in [0, 1] or [0, 100].")
  }

  if (r[2] <= 1) {
    breaks <- x * 100
  } else {
    breaks <- x
  }

  accuracy <- 1 / (10^max_n_digits(breaks))
  if (r[2] <= 1) {
    f <- scales::percent_format(accuracy, 100)
  } else {
    f <- scales::percent_format(accuracy, 1)
  }
  f(x)
}

max_n_digits <- function(x) {
  decimal_values <- x %>%
    as.character() %>%
    strsplit("\\.") %>%
    vapply(`[`, character(1), 2)

  if (all(is.na(decimal_values))) {
    return(0)
  } else {
    decimal_values <- decimal_values[!is.na(decimal_values)]
  }

  decimal_values %>%
    nchar() %>%
    as.numeric() %>%
    max(na.rm = TRUE)
}
