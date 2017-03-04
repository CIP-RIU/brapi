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

  ba_studies_table_save(con)

  # Note: the test server fro brapiTS does not store the table. It only does some simple checking.

}
