if (interactive()) {
  library(brapi)

  con <- ba_connect()
  ba_calls(con)
}
