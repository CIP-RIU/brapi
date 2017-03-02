if (interactive()) {
  library(brapi)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect()

  ba_trials_details(con)

}
