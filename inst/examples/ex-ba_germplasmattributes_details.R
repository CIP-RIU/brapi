if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasmattributes_details(con, germplasmDbId = "1")

}
