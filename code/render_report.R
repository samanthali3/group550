print(here::here())
here::i_am("code/render_report.R")

library(rmarkdown)

rmarkdown::render(
  here::here("report.Rmd")
)