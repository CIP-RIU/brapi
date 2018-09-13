if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasmattributes_attributes(con, "1")
}
