library(jug)
library(jsonlite)

source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))
source(system.file("apps/brapi/utils/safe_split.R", package = "brapi"))

studyTypes_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studyTypes.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

studyTypes_list = function(page = 0, pageSize = 100){
  if(is.null(studyTypes_data)) return(NULL)

  # paging here after filtering
  pg = paging(studyTypes_data, page, pageSize)
  studyTypes_data <- studyTypes_data[pg$recStart:pg$recEnd, ]

  n = nrow(studyTypes_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(studyTypes_data[i, ])
    #out[[i]]$datatypes = list(safe_split(out[[i]]$datatypes, ";"))
    #out[[i]]$methods = list(safe_split(out[[i]]$methods, ";"))
  }

  attr(out, "pagination") = pg$pagination
  out
}


studyTypes = list(
  metadata = list(
    pagination = list(
      pageSize = 10,
      currentPage = 0,
      totalCount = nrow(studyTypes_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = studyTypes_list())
)


process_studyTypes <- function(req, res, err){
  prms <- names(req$params)
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 100)

  studyTypes$result$data = studyTypes_list(page, pageSize)
  studyTypes$metadata$pagination = attr(studyTypes$result$data, "pagination")


  if(is.null(studyTypes$result$data)){
    res$set_status(404)
    studyTypes$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(studyTypes)
}


mw_studytypes <<-
  collector() %>%
  get("/brapi/v1/studyTypes[/]?", function(req, res, err){
    process_studyTypes(req, res, err)
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
