if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_details_study(con, "1001")
}
