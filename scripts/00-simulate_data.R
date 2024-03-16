#### Preamble ####
# Purpose: Simulates the number of e's in the first ten lines.
# Author: Irene Huynh
# Date: 16 March 2023
# Contact: irene.huynh@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(123)

count_of_e_sim <-
  tibble(
    chapter = c(rep(1, 10), rep(2, 10), rep(3, 10)),
    line = rep(1:10, 3),
    num_words_in_line = runif(min = 0, max = 15, n = 30) |> round(0),
    num_e = rpois(n = 30, lambda = 10)
  )

count_of_e_sim |>
  ggplot(aes(y = num_e, x = num_words_in_line)) +
  geom_point() +
  labs(
    x = "Number of words in line",
    y = "Number of e/Es in the first ten lines"
  ) +
  theme_light() +
  scale_fill_brewer(palette = "Set1")

#### Test data ####

# Checking that there are exactly 30 lines analyzed
count_of_e_sim$line |> length() == 30

# Checking that the maximum number of words per line is at most 30
count_of_e_sim$num_words_in_line |> length() <= 30

# Checking the classes of the columns
count_of_e_sim$chapter |> class() == "numeric"
count_of_e_sim$line |> class() == "integer"
count_of_e_sim$num_words_in_line |> class() == "numeric"
count_of_e_sim$num_e |> class() == "integer"