if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_germplasm_search_post(con, germplasmDbIds = c("1", "2"))


}
