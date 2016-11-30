library(jug)
library(jsonlite)

source(system.file("apps/brapi/brapi_status.R", package = "brapi"))

calls_data = tryCatch({
  read.csv(system.file("apps/brapi/data/calls.csv", package = "brapi"), stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

calls_list = function(datatypes = NULL){
  if(is.null(calls_data)) return(NULL)
  if(!is.null(datatypes)){
    calls_data = calls_data[stringr::str_detect(calls_data$datatypes, datatypes), ]
    if(nrow(calls_data) == 0) return(NULL)
  }

  n = nrow(calls_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(calls_data[i, ])
    if(stringr::str_detect(out[[i]]$datatypes, ";") ) {
      out[[i]]$datatypes = stringr::str_split(out[[i]]$datatypes, ";")[[1]]
    }
    if(stringr::str_detect(out[[i]]$methods, ";") ) {
      out[[i]]$methods = stringr::str_split(out[[i]]$methods, ";")[[1]]
    }

  }
  out
}


calls = list(
  metadata = list(
    pagination = list(
      pageSize = 100,
      currentPage = 1,
      totalCount = nrow(calls_data),
      totalPages = 1
    ),
    status = NULL,
    datafiles = NULL
  ),
  result = list(data = calls_list())
)


process_calls <- function(req, res, err){
  prms <- names(req$params)
  if('datatypes' %in% prms){
    calls$result <- list(data = calls_list(req$params$datatypes))
    calls$metadata$pagination$totalCount = length(calls$result$data)
  }

  if('page' %in% prms | 'pageSize' %in% prms){
    calls$metadata <- brapi_status(code = 200,
                                      "Parameters 'page' and 'pageSize' are not implemented." )
  }


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
