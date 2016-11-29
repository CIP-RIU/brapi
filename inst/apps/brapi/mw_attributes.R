library(jug)
library(jsonlite)

mw_attributes <<-
  collector() %>%
  get("/brapi/v1/attributes[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  put("/brapi/v1/attributes[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/attributes[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/attributes[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  get("/brapi/v1/attributes/categories[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  put("/brapi/v1/attributes/categories[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/attributes/categories[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/attributes/categories[/]?", function(req, res, err){
    res$set_status(405)
  })

