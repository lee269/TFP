#' Extract an ONS data series
#'
#' creates a url which returns a yearly series of ONS data
#'
#' @param seriesuri the URI of the data series
#' @param from the start year
#' @param to the end year
#'
#' @return a dataframe of an ONS data series
#' @export
#'
#' @examples
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

  return(x)

}



# https://www.ons.gov.uk/generator?format=csv&uri=/economy/nationalaccounts/uksectoraccounts/timeseries/mi35/capstk&series=&fromYear=1995&toYear=2016&frequency=years
# https://www.ons.gov.uk/generator?format=csv&uri=/economy/inflationandpriceindices/timeseries/l55o/mm23&series=&fromYear=1995&toYear=2016&frequency=years
