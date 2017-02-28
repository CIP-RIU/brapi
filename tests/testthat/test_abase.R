source("check_server_status.R")

if (check_server_status == 555) {
  message("Could not connect to local BrAPI server.")
  message("Start a server in an independent command line
          window\nusing brapiTS::mock_server().")
}


if (check_server_status != 555) {
  context("\nTesting server")

  test_that("Base URL for brapi.", {
    expect_equal(check_server_status, 200)
  })
}
