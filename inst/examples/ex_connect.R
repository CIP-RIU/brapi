if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  con <- ba_connect(con)
}
