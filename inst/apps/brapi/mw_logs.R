library(jug)
library(jsonlite)


process_logs <- function(req, res, err){
  message(paste(req$method, req$path, req$params))
  prms <- names(req$params)
}

mw_logs <<-
  collector() %>%
  get("/brapi/v1/[a-zA-Z/-]*", function(req, res, err){
    process_logs(req, res, err)
  }) %>%
  put("/brapi/v1/", function(req, res, err){
    process_logs(req, res, err)
  }) %>%
  post("/brapi/v1/", function(req, res, err){
    process_logs(req, res, err)
  }) %>%
  delete("/brapi/v1/calls[/]?", function(req, res, err){
    process_logs(req, res, err)
  })
