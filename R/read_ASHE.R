#' Read in an ASHE data table
#'
#' @param file
#' @param sheet
#' @param year
#' @param category
#'
#' @return
#' @export
#'
#' @examples
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
