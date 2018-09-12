extract_fields <- function(dat, field_names, prefix) {
  field_data <- paste(dat[, field_names], collapse = "; ")
  keep_names <-  names(dat)[!names(dat) %in% field_names]
  out <- cbind(dat[, keep_names], prefix = paste(dat[, field_names], collapse = "; "))
  names(out)[ncol(out)] <- prefix
  out[, prefix] <- as.character(out[, prefix])
  out
}

join_subfields <- function(dat, prefix) {
  field_names <- names(dat)[startsWith(names(dat), prefix = prefix)]
  return(
    extract_fields(dat, field_names, prefix )
  )
}

join_records <- function(dat, prefix, field_sub) {
  record_group <- names(dat)[startsWith(names(dat), prefix = prefix)]
  record_n <- stringr::str_extract_all(record_group, "[0-9]{1,3}") %>% unlist %>% as.numeric() %>% max
  field_rec <- ""
  for (r in 1:record_n) {

    field_names <- paste(prefix, ".", field_sub, r, sep = "")
    field_data <- paste( paste(field_sub,  dat[, field_names], sep = ": "), collapse = ", ")
    field_rec <- paste(field_rec, field_data, sep = "; ")
  }
  keep_names <-  names(dat)[!names(dat) %in% record_group]
  out <- cbind(dat[, keep_names], prefix = field_rec)
  out$prefix <- as.character(out$prefix)
  names(out)[ncol(out)] <- prefix

  out
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
  dat <- join_records(dat, "contacts", c("contactDbId", "email", "instituteName", "name", "orcid", "type" ))
  dat <- join_records(dat, "dataLinks", c("name", "type", "url"))


  if (rclass == "tibble") {
    dat <- tibble::as_tibble(x = dat)
  }
  return(dat)
}
