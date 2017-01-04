
studies_observations_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies_observations.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
  res
}, error = function(e) {
  NULL
}
)

studies_observations_list = function(studyDbId = "any", observationVariableDbId = "any", page = 0, pageSize = 1000){
  studies_observations_data <- studies_observations_data[studies_observations_data$studyDbId == studyDbId, ]
  studies_observations_data <- studies_observations_data[studies_observations_data$observationVariableDbId %in% observationVariableDbId, ]

  if(nrow(studies_observations_data) == 0) return(NULL)

  # paging here after filtering
  pg = paging(studies_observations_data, page, pageSize)
  studies_observations_data <- studies_observations_data[pg$recStart:pg$recEnd, ]


  n = nrow(studies_observations_data)
  #message(n)
  out = list(n)

  for(i in 1:n){
    out[[i]] <- as.list(studies_observations_data[i, ])
  }

  attr(out, "status") = list()
  attr(out, "pagination") = pg$pagination

  out
}


studies_observations = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(studies_observations_data),
      totalPages = 0
    ),
    status = list(),
    datafiles = list()
  ),
  result =  list()
)



process_studies_observations <- function(req, res, err){
  studyDbId = basename(stringr::str_replace(req$path, "/observations[/]?", ""))

  prms <- names(req$params)

  #observationVariableDbId = ifelse('observationVariableDbIds' %in% prms, req$params$observationVariableDbId, "any")

  observationVariableDbId = req$params[stringr::str_detect(names(req$params), "observationVariableDbIds")] %>%
    paste(collapse = ",")
  observationVariableDbId = safe_split(observationVariableDbId, ",")


  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 1000)

  studies_observations$result$data = studies_observations_list(studyDbId, observationVariableDbId, page, pageSize)
  print(studies_observations$result$data)

  if(is.null(studies_observations$result$data)){
    res$set_status(404)
    studies_observations$metadata <-
      brapi_status(100,"No matching results.!"
                   , studies_observations$metadata$status)
    studies_observations$result = list()
  }

  studies_observations$metadata = list(pagination = attr(studies_observations$result$data, "pagination"),
                            status = attr(studies_observations$result$data, "status"),
                            datafiles = list())

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(studies_observations)

}


mw_studies_observations <<-
  collector() %>%
  get("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observations[/]?", function(req, res, err){
    process_studies_observations(req, res, err)
  })  %>%
  put("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observations[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observations[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/observations[/]?", function(req, res, err){
    res$set_status(405)
  })

