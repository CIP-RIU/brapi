trld2tbl2 <- function(res, rclass) {
  lst <- tryCatch(
    jsonlite::fromJSON(txt = res)
  )
  assertthat::assert_that("result" %in% names(lst),
                        msg = "The json return object lacks a result element.")
  dat <- jsonlite::toJSON(x = lst$result)
  df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  # handle two special cases: empty 'additionalInfo' and empty 'studies'
  if ("additionalInfo" %in% names(df)) {
    if (length(df$additionalInfo) == 0) {
      df$additionalInfo <- ""
    } else {
      names(df$additionalInfo) <- paste("additionalInfo",
                                        names(df$additionalInfo), sep = ".")
    }
  }
  for (i in 1:length(df)) {
    if (length(df[[i]]) == 0) df[[i]] <- ''
  }
  df <- as.data.frame(df, stringsAsFactors = FALSE)
  names(df) <- stringr::str_replace_all(names(df),
                  "additionalInfo.additionalInfo.", "additionalInfo.")
  # rename columns in the data.frame
  if (length(grep(pattern = "^additionalInfo.", x = colnames(df))) > 0) {
    colnames(df) <- gsub(pattern = "^additionalInfo.",
                          replacement = "",
                          x = colnames(df))
  }
  if (length(grep(pattern = "^contacts.", x = colnames(df))) > 0) {
    colnames(df) <- gsub(pattern = "^contacts.",
                         replacement = "",
                         x = colnames(df))
  }
  if (length(grep(pattern = "^datasetAuthorship.", x = colnames(df))) > 0) {
    colnames(df) <- gsub(pattern = "^datasetAuthorship.",
                         replacement = "",
                         x = colnames(df))
  }
  if (length(grep(pattern = "^studies.", x = colnames(df))) > 0) {
    colnames(df) <- gsub(pattern = "^studies.",
                         replacement = "",
                         x = colnames(df))
  }
  # set tibble class when necessary
  if (rclass == "tibble") {
    df <- tibble::as_tibble(df)
  }
  return(df)
}
