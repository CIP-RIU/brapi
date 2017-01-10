library(jug)
library(jsonlite)

variables_datatypes_data = readLines(system.file("apps/brapi/data/variables_datatypes.txt", package = "brapi"))

variables_datatypes = list(
  metadata = list(
    pagination =
    list(
    pageSize = 0,
    currentPage = 0,
    totalCount = 0,
    totalPages = 0
    )
      ,
    status = list(),
    datafiles = list()
  ),
  result = list(data = variables_datatypes_data)
  )

mw_variables_datatypes <<-
  collector() %>%
   get("/brapi/v1/variables/datatypes[/]?", function(req, res, err){
     res$set_header("ContentType", "text/plain")
     res$set_status(200)
     res$text(paste(variables_datatypes_data, collapse = ", "))
     res$json(variables_datatypes)
  }) %>%
  post("/brapi/v1/variables/datatypes[/]?", function(req, res, err){
    res$set_status(405)
  })  %>%
  put("/brapi/v1/variables/datatypes[/]?", function(req, res, err){
    res$set_status(405)
  })  %>%
  delete("/brapi/v1/variables/datatypes[/]?", function(req, res, err){
    res$set_status(405)
  })

