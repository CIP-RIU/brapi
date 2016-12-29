
studiesid_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
  #colnames(res)[2] = "name"
  res
}, error = function(e) {
  NULL
}
)

studiesid_additionalInfo_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/studies_additionalinfo.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

studiesid_contacts_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/contacts.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
  res
}, error = function(e) {
  NULL
}
)


locations1_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/locations.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)


locations1_additionalInfo_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/locations_additionalinfo.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)


studies_list = function(studyDbId = "any"){
  studiesid_data <- studiesid_data[studiesid_data$studyDbId == studyDbId, ]
  if(nrow(studiesid_data) == 0) return(NULL)

   i = 1
    out <- as.list(studiesid_data[i, ])
    out$seasons = safe_split(out$seasons, ";")  %>% as.list # %>% list

    additionalInfoL =
      locations1_additionalInfo_data[locations1_additionalInfo_data$locationDbId == out$locationDbId,
                                    -c(1)]
    if(nrow(additionalInfoL) == 0) {
      additionalInfoL = NULL
    } else {
      additionalInfoL = additionalInfoL[, !is.na(additionalInfoL)  %>% as.logical() ] %>% as.list
      #additionalInfo = as.list(additionalInfoL)
      #$message(additionalInfoL)
    }

    locations1_data = locations1_data[locations1_data$locationDbId == out$locationDbId,  ] %>% as.list
    locations1_data$additionalInfo = additionalInfoL

    out$location = locations1_data

    out$locationDbId = NULL
    out$locationName = NULL
    #
    contact_s = safe_split(studiesid_data[i, "contactDbId"], ";")
    out$contactDbId <- NULL
    out$contacts <- list(as.list(NULL))
    if(all(contact_s != "")){
      studiesid_contacts_data = studiesid_contacts_data[studiesid_contacts_data$contactDbId %in% contact_s,  ]
      contacts = list(nrow(studiesid_contacts_data))
      for(j in 1:nrow(studiesid_contacts_data)){
        contacts[[j]] <- as.list(studiesid_contacts_data[j, ])
      }
      out$contacts <- contacts
    }

    additionalInfo =
      studiesid_additionalInfo_data[studiesid_additionalInfo_data$studyDbId == studiesid_data$studyDbId[i],
                                    -c(1)]
    if(nrow(additionalInfo) == 0) {
      additionalInfo = NULL
    } else {
      additionalInfo = additionalInfo[, !is.na(additionalInfo)  %>% as.logical() ]
      additionalInfo = as.list(additionalInfo)
    }
    out$additionalInfo = additionalInfo
  #}

  attr(out, "status") = list()
  #attr(out, "pagination") = pg$pagination
  out
}


studies = list(
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



process_studies <- function(req, res, err){
  studyDbId = basename(req$path)

  studies$result = studies_list(studyDbId)

  if(is.null(studies$result)){
    res$set_status(404)
    studies$metadata <-
      brapi_status(100,"No matching results.!"
                   , studies$metadata$status)
    studies$result = list()
  }

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(studies)

}


mw_studies <<-
  collector() %>%
  get("/brapi/v1/studies/[0-9a-zA-Z]{1,12}[/]?", function(req, res, err){
    process_studies(req, res, err)
  })  %>%
  put("/brapi/v1/studies/[0-9a-zA-Z]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/studies/[0-9a-zA-Z]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/studies/[0-9a-zA-Z]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  })

