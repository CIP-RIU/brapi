if (interactive()) {
  library(brapi)
  library(magrittr)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect()

  ba_markerprofiles_allelematrix_search(con, markerprofileDbId = "3")

}
