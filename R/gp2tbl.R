gp2tbl <- function(res) {

  lst <- tryCatch(
    jsonlite::fromJSON(txt = res)
  )

  dat <- jsonlite::toJSON(x = lst$result)

  df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  donors <- synonyms <- taxonIds <- list()
  if (length(df$donors) == 0) df$donors <- list()
  if (length(df$synonyms) == 0) df$synonyms <- list()
  taxonIds <- as.list(df$taxonIds)
  donors <- as.list(df$donors)
  typeOfGermplasmStorageCode <- df$typeOfGermplasmStorageCode

  df$donors <- NULL
  df$taxonIds <- NULL
  df$synonyms <- NULL
  df$typeOfGermplasmStorageCode <- NULL

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
    as.data.frame(cbind(df, al, stringsAsFactors = FALSE))
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
