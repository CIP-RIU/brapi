source("check_server_status.R")

if (check_server_status == 200) {


context("Testing the path 'sample' using PUT")



test_that("Parameters work", {
  con <- ba_connect()
  con$bms <- TRUE
  out <- ba_login(con)

  sampleData <- list(
    plantId = 1,
    plotId = 1,
    takenBy = "RS",
    sampleDate = "01",
    sampleType = "x",
    tissueType = "tt",
    notes = "notes"
  )


  expect_equal(ba_samples_save(out, sampleData)[1], "Unique-Plant-SampleId-1234567890")

  expect_error(ba_samples_save(out, NULL))

  sampleData <- list(

    plotId = 1,
    takenBy = "RS",
    sampleDate = "01",
    sampleType = "x",
    tissueType = "tt",
    notes = "notes"
  )

  expect_error(ba_samples_save(out, NULL))

})


}
