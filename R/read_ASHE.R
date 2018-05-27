read_ASHE <- function(file, sheet, year, category) {
  
  library(readxl)
  library(tidyr)
  library(dplyr)
  
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
  
  x <- read_excel(path = file, sheet = sheet, range = cell_cols("A:Q"), col_names = colnames, col_types = coltypes)
  
  x <- x %>% 
    filter(sic != is.na(sic) & sic != "Code") %>% 
    mutate(year = year,
           category = category)
  
  return(x)
  
}