if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_genomemaps_data(con, "gm1")

}
