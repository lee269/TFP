capital <- function(series, from, to){

library(here)
library(tidyverse)

source(here("R", "read_ONS.R"))

# an example of how to use read_ONS
# x <- read_ONS(seriesuri = "/economy/nationalaccounts/uksectoraccounts/timeseries/mhy2/capstk", 1998, 2016)

# build up a list of the series and parameters to feed to read_ONS

ids <- tolower(c("MHY2", "MI27", "MI36", "MI3O", "MI48", "MI4Q", "MI5S", "MI6C", "MI5A", "MI6U", "MI7E", "MI7W",
                 "MI8G", "MI8Y", "MI9I", "MIA2", "MIC4", "MIE6", "MIH3", "MIJ5", "MIO7", "MIT6", "MIW3", "MIY8",
                 "MJ2A", "MJ2S", "MJ3C", "MJ3X", "MJ4H", "MJ4Z", "MJ5J", "MJ63", "MJ6O", "MJ7B", "MJ7T", "MJ8D",
                 "MJ8V", "MJ9F", "MJ9X", "MJB9", "MJE3", "MHX9", "MI26", "MI35", "MI3N", "MI47", "MI4P", "MI59",
                 "MI5R", "MI6B", "MI6T", "MI7D", "MI7V", "MI8F", "MI8X", "MI9H", "MI9Z", "MIC3", "MIE5", "MIH2",
                 "MIJ4", "MIO6", "MIT5", "MIW2", "MIY7", "MJ29", "MJ2R", "MJ3B", "MJ3W", "MJ4G", "MJ4Y", "MJ5I",
                 "MJ62", "MJ6N", "MJ7A", "MJ7S", "MJ8C", "MJ8U", "MJ9E", "MJ9W", "MJB8", "MJE2", "MK3P", "MK4C",
                 "MK5B", "MK5T", "MK6D", "MK6V", "MK7F", "MK7X", "MK8H", "MK8Z", "MK9J", "MKA3", "MKC5", "MKE6",
                 "MKG8", "MKJ2", "MKL4", "MKN6", "MKQ3", "MKS5", "MKX7", "ML2M", "ML39", "ML3U", "ML4E", "ML4W",
                 "ML5G", "ML63", "ML6L", "ML75", "ML7N", "ML87", "ML8S", "ML9F", "ML9X", "MLB9", "MLE3", "MLG5",
                 "MLI7", "MLK9", "MLN3"))
series <- as.list(paste("/economy/nationalaccounts/uksectoraccounts/timeseries/", ids, "/capstk", sep = ""))
froms <- as.list(rep(1998, times = length(series)))
tos <- as.list(rep(2016, times = length(series)))
parameters <- list(series, froms, tos)


# Now maka a basic dataframe of cap stock series data
capstk <- pmap(parameters, read_ONS) %>%
          reduce(bind_cols)

# delete alternate columns. We will take the first column later
capstk2 <- capstk[ ,seq(2,ncol(capstk),2)]
colnames(capstk2) <- tolower(ids)

# take the first 6 rows of metadata and turn to long form. We will save this for
# reference
seriesmetadata <- capstk2[1:6, ] %>%
                  gather()

# Stick the year column from the original dataset and delete the first 6 rows
capstk2 <- bind_cols(capstk2, as.data.frame(capstk[, 1]))
colnames(capstk2)[ncol(capstk2)] <- "year"
capstk2 <- capstk2[, c("year", tolower(ids))]
capstk2 <- capstk2[-c(1:6), ]
capstk2 <- capstk2 %>%
           gather(series, value, 2:ncol(capstk2))


# write_csv(capstk2, here("data", "capstk.csv"))
# write_csv(seriesmetadata, here("data", "capstkmeta.csv"))



}




