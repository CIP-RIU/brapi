source("check_server_status.R")

if (check_server_status == 200) {

context("Testing describe methods")

test_that("print output for 'ba_locations'.", {
  con <- ba_connect(secure = FALSE)

  out <- capture.output( ba_locations(con) %>% describe() )

  expect_equal(length(out), 3)
  expect_equal(out[1], "n locations = 17")
  expect_equal(out[2], "n locations with missing lat/lon = 0 (0%) ")
  expect_equal(out[3], "")
})


}
