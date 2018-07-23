if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_markerprofiles(con, germplasmDbId = "1")

}
