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
#' read_ONS("/economy/inflationandpriceindices/timeseries/l55o/mm23", 2005, 2016)
read_ONS <- function(seriesuri, from, to){

    url <- paste("https://www.ons.gov.uk/generator?format=csv&uri=",
                 seriesuri,
                 "&series=&fromYear=",
                 from,
                 "&toYear=",
                 to,
                 "&frequency=years",
                 sep = "")

  if (length(seriesuri) == 1) {

    x <- read.csv(url, stringsAsFactors = FALSE)

  } else {

    x <- purrr::map(url, read.csv, stringsAsFactors = FALSE) %>%
      purrr::reduce(dplyr::bind_cols) %>%
      dplyr::select(-c(seq(3,length(seriesuri)*2,2)))

  }

    colnames(x) <- c("year", x[1, 2:ncol(x) ])

    x <- x %>%
      dplyr::slice(6:n()) %>%
      dplyr::mutate_all(as.numeric)

    return(x)


}



# https://www.ons.gov.uk/generator?format=csv&uri=/economy/nationalaccounts/uksectoraccounts/timeseries/mi35/capstk&series=&fromYear=1995&toYear=2016&frequency=years
# https://www.ons.gov.uk/generator?format=csv&uri=/economy/inflationandpriceindices/timeseries/l55o/mm23&series=&fromYear=1995&toYear=2016&frequency=years
