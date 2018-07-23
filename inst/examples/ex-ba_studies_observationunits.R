if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_studies_observationunits(con, studyDbId = "1001")
}
