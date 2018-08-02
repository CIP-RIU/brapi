if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_studies_germplasm_details(con = con, studyDbId = "1001")
}
