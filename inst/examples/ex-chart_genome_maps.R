if (interactive()) {
  library(brapi)
  library(magrittr)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect()

  # example 1
  gm <- ba_genomemaps(con)
  gm %>% ba_chart

}
