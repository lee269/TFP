# describe a value which represents a change
# put the responses into a data frame
updown <- function(val, reference = "idpres") {
  
  require(dplyr)
  
  ref <- c("idpres", "idpresart", "idpast", "hl", "frpresent", "frpast")
  up <- c("increase", "an increase", "increased", "higher", "rise", "rose")
  down <- c("decrease", "a decrease", "decreased", "lower", "fall", "fell")
  zero <- c("unchanged", "unchanged", "unchanged", "unchanged", "unchanged", "unchanged")
  
  ud <- data.frame(ref, up, down, zero, stringsAsFactors = FALSE)
  
  output <- ud %>% 
            filter(ref == reference)
  
  if (val > 0) {return(output$up[1])}
  if (val < 0) {return(output$down[1])}
  if (val == 0) {return(output$zero[1])}
  
}
  
  # if (val > 0) {
  
  #   output <- switch(reference,
  #          "idpres" = "increase",
  #          "idpresart" = "an increase",
  #          "idpast" = "increased",
  #          "hl" = "higher",
  #          "frpresent" = "rise",
  #          "frpast" = "rose")
  #   output
  #   
  # } else if (val < 0) {
  #   output <- switch(reference,
  #                    "idpres" = "decrease",
  #                    "idpresart" = "a decrease",
  #                    "idpast" = "decreased",
  #                    "hl" = "lower",
  #                    "frpresent" = "fall",
  #                    "frpast" = "fell")
  #   output
  #   
  # } else if (val == 0) {
  #   output <- "unchanged"
  #   output
  # }
  
  


# compare two values more/less, larger/smaller
compare <- function(val1, val2, reference){
  
}


