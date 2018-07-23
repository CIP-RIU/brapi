if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_genomemaps(con)

}
