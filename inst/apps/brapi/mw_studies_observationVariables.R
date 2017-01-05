
studies_observationVariables_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies_observationVariables.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
  res
}, error = function(e) {
  NULL
}
)

lst2arr <- function(lst, split = ";"){
  if(lst == "") lst = jsonlite::fromJSON("{}")
  if(length(lst) > 0) {
    lst = safe_split(lst, split)
  }
  lst
}

studies_observationVariables_list = function(studyDbId = "any"){
  studies_observationVariables_data <- studies_observationVariables_data[studies_observationVariables_data$studyDbId == studyDbId, ]

  if(nrow(studies_observationVariables_data) == 0) return(NULL)

  # paging here after filtering

  n = nrow(studies_observationVariables_data)
  out = list(n)
  cn = colnames(studies_observationVariables_data)

  for(i in 1:n){
    out[[i]] <- as.list(studies_observationVariables_data[i, -c(1, 2) ])
    #synonyms
    out[[i]]$synonyms <- lst2arr(out[[i]]$synonyms)

    #context of use
    out[[i]]$contextOfUse <- lst2arr(out[[i]]$contextOfUse)

    #trait
    xt = which(stringr::str_detect(cn, "trait\\."))
    xy = studies_observationVariables_data[i, xt]
    if (all(xy == "" | is.na(xy)) | is.null(xy)) xy = jsonlite::fromJSON("{}")
    if (any(xy != "" | !is.na(xy) | !is.null(xy))) {
      colnames(xy) = stringr::str_replace(colnames(xy), "trait\\.", "")
      xy = as.list(xy)

    }
    names(out[[i]])[15] = "trait"
    out[[i]]$trait = xy
    out[[i]][16:(max(xt) - 2)] = NULL

    out[[i]]$trait$synonyms <- lst2arr(out[[i]]$trait$synonyms)
    out[[i]]$trait$alternativeAbbreviations <- lst2arr(out[[i]]$trait$alternativeAbbreviations)


    #method
    xt = which(stringr::str_detect(cn, "method\\."))
    xy = studies_observationVariables_data[i, xt]
    if (all(xy == "" | is.na(xy)) | is.null(xy)) xy = jsonlite::fromJSON("{}")
    if (any(xy != "" | !is.na(xy) | !is.null(xy))) {
      colnames(xy) = stringr::str_replace(colnames(xy), "method\\.", "")
      xy = as.list(xy)
    }
    names(out[[i]])[16] = "method"
    out[[i]]$method = xy
    out[[i]][17:(max(xt) - 2)] = NULL

    #scale
    xt = which(stringr::str_detect(cn, "scale\\."))
    xy = studies_observationVariables_data[i, xt]
    if (all(xy == "" | is.na(xy)) | is.null(xy)) xy = jsonlite::fromJSON("{}")
    if (any(xy != "" | !is.na(xy) | !is.null(xy))) {
      colnames(xy) = stringr::str_replace(colnames(xy), "scale\\.", "")
      xy = as.list(xy)
    }
    out[[i]]$scale = xy
    out[[i]]$scale[6:8] = NULL

    #scale valid values
    xt = which(stringr::str_detect(cn, "scale\\.validValues\\."))
    xy = studies_observationVariables_data[i, xt]
    if (all(xy == "" | is.na(xy)) | is.null(xy)) xy = jsonlite::fromJSON("{}")
    if (any(xy != "" | !is.na(xy) | !is.null(xy))) {
      colnames(xy) = stringr::str_replace(colnames(xy), "scale\\.validValues\\.", "")
      xy = as.list(xy)
    }
    if(jsonlite::toJSON(out[[i]]$scale) != "{}")  out[[i]]$scale$validValues = xy

    #scale valid values categories
    if(jsonlite::toJSON(out[[i]]$scale) != "{}")  out[[i]]$scale$validValues$categories = lst2arr(xy$categories, "; ")
    out[[i]]$defaultValue = studies_observationVariables_data[i, "defaultValue" ]
  }

  attr(out, "status") = list()
  #attr(out, "pagination") = pg$pagination

  res = list(studyDbId = studyDbId,
             trialName = studies_observationVariables_data[1, 2],
             data = out)
  res
}


studies_observationVariables = list(
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



process_studies_observationVariables <- function(req, res, err){
  studyDbId = basename(stringr::str_replace(req$path, "/observationVariables[/]?", ""))

  studies_observationVariables$result = studies_observationVariables_list(studyDbId)

  if(is.null(studies_observationVariables$result$data)){
    res$set_status(404)
    studies_observationVariables$metadata <-
      brapi_status(100,"No matching results.!"
                   , studies_observationVariables$metadata$status)
    studies_observationVariables$result = list()
  }

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(studies_observationVariables)

}


mw_studies_observationVariables <<-
  collector() %>%
  get("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observationVariables[/]?", function(req, res, err){
    process_studies_observationVariables(req, res, err)
  })  %>%
  put("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observationVariables[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observationVariables[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observationVariables[/]?", function(req, res, err){
    res$set_status(405)
  })

