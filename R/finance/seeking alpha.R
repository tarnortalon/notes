library(tidyverse)
library(magrittr)
library(readxl)

f <- "~/Downloads/edu_stocks.xlsx"
x <- read_excel(f)
x %>%
  slice(1:20) %>%
  pull(Ticker) %>%
  paste(collapse = ", ")
