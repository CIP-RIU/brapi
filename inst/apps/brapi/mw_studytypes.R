library(jug)
library(jsonlite)

mw_studytypes <<-
  collector() %>%
  get("/brapi/v1/studyTypes[/]?", function(req, res, err){
    res$set_status(501)
  })  %>%
  put("/brapi/v1/studyTypes[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/studyTypes[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/studyTypes[/]?", function(req, res, err){
    res$set_status(405)
  })
