library(jug)
library(jsonlite)

mw_allelematrix_search <<-
  collector() %>%
  get("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  put("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  delete("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    res$set_status(405)
  })
