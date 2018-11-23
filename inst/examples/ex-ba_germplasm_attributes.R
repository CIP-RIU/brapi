if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_attributes(con, germplasmDbId = "1")

}
