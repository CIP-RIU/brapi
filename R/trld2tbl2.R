trld2tbl2 <- function(res) {
  lst <- tryCatch(
    jsonlite::fromJSON(txt = res)
  )

  assertthat::assert_that("result" %in% names(lst),
                        msg = "The json return object lacks a result element.")
  dat <- jsonlite::toJSON(x = lst$result)

  df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  # handle two special cases: empty 'additionalInfo' and empty 'studies'

  if ("additionalInfo" %in% names(df)) {
    if (length(df$additionalInfo) == 0 ) {
      df$additionalInfo <- ""
    } else {
      names(df$additionalInfo) <- paste("additionalInfo",
                                        names(df$additionalInfo), sep = ".")
    }
  }
  std <- NULL
  if (!is.null(df$studies)) {
    std <- df$studies
    df$studies <- NULL
  }

  df <- as.data.frame(df, stringsAsFactors = FALSE)
  names(df) <- stringr::str_replace_all(names(df),
                  "additionalInfo.additionalInfo.", "additionalInfo.")

  if (!is.null(std)) {
    df3 <-  df[rep(seq_len(nrow(df)), each=nrow(std)),]
    df <- cbind(df3, std)
    row.names(df) <- 1:nrow(df)
  }

  return(df)
}
