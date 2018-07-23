if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_markerprofiles_search(con, germplasmDbId = "1")
}
