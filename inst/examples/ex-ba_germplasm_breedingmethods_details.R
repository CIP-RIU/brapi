if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_breedingmethods_details(con, "bm1")


}
