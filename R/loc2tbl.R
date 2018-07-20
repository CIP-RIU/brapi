loc2tbl <- function(res, rclass, con = NULL) {
  lst <- jsonlite::fromJSON(txt = res)
  dat <- jsonlite::toJSON(x = lst$result$data)
  dat <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE)

  addinfo <- "additionalInfo"
  field_list <- c("locationDbId",
                  "locationType",
                  "name",
                  "abbreviation",
                  "countryCode",
                  "countryName",
                  "latitude",
                  "longitude",
                  "altitude",
                  "instituteName",
                  "instituteAddress",
                  addinfo)
  dat <- complement_missing_fields(DF = dat, field_vector = field_list)
  df <- dat
  has_add_cols <- FALSE
  if (length(dat[addinfo][[addinfo]]) == 0) {
    has_add_cols <- FALSE
  } else {
    has_add_cols <- !all(dat[addinfo][[addinfo]] %>% is.na) &
      !all(length(dat[[addinfo]][[1]]) == 0)
  }
  if (has_add_cols) {
    add_field_list <- names(dat[, names(dat[addinfo])]) %>% unique
    df <- complement_missing_fields(DF = dat,
                                    field_vector = add_field_list)
    df[[addinfo]] <- NULL
  } else {
    df <- dat[, setdiff(field_list, addinfo)]
    #df <- dat[, 1:11]
  }
  if (!is.null(df$latitude)) {
    df$latitude <- as.numeric(df$latitude)
  }
  if (!is.null(df$longitude)) {
    df$longitude <- as.numeric(df$longitude)
  }
  if (!is.null(df$altitude)) {
    df$altitude <- as.integer(df$altitude)
  }
  if (!is.null(df$instituteName)) {
    df$instituteName <- as.character(df$instituteName)
  }
  if (!is.null(df$instituteAddress)) {
    df$instituteAddress <- as.character(df$instituteAddress)
  }
  df[addinfo] <- NULL
  if (rclass == "tibble") {
    df <- tibble::as_tibble(df)
  }
  return(df)
}
