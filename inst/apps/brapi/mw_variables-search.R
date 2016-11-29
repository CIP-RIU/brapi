library(jug)
library(jsonlite)

mw_variables_search <<-
  collector() %>%
  get("/brapi/v1/variables-search[/]?", function(req, res, err){
    res$set_status(405)
  })  %>%
  put("/brapi/v1/variables-search[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/variables-search[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  delete("/brapi/v1/variables-search[/]?", function(req, res, err){
    res$set_status(405)
  })
