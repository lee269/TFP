#' Compliles a tidy dataset from ABS data as read in using read_ABS
#'
#' Uses read_ABS to compile and concatenate a dataset from multiple tabs in a
#' 'standard' ABS workbook. The data is transformed to tidy (long) form.
#'
#' @param file an ABS workbook
#' @param sheets a vector of spreadsheet tab names
#'
#' @return a data frame
#' @export
#'
#' @examples
#' ABS(read.csv("url_to_abs_data.xls", "Section C"))
ABS <- function(file, sheets) {

  # load up functions
  # source(here("R", "read_ABS.R"))


  # list of sheets in the spreadsheet we want to read in
  # sheets <- c("Sections A-S", "Section C", "Division 46", "Division 47", "Section I")

  # using purrr map-reduce to create a list of data frames and bind them together
  # into one
  abs <- purrr::map2(file, sheets, read_ABS) %>%
         purrr::reduce(bind_rows)

  # using tidyr::gather to convert to long form - if we dont impute all the *
  # suppressed vals they will come in as NAs, and they will get deleted
  abs_tidy <- abs %>%
          tidyr::gather(attribute, value, no_enterprises:stocks_increase, na.rm = TRUE)


  return(abs_tidy)

  # gva <- abs_tidy %>%
  #        left_join(sectors, by = c("sic") ) %>%
  #        filter(attribute =="gva" & sector != is.na(sector)) %>%
  #        group_by(sector, year) %>%
  #        summarise(gva = sum(value)) %>%
  #        ungroup()
}
