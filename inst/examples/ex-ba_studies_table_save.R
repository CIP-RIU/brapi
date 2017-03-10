if (interactive()) {
  library(brapi)
  library(magrittr)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect() %>% ba_login()

  df <- as.data.frame(cbind(
    observationUnitDbId = 1:2, # obligatory variable
    collector = c("T1", "T2"), # obligatory variable
    observationTimestamp = c("ts 1", "ts 2"), # obligatory variable
    variable1Id = c(3, 4)
    ))

  brapi::ba_studies_table_save(con, "1", df)

  # Note: the test server from brapiTS does not store the table. It only does some simple checking.

}
