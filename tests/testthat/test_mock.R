source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function: mock")

test_that("Mock can be launched.", {
  # srv <- tryCatch({
  #   x= server(1111, TRUE)
  #   jug::stop_daemon(x)
  #   200
  # }, error = function(e){
  #   555
  # })
  # expect_equal(srv, 200)
})

}
