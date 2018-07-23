if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_genomemaps_data_range(con, "gm1", linkageGroupName = "1")
}
