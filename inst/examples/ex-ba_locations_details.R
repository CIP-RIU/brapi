if (interactive()) {
  library(brapi)
  # Need to connect to a database with genetic data

  con <- ba_db()$testserver

  loc <- ba_locations_details(con = con, "1")

}
