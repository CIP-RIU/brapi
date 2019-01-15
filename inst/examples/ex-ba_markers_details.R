if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_markers_details(con = con, markerDbId = "mr01")
}
