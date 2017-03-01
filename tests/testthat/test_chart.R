source("check_server_status.R")

if (check_server_status == 200) {

context("Testing chart methods")
  con <- ba_connect(secure = FALSE)

test_that("print output for 'ba_locations'.", {
  tmp <- tempfile(fileext = "png")
  png(tmp)
  ba_locations(con) %>% chart()
  dev.off()

  expect_equal(file.exists(tmp), TRUE)
  expect_equal(file.size(tmp) > 0, TRUE)

  unlink(tmp)


  #######################

  out <- capture_messages(
    ba_locations(con) %>% chart(chart_type = "map")
  )

  expect_equal(out[1], "Please install and load: library(maps)\n")

  #####################


  library(maps)
  tmp <- tempfile(fileext = "png")
  png(tmp)
  ba_locations(con) %>% chart(chart_type = "map")
  dev.off()

  expect_equal(file.exists(tmp), TRUE)
  expect_equal(file.size(tmp) > 0, TRUE)

  unlink(tmp)

})

test_that("print output for 'ba_genomemaps'.", {
  tmp <- tempfile(fileext = "png")
  png(tmp)
  ba_genomemaps(con) %>% chart()
  dev.off()

  expect_equal(file.exists(tmp), TRUE)
  expect_equal(file.size(tmp) > 0, TRUE)

  unlink(tmp)
})

test_that("print output for 'ba_genomemaps_details'.", {
  tmp <- tempfile(fileext = "png")
  png(tmp)
  ba_genomemaps_details(con) %>% chart()
  dev.off()

  expect_equal(file.exists(tmp), TRUE)
  expect_equal(file.size(tmp) > 0, TRUE)

  unlink(tmp)
})

}
