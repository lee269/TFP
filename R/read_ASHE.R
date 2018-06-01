#' Read in an ASHE data table
#'
#' written for table 4.9, maybe works with other downloads
#'
#' @param file spreadsheet workbook containing ASHE data
#' @param sheet worksheet tab to process
#' @param year provide a year to add to the output dataset
#' @param category provide a category to add to the dataset, eg "Full time"
#'
#' @return a dataset of ASHE data
#' @export
#'
#' @examples
#' read_ASHE("ASHE_T4_9.xls", "Full time", 2017, "fulltime")
read_ASHE <- function(file, sheet, year, category) {

  colnames <- c("sic_desc",
                "sic",
                "no_jobs",
                "median",
                "median_pc_change",
                "mean",
                "mean_pc_change",
                "pcile_10",
                "pcile_20",
                "pcile_25",
                "pcile_30",
                "pcile_40",
                "pcile_60",
                "pcile_70",
                "pcile_75",
                "pcile_80",
                "pcile_90")

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
                "numeric",
                "numeric")

  x <- readxl::read_excel(path = file, sheet = sheet, range = cell_cols("A:Q"), col_names = colnames, col_types = coltypes)

  x <- x %>%
    dplyr::filter(sic != is.na(sic) & sic != "Code") %>%
    dplyr::mutate(year = year,
                  category = category)

  return(x)

}
