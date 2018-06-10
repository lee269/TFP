#' Fixed-basket indices - Laspeyres (q=q0), Paasche (q=q1), Lowe (q=qb)
fixed_t <- function(p0,p1,q){
  return(sum(p1*q)/sum(p0*q))
}

fisher_t <- function(p0,p1,q0,q1){
  las <- fixed_t(p0,p1,q0)
  pas <- fixed_t(p0,p1,q1)
  return(sqrt((las*pas)))
}




calclasp <- function(data, prices, quantities, indextype = "Laspeyres") {

  n <- length(data[[prices]])
  i0 <- 1
  i1 <- 0
  result <- c()
  result[1] <- 100

  for (i in 2:n){

    p0 <- data[[ prices ]][i-1]
    p1 <- data[[ prices ]][i]

    q0 <- data[[ quantities ]][i-1]
    q1 <- data[[ quantities ]][i]

    print(q0)
    print(q1)

    switch(tolower(indextype),
           laspeyres = {i1 <- fixed_t(p0, p1, q0) * i0},
           paasche = {i1 <- fixed_t(p0, p1, q1) * i0},
           fisher = {i1 <- fisher_t(p0, p1, q0, q1) * i0})

    i0 <- i1

    result[i] <- i1
  }

  return(as.data.frame(result))

}
