if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_progeny(con, germplasmDbId = "1")

}
