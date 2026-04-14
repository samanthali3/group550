library(readxl)
library(ggplot2)
library(rstatix)
library(dplyr)
library(broom)
library(labelled)
library(gtsummary)
library(gt)

here::i_am("code/sl_code/02_sl_plot.R")
print(here::here())

data <- read_excel(here::here("data/nba_data.xlsx"))

boxplot <- ggplot(data, aes(x = Pos, y = `3PA`, fill = Pos))+
  geom_boxplot()+
  labs(title = "3-Point Field Goal Attempts by Position",
       x = "Position",
       y = "3-Point Field Goal Attempts")

saveRDS(
  boxplot,
  file = here::here("output/sl_output/boxplot.rds")
)