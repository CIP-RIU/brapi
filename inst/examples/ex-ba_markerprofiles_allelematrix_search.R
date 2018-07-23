if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_markerprofiles_allelematrix_search(con)
}
