lyt2tbl <- function(res, rclass) {
  lst <- jsonlite::fromJSON(txt = res)
  datJSON <- jsonlite::toJSON(x = lst$result$data)
  df <- jsonlite::fromJSON(txt = datJSON)
  # split off additionalInfo from df
  dfAddInf <- df[["additionalInfo"]]
  df[["additionalInfo"]] <- NULL
  if (length(dfAddInf) == 0) {
    df <- df
  } else {
    dfAddInf <- as.data.frame(lapply(X = dfAddInf,
                                     FUN = function(x) {
                                       if (class(x) == "list") {
                                         x <- sapply(X = x ,
                                                     FUN = paste0,
                                                     collapse = "; ")
                                       } else {
                                         x <- x
                                       }
                                     }),
                              stringsAsFactors = FALSE)
    df <- cbind(df, dfAddInf)
  }
  if (rclass == "tibble") {
    df <- tibble::as_tibble(x = df)
  }
  return(df)
}
