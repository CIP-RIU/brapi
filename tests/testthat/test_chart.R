source("check_server_status.R")

if (check_server_status == 200) {

context("Testing chart methods")
  con <- ba_connect(secure = FALSE)

test_that("print output for 'ba_locations'.", {
  tmp <- tempfile(fileext = "png")
  png(tmp)
  ba_locations(con) %>% ba_chart()
  dev.off()

  expect_equal(file.exists(tmp), TRUE)
  expect_equal(file.size(tmp) > 0, TRUE)

  unlink(tmp)


  #######################

  out <- capture_messages(
    ba_locations(con) %>% ba_chart(chart_type = "map")
  )



  expect_error(ba_locations(con) %>% ba_chart(chart_type = "any"))

  #####################


  library(maps)
  tmp <- tempfile(fileext = "png")
  png(tmp)
  ba_locations(con) %>% ba_chart(chart_type = "map")
  dev.off()

  expect_equal(file.exists(tmp), TRUE)
  expect_equal(file.size(tmp) > 0, TRUE)

  unlink(tmp)

})

test_that("print output for 'ba_genomemaps'.", {
  tmp <- tempfile(fileext = "png")
  png(tmp)
  ba_genomemaps(con) %>% ba_chart()
  dev.off()

  expect_equal(file.exists(tmp), TRUE)
  expect_equal(file.size(tmp) > 0, TRUE)

  unlink(tmp)

  expect_error(ba_genomemaps(con) %>% ba_chart(chart_type = "any"))
})

test_that("print output for 'ba_genomemaps_details'.", {
  tmp <- tempfile(fileext = "png")
  png(tmp)
  ba_genomemaps_details(con) %>% ba_chart()
  dev.off()

  expect_equal(file.exists(tmp), TRUE)
  expect_equal(file.size(tmp) > 0, TRUE)

  unlink(tmp)

  expect_error(ba_genomemaps_details(con) %>% ba_chart(chart_type = "any"))
})

}
