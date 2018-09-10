#' ba_commoncropnames
#'
#' List supported crops in a database.
#'
#' @param con list, brapi connection object
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"vector"/"data.frame"
#'
#' @return an object of class as specified by rclass with common crop names or
#'         NULL
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Crops/CommonCropNames_GET.md}{github}
#' @family brapicore
#' @example inst/examples/ex-ba_commoncropnames.R
#' @export
ba_commoncropnames <- function(con = NULL, rclass = "tibble") {
  stopifnot(is.ba_con(obj = con))
  check_rclass(rclass = rclass)
  # temporarily store the multicrop argument in omc (oldmulticrop)
  omc <- con$multicrop
  con$multicrop <- FALSE
  ba_check(con = con, verbose = FALSE, brapi_calls = "commoncropnames")
  brp <- get_brapi(con = con)
  callurl <- paste0(brp, "commoncropnames")
  # store original rclass, needed when equal to data.frame
  orclass <- rclass
  rclass <- df2tibble(rclass = rclass)
  out <- try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    if (any(class(out) %in% c("tbl_df", "data.frame"))) {
      names(out)[1] <- "commonCropNames"
      # out$commonCropNames <- tolower(out$commonCropNames)
    }
    # if (rclass == "list") out$result$data <- tolower(out$result$data )
    # if (rclass == "vector") out <- tolower(out)
    if (orclass == "data.frame") out <- as.data.frame(out)

    class(out) <- c(class(out), "ba_crops")
    out
  })
  # reset multicrop argument in con object to omc (oldmulticrop) value
  con$multicrop <- omc
  return(out)
}
