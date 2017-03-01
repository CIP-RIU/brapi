loc2tbl <- function(res, rclass, con) {
    lst <- jsonlite::fromJSON(res)
    dat <- jsonlite::toJSON(lst$result)
    dat <- jsonlite::fromJSON(dat)


    addinfo <- "additionalInfo"
    xnms <- c("locationDbId", "locationType", "name", "abbreviation",
              "countryName", "countryCode", "longitude", "latitude",
              "altitude", addinfo
    )
    if (con$bms) {
      addinfo <- "attributes"
      xnms <- c("locationDbId", "locationType", "name", "abbreviation",
                "countryName", "countryCode", "longitude", "latitude",
                addinfo
      )
    }

    # get all var names
    nms <- unique(lapply(dat, colnames) %>% unlist)
    # TODO vectorize the next
    n <- length(dat)
    x <- character(n)
    for (i in 1:n) {
      if(length(dat[[i]]) == 10) {
        x <- c(x, names(dat[[i]][[10]]))
      }
    }
    nms <- c(nms, unique(x))
    nms <- nms[!nms %in% c("", 10)]

    # construct basic data.frame

    df <- as.data.frame(matrix(NA, ncol = length(nms), nrow = n), stringsAsFactors = FALSE)
    names(df) <- nms
    for (i in 1:n) {
        # fixed names
        df[i, 1:9] <- dat[[i]][, 1:9]

        # variable names
        if(length(dat[[i]]) == 10) {
          vnms <- colnames(dat[[i]][[10]])
          df[i, vnms] <- dat[[i]][[10]]
        }
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
