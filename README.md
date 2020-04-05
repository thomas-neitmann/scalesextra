scalesextra
================

[![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

Overview
--------

`scalesextra` aims to make it a no brainer to customize `ggplot2` scales.

Installation
------------

The package is an a very early development stage and thus only available from GitHub.

``` r
if (!"remotes" %in% installed.packages()) {
  install.packages("remotes")
}
remotes::install_github("thomas-neitmann/scalesextra")
```

Usage
-----

``` r
library(dplyr)
library(ggcharts)
data(mtcars)

cyl <- mtcars %>%
  count(cyl) %>%
  mutate(pct = n / sum(n) * 100)

(p <- bar_chart(cyl, cyl, pct))
p + scalesextra::scale_y_pct()
```

<img src="README_files/figure-markdown_github/scale_pct-1.png" width="50%" /><img src="README_files/figure-markdown_github/scale_pct-2.png" width="50%" />

``` r
library(gapminder)
data(gapminder)

(p <- gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(pop, gdpPercap)) +
  geom_point())
p + scalesextra::scale_x_pretty() + scalesextra::scale_y_pretty()
```

<img src="README_files/figure-markdown_github/scale_pretty-1.png" width="50%" /><img src="README_files/figure-markdown_github/scale_pretty-2.png" width="50%" />

``` r
data(biomedicalrevenue)

(p <- biomedicalrevenue %>%
  filter(company == "Roche") %>%
  ggplot(aes(year, revenue)) +
  geom_col())
p + scalesextra::scale_y_tight()
```

<img src="README_files/figure-markdown_github/scale_tight-1.png" width="50%" /><img src="README_files/figure-markdown_github/scale_tight-2.png" width="50%" />
