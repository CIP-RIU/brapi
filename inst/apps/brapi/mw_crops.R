library(jug)
library(jsonlite)

crops_data = readLines(system.file("apps/brapi/data/crops.txt", package = "brapi"))

crops = list(
  metadata = list(
    pagination = NULL
      #list(
      # pageSize = 100,
      # currentPage = 0,
      # totalCount = length(crops_data),
      # totalPages = 1
    #)
      ,
    status = list(),
    datafiles = list()
  ),
  result = list(data = crops_data)
  )

mw_crops <<-
  collector() %>%
   get("[/a-z]*/brapi/v1/crops[/]?", function(req, res, err){
     prms <- names(req$params)
     if('format' %in% prms){
       #message("ok")
       if(req$params$format == "plain") {
         #message("ok")

         res$set_header("ContentType", "text/plain")
         res$set_status(200)
         res$text(paste(crops_data, collapse = ", "))
       } else {
         res$json(crops)
       }
     } else {
       res$json(crops)
     }
     res

  }) %>%
  post("/brapi/v1/crops[/]?", function(req, res, err){
    res$set_status(405)
  })  %>%
  put("/brapi/v1/crops[/]?", function(req, res, err){
    res$set_status(405)
  })  %>%
  delete("/brapi/v1/crops[/]?", function(req, res, err){
    res$set_status(405)
  })

