library(here)
library(tidyverse)

# load up functions
source(here("R", "read_ABS.R"))

# set up dataframe of SIC sector definitions
manufacturing <- c("10", "11")
wholesale <- c("46.31", "46.32", "46.33", "46.34", "46.36", "46.37", "46.38", "46.39", "46.17")
retail <- c("47.21", "47.22", "47.23", "47.24", "47.25", "47.29", "47.11", "47.81")
catering <- c("56")
wider_economy <- c("B", "C","D", "E", "F", "G", "H", "I", "J", "L", "M", "N")

sectors <- data.frame(sector = c(rep("manufacturing", times = length(manufacturing)),
                                 rep("wholesale", times = length(wholesale)),
                                 rep("retail", times = length(retail)),
                                 rep("catering", times = length(catering)),
                                 rep("wider economy", times = length(wider_economy))),
                      sic = c(manufacturing, wholesale, retail, catering, wider_economy), stringsAsFactors = FALSE)

# list of sheets in the spreadsheet we want to read in
sheets <- c("Sections A-S", "Section C", "Division 46", "Division 47", "Section I")

# using purrr map-reduce to create a list of data frames and bind them together
# into one
abs <- map2(here("data", "abssectionsas.xls"), sheets, read_ABS) %>% 
       reduce(bind_rows)

# using tidyr::gather to convert to long form - if we dont impute all the *
# suppressed vals they will come in as NAs, and they will get deleted
abs_tidy <- abs %>% 
        gather(attribute, value, no_enterprises:stocks_increase, na.rm = TRUE)




gva <- abs_tidy %>% 
       left_join(sectors, by = c("sic") ) %>% 
       filter(attribute =="gva" & sector != is.na(sector)) %>% 
       group_by(sector, year) %>% 
       summarise(gva = sum(value)) %>% 
       ungroup()
