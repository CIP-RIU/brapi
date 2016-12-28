
trials_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/trials.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

studies_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

trials_additionalInfo_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/trials_additionalinfo.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)


trials_list = function(programDbId = "any", locationDbId = "any",
                       active = "any",
                       sortBy = "none", sortOrder = "asc",
                       page = 0, pageSize = 100){
  # if(is.null(trials_data)) return(NULL)
  # if(locationType != "all") {
  #   trials_data = trials_data[
  #     stringr::str_detect(trials_data$locationType, locationType), ]
  #   if(nrow(trials_data) == 0) return(NULL)
  # }

  # paging here after filtering
  pg = paging(trials_data, page, pageSize)
  trials_data <- trials_data[pg$recStart:pg$recEnd, ]

  n = nrow(trials_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- trials_data[i, ]
    # Note: additionalInfo insertion fails if only one column has a value in a row

    studiesd = studies_data[studies_data$trialDbId == i, c("studyDbId", "studyName", "locationName")]
    if(nrow(studiesd) == 0) {
      studieso = list()
    } else {
      o = nrow(studiesd)
      studieso = list(o)
      for(k in 1:o){
        studieso[[k]] = as.list(studiesd[k, ])
      }

    }
    out[[i]]$studies = list(studieso)

    additionalInfo =
      trials_additionalInfo_data[trials_additionalInfo_data$trialDbId == i,
                                    -c(1)]
    if(nrow(additionalInfo) == 0) {
      additionalInfo = NULL
    } else {
      additionalInfo = additionalInfo[, !is.na(additionalInfo)  %>% as.logical() ]
      additionalInfo = as.list(additionalInfo)
    }
    out[[i]]$additionalInfo = list(additionalInfo)




  }

  attr(out, "status") = list()
  attr(out, "pagination") = pg$pagination
  out
}


trials = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(trials_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = trials_data
)



process_trials <- function(req, res, err){
  prms <- names(req$params)

  programDbId = ifelse('programDbId' %in% prms, req$params$programDbId, "any")
  locationDbId = ifelse('locationDbId' %in% prms, req$params$locationDbId, "any")
  active = ifelse('active' %in% prms, req$params$active, "any")
  sortBy = ifelse('sortBy' %in% prms, req$params$sortBy, "none")
  sortOrder = ifelse('sortOrder' %in% prms, req$params$sortOrder, "asc")

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 1000)



  trials$result = trials_list(programDbId, locationDbId, active, sortBy, sortOrder,
                              page, pageSize)
  trials$metadata = list(pagination = attr(trials$result, "pagination"),
                            status = attr(trials$result, "status"),
                            datafiles = list())

  if(is.null(trials$result)){
    res$set_status(404)
    trials$metadata <-
      brapi_status(100,"No matching results.!"
                   , trials$metadata$status)
    trials$result = list()
  }

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(trials)

}



mw_trials <<-
  collector() %>%
  get("/brapi/v1/trials[/]?", function(req, res, err){
    process_trials(req, res, err)
  })  %>%
  put("/brapi/v1/trials[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/trials[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/trials[/]?", function(req, res, err){
    res$set_status(405)
  })
