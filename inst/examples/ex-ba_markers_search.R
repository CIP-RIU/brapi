if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_markers_search(con)
}
