trl2tbl2 <- function(res, rclass) {
  lst <- tryCatch(
    jsonlite::fromJSON(txt = res)
  )
  assertthat::assert_that("data" %in% names(lst$result),
                          msg = "The json return object lacks a data element.")
  dat <- jsonlite::toJSON(x = lst$result$data)
  df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  assertthat::validate_that(nrow(df) > 0,
                          msg = "The json return object lacks a data element.")

  jointrlstd <- function(dat2) {
    assertthat::validate_that("studies" %in% names(dat2),
                        msg = "The json return object lacks a studies element.")
    df2 <- dat2$studies[[1]]
    assertthat::validate_that(class(df2) == "data.frame",
                              msg = "The JSON studies element is malformed.")
    assertthat::validate_that(nrow(df2) > 0,
                              msg = "The JSON studies element has no entries.")
    dat2$studies <- NULL
    if (nrow(df2) > 0) {
      df3 <-  dat2[rep(seq_len(nrow(dat2)), each = nrow(df2)), ]
      df <- cbind(df3, df2)
    } else {
      df <- dat2
    }
    row.names(df) <- 1:nrow(df)
    return(df)
  }

  out <- jointrlstd(dat2 = df[1, ])
  n <- nrow(df)
  if (n > 1) {
    for (i in 2:n) {
      jn <- jointrlstd(dat2 = df[i, ])
      #print(jn)
      out <- dplyr::bind_rows(out, jn)
    }
  }
  out$studies <- NULL
  # replace column names starting with "additionalInfo."
  if (length(grep(pattern = "^additionalInfo.", x = colnames(out))) > 0) {
    colnames(out) <- gsub(pattern = "^additionalInfo.",
                          replacement = "",
                          x = colnames(out))
  }
  # remove duplicated rows
  out <- out[!duplicated(out), ]
  # reset row name numbering in case row have been removed
  rownames(out) <- 1:nrow(out)
  if (rclass == "tibble") {
    out <- tibble::as_tibble(out)
  }
  return(out)
}
