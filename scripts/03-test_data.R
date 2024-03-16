#### Preamble ####
# Purpose: Tests the cleaned text data for Frankenstein by Mary Shelley.
# Author: Irene Huynh
# Date: 16 March 2023
# Contact: irene.huynh@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)

#### Test data ####

frankenstein_test <- read.csv("data/analysis_data/frankenstein.csv")

# Checking that there are exactly 23 chapters
(frankenstein_test$chapter |> length())/10 == 23

# Checking the classes of the columns
frankenstein_test$chapter |> class() == 'integer'
frankenstein_test$count_e |> class() == 'integer'
frankenstein_test$word_count |> class() == 'integer'

# Checking that each line has at least one word
frankenstein_test$word_count > 0
