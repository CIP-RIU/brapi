gp2tbl <- function(res) {

  lst <- tryCatch(
    jsonlite::fromJSON(txt = res)
  )

  #assertthat::assert_that("data" %in% names(lst$result), msg = "The json return object lacks a data element.")
  dat <- jsonlite::toJSON(x = lst$result)

  df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  if (length(df$donors) == 0) df$donors <- ""
  if (length(df$synonyms) == 0) df$synonyms <- ""

  df <- as.data.frame(df, stringsAsFactors = FALSE)
  #assertthat::validate_that(nrow(df) > 0, msg = "The json return object lacks a data element.")

  # join synonymms, taxonIds, donors

  join_all <- function(dat2) {
    dat2 <- join_slaves(dat2, "synonyms")
    if ("taxonIds" %in% names(dat2))  dat2 <- join_slaves(dat2, "taxonIds")
    dat2 <- join_slaves(dat2, "donors")
    return(dat2)
  }


  out <- join_all(df[1, ])

  n <- nrow(df)

  if(n > 1) {
    for (i in 2:n) {
      out <- dplyr::bind_rows(out, join_all(df[i, ]))
    }
  }

  return(out)
}
