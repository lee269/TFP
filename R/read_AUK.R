#' read in AUK API data
#'
#' @param file a spreadsheet
#'
#' @return
#' @export
#'
#' @examples
read_AUK <- function(file) {

  x <- readxl::read_excel(path = file, skip = 8, col_names = TRUE)

  x <- x %>%
      dplyr::select(-2) %>%
      dplyr::filter(X__1 != is.na(X__1)) %>%
      dplyr::rename(product = X__1)


  return(x)

}
