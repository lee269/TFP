read_ONS <- function(seriesuri, from, to){
  
  url <- paste("https://www.ons.gov.uk/generator?format=csv&uri=",
               seriesuri,
               "&series=&fromYear=",
               from,
               "&toYear=",
               to,
               "&frequency=years",
               sep = "")
  
  x <- read.csv(url, header = FALSE)
  
  x
  
}



# https://www.ons.gov.uk/generator?format=csv&uri=/economy/nationalaccounts/uksectoraccounts/timeseries/mi35/capstk&series=&fromYear=1995&toYear=2016&frequency=years
# https://www.ons.gov.uk/generator?format=csv&uri=/economy/inflationandpriceindices/timeseries/l55o/mm23&series=&fromYear=1995&toYear=2016&frequency=years