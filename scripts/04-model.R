#### Preamble ####
# Purpose: Models the predicted number of e/Es in each line based on the number of words, in Frankenstein by Mary Shelley.
# Author: Irene Huynh
# Date: 16 March 2023
# Contact: irene.huynh@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
frankenstein_reduced <- read_parquet("data/analysis_data/frankenstein.parquet")

### Model data ####
frankenstein_e_counts <-
  stan_glm(
    count_e ~ word_count,
    data = frankenstein_reduced,
    family = poisson(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  frankenstein_e_counts,
  file = "models/frankenstein_e_counts.rds"
)