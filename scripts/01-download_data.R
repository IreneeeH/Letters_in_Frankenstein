#### Preamble ####
# Purpose: Downloads and saves the text data for Frankenstein by Mary Shelley from gutenbergr.
# Author: Irene Huynh
# Date: 16 March 2023
# Contact: irene.huynh@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(gutenbergr)

#### Download data ####
gutenberg_id_of_frankenstein <- 41445

frankenstein <-
  gutenberg_download(
    gutenberg_id = gutenberg_id_of_frankenstein,
    mirror = "https://gutenberg.pglaf.org/"
  )


#### Save data ####
write_csv(frankenstein, "data/raw_data/frankenstein.csv")
