if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_details(con, "1")
}
