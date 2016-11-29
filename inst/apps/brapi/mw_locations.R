library(jug)
library(jsonlite)

mw_locations <<-
  collector() %>%
  get("/brapi/v1/locations[/]?", function(req, res, err){
    res$set_status(501)
  })  %>%
  put("/brapi/v1/locations[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/locations[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/locations[/]?", function(req, res, err){
    res$set_status(405)
  })
