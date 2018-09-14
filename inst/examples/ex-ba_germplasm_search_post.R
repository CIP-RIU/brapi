if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_search_post(con, "1")


}
