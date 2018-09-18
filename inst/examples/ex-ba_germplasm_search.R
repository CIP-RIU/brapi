if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_search(con, germplasmDbId = "1")


}
