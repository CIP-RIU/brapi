#' ba_commoncropnames
#'
#' Lists supported crops in a database
#'
#' @param con brapi connection object
#' @param rclass character; default: "tibble" possible other values: "vector"/"json"/"list"/"data.frame"
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.2, 1.3
#' @note BrAPI Status:
#'
#' @author Reinhard Simon, Maikel Verouden
#' @return a vector of crop names or NULL
#' @example inst/examples/ex_crops.R
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Crops/CommonCropNames_GET.md}{github}
#' @family brapicore
#' @export
ba_commoncropnames <- function(con = NULL, rclass = "tibble") {
  stopifnot(is.ba_con(obj = con))
  check_rclass(rclass = rclass)
  # temporarily store the multicrop argument in omc (oldmulticrop)
  omc <- con$multicrop
  con$multicrop <- FALSE
  ba_check(con = con, verbose = FALSE, brapi_calls = "crops")
  # generate the brapi call url
  crops_list <- paste0(get_brapi(con = con), "commonCropNames")
  rclass <- df2tibble(rclass = rclass)
  out <- try({
    res <- brapiGET(url = crops_list, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    if (any(class(out) %in% c("tbl_df", "data.frame"))) {
      names(out)[1] <- "crops"
      out$crops <- tolower(out$crops)
    }
    if (rclass == "list") out$result$data <- tolower(out$result$data )
    if (rclass == "vector") out <- tolower(out)

    class(out) <- c(class(out), "ba_crops")
    out
  })
  # reset multicrop argument in con object to omc (oldmulticrop) value
  con$multicrop <- omc
  return(out)
}
