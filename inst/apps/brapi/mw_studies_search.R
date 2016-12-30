
studies_search_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies.csv", package = "brapi"),
                  stringsAsFactors = FALSE)[, 1:13]
  colnames(res)[2] = "name"
  res
}, error = function(e) {
  NULL
}
)

studies_search_additionalInfo_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies_additionalinfo.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)


studies_search_list = function(studyType = "any", programDbId = "any",
                        locationDbId = "any", seasonDbId = "any",
                        germplasmDbIds = "any", observationVariableDbIds = "any",
                       active = "any",
                       sortBy = "none", sortOrder = "asc",
                       page = 0, pageSize = 100){


  if(studyType != "any") {
    studies_search_data <- studies_search_data[studies_search_data$studyType == studyType, ]
    if(nrow(studies_search_data) == 0) return(NULL)
  }


  if(programDbId != "any") {
    studies_search_data <- studies_search_data[studies_search_data$programDbId == programDbId, ]
    if(nrow(studies_search_data) == 0) return(NULL)
  }

  if(active != "any") {
    studies_search_data <- studies_search_data[studies_search_data$active == active, ]
    if(nrow(studies_search_data) == 0) return(NULL)
  }

  if(locationDbId != "any" ) {
    studies_search_data <- studies_search_data[studies_search_data$locationDbId == locationDbId, ]
    if(nrow(studies_search_data) == 0) return(NULL)
  }

  if(seasonDbId != "any" ) {
    studies_search_data <- studies_search_data[studies_search_data$seasons == seasonDbId, ]
    if(nrow(studies_search_data) == 0) return(NULL)
  }

  # TODO germplasmDbIds

  # TODO observationVariableDbIds


  if(sortBy != "none" & sortBy %in% colnames(studies_search_data)){
    dcr = ifelse(sortOrder == "asc", FALSE, TRUE)
    studies_search_data <- studies_search_data[ order( studies_search_data[, sortBy], decreasing = dcr), ]
  }

  # paging here after filtering
  pg = paging(studies_search_data, page, pageSize)
  studies_search_data <- studies_search_data[pg$recStart:pg$recEnd, ]

  n = nrow(studies_search_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- studies_search_data[i, ] %>% as.list
    out[[i]]$seasons = safe_split(out[[i]]$seasons, ";")  %>% as.list


    additionalInfo =
      studies_search_additionalInfo_data[studies_search_additionalInfo_data$studyDbId == studies_search_data$studyDbId[i],
                                    -c(1)]
    if(nrow(additionalInfo) == 0) {
      out[[i]] = list(additionalInfo = NULL)
    } else {
      additionalInfo = additionalInfo[, !is.na(additionalInfo)  %>% as.logical() ]
      additionalInfo = as.list(out[[i]], additionalInfo)
    }
    out[[i]]$additionalInfo = additionalInfo
    #out[[i]] = list(out[[i]], additionalInfo = additionalInfo)
  }

  attr(out, "status") = list()
  attr(out, "pagination") = pg$pagination
  out
}


studies_search = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(studies_search_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list()
)



process_studies_search <- function(req, res, err){
  prms <- names(req$params)

  studyType = ifelse('studyType' %in% prms, req$params$studyType, "any")
  seasonDbId = ifelse('seasonDbId' %in% prms, req$params$seasonDbId, "any")
  programDbId = ifelse('programDbId' %in% prms, req$params$programDbId, "any")
  locationDbId = ifelse('locationDbId' %in% prms, req$params$locationDbId, "any")
  active = ifelse('active' %in% prms, req$params$active, "any")

  #germplasmDbIds = ifelse('germplasmDbIds' %in% prms, req$params$germplasmDbIds, "any")
  germplasmDbIds = req$params[stringr::str_detect(names(req$params), "germplasmDbIds")] %>% paste(collapse = ",")
  germplasmDbIds = safe_split(germplasmDbIds, ",")

  #observationVariableDbIds = ifelse('observationVariableDbIds' %in% prms, req$params$observationVariableDbIds, "any")
  observationVariableDbIds = req$params[stringr::str_detect(names(req$params), "observationVariableDbIds")] %>% paste(collapse = ",")
  observationVariableDbIds = safe_split(observationVariableDbIds, ",")

  sortBy = ifelse('sortBy' %in% prms, req$params$sortBy, "none")
  sortOrder = ifelse('sortOrder' %in% prms, req$params$sortOrder, "asc")

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 1000)

  studies_search$result$data = studies_search_list(
    studyType, programDbId, locationDbId, seasonDbId,
    germplasmDbIds, observationVariableDbIds,
    active, sortBy, sortOrder,
    page, pageSize)
  studies_search$metadata$pagination = attr(studies_search$result$data, "pagination")#,
                            #status = attr(studies_search$result, "status"),
                            #datafiles = list())

  if(is.null(studies_search$result$data)){
    res$set_status(404)
    studies_search$metadata <-
      brapi_status(100,"No matching results.!"
                   , studies_search$metadata$status)
    studies_search$result = list()
  }

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(studies_search)

}


mw_studies_search <<-
  collector() %>%
  get("/brapi/v1/studies-search[/]?", function(req, res, err){
    process_studies_search(req, res, err)
  })  %>%
  put("/brapi/v1/studies-search[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/studies-search[/]?", function(req, res, err){
    process_studies_search(req, res, err)
  }) %>%
  delete("/brapi/v1/studies-search[/]?", function(req, res, err){
    res$set_status(405)
  })

