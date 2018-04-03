stdd2tbl <- function(res, rclass) {
  lst <- jsonlite::fromJSON(txt = res)
  if (length(lst$result) == 0) {
    return(NULL)
  }
  dat <- jsonlite::toJSON(x = lst$result)
  dat <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  dat <- as.data.frame(t(as.matrix(unlist(dat))), stringsAsFactors = FALSE)
  dat$location.longitude <- ifelse("location.longitude" %in% names(dat),
                                   as.numeric(dat$location.longitude), NA)
  dat$location.latitude <- ifelse("location.latitude" %in% names(dat),
                                  as.numeric(dat$location.latitude), NA)
  dat$location.altitude <- ifelse("location.altitude" %in% names(dat),
                                  as.numeric(dat$location.altitude), NA)
  if (rclass == "tibble") {
    dat <- tibble::as_tibble(x = dat)
  }
  return(dat)
}
