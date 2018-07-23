if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_phenotypes_search(con)
}
