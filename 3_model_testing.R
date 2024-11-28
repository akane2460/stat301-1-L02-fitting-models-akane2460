# L02 fitting models ----
# Stat 301-2
# model testing

## load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

## load data ----
kc_test <- read_rds(here("data/kc_test.rds"))

# OLS
lm_fit <- read_rds(here("data/lm_fit.rds"))

# lasso
lasso_fit <- read_rds(here("data/lasso_fit.rds"))

# ridge
ridge_fit <- read_rds(here("data/ridge_fit.rds"))

## Ex 4----

# OLS
lm_coef_comp <- tidy(lm_fit)

write_rds(lm_coef_comp, file = here("data/lm_coef_comp.rds"))

# lasso
lasso_coef_comp <- tidy(lasso_fit)

write_rds(lasso_coef_comp, file = here("data/lasso_coef_comp.rds"))

# ridge
ridge_coef_comp <- tidy(ridge_fit)

write_rds(ridge_coef_comp, file = here("data/ridge_coef_comp.rds"))


## Ex 05----

# OLS
lm_predict <- kc_test |> 
  bind_cols(predict(lm_fit, kc_test))

write_rds(lm_predict, file = here("data/lm_predict.rds"))

CI_lm_predict <- kc_test |> 
  select(price_log10) |> 
  bind_cols(predict(lm_fit, kc_test)) |> 
  bind_cols(predict(lm_fit, kc_test, type = "pred_int"))

write_rds(CI_lm_predict, file = here("data/CI_lm_predict.rds"))

# lasso
lasso_predict <- kc_test |> 
  bind_cols(predict(lasso_fit, kc_test))

write_rds(lasso_predict, file = here("data/lasso_predict.rds"))

# ridge
ridge_predict <- kc_test |> 
  bind_cols(predict(ridge_fit, kc_test))

write_rds(ridge_predict, file = here("data/ridge_predict.rds"))

## Ex 06----

lm_predict_og_scale <- kc_test |> 
  bind_cols(predict(lm_fit, kc_test)) |> 
  mutate(price_original = 10^price_log10, 
         .pred = 10^.pred)

write_rds(lm_predict_og_scale, file = here("data/lm_predict_og_scale.rds"))

CI_lm_predict_og_scale <- kc_test |> 
  select(price_log10) |>
  bind_cols(predict(lm_fit, kc_test)) |> 
  bind_cols(predict(lm_fit, kc_test, type = "pred_int")) |> 
  mutate(price_original = 10^price_log10,
         .pred = 10^.pred,
         .pred_lower = 10^.pred_lower,
         .pred_upper = 10^.pred_upper) |> 
  select(-price_log10)

write_rds(CI_lm_predict_og_scale, file = here("data/CI_lm_predict_og_scale.rds"))

# lasso
lasso_predict_og_scale <- kc_test |> 
  bind_cols(predict(lasso_fit, kc_test)) |> 
  mutate(price_original = 10^price_log10, 
         .pred = 10^.pred)

write_rds(lasso_predict_og_scale, file = here("data/lasso_predict_og_scale.rds"))

# ridge
ridge_predict_og_scale <- kc_test |> 
  bind_cols(predict(ridge_fit, kc_test)) |> 
  mutate(price_original = 10^price_log10, 
         .pred = 10^.pred)

write_rds(ridge_predict_og_scale, file = here("data/ridge_predict_og_scale.rds"))

