context("ts studies_observationunits_save")

con <- ba_db()$testserver

test_that("  are present", {

  expect_true({
    res <- ba_studies_observationunits_save(con = con, studyDbId = "1011",
                                            unitData = as.data.frame(cbind(
                                              observationUnitDbId = 1,
                                              observationDbId = 4,
                                              observationVariableId = "x",
                                              observationVariableName = "Y",
                                              collector = "A",
                                              observationTimeStamp = "xxxxx",
                                              value = "1"
                                            ), stringsAsFactors = FALSE)  )

  })

})
