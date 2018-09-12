extract_fields <- function(dat, field_names, prefix) {
  field_data <- paste(dat[, field_names], collapse = "; ")
  keep_names <-  names(dat)[!names(dat) %in% field_names]
  out <- cbind(dat[, keep_names], prefix = field_names)
  names(out)[ncol()]
}

join_subfields <- function(dat, prefix) {
  field_names <- names(dat)[startsWith(names(dat), prefix = prefix)]
  return(
    extract_fields(dat, field_names )
  )
}



stdd2tbl <- function(res, rclass = c("tibble", "json", "list")) {
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

  # joint seasons, contacts and datalinks into one field each
  dat <- join_subfields(dat, "seasons")

  record_group <- names(dat)[startsWith(names(dat), prefix = "contacts")]
  record_n <- stringr::str_extract_all(record_group, "[0-9]{1,3}") %>% unlist %>% as.numeric() %>% max
  for (r in 1:record_n) {
    field_names <- paste("contacts.", c("contactDbId", "email", "instituteName", "name", "orcid", "type" ), r, sep = "")
  }


  if (rclass == "tibble") {
    dat <- tibble::as_tibble(x = dat)
  }
  return(dat)
}
