#' @export
scale_x_pretty <- function(...) {
  ggplot2::scale_x_continuous(..., labels = pretty)
}

#' @export
scale_y_pretty <- function(...) {
  ggplot2::scale_y_continuous(..., labels = pretty)
}

pretty <- function(x) {
  max_x <- max(x, na.rm = TRUE)
  f <- function(x) {
    format(x, big.mark = ",", decimal.mark = ".", scientific = FALSE)
  }
  if (max_x >= 1e9) {
    return(paste(f(x / 1e9), "Bn."))
  } else if (max_x >= 1e6) {
    return(paste(f(x / 1e6), "Mn."))
  } else {
    return(f(x))
  }
}

#' @export
scale_x_pretty2 <- function(...) {
  ggplot2::scale_x_continuous(..., labels = pretty2)
}

#' @export
scale_y_pretty2 <- function(...) {
  ggplot2::scale_y_continuous(..., labels = pretty2)
}

pretty2 <- function(x) {
  max_x <- max(x, na.rm = TRUE)
  f <- function(x) {
    format(x, big.mark = ",", decimal.mark = ".", scientific = FALSE)
  }
  if (max_x >= 1e9) {
    return(paste(f(x / 1e9), "Bn."))
  } else if (max_x >= 1e6) {
    return(paste(f(x / 1e6), "Mn."))
  } else {
    return(f(x))
  }
}
