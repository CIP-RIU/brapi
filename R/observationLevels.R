#' observationLevels
#'
#' lists crops available in a database
#'
#' @param rclass character; default is FALSE; whether to display the raw list object or not
#' @author Reinhard Simon
#' @return a vector of crop names or NULL
#' @family brapi_call
#' @family core
#' @family access
#' @export
observationLevels <- function(rclass = "vector"){
  brapi::check(FALSE)
  observationLevels_List = paste0(get_brapi(), "observationLevels")
  #rclass <- df2tibble(rclass)

  try({
    res <- brapiGET(observationLevels_List)
    res <- httr::content(res, "text",encoding = "UTF-8")

    dat2tbl(res, rclass)
  })
}
