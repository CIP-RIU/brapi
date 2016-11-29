library(jug)
library(jsonlite)

mw_studies <<-
  collector() %>%
  get("/brapi/v1/studies[/]?", function(req, res, err){
    res$set_status(501)
  })  %>%
  put("/brapi/v1/studies[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/studies[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  delete("/brapi/v1/studies[/]?", function(req, res, err){
    res$set_status(405)
  })
