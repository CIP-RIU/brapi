markerprofiles_id_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/markerprofiles.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

markerprofiles_id_alleles_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/markerprofiles_alleles.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)


markerprofiles_id_list = function(#germplasmDbId = 0,
  markerprofilesDbId = 0,
            unknownString = "empty_string", expandHomozygotes = TRUE,
            sepPhased ="empty_string", sepUnphased ="empty_string",
                        page = 0, pageSize = 1000){

  # markerprofiles_id_data <- markerprofiles_id_data[markerprofiles_id_data$germplasmDbId == germplasmDbId, ]
  # if(nrow(markerprofiles_id_data) == 0) return(NULL)

  if(markerprofilesDbId > 0){
    markerprofiles_id_data <- markerprofiles_id_data[markerprofiles_id_data$markerProfilesDbId == markerprofilesDbId, ]
  }
  if(nrow(markerprofiles_id_data) == 0) return(NULL)
  if(!any(markerprofilesDbId == markerprofiles_id_alleles_data$markerprofilesDbId)) return(NULL)

  # paging here after filtering
  x <- markerprofiles_id_alleles_data[markerprofiles_id_alleles_data$markerprofilesDbId == markerprofilesDbId, 3:4]

  pg = paging(x, page, pageSize)
  x <- x[pg$recStart:pg$recEnd, ]

  markerprofiles_id_data = markerprofiles_id_data[, !names(markerprofiles_id_data) %in% c("synonyms", "sampleDbId", "studyDbId", "resultCount" )]
  n = nrow(markerprofiles_id_data)
  #message(n)
  out = list(n)
  for (i in 1:n){
    out[[i]] <- as.list(markerprofiles_id_data[i, ])

    if(!is.null(markerprofiles_id_alleles_data)) {

      y <- sapply(x, function(x) ifelse(is.na(x), "", x))
      nn <- nrow(y)
      if(!is.null(nn)){
        out[[i]]$data = list(nn)
        z1 = sapply(y[, 2], list)
        names(z1) = y[, 1]
        #out[[i]]$data <- z1
        for (j in 1:nn) {
          out[[i]]$data[[j]] <- z1[j]
        }
      } else {
        out[[i]]$data <- list(as.vector(y))
      }

    }
  }

  attr(out, "pagination") = pg$pagination
  out
}


markerprofiles_id = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(markerprofiles_id_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = markerprofiles_id_list())
)


process_markerprofiles_id <- function(req, res, err){
  #message(basename(req$path))
  markerprofilesDbId <- basename(req$path) %>% as.integer()

  prms <- names(req$params)

  #markerprofilesDbId = ifelse('markerprofilesDbId' %in% prms, req$params$markerprofilesDbId, 0)
  unknownString = ifelse('unknownString' %in% prms, req$params$unknownString, "empty_string")
  expandHomozygotes = ifelse('expandHomozygotes' %in% prms, req$params$expandHomozygotes, TRUE)
  sepPhased = ifelse('sepPhased' %in% prms, req$params$sepPhased, 0)
  sepUnphased = ifelse('sepUnphased' %in% prms, req$params$sepUnphased, 0)

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 10000)

  #message(germplasmDbId)
  #message(markerprofilesDbId)

  markerprofiles_id$result$data = markerprofiles_id_list(
    #germplasmDbId,
    markerprofilesDbId,
    unknownString, expandHomozygotes, sepPhased, sepUnphased,
    page, pageSize)
  markerprofiles_id$metadata$pagination = attr(markerprofiles_id$result$data, "pagination")


  if(is.null(markerprofiles_id$result$data)){
    res$set_status(404)
    markerprofiles_id$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(markerprofiles_id)
}


mw_markerprofiles_id <<-
  collector() %>%
  get("/brapi/v1/markerprofiles/[a-zA-Z0-9]{1,12}[/]?", function(req, res, err){
    process_markerprofiles_id(req, res, err)
  }) %>%
  put("/brapi/v1/markerprofiles[a-zA-Z0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/markerprofiles[a-zA-Z0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/markerprofiles[a-zA-Z0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  })
