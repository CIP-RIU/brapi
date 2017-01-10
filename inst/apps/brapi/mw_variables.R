
variables_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies_observationVariables.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
  res[!duplicated(res$observationVariableDbId), 3:ncol(res)]
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

variables_list = function(observationVariableDbId = "all", traitClass = "all",
                          pageSize = 1000, page = 0){
  if(observationVariableDbId != "all") {
    variables_data <- variables_data[variables_data$observationVariableDbId == observationVariableDbId, ]
  }
  if(nrow(variables_data) == 0) return(NULL)

  if(traitClass != "all") {
    variables_data <- variables_data[
      stringr::str_detect(toupper(variables_data$trait.class), toupper(traitClass)), ]
  }
  if(nrow(variables_data) == 0) return(NULL)


  # paging here after filtering
  pg = paging(variables_data, page, pageSize)
  variables_data <- variables_data[pg$recStart:pg$recEnd, ]


  # paging here after filtering

  n = nrow(variables_data)
  out = list(n)
  cn = colnames(variables_data)

  for(i in 1:n){
    out[[i]] <- as.list(variables_data[i, ] )
    #synonyms
    out[[i]]$synonyms <- lst2arr(out[[i]]$synonyms)

    #context of use
    out[[i]]$contextOfUse <- lst2arr(out[[i]]$contextOfUse)

    #trait
    xt = which(stringr::str_detect(cn, "trait\\."))
    xy = variables_data[i, xt]
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
    xy = variables_data[i, xt]
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
    xy = variables_data[i, xt]
    if (all(xy == "" | is.na(xy)) | is.null(xy)) xy = jsonlite::fromJSON("{}")
    if (any(xy != "" | !is.na(xy) | !is.null(xy))) {
      colnames(xy) = stringr::str_replace(colnames(xy), "scale\\.", "")
      xy = as.list(xy)
    }
    out[[i]]$scale = xy
    out[[i]]$scale[6:8] = NULL

    #scale valid values
    xt = which(stringr::str_detect(cn, "scale\\.validValues\\."))
    xy = variables_data[i, xt]
    if (all(xy == "" | is.na(xy)) | is.null(xy)) xy = jsonlite::fromJSON("{}")
    if (any(xy != "" | !is.na(xy) | !is.null(xy))) {
      colnames(xy) = stringr::str_replace(colnames(xy), "scale\\.validValues\\.", "")
      xy = as.list(xy)
    }
    if(jsonlite::toJSON(out[[i]]$scale) != "{}")  out[[i]]$scale$validValues = xy

    #scale valid values categories
    if(jsonlite::toJSON(out[[i]]$scale) != "{}")  out[[i]]$scale$validValues$categories = lst2arr(xy$categories, "; ")
    out[[i]]$defaultValue = variables_data[i, "defaultValue" ]
  }

  attr(out, "status") = list()
  attr(out, "pagination") = pg$pagination

  res = list(
    data = out)
  res
}


variables = list(
  metadata = list(
    pagination = list(
      pageSize = 0,
      currentPage = 0,
      totalCount = nrow(variables_data),
      totalPages = 0
    ),
    status = list(),
    datafiles = list()
  ),
  result =  list()
)



process_variables <- function(req, res, err){
  observationVariableDbId = basename(req$path)
  prms <- names(req$params)

  #message(observationVariableDbId)
  observationVariableDbId = ifelse(observationVariableDbId != "variables", observationVariableDbId, "all")
  traitClass = ifelse('traitClass' %in% prms, req$params$traitClass, "all")
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 10000)

  variables$result = variables_list(observationVariableDbId, traitClass, pageSize, page)
  variables$metadata$pagination = attr(variables$result$data, "pagination")

  if(is.null(variables$result$data)){
    res$set_status(404)
    variables$metadata <-
      brapi_status(100,"No matching results.!"
                   , variables$metadata$status)
    variables$result = list()
  }

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(variables)

}

mw_variables <<-
  collector() %>%
  get("/brapi/v1/variables[/]?", function(req, res, err){
    process_variables(req, res, err)
  })  %>%
  put("/brapi/v1/variables[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/variables[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/variables[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  get("/brapi/v1/variables/[0-9a-zA-Z_:]{1,18}[/]?", function(req, res, err){
    process_variables(req, res, err)
  })  %>%
  put("/brapi/v1/variables/[0-9a-zA-Z_:]{1,18}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/variables/[0-9a-zA-Z_:]{1,18}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/variables/[0-9a-zA-Z_:]{1,18}[/]?", function(req, res, err){
    res$set_status(405)
  })

