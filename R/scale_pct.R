#' @export
scale_x_pct <- function(...) {
  args <- list(...)
  args$axis <- "x"
  structure(
    args,
    class = "pct_scale"
  )
}

#' @export
scale_y_pct <- function(...) {
  args <- list(...)
  args$axis <- "y"
  structure(
    args,
    class = "pct_scale"
  )
}

#' @export
ggplot_add.pct_scale <- function(object, plot, object_name) {
  data <- plot[["data"]]
  var <- plot[["mapping"]][[object$axis]]
  if (object$axis == "x") {
    scale <- ggplot2::scale_x_continuous
  } else {
    scale <- ggplot2::scale_y_continuous
  }
  r <- range(rlang::eval_tidy(var, data), na.rm = TRUE)

  if (r[1] < 0 || r[2] > 100) {
    rlang::abort("Values must be in [0, 1] or [0, 100].")
  }

  if (exists("breaks", object)) {
    if (r[2] <= 1) {
      breaks <- object[["breaks"]] * 100
    } else {
      breaks <- object[["breaks"]]
    }
  } else {
    if (r[2] <= 1) {
      breaks <- labeling::extended(r[1] * 100, r[2] * 100, m = 5)
    } else {
      breaks <- labeling::extended(r[1], r[2], m = 5)
    }
  }

  accuracy <- 1 / (10^max_n_digits(breaks))

  args <- object[names(object) != "axis"]
  if (r[2] <= 1) {
    args$labels <- scales::percent_format(accuracy, 100)
  } else {
    args$labels <- scales::percent_format(accuracy, 1)
  }

  plot + do.call(scale, args)
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
