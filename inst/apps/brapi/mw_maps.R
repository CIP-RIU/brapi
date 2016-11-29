library(jug)
library(jsonlite)

mw_maps <<-
  collector() %>%
  get("/brapi/v1/maps[/]?", function(req, res, err){
    res$set_status(501)
  })  %>%
  put("/brapi/v1/maps[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/maps[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/maps[/]?", function(req, res, err){
    res$set_status(405)
  })
