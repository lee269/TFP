library(here)
library(tidyverse)

# set up dataframe of SIC sector definitions
manufacturing <- c("10", "11")
wholesale <- c("46.31", "46.32", "46.33", "46.34", "46.36", "46.37", "46.38", "46.39", "46.17")
retail <- c("47.21", "47.22", "47.23", "47.24", "47.25", "47.29", "47.11", "47.81")
catering <- c("56")
wider_economy <- c("B", "C","D", "E", "F", "G", "H", "I", "J", "L", "M", "N")

sectors <- data.frame(sector = c(rep("food manufacturing", times = length(manufacturing)),
                                 rep("wholesale", times = length(wholesale)),
                                 rep("retail", times = length(retail)),
                                 rep("catering", times = length(catering)),
                                 rep("wider economy", times = length(wider_economy))),
                      sic = c(manufacturing, wholesale, retail, catering, wider_economy), stringsAsFactors = FALSE)

capital <- data.frame(sector = c("manufacturing", "wholesale", "retail", "catering"),
                        series = c("mi3n", "xxxx", "xxxx", "xxxx"), stringsAsFactors = FALSE)


capstk <- read_csv(here("data", "capstk.csv"))
abs_tidy <- read_csv(here("data", "abs_tidy.csv"))

abs <- abs_tidy %>% 
       left_join(sectors) %>% 
       filter(sector == "food manufacturing") %>% 
       select(sector, year, attribute, value) %>% 
       group_by(sector, year, attribute) %>% 
       summarise(value = sum(value)) %>% 
       spread(attribute, value) %>% 
       select(sector, year, capex, purchases, employment_costs, employment_pit, turnover)


cap_series <- capital %>% 
          filter(sector == "manufacturing") %>% 
          select(series)


capital_stock <- capstk %>% 
                 filter(series == as.character(cap_series)) %>% 
                 select(year, capital = value)

tfp <- abs %>% 
        left_join(capital_stock, by = c("year", "year")) %>% 
        mutate(input_wt_total = capital + purchases + employment_costs,
               input_wt_capital = capital / input_wt_total,
               input_wt_purchases = purchases / input_wt_total,
               input_wt_employment = employment_costs / input_wt_total)

                 

