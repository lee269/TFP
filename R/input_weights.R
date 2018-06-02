#' calculate input weights for a sector
#'
#' @param data a dataset containing current price data
#' @param capital the capital variable
#' @param purchases the purchases variable
#' @param employment the employment variable
#'
#' @return a dataset of input weights
#' @export
#'
#' @examples
#'
#' @importFrom rlang ":="
input_weights <- function(data, capital, purchases, employment) {

  # using NSE quotation examples from
  # https://dplyr.tidyverse.org/articles/programming.html

  capital <- dplyr::enquo(capital)
  purchases <- dplyr::enquo(purchases)
  employment <- dplyr::enquo(employment)

  data <- data %>%
          dplyr::mutate(total_input := !! capital + !! purchases + !! employment,
                 capital_weight := !! capital / total,
                 purchases_weight := !! purchases / total,
                 employment_weight := !! employment / total) %>%
          dplyr::select(!! capital,
                        !! purchases,
                        !! employment,
                        total_input,
                        capital_weight,
                        purchases_weight,
                        employment_weight)

  return(data)


}
