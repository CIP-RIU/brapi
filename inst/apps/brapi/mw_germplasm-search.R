library(jug)
library(jsonlite)
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))
source(system.file("apps/brapi/utils/get_germplasm.R", package = "brapi"))


process_germplasm_search <- function(req, res, err){
  prms <- names(req$params)
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 100)
  germplasmDbId = ifelse('germplasmDbId' %in% prms, as.integer(req$params$germplasmDbId), 0)
  germplasmName = ifelse('germplasmName' %in% prms, req$params$germplasmName, "none")
  germplasmPUI = ifelse('germplasmPUI' %in% prms, req$params$germplasmPUI, "none")

  germplasm_search$result$data =
    germplasm_search_list(
      germplasmDbId, germplasmName, germplasmPUI,
      page, pageSize)
  germplasm_search$metadata$pagination = attr(germplasm_search$result$data, "pagination")

  if(is.null(germplasm_search$result$data)){
    res$set_status(404)
    germplasm_search$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(germplasm_search)

}

mw_germplasm_search <<-
  collector() %>%
  get("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    process_germplasm_search(req, res, err)
  }) %>%
  put("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    #res$set_status(405)
    process_germplasm_search(req, res, err)
  }) %>%
  delete("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    res$set_status(405)
  })
