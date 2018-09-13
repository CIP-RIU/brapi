if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_markerprofiles_allelematrices_details(con, studyDbId = "1001")
}
