library(jug)
library(jsonlite)

mw_germplasm_search <<-
  collector() %>%
  get("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  put("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  delete("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    res$set_status(405)
  })
