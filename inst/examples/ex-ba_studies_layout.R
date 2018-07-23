if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_studies_layout(con, studyDbId = "1001")
}
