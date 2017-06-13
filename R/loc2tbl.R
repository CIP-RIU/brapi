loc2tbl <- function(res, rclass, con) {
  lst <- jsonlite::fromJSON(txt = res)
  dat <- jsonlite::toJSON(x = lst$result$data)
  dat <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE)

  addinfo <- "additionalInfo"
  if (con$bms) {
    addinfo <- "attributes"
  }
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
  #xnms <- c(field_list, addinfo)
  # Complete any missing columns TODO
  #dat <- dat[, xnms]
  has_add_cols <- FALSE
  if (length(dat[addinfo][[addinfo]]) == 0) {
    has_add_cols <- FALSE
  } else {
    has_add_cols <- !all(dat[addinfo][[addinfo]] %>% is.na) & !all(length(dat[[addinfo]][[1]]) == 0)
  }
  if (has_add_cols) {
  # get all var names
    #addinf <- dat[, names(dat[addinfo])]
    #addinf <- jsonlite::toJSON(dat[, names(dat[addinfo])])
    #addinf <- jsonlite::fromJSON(addinf, simplifyDataFrame = TRUE)
    add_field_list <- sapply(dat[, names(dat[addinfo])], names) %>% unlist %>% c %>% unique()
    # idx <- which(names(df) == addinf)
    # add_field_list <- add_field_list[-idx]

    #dat[addinfo] <- NULL
    #dat <- cbind(dat, addinf)

    df <- complement_missing_fields(DF = dat, field_vector = add_field_list)
    df[[addinfo]] <- NULL
    # nms <- lapply(X = addinf, FUN = names) %>% unlist %>% unique()
    #
    # df <- as.data.frame(x = matrix(NA, ncol = length(nms), nrow = nrow(dat)), stringsAsFactors = FALSE)
    # names(df) <- nms
    n <- nrow(dat)
    for (i in 1:n) {
        #if (ncol(dat[[i]]) > 0) {
            rec <- lst$result$data[i, addinfo][[1]]
            df[i, names(rec)] <- rec
        #}
    #
    }
    # if (ncol(df) > 0) {
    #     df <- cbind(dat, df)
    # } else {
    #     df <- dat[, 1:8]
    # }
  } else {
    df <- dat[, 1:9]
  }
  # for (i in 1:ncol(df)) {
  #   if (is.numeric(df[, i])) {
  #     df[, i] <- as.numeric(df[, i])
  #   }
  #   if (is.integer(df[, i])) {
  #     df[, i] <- as.integer(df[, i])
  #   }
  # }
  df$latitude <- as.numeric(df$latitude)
  df$longitude <- as.numeric(df$longitude)
  df$altitude <- as.integer(df$altitude)
  df[addinfo] <- NULL
  if (rclass == "tibble") {
    df <- tibble::as_tibble(df)
  }
  return(df)
}
