if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_samples_search(con)
}
