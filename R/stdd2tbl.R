stdd2tbl <- function(res, rclass) {
  lst <- jsonlite::fromJSON(txt = res)
  if (length(lst$result) == 0) {
    return(NULL)
  }
  dat <- jsonlite::toJSON(x = lst$result)
  dat <- jsonlite::fromJSON(x = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  contacts <- dat$contacts
  dat$contacts <- NULL
  location <- dat$location
  if (length(location$additionalInfo) == 0) {
    location$additionalInfo <- NULL
  }
  location <- as.data.frame(x = location)
  dat$location <- NULL
  additionalInfo <- dat$additionalInfo
  additionalInfo <- as.data.frame(x = additionalInfo)
  dat$additionalInfo <- NULL
  if(length(location) == 0) {
    location <- cbind(studyDbId = rep(x = dat$studyDbId, times = nrow(location)), location)
    names(location)[2:ncol(location)] <- paste("location", names(location)[2:ncol(location)], sep = ".")
    dat <- merge(x = dat, y = location)
    dat$location.studyDbId <- NULL
  }
  if (length(contacts) != 0) {
    contacts <- cbind(studyDbId = rep(x = dat$studyDbId, times = nrow(contacts)), contacts)
    names(contacts)[2:ncol(contacts)] <- paste("contacts", names(contacts)[2:ncol(contacts)], sep = ".")
    dat <- merge(x = dat, y = contacts)
    dat$contacts.studyDbId <- NULL
  }
  if (length(additionalInfo) != 0) {
    additionalInfo <- cbind(studyDbId = rep(x = dat$studyDbId, times = nrow(additionalInfo)), additionalInfo)
    names(additionalInfo)[2:ncol(additionalInfo)] <- paste("additionalInfo", names(additionalInfo)[2:ncol(additionalInfo)], sep = ".")
    dat <- merge(dat, additionalInfo)
    dat$additionalInfo.studyDbId <- NULL
  }
  if (rclass == "tibble") {
    dat <- tibble::as_tibble(x = dat)
  }
  return(dat)
}
