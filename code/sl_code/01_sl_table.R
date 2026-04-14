library(readxl)
library(ggplot2)
library(rstatix)
library(dplyr)
library(broom)
library(labelled)
library(gtsummary)
library(gt)

here::i_am("code/sl_code/01_sl_table.R")
print(here::here())

data <- read_excel(here::here("data/nba_data.xlsx"))

#renaming variables to be consistent/look nice
var_label(data) <- list(
  Pos = "Position",
  `3PA` = "3-Point Field Goal Attempts"
)

#renaming the positions within the Position column
data <- data %>% 
  mutate(
    Pos = recode(
      Pos,
      "C" = "Center",
      "PF" = "Power Forward",
      "PG" = "Point Guard",
      "SF" = "Small Forward",
      "SG" = "Shooting Guard"
    )
  )

#creating table summary
table_one <- data %>% 
  select(Pos, `3PA`) %>% 
  tbl_summary(by = Pos) %>% 
  modify_spanning_header(all_stat_cols() ~ "**Position**") %>% 
  add_overall() %>% 
  add_p()

saveRDS(
  table_one,
  file = here::here("output/sl_output/table_one.rds")
)

#running ANOVA test
anova_model <- aov(formula = data$`3PA` ~ data$Pos)
summary(anova)

#since the p-value is less than 0.05, the ANOVA test is statistically significant
tukey_results <- TukeyHSD(anova_model)
print(tukey_results)

tidy_tukey <- tidy(tukey_results)
print(tidy_tukey)

tukey_table <- tidy_tukey %>% 
  select (term, contrast, estimate, conf.low, conf.high, adj.p.value) %>% 
  mutate(significance = ifelse(adj.p.value <0.05, "*","")) %>% 
  rename(
    "Term" = term,
    "Contrast" = contrast,
    "Estimate" = estimate,
    "Lower Bound of CI" = conf.low,
    "Upper Bound of CI" = conf.high,
    "Adjusted P-Value" = adj.p.value,
    "Significance" = significance)

tukey_table_gt <- tukey_table %>% 
  gt()

saveRDS(
  tukey_table_gt,
  file = here::here("output/sl_output/tukey_table.rds")
)