if (interactive()) {
  library(brapi)
  library(magrittr)

  # make sure brapiTS::mock_server() is running in a separate process

  bdb <- ba_db()

  print(bdb)

  bdb$mockbase %>% print

}
