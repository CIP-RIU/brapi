gp2tbl <- function(res, type = '1') {

  lst <- tryCatch(
    jsonlite::fromJSON(txt = res)
  )

  if (type == '1') {
    dat <- jsonlite::toJSON(x = lst$result)
  } else {
    dat <- jsonlite::toJSON(x = lst$result$data)
  }


  df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  dfdonors <- synonyms <- taxonIds <- list()
  if (length(df$donors) == 0) df$donors <- list()
  if (length(df$synonyms) == 0) df$synonyms <- list()
  taxonIds <- as.list(df$taxonIds)
  donors <- as.list(df$donors)
  typeOfGermplasmStorageCode <- df$typeOfGermplasmStorageCode

  if(length(df$donors) == 0) df$donors <- NULL
  if(length(df$taxonIds) == 0) df$taxonIds <- NULL
  if(length(df$synonyms) == 0) df$synonyms <- NULL
  if(length(df$typeOfGermplasmStorageCode) == 0) df$typeOfGermplasmStorageCode <- NULL

  if(length(df$instituteName) == 0) df$instituteName <- NULL
  if(length(df$speciesAuthority) == 0) df$speciesAuthority <- NULL

  # filter out empty lists by replacing with empty string
  n <- length(df)
  for (i in 1:n) {
    if (class(df[[i]]) == "list" & length(df[[i]]) == 0) {
      df[[i]] <- ""
    }
  }

  df <- as.data.frame(df, stringsAsFactors = FALSE)


  rep_df <- function(df, n) {
    if(n == 1) return(df)
    df1 <- df
    for(i in 2:n) {
      df <- rbind(df, df1)
    }
    df
  }
  join_df <- function(df, al, prefix) {
    if (nrow(al) == 0) return(df)
    names(al) <- paste0(prefix, ".", names(al))
    df <- rep_df(df, nrow(al))
    as.data.frame(cbind(df, al), stringsAsFactors = FALSE)
  }

  df <- join_df(df, as.data.frame(donors), "donors")
  df <- join_df(df, as.data.frame(taxonIds), "taxonIds")
  df <- join_df(df, as.data.frame(synonyms), "synonyms")
  df <- join_df(df, as.data.frame(typeOfGermplasmStorageCode), "typeOfGermplasmStorageCode")



  # join_all <- function(dat2) {
  #   dat2 <- join_slaves(dat2, "synonyms")
  #   if ("taxonIds" %in% names(dat2))  dat2 <- join_slaves(dat2, "taxonIds")
  #   dat2 <- join_slaves(dat2, "donors")
  #
  #   return(dat2)
  # }
  #
  #
  # out <- join_all(df[1, ])

  # n <- nrow(df)
  #
  # if(n > 1) {
  #   for (i in 2:n) {
  #     out <- dplyr::bind_rows(out, join_all(df[i, ]))
  #   }
  # }

  return(df)
}
