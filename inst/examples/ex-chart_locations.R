if (interactive()) {
  library(brapi)
  library(magrittr)
  library(maps)

  # make sure brapiTS::mock_server() is running in a separate process

  con <- ba_connect()

  # Example 1
  bl <- ba_locations(con)
  bl %>% ba_chart()
  dev.off()

  # Example 2
  bl %>% ba_chart(chart_type = "map")
  dev.off()
}
