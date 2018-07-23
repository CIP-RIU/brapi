if (interactive()) {
  library(brapi)

  con <-  ba_db()$testserver

  ba_commoncropnames(con = con)
}
