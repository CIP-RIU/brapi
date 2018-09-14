if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_samples_search_post(con)
}
