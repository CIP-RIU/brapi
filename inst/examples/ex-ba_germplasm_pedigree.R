if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_pedigree(con, germplasmDbId = "1")

}
