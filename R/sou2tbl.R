sou2tbl <- function(res,
                    rclass) {

  lst <- tryCatch(
    jsonlite::fromJSON(txt = res)
  )

  assertthat::assert_that("data" %in% names(lst$result), msg = "The json return object lacks a data element.")
  dat <- jsonlite::toJSON(x = lst$result$data)

  df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  assertthat::validate_that(nrow(df) > 0, msg = "The json return object lacks a data element.")

  # join synonymms, taxonIds, donors

  join_all <- function(dat2) {
    dat2 <- join_slaves(dat2, "observationUnitXref")
    dat2 <- join_slaves(dat2, "observations")
    return(dat2)
  }


  out <- join_all(df[1, ])

  n <- nrow(df)

  if(n > 1) {
    for (i in 2:n) {
      out <- dplyr::bind_rows(out, join_all(df[i, ]))
    }
  }


  if (rclass == "tibble") {
    out <- tibble::as_tibble(x = out)
  } else {
    class(out) <- "data.frame"
  }
  return(out)
}
