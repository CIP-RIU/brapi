if (interactive()) {
  library(brapi)
  library(magrittr)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect()

  ba_genomemaps_details(con, mapDbId = 1)

}
