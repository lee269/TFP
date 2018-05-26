library(here)
library(tidyverse)


source(here("R", "read_ABS.R"))

sheets <- c("Sections A-S", "Section C", "Division 46", "Division 47", "Section I")

# using purrr map-reduce to create a list of data frames and bind them together
abs <- map2(here("data", "abssectionsas.xls"), sheets, read_ABS) %>% 
       reduce(bind_rows)

# using tidyr::gather to convert to long form if we dont impute all the *
# suppressed vals they will come in as NAs, and they will get deleted
abs_tidy <- abs %>% 
        gather(attribute, value, no_enterprises:stocks_increase, na.rm = TRUE)


manufacturing <- c("10", "11")
wholesale <- c("46.31", "46.32", "46.33", "46.34", "46.36", "46.37", "46.38", "46.39", "46.17")
retail <- c("47.21", "47.22", "47.23", "47.24", "47.25", "47.29", "47.11", "47.81")
catering <- c("56")
wider_economy <- LETTERS[1:19]

gva <- abs_tidy %>% 
       filter(attribute =="gva" & sic %in% manufacturing) %>% 
       group_by(year) %>% 
       summarise(gva = sum(value))
