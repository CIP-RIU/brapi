if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_vendor_specifications(con)
}
