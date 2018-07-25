if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_markerprofiles_allelematrices_search(con)
}
