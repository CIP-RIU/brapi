library(jug)
library(jsonlite)

mw_samples <<-
  collector() %>%
  get("/brapi/v1/samples[/]?", function(req, res, err){
    res$set_status(501)
  })  %>%
  put("/brapi/v1/samples[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  post("/brapi/v1/samples[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/samples[/]?", function(req, res, err){
    res$set_status(405)
  })
