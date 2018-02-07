if (interactive()) {
  library(brapi)

  # Checks against a well known and high uptime web site. Default: google

  ba_can_internet()

  # or use an alternative

  ba_can_internet("www.amazon.com")

}
