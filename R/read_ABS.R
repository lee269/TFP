read_ABS <- function(file, sheet) {

library(readxl)
library(tidyr)
library(dplyr)

colnames <- c("sic",
               "sic_desc",
               "year",
               "no_enterprises",
               "turnover",
               "gva",
               "purchases",
               "employment_pit",
               "employment_avg",
               "employment_costs",
               "capex",
               "capex_acuisitions",
               "capex_disposals",
               "stocks_endyr",
               "stocks_startyr",
               "stocks_increase")

coltypes <- c("text",
               "text",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric")

x <- read_excel(path = file, sheet = sheet, skip = 8, col_names = colnames, col_types = coltypes)

x <- x %>% 
      filter(year != is.na(year)) %>% 
      fill(sic)

return(x)

}