#' reads in a sheet from a standard ONS ABS spreadsheet
#'
#' Expects a 'standard' ABS spreadsheet as published at (link). Applies standard
#' column names and variable types, skips the first 8 header lines, and removes
#' blank lines. Fills down SIC codes into empty cells, but does not do this for
#' SIC descriptions, since some are displayed on multiple lines.
#'
#' @param file spreadsheet file name
#' @param sheet spreadsheet sheet name
#'
#' @return
#' @export
#'
#' @examples
#'
#' @importFrom magrittr "%>%"
read_ABS <- function(file, sheet) {


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

x <- readxl::read_excel(path = file, sheet = sheet, skip = 8, col_names = colnames, col_types = coltypes)

x <- x %>%
      dplyr::filter(year != is.na(year)) %>%
      tidyr::fill(sic)

return(x)

}
