library(jug)
library(jsonlite)

mw_germplasm <<-
  collector() %>%
  get("/brapi/v1/germplasm[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  put("/brapi/v1/germplasm[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/germplasm[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/germplasm[/]?", function(req, res, err){
    res$set_status(405)
  })
