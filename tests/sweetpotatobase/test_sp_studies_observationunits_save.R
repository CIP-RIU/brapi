context("sp studies_observationunits_save")

con <- ba_db()$sweetpotatobase

test_that("  are present", {

  #expect_message({
    res <- ba_studies_observationunits_save(con = con, studyDbId = "11111",
                                            unitData = as.data.frame(cbind(
                                              observationUnitDbId = 1,
                                              observationDbId = 4,
                                              observationVariableId = "x",
                                              observationVariableName = "Y",
                                              collector = "A",
                                              observationTimeStamp = "xxxxx",
                                              value = "1"
                                            ), stringsAsFactors = FALSE)  )

  #})
    expect_true(res)

})
