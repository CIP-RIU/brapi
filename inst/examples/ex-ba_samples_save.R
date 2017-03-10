if (interactive()) {
  library(brapi)
  library(magrittr)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect() %>% ba_login()

  sampleData <- list(
    plantId = 1,
    plotId = 1,
    takenBy = "RS",
    sampleDate = "01",
    sampleType = "x",
    tissueType = "tt",
    notes = "notes"
  )

  ba_samples_save(con, sampleData)

  # Note: the test server from brapiTS does not store the table. It only does some simple checking.

}
