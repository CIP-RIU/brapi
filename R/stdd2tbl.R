stdd2tbl <- function(res, rclass) {
    lst <- jsonlite::fromJSON(res)
    if (length(lst$result) == 0)
        return(NULL)
    dat <- jsonlite::toJSON(lst$result)
    dat <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE, flatten = TRUE)

    contacts <- dat$contacts
    dat$contacts <- NULL


    location <- dat$location
    if(length(location$additionalInfo) == 0) location$additionalInfo <- NULL
    location <- as.data.frame(location)
    dat$location <- NULL

    additionalInfo <- dat$additionalInfo
    additionalInfo <- as.data.frame(additionalInfo)
    dat$additionalInfo <- NULL

    #dat <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE, flatten = TRUE)

    if(length(location) == 0) {
      location <- cbind(studyDbId = rep(dat$studyDbId, nrow(location)), location)
      names(location)[2:ncol(location)] <- paste("location", names(location)[2:ncol(location)], sep = ".")
      dat <- merge(dat, location)
      dat$location.studyDbId <- NULL
    }

    if (length(contacts) != 0) {
        contacts <- cbind(studyDbId = rep(dat$studyDbId, nrow(contacts)), contacts)
        names(contacts)[2:ncol(contacts)] <- paste("contacts", names(contacts)[2:ncol(contacts)], sep = ".")
        dat <- merge(dat, contacts)
        dat$contacts.studyDbId <- NULL
    }

    if (length(additionalInfo) != 0) {
      additionalInfo <- cbind(studyDbId = rep(dat$studyDbId, nrow(additionalInfo)), additionalInfo)
      names(additionalInfo)[2:ncol(additionalInfo)] <- paste("additionalInfo", names(additionalInfo)[2:ncol(additionalInfo)], sep = ".")
      dat <- merge(dat, additionalInfo)
      dat$additionalInfo.studyDbId <- NULL
    }


    if (rclass == "tibble")
        dat <- tibble::as_tibble(dat)
    return(dat)
}
