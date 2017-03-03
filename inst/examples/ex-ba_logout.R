if (interactive()) {
  library(brapi)
  library(magrittr)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect() %>% ba_login()

  con <- ba_logout(con)
  print(con)
}
