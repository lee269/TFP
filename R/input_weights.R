#' calculate input weights for a sector
#'
#' @param data a dataset containing current price data
#' @param period the period variable
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
input_weights <- function(data, period, capital, purchases, employment) {

  # using NSE quotation examples from
  # https://dplyr.tidyverse.org/articles/programming.html

  period <- dplyr::enquo(period)
  capital <- dplyr::enquo(capital)
  purchases <- dplyr::enquo(purchases)
  employment <- dplyr::enquo(employment)

  data <- data %>%
          dplyr::mutate(total_input := !! capital + !! purchases + !! employment,
                 capital_weight := !! capital / total_input,
                 purchases_weight := !! purchases / total_input,
                 employment_weight := !! employment / total_input) %>%
          dplyr::select(!! period,
                        !! capital,
                        !! purchases,
                        !! employment,
                        total_input,
                        capital_weight,
                        purchases_weight,
                        employment_weight)

  return(data)


}
