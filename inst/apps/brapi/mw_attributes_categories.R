library(jug)
library(jsonlite)
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))

attributes_categories_data = tryCatch({
  read.csv(system.file("apps/brapi/data/attributes_categories.csv", package = "brapi"), stringsAsFactors = FALSE)
}, error = function(e){
  NULL
}
)


attributes_categories_list = function(page=0, pageSize = 100){
  if(is.null(attributes_categories_data)) return(NULL)
  # paging here after filtering
  pg = paging(attributes_categories_data, page, pageSize)
  attributes_categories_data <- attributes_categories_data[pg$recStart:pg$recEnd, ]

  n = nrow(attributes_categories_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(attributes_categories_data[i, ])
  }
  attr(out, "pagination") = pg$pagination
  out
}


attributes_categories = list(
  metadata = list(
    pagination = list(
      pageSize = 10,
      currentPage = 0,
      totalCount = nrow(attributes_categories_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = attributes_categories_list())
)


process_attributes_categories <- function(req, res, err){
  prms <- names(req$params)
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 100)

  attributes_categories$result$data = attributes_categories_list(page, pageSize)
  attributes_categories$metadata$pagination =
    attr(attributes_categories$result$data, "pagination")

  if(is.null(attributes_categories$result$data)){
    res$set_status(404)
    attributes_categories$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(attributes_categories)

}


mw_attributes_categories <<-
  collector() %>%
  get("/brapi/v1/attributes/categories[/]?", function(req, res, err){
    process_attributes_categories(req, res, err)
  }) %>%
  put("/brapi/v1/attributes/categories[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/attributes/categories[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/attributes/categories[/]?", function(req, res, err){
    res$set_status(405)
  })
