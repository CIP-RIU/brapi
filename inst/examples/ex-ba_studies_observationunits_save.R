if (interactive()) {
  library(brapi)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect()

  out <- ba_login(con)

  df <- as.data.frame(cbind(
    observationUnitDbId = rep(c("abc-123", "abc-456"), each = 2),
    observationDbId = c(1, 2, 3, 4),
    observationVariableId = rep(c(18020, 51496), 2),
    observationVariableName = rep(c("Plant_height", "GW100_g"), 2),
    collector = rep("Mr. Technician", 4),
    observationTimeStamp = rep("2015-06-16T00:53:26Z", 4),
    value = c(11, 111, 22, 222)
  ))

  df

  ba_studies_observationunits_save(
    con,
    studyDbId = "1",
    unitData = df,
    observationLevel = "plot",
    transactionDbId = "1234",
    commit = TRUE
  )

}
