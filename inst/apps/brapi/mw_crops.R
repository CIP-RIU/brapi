library(jug)
library(jsonlite)

crops = readLines("crops.txt")
crops = list(
  metadata = list(
    pagination = list(
      pageSize = 100,
      currentPage = 1,
      totalCount = length(crops),
      totalPages = 1
    ),
    status = NULL,
    datafiles = NULL
  ),
  result = list(data = crops)
  )

mw_crops <-
  collector() %>%
  get("/brapi/v1/crops/", function(req,res,err){
    #res$content_type("text/json")
    #toJSON(crops)
    res$json(crops)
  })
