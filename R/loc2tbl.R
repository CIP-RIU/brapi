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
    add_field_list <- sapply(dat[, names(dat[addinfo])], names) %>%
      unlist %>% c %>% unique()

    df <- complement_missing_fields(DF = dat,
                                    field_vector = add_field_list)
    df[[addinfo]] <- NULL
    n <- nrow(dat)
    for (i in 1:n) {
            rec <- lst$result$data[i, addinfo][[1]]
            df[i, names(rec)] <- rec
    }
  } else {
    df <- dat[, 1:10]
  }
  df$latitude <- as.numeric(df$latitude)
  df$longitude <- as.numeric(df$longitude)
  df$altitude <- as.integer(df$altitude)
  df[addinfo] <- NULL
  if (rclass == "tibble") {
    df <- tibble::as_tibble(df)
  }
  return(df)
}
