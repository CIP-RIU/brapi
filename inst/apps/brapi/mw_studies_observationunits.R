
studies_observationunits_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies_observations.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
  res
}, error = function(e) {
  NULL
}
)

studies_observationunits_list = function(studyDbId = "any", observationLevel = "plot"){
  studies_observationunits_data <- studies_observationunits_data[
    studies_observationunits_data$studyDbId == studyDbId, ]

  if(nrow(studies_observationunits_data) == 0) return(NULL)

  # paging here after filtering

  ouid = unique(studies_observationunits_data$observationUnitDbId)
  n = length(ouid)
  #message(n)
  out = list(n)

  for(i in 1:n){
    odat = studies_observationunits_data[studies_observationunits_data$observationUnitDbId == ouid[i], ]
    odat1 = odat[1, ]
    obsLevel = ifelse(observationLevel == "plant", "plantNumber", "plotNumber")
    out[[i]] <- as.list(odat1[1,
                   c("observationUnitDbId", "observationUnitName", "germplasmDbId", "germplasmName",
                     "pedigree", "entryNumber", "entryType", obsLevel, "blockNumber", "X", "Y",
                     "replicate") ])

    obid = unique(odat$observationVariableDbId)
    m = length(obid)
    obs = list(m)
    for(j in 1:m){
      obs[[j]] <- as.list(odat[odat$observationVariableDbId == obid[j],
                   c("observationDbId", "observationVariableDbId", "observationVariableName",
                     "operator", "observationTimestamp", "value")])
      names(obs[[j]])[4:5] = c("collector", "observationTimeStamp")
    }
    out[[i]]$observations = obs


  }

  attr(out, "status") = list()
  #attr(out, "pagination") = pg$pagination

  out
}


studies_observationunits = list(
  metadata = list(
    pagination = list(
      pageSize = 0,
      currentPage = 0,
      totalCount = 0,
      totalPages = 0
    ),
    status = list(),
    datafiles = list()
  ),
  result =  list()
)



process_studies_observationunits <- function(req, res, err){
  studyDbId = basename(stringr::str_replace(req$path, "/observationunits[/]?", ""))

  prms <- names(req$params)

  observationLevel = ifelse('observationLevel' %in% prms, req$params$observationLevel, "any")

  studies_observationunits$result$data = studies_observationunits_list(studyDbId, observationLevel)

  if(is.null(studies_observationunits$result$data)){
    res$set_status(404)
    studies_observationunits$metadata <-
      brapi_status(100,"No matching results.!"
                   , studies_observationunits$metadata$status)
    studies_observationunits$result = list()
  }

  # studies_observationunits$metadata = list(#pagination = attr(studies_observationunits$result$data, "pagination"),
  #                           status = attr(studies_observationunits$result$data, "status"),
  #                           datafiles = list())

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(studies_observationunits)

}


mw_studies_observationunits <<-
  collector() %>%
  get("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observationunits[/]?", function(req, res, err){
    process_studies_observationunits(req, res, err)
  })  %>%
  put("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observationunits[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observationunits[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observationunits[/]?", function(req, res, err){
    res$set_status(405)
  })

