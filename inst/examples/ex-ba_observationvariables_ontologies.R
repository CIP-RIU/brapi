if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_observationvariables_ontologies(con)
}
