if (interactive()) {
  library(brapi)
  library(magrittr)
  library(maps)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect()

  # example 1
  gm <- ba_genomemaps(con)
  gm %>% chart

  # example 2
  gmd <- ba_genomemaps_details(con, mapDbId = 1)
  gmd %>% chart

  # example 3
  bl <- ba_locations()
  bl %>% chart()

  # example 4
  bl %>% chart(chart_type = "map")
}
