if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_details(con, germplasmDbId = "1")
}
