library(jug)
library(jsonlite)
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))
source(system.file("apps/brapi/utils/get_germplasm.R", package = "brapi"))

process_germplasm_pedigree <- function(req, res, err){
  prms <- names(req$params)
  notation = ifelse('notation' %in% prms, req$params$notation, "purdue")
  germplasmDbId <- basename(stringr::str_replace(req$path, "/pedigree[/]?", "")) %>%
    as.integer()

  germplasm_search$result$data = germplasm_search_list(germplasmDbId)
  germplasm_search$metadata = list(pagination = NULL, status = NULL,
                                   datafiles = list())

  if(is.null(germplasm_search$result$data)){
    res$set_status(404)
    germplasm_search$metadata <- brapi_status(100, "No matching results!")
  } else {
    # extract pedigree info
    ped = germplasm_search$result$data[[1]]$pedigree
    if(stringr::str_detect(ped, " / ")){
      prs = stringr::str_split(ped, " / ")[[1]]
      pr1 = germplasm_search_data[germplasm_search_data$accessionNumber == prs[1], 1] %>%
        as.integer()

      pr2 = germplasm_search_data[germplasm_search_data$accessionNumber == prs[2], 1] %>%
        as.integer()
    } else {
      pr1 = pr2 = ped
    }
    info = list(
      germplasmDbId = germplasmDbId,
      pedigree = ped,
      parent1Id = pr1,
      parent2Id = pr2
    )
    germplasm_search$result = info
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(germplasm_search)

}


mw_germplasm_pedigree <<-
  collector() %>%
  get("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}/pedigree[/]?", function(req, res, err){
    #res$set_status(501)
    process_germplasm_pedigree(req, res, err)
  }) %>%
  put("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}/pedigree[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}/pedigree[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}/pedigree[/]?", function(req, res, err){
    res$set_status(405)
  })
