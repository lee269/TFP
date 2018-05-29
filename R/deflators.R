library(here)
library(tidyverse)

source(here("R", "read_ONS.R"))

# an example of how to use read_ONS
# x <- read_ONS(seriesuri = "/economy/nationalaccounts/uksectoraccounts/timeseries/mhy2/capstk", 1998, 2016)
# https://www.ons.gov.uk/generator?format=csv&uri=/economy/inflationandpriceindices/timeseries/k37l/ppi
# https://www.ons.gov.uk/generator?format=csv&uri=/economy/grossdomesticproductgdp/timeseries/ybgb/pn2

# build up a list of the series and parameters to feed to read_ONS

ids <- tolower(c("L556", "L523", "L52U", "CBZW", "K37L", "MC35", "YBGB"))
ids2 <- tolower(c("L556/mm23", "L523/mm23", "L52U/mm23", "CBZW/mm23", "K37L/ppi", "MC35/ppi"))
series <- as.list(c(paste("/economy/inflationandpriceindices/timeseries/", ids2, sep = ""), "/economy/grossdomesticproductgdp/timeseries/ybgb/pn2"))
froms <- as.list(rep(2005, times = length(series)))
tos <- as.list(rep(2017, times = length(series)))
parameters <- list(series, froms, tos)


# Now maka a basic dataframe of cap stock series data
deflators <- pmap(parameters, read_ONS) %>% 
  reduce(bind_cols)

# delete alternate columns. We will take the first column later
deflators2 <- deflators[ ,seq(2,ncol(deflators),2)]
colnames(deflators2) <- tolower(ids)

# take the first 6 rows of metadata and turn to long form. We will save this for
# reference
seriesmetadata <- deflators2[1:6, ] %>% 
  gather()

# Stick the year column from the original dataset and delete the first 6 rows
deflators2 <- bind_cols(deflators2, as.data.frame(deflators[, 1]))
colnames(deflators2)[ncol(deflators2)] <- "year"
deflators2 <- deflators2[, c("year", tolower(ids))]
deflators2 <- deflators2[-c(1:6), ]
deflators2 <- deflators2 %>% 
  gather(series, value, 2:ncol(deflators2))


# write_csv(deflators2, here("data", "deflators.csv"))
# write_csv(seriesmetadata, here("data", "deflatorsmeta.csv"))















