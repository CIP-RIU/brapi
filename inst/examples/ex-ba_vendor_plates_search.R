if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_vendor_plates_search(con)
}
