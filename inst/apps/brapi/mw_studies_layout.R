
studies_layout_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies_layout.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
  #colnames(res)[2] = "name"
  res
}, error = function(e) {
  NULL
}
)

studies_layout_additionalInfo_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies_layout_additionalInfo.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)


studies_layout_list = function(studyDbId = "any"){
  studies_layout_data <- studies_layout_data[studies_layout_data$studyDbId == studyDbId, ]
  if(nrow(studies_layout_data) == 0) return(NULL)

  n = nrow(studies_layout_data)
  #message(n)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(studies_layout_data[i, ])
    #out$seasons = safe_split(out$seasons, ";")  %>% as.list # %>% list


    additionalInfo =
      studies_layout_additionalInfo_data[
        studies_layout_additionalInfo_data$observationUnitDbId ==
          studies_layout_data$observationUnitDbId[i], -c(1)]
    additionalInfo = tibble::as_tibble(additionalInfo)
    if(nrow(additionalInfo) == 0) {
      additionalInfo = jsonlite::fromJSON("{}")
    } else {
      additionalInfo = additionalInfo[, !is.na(additionalInfo)  %>% as.logical() ]
      additionalInfo = as.list(additionalInfo)
    }
    out[[i]]$additionalInfo = additionalInfo
  }

  attr(out, "status") = list()
  #attr(out, "pagination") = pg$pagination
  out
}


studies_layout = list(
  metadata = list(
    pagination = list(
      pageSize = 0,
      currentPage = 0,
      totalCount = 1,
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result =  list()
)



process_studies_layout <- function(req, res, err){
  studyDbId = basename(stringr::str_replace(req$path, "/layout", ""))

  studies_layout$result$data = studies_layout_list(studyDbId)

  if(is.null(studies_layout$result)){
    res$set_status(404)
    studies_layout$metadata <-
      brapi_status(100,"No matching results.!"
                   , studies_layout$metadata$status)
    studies_layout$result = list()
  }

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(studies_layout)

}


mw_studies_layout <<-
  collector() %>%
  get("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/layout[/]?", function(req, res, err){
    process_studies_layout(req, res, err)
  })  %>%
  put("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/layout[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/layout[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/layout[/]?", function(req, res, err){
    res$set_status(405)
  })

