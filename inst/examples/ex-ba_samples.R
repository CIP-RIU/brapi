if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_samples(con, sampleDbId = "sam01")
}
