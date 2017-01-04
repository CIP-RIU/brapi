
studies_germplasm_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies_germplasm.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
  res
}, error = function(e) {
  NULL
}
)

studies_germplasm_list = function(studyDbId = "any", page = 0, pageSize = 1000){
  studies_germplasm_data <- studies_germplasm_data[studies_germplasm_data$studyDbId == studyDbId, ]
  if(nrow(studies_germplasm_data) == 0) return(NULL)

  # paging here after filtering
  pg = paging(studies_germplasm_data, page, pageSize)
  studies_germplasm_data <- studies_germplasm_data[pg$recStart:pg$recEnd, ]


  n = nrow(studies_germplasm_data)
  #message(n)
  out = list(n)
  trl = unique(studies_germplasm_data$trialName)
  for(i in 1:n){
    out[[i]] <- as.list(studies_germplasm_data[i, -c(1, 2)])
    syn <- safe_split(out[[i]]$synonyms)
    # message(syn)
    # message("+++")
    if(any(syn == "")) {
      syn = jsonlite::fromJSON("{}")
    } else {
      syn = as.list(syn)
    }
    #message(syn)
    out[[i]]$synonyms <- syn
  }

  attr(out, "status") = list()
  attr(out, "pagination") = pg$pagination

  res = list(studyDbId = studyDbId,
             trialName = trl,
             data = out)
  res
}


studies_germplasm = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(studies_germplasm_data),
      totalPages = 0
    ),
    status = list(),
    datafiles = list()
  ),
  result =  list()
)



process_studies_germplasm <- function(req, res, err){
  studyDbId = basename(stringr::str_replace(req$path, "/germplasm[/]?", ""))

  prms <- names(req$params)

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 1000)

  studies_germplasm$result = studies_germplasm_list(studyDbId, page, pageSize)

  if(is.null(studies_germplasm$result)){
    res$set_status(404)
    studies_germplasm$metadata <-
      brapi_status(100,"No matching results.!"
                   , studies_germplasm$metadata$status)
    studies_germplasm$result = list()
  }

  studies_germplasm$metadata = list(pagination = attr(studies_germplasm$result$data, "pagination"),
                            status = attr(studies_germplasm$result$data, "status"),
                            datafiles = list())

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(studies_germplasm)

}


mw_studies_germplasm <<-
  collector() %>%
  get("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/germplasm[/]?", function(req, res, err){
    process_studies_germplasm(req, res, err)
  })  %>%
  put("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/germplasm[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/germplasm[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/germplasm[/]?", function(req, res, err){
    res$set_status(405)
  })

