if (interactive()) {
  library(brapi)

  # make sure brapiTS::mock_server() is running in a separate process

  # Checks against a well known and high uptime web site. Default: google

  ba_can_internet()

  # or use an alternative

  ba_can_internet("www.amazon.com")

}
