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
    scale <- scale_x_continuous
  } else {
    scale <- scale_y_continuous
  }
  r <- range(rlang::eval_tidy(var, data), na.rm = TRUE)

  if (r[1] < 0 || r[2] > 100) {
    rlang::abort("Values must be in [0, 1] or [0, 100].")
  }

  as_pct <- function(scale = 100) {
    function(x) paste0(x * scale, "%")
  }

  if (exists("breaks", object)) {
    breaks <- object[["breaks"]]
  } else {
    breaks <- labeling::extended(r[1], r[2], m = 5)
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
  max <- x %>%
    as.character() %>%
    strsplit("\\.") %>%
    vapply(`[`, character(1), 2) %>%
    nchar() %>%
    as.numeric() %>%
    max(na.rm = TRUE)
  if (!is.finite(max)) {
    return(0)
  }
  max
}
