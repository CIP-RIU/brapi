if (interactive()) {
  library(brapi)
  library(magrittr)
  library(maps)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect()


  # example 1

  gm <- ba_genomemaps(con)
  gm %>% ba_chart
  dev.off()

  # example 2

  gmd <- ba_genomemaps_details(con, mapDbId = "1")
  gmd %>% ba_chart
  dev.off()

  # example 3

  bl <- ba_locations(con)
  bl %>% ba_chart()
  dev.off()

  # example 4

  bl %>% ba_chart(chart_type = "map")
  dev.off()

}
