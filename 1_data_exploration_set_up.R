# L02 fitting models ----
# Stat 301-2

## load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(patchwork)

# handle common conflicts
tidymodels_prefer()

# load data
kc_data <- read_csv(here("data/kc_house_data.csv")) |> 
  janitor::clean_names() |> 
  mutate(
    waterfront = factor(waterfront)
  )
  # no missing data

# set seed
set.seed(20243012)

## Exercises ----

### Ex 1 ----

kc_data |> skimr::skim_without_charts(price)
  # definitiely skewed right

# inspecting target variable
p1 <- kc_data |> 
ggplot(aes(price)) + 
  geom_density() +
  theme_minimal() +
  theme(
    axis.text.y = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.y = element_blank()
  ) 
  # unimodal

p2 <- kc_data |> 
  ggplot(aes(price)) + 
  geom_boxplot() +
  theme_void()

p2/p1 + plot_layout(heights = unit(c(1, 5), c("cm", "cm"))) &
  scale_x_log10(name = "log10 price")

# transform target variable to log10 scale, remove original scale
kc_transformed <- kc_data |> 
  mutate(price_log10 = log10(price)) |> 
  select(-price)





### Ex 2----

# splitting data
kc_split <- kc_transformed |> 
  initial_split(prop = .8, strata = price_log10)

# making train and test data
kc_train <- kc_split |> training()
kc_test <- kc_split |> testing()

# write out split, train and test data
write_rds(kc_split, file = here("data/kc_split.rds"))
write_rds(kc_train, file = here("data/kc_train.rds"))
write_rds(kc_test, file = here("data/kc_test.rds"))

