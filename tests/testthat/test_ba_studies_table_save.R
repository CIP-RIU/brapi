source("check_server_status.R")

if (check_server_status == 200) {


context("Testing the path 'studies/{id}/table' using POST")

  con <- ba_connect(secure = FALSE)

test_that("Parameters work", {
  con$bms <- TRUE
  out <- ba_login(con)

  df <- as.data.frame(cbind(
    observationUnitDbId = 1:2, # obligatory variable
    collector = c("T1", "T2"), # obligatory variable
    observationTimestamp = c("ts 1", "ts 2"), # obligatory variable
    variable1Id = c(3, 4)
  ))

  expect_message(ba_studies_table_save(out, "1", df), "Successfully posted studies table!")

  expect_error(ba_studies_table_save(out, "1", 1))

})


}
