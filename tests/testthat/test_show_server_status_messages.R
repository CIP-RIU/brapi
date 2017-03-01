source("check_server_status.R")

if (check_server_status == 200) {

context("Testing show_server_status_messages")

  msg <- cbind(code = c(123, 456), message = c("M1", "M2")) %>%
    as.data.frame()

test_that("printing messages", {

  ba_show_info(TRUE)

  out <- capture_messages(
    brapi:::show_server_status_messages(msg)
  )

  expect_equal(length(out), 3)
  expect_equal(out[1], "Status messages\n")
  expect_equal(out[2], "BrAPI server warning code -> 123: M1\n")
  expect_equal(out[3], "BrAPI server warning code -> 456: M2\n")
}
)

}
