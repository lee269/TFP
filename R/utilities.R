#' Sanitize table field names
#'
#' Removes odd characters from field names and makes them lower case. Converts
#' periods to underscores. Makes table field names safe to use in PostgreSQL
#' databases.
#'
#' @param names A vector of strings
#'
#' @return A vector of strings with punctuation and spaces removed, and replaced
#'   with underscores
#'
#' @examples
#' x <- c("Isabella", "Andrew", "Graham", "Leigh")
#' y <- c(10, 25, 19, 36)
#' df <- data.frame( "First Name" = x, "High score! in 2018" = y)
#' colnames(df) <- safe_names(colnames(df))
#' @export
safe_names = function(names) {

  names = gsub('[^a-z0-9]+','_',tolower(names))
  names = make.names(names, unique = TRUE, allow_ = TRUE)
  names = gsub('.','_',names, fixed = TRUE)
  names

}
