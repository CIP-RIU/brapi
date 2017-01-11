#' crops
#'
#' lists crops available in a database
#'
#' @param con brapi connection object
#' @param rclass logical; default is FALSE; whether to display the raw list object or not
#'
#' @author Reinhard Simon
#' @return a vector of crop names or NULL
# @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Crops/ListCrops.md}{github}
# @family core
#' @export
crops <- function(con = NULL, rclass = "tibble"){
  brapi::check(con, FALSE, "crops")
  crops_list <- paste0(get_brapi(con), "crops")
  rclass <- df2tibble(rclass)

  try({
    res <- brapiGET(crops_list, con = con)
    res <- httr::content(res, "text",encoding = "UTF-8")
    out <- dat2tbl(res, rclass)
    class(out)  <-  c(class(out), "brapi_crops")
    out
  })
}
