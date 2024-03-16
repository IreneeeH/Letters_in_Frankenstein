#### Preamble ####
# Purpose: Cleans the raw csv data of text from Frankenstein by Mary Shelley.
# Author: Irene Huynh
# Date: 16 March 2023
# Contact: irene.huynh@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####
frankenstein <- read_csv(
  "data/raw_data/frankenstein.csv",
  col_types = cols(
    gutenberg_id = col_integer(),
    text = col_character()
  )
)

frankenstein_reduced <-
  frankenstein |>
  filter(!is.na(text)) |> # Remove empty lines
  filter(!grepl("\\*", text)) |> # Remove lines that only consist of asterisks
  mutate(chapter = if_else(str_detect(text, "CHAPTER") == TRUE,
                           text,
                           NA_character_)) |> # Find start of chapter
  fill(chapter, .direction = "down") |> 
  mutate(chapter_line = row_number(), 
         .by = chapter) |> # Add line number to each chapter
  filter(!is.na(chapter), 
         chapter_line %in% c(2:11)) |> # Remove "CHAPTER I." etc
  select(text, chapter) |>
  mutate(
    # Currently each chapter heading looks like "CHAPTER I."
    # Need to remove "CHAPTER" and the period at the end, and convert the roman 
    # numeral to an integer to get the chapter number
    chapter = str_remove(chapter, "CHAPTER "),
    chapter = str_remove_all(chapter, "\\."),
    chapter = as.integer(as.roman(chapter))
  ) |>
  mutate(count_e = str_count(text, "e|E"),
         word_count = str_count(text, "\\w+")
         # From: https://stackoverflow.com/a/38058033
  ) 

frankenstein_reduced |>
  select(chapter, word_count, count_e, text) |>
  head()

#### Save data ####
write_csv(frankenstein_reduced, "data/analysis_data/frankenstein.csv")
write_parquet(frankenstein_reduced, "data/analysis_data/frankenstein.parquet")
