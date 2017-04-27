loc2tbl <- function(res, rclass, con) {
    lst <- jsonlite::fromJSON(res)
    dat <- jsonlite::toJSON(lst$result$data)
    dat <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)


    addinfo <- "additionalInfo"
    xnms <- c("locationDbId", "locationType", "name", "abbreviation", "countryName", "countryCode", "longitude", "latitude", "altitude", addinfo)
    if (con$bms) {
        addinfo <- "attributes"
        xnms <- c("locationDbId", "locationType", "name", "abbreviation", "countryName", "countryCode", "longitude", "latitude", addinfo)
    }

    # Complete any missing columns TODO

    dat <- dat[, xnms]

    has_add_cols <- FALSE

    if (length(dat[addinfo][[addinfo]]) == 0) {
      has_add_cols <- FALSE
    } else {
      has_add_cols <- !(dat[addinfo][[addinfo]] %>% is.null) & !all(length(dat[[addinfo]][[1]]) == 0)
    }

    if (has_add_cols) {
        # get all var names
        addinf <- dat[, names(dat[addinfo])]
        nms <- lapply(addinf, names) %>% unlist %>% unique()

        df <- as.data.frame(matrix(NA, ncol = length(nms), nrow = nrow(dat)), stringsAsFactors = FALSE)
        names(df) <- nms
        n <- nrow(dat)
        for (i in 1:n) {
            if (ncol(addinf[[i]]) > 0) {
                df[i, names(addinf[[i]])] <- addinf[[i]]
            }

        }
        if (ncol(df) > 0) {
            df <- cbind(dat, df)
        } else {
            df <- dat[, 1:8]
        }

    } else {
        df <- dat[, 1:8]
    }


    for (i in 1:ncol(df)) {
        if (is.numeric(df[, i]))
            df[, i] <- as.numeric(df[, i])
        if (is.integer(df[, i]))
            df[, i] <- as.integer(df[, i])
    }


    if (rclass == "tibble") {
        df <- tibble::as_tibble(df)
    }

    return(df)
}
