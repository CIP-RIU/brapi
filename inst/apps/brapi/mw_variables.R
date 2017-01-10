library(jug)
library(jsonlite)

mw_variables <<-
  collector() %>%
  get("/brapi/v1/variables[/]?", function(req, res, err){
    res$set_status(501)
  })  %>%
  put("/brapi/v1/variables[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/variables[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/variables[/]?", function(req, res, err){
    res$set_status(405)
  })

