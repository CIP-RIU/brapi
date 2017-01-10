# library(jug)
# library(jsonlite)
#
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))
source(system.file("apps/brapi/utils/safe_split.R", package = "brapi"))
#

calls_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/calls.csv", package = "brapi"),
           stringsAsFactors = FALSE)
  res[stringr::str_detect(res$clients, "brapi"), 3:5]
}, error = function(e) {
  NULL
}
)

calls_list = function(datatypes = "all", page = 0, pageSize = 100){
  if(is.null(calls_data)) return(NULL)
  if(datatypes != "all") {
    calls_data = calls_data[stringr::str_detect(calls_data$datatypes, datatypes), ]
    if(nrow(calls_data) == 0) return(NULL)
  }

  # paging here after filtering
  pg = paging(calls_data, page, pageSize)
  calls_data <- calls_data[pg$recStart:pg$recEnd, ]

  n = nrow(calls_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(calls_data[i, ])
    out[[i]]$datatypes = list(safe_split(out[[i]]$datatypes, ";"))
    out[[i]]$methods = list(safe_split(out[[i]]$methods, ";"))
  }

  attr(out, "pagination") = pg$pagination
  out
}


calls = list(
  metadata = list(
    pagination = list(
      pageSize = 10,
      currentPage = 0,
      totalCount = nrow(calls_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = calls_list())
)


process_calls <- function(req, res, err){
  prms <- names(req$params)
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 100)
  datatypes = ifelse(('datatypes' %in% prms), req$params$datatypes, "all")

  calls$result$data = calls_list(datatypes, page, pageSize)
  calls$metadata$pagination = attr(calls$result$data, "pagination")


  if(is.null(calls$result$data)){
    res$set_status(404)
    calls$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(calls)
}



mw_calls <<-
  collector() %>%
  get("/brapi/v1/calls[/]?", function(req, res, err){
    process_calls(req, res, err)
  }) %>%
  put("/brapi/v1/calls[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/calls[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/calls[/]?", function(req, res, err){
    res$set_status(405)
  })
