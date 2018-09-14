if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_studies_search_post(con)
}
