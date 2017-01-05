
read_study <- function(studyDbId = 1){
  fp = system.file(
    paste0("apps/brapi/data/studies_table_", studyDbId, ".csv"),
    package = "brapi")

  tryCatch({
    readr::read_csv(fp)
  }, error = function(e) {
    NULL
  }
  )
}
#
# studies_table2_data = tryCatch({
#   res <- suppressMessages(
#    readr::read_csv(system.file("apps/brapi/data/studies_table_2.csv", package = "brapi"))
#   )
#   res
# }, error = function(e) {
#   NULL
# }
# )


studies_table_list = function(studyDbId = "any", format = "json"){
  if(!(studyDbId %in% 1:2)) return(NULL)
  df <- read_study(studyDbId)

  cn = colnames(df)
  x = stringr::str_split(cn[16:length(cn)], "\\|") %>% unlist()

  dat = list()
  #class(df) = "matrix"
  df = as.matrix(df)
  for(i in 1:nrow(df)) {
    dat[[i]] = as.vector(df[i, ])
  }

  out = list(
    headerRow = cn[1:15],
    observationVariableDbIds =  x[seq(from = 1, to = length(x), by = 2)],
    observationVariableNames =  x[seq(from = 2, to = length(x), by = 2)],
    data = dat
  )
  attr(out, "status") = list()
  out
}


studies_table = list(
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



process_studies_table <- function(req, res, err){
  studyDbId = basename(stringr::str_replace(req$path, "/table[/]?", ""))
  prms <- names(req$params)
  format = ifelse('format' %in% prms, req$params$format, "json")
  #message(format)

  if(format == "json") {
    studies_table$result = studies_table_list(studyDbId, format)

    if(is.null(studies_table$result$data)){
      res$set_status(404)
      studies_table$metadata <-
        brapi_status(100,"No matching results.!"
                     , studies_table$metadata$status)
      studies_table$result = list()
    }

  }

  if(format %in% c("csv", "tsv")) {
    studies_table$metadata$datafiles = list(list(url = paste0("http://127.0.0.1:2021/brapi/v1/studies/", studyDbId, "/table/", format, "/")))
  }

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(studies_table)

}

process_studies_table_format <- function(req, res, err){
  prms <- names(req$params)
  #format = ifelse('format' %in% prms, req$params$format, "json")
  format = basename(req$path)

  studyDbId = basename(stringr::str_replace(req$path, paste0("/table/", format, "[/]?"), ""))
  # message("---")
  # message(format)
  # message(studyDbId)
  #out = NULL
  #if(format %in% c("csv", "tsv")) {

    out <- read_study(studyDbId)
    txt = ifelse(is.null(out), '', toTextTable(out, format, FALSE))
    #out = as.character(txt)

    #message(out)
    #message(txt)

    if(txt == '') {
      res$set_status(404)
      txt = "No matching results!"
      res$content_type("text/txt")
      res$text(txt)
    } else {
      res$content_type(paste0("text/", format))
      res$text(txt)
    }
  #}
}


mw_studies_table <<-
  collector() %>%
  get("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/table[/]?", function(req, res, err){
    process_studies_table(req, res, err)
  })  %>%
  get("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/table/csv[/]?", function(req, res, err){
    process_studies_table_format(req, res, err)
  })  %>%
  get("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/table/tsv[/]?", function(req, res, err){
    process_studies_table_format(req, res, err)
  })  %>%

  get("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/table/tsv[/]?", function(req, res, err){
    process_studies_table_format(req, res, err)
  })  %>%

  post("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/table[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/studies/[0-9a-zA-Z]{1,12}/table[/]?", function(req, res, err){
    res$set_status(405)
  })

