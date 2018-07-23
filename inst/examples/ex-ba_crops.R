if (interactive()) {
  library(brapi)

  con <-  ba_db()$testserver

  ba_crops(con = con)
}
