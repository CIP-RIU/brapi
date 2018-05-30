join_slaves <- function(dat2, slave) {
  assertthat::assert_that(
    (slave %in% names(dat2)),
    msg = paste("The json return object lacks a", slave, "element."))

  df2 <- dat2[slave][[1]][[1]]
  dat2[slave] <- NULL
  #if (!is.data.frame(df2)) return(dat2)
  df2 <- as.data.frame(df2)
  df3 <-  dat2[rep(seq_len(nrow(dat2)), each=nrow(df2)),]
  df <- cbind(df3, df2)
  row.names(df) <- 1:nrow(df)
  return(df)
}
