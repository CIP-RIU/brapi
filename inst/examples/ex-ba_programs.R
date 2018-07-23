if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_programs(con)
}
