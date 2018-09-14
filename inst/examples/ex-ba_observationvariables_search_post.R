if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_observationvariables_search_post(con)

}
