if (interactive()) {
  library(brapi)
  library(magrittr)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- as.ba_db(
    crop = "potato",
    user = "myself"
    )

  print(con)
}
