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

  if (length(seriesuri) == 1) {
    url <- paste("https://www.ons.gov.uk/generator?format=csv&uri=",
                 seriesuri,
                 "&series=&fromYear=",
                 from,
                 "&toYear=",
                 to,
                 "&frequency=years",
                 sep = "")

    x <- read.csv(url)
    colnames(x)[1] <- "year"
    colnames(x) <- safe_names(colnames(x))
    x <- x[-c(1:6), ]

    return(x)

  } else {
    url <- as.list(paste("https://www.ons.gov.uk/generator?format=csv&uri=",
                         seriesuri,
                         "&series=&fromYear=",
                         from,
                         "&toYear=",
                         to,
                         "&frequency=years",
                         sep = ""))

  x <- purrr::map(url, read.csv) %>%
       purrr::reduce(dplyr::bind_cols)

  x2 <- x[ ,seq(2,ncol(x),2)]
  x2 <- dplyr::bind_cols(as.data.frame(x[, 1]), x2)
  colnames(x2)[1] <- "year"
  colnames(x2) <- safe_names(colnames(x2))
  x2 <- x2[-c(1:6), ]

  return(x2)
  }


}



# https://www.ons.gov.uk/generator?format=csv&uri=/economy/nationalaccounts/uksectoraccounts/timeseries/mi35/capstk&series=&fromYear=1995&toYear=2016&frequency=years
# https://www.ons.gov.uk/generator?format=csv&uri=/economy/inflationandpriceindices/timeseries/l55o/mm23&series=&fromYear=1995&toYear=2016&frequency=years
