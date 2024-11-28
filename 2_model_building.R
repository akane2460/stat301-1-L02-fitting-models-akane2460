# L02 fitting models ----
# Stat 301-2
# model building

## load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(parsnip)

# handle common conflicts
tidymodels_prefer()

## load data ----
kc_train <- read_rds(here("data/kc_train.rds"))

## Ex 3----

# OLS
lm_spec <-linear_reg() |> 
  set_engine("lm") |> 
  set_mode("regression")

lm_fit <- lm_spec |> 
  fit(
    price_log10 ~ waterfront + sqft_living + yr_built + bedrooms,
    kc_train
  )

write_rds(lm_fit, file = here("data/lm_fit.rds"))

# lasso
lasso_spec <-linear_reg(penalty = 0.01, mixture = 1) |> 
  set_engine("glmnet") |> 
  set_mode("regression")

lasso_fit <- lasso_spec |> 
  fit(
    price_log10 ~ waterfront + sqft_living + yr_built + bedrooms,
    kc_train
  )

write_rds(lasso_fit, file = here("data/lasso_fit.rds"))

# ridge
ridge_spec <-linear_reg(penalty = 0.01, mixture = 0) |> 
  set_engine("glmnet") |> 
  set_mode("regression")

ridge_fit <- ridge_spec |> 
  fit(
    price_log10 ~ waterfront + sqft_living + yr_built + bedrooms,
    kc_train
  )

write_rds(ridge_fit, file = here("data/ridge_fit.rds"))
