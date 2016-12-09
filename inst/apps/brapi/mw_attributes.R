library(jug)
library(jsonlite)
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
#source(system.file("apps/brapi/utils/paging.R", package = "brapi"))

attributes_data = tryCatch({
  read.csv(system.file("apps/brapi/data/attributes.csv", package = "brapi"), stringsAsFactors = FALSE)
}, error = function(e){
  NULL
}
)


attributes_list = function(attributeCategoryDbId = 0){
  if(is.null(attributes_data)) return(NULL)
  if(attributeCategoryDbId > 0){
    attributes_data = attributes_data[
      attributes_data$attributeCategoryDbId == attributeCategoryDbId, ]
    if(nrow(attributes_data) == 0) return(NULL)
  }

  n = nrow(attributes_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(attributes_data[i, ])
    if(stringr::str_detect(out[[i]]$values, ";") ) {
      out[[i]]$values = stringr::str_split(out[[i]]$values, ";")[[1]]
    }
  }
  out
}


attributes = list(
  metadata = list(
    pagination = list(
      pageSize = 10000,
      currentPage = 0,
      totalCount = nrow(attributes_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = attributes_list())
)


process_attributes <- function(req, res, err){
  prms <- names(req$params)
  attributeCategoryDbId = ifelse('attributeCategoryDbId' %in% prms,
                                 as.integer(req$params$attributeCategoryDbId), 0)

  attributes$result$data = attributes_list(attributeCategoryDbId)
  #attributes$metadata$pagination = attr(attributes$result$data, "pagination")

  if(is.null(attributes$result$data)){
    res$set_status(404)
    attributes$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(attributes)

}


mw_attributes <<-
  collector() %>%
  get("/brapi/v1/attributes[/]?", function(req, res, err){
    process_attributes(req, res, err)
  }) %>%
  put("/brapi/v1/attributes[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/attributes[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/attributes[/]?", function(req, res, err){
    res$set_status(405)
  })
