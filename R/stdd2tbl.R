stdd2tbl <- function(res, rclass){
  lst <- jsonlite::fromJSON(res)
  if(length(lst$result) == 0) return(NULL)
  dat <- jsonlite::toJSON(lst$result)
  dat <- jsonlite::fromJSON(dat)

  contacts =  cbind(studyDbId = rep(dat$studyDbId, nrow(dat$contacts)), dat$contacts)

  dat$contacts <- NULL
  dat = as.data.frame(dat)
  dat = merge(dat, contacts)

  if(rclass == "tibble") dat = tibble::as_tibble(dat)
  dat
}
