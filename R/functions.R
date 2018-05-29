#' Fixed-basket indices - Laspeyres (q=q0), Paasche (q=q1), Lowe (q=qb)
#'
#' compute a bilateral fixed base index for a single period
#'
#' @keywords internal
fixed_t <- function(p0,p1,q){
  return(sum(p1*q)/sum(p0*q))
}

#' fisher_t
#'
#' compute a bilateral Fisher index for a single period
#'
#' @keywords internal
fisher_t <- function(p0,p1,q0,q1){
  las <- fixed_t(p0,p1,q0)
  pas <- fixed_t(p0,p1,q1)
  return(sqrt((las*pas)))
}


tfp <- function(x,pvar,qvar,pervar) {
  
  n <- max(x[[pervar]],na.rm = TRUE)
  plist <- matrix(1, nrow = n, ncol = 1)
  
  xt0 <- x[x[[pervar]]==1,]
  
  for(i in 2:n){
    
    xt1 <- x[x[[pervar]]==i,]
    
    # set p and q
    p0 <- xt0[[pvar]]
    p1 <- xt1[[pvar]]
    q0 <- xt0[[qvar]]
    q1 <- xt1[[qvar]]
    
    plist[i,1] <- fisher_t(p0,p1,q0,q1)
    }
    
    result <- plist
    
    return(result)
  
  
}