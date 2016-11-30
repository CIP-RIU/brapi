library(jug)
library(jsonlite)

crops_data = readLines(system.file("apps/brapi/data/crops.txt", package = "brapi"))

crops = list(
  metadata = list(
    pagination = list(
      pageSize = 100,
      currentPage = 1,
      totalCount = length(crops_data),
      totalPages = 1
    ),
    status = NULL,
    datafiles = NULL
  ),
  result = list(data = crops_data)
  )

mw_crops <<-
  collector() %>%
   get("/brapi/v1/crops[/]?", function(req, res, err){
     prms <- names(req$params)
     if('format' %in% prms){
       #message("ok")
       if(req$params$format != "plain") {
         #message("ok")

         res$set_header("ContentType", "text/plain")
         res$set_status(200)
         res$text(paste(crops_data, collapse = ", "))
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

