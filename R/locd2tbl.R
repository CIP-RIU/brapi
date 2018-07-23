locd2tbl <- function(res, rclass, con = NULL) {
  lst <- jsonlite::fromJSON(txt = res)
  dat <- jsonlite::toJSON(x = lst$result)
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
                  "instituteAddress")
  ### split resulting list into datAddInfo and dat
  if (addinfo %in% names(dat)) {
    datAddInfo <- dat[[addinfo]]
    dat[[addinfo]] <- NULL
    dat <- dat[names(dat) %in% field_list]
  } else {
    dat <- dat[names(dat) %in% field_list]
  }

  df <- dat
  has_add_cols <- FALSE
  if (!exists(x = "datAddInfo")) {
    has_add_cols <- FALSE
  } else if (length(datAddInfo) == 0) {
    has_add_cols <- FALSE
  } else {
    has_add_cols <- !all(datAddInfo %>% is.na) &
      !all(length(datAddInfo[[1]]) == 0)
  }
  if (has_add_cols) {
    df <- as.data.frame(x = c(df, datAddInfo),
                        stringsAsFactors = FALSE)
  } else {
    df <- as.data.frame(x = df,
                        stringsAsFactors = FALSE)
  }
  if (rclass == "tibble") {
    df <- tibble::as_tibble(df)
  }
  return(df)
}
