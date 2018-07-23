if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_traits_details(con, traitDbId = "1")
}
