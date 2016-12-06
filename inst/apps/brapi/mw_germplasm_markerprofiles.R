library(jug)
library(jsonlite)
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))


germplasm_markerprofiles_data = tryCatch({
  x <- read.csv(system.file("apps/brapi/data/germplasm_markerprofiles.csv",
                       package = "brapi"),
           stringsAsFactors = FALSE)
  x$germplasmDbId <- as.integer(x$germplasmDbId)
  x
}, error = function(e){
  NULL
}
)


germplasm_markerprofiles_list = function(germplasmDbId = 0){
  if(is.null(germplasm_markerprofiles_data)) return(NULL)
  if(germplasmDbId > 0){
    germplasm_markerprofiles_data =
      germplasm_markerprofiles_data[
        germplasm_markerprofiles_data$germplasmDbId == germplasmDbId, ]
    if(nrow(germplasm_markerprofiles_data) == 0) return(NULL)
  } else {
    return(NULL)
  }
  #out <- germplasm_markerprofiles_data$ %>% as.list
  out <- list(
    germplasmDbId = germplasmDbId,
    markerProfiles = germplasm_markerprofiles_data$markerProfiles
  )

  attr(out, "pagination") = NULL
  out
}


germplasm_markerprofiles = list(
  metadata = list(
    pagination = NULL,
    status = list(),
    datafiles = list()
  ),
  result = germplasm_search_list()
)

process_germplasm_markerprofiles <- function(req, res, err){
  germplasmDbId <- basename(stringr::str_replace(req$path, "/markerprofiles[/]?", "")) %>%
    as.integer()

  germplasm_markerprofiles$result = germplasm_markerprofiles_list(germplasmDbId)
  germplasm_markerprofiles$metadata = list(pagination = NULL, status = list(),
                                   datafiles = list())

  if(is.null(germplasm_markerprofiles$result)){
    res$set_status(404)
    germplasm_markerprofiles$metadata <-
      brapi_status(100,"No matching results!")
      #result = list()
    germplasm_markerprofiles$result = list()

  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(germplasm_markerprofiles)

}


mw_germplasm_markerprofiles <<-
  collector() %>%
  get("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}/markerprofiles[/]?", function(req, res, err){
    #res$set_status(501)
    process_germplasm_markerprofiles(req, res, err)
  }) %>%
  put("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}/markerprofiles[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}/markerprofiles[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}/markerprofiles[/]?", function(req, res, err){
    res$set_status(405)
  })
