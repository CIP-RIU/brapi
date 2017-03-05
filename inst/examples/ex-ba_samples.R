if (interactive()) {
  library(brapi)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect()

  sampleId <- "Unique-Plant-SampleId-1234567890"

  # Example 1
  bl <- ba_samples(con, sampleId)

}
