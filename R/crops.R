#' crops
#'
#' lists crops available in a database
#'
#' @param rclass logical; default is FALSE; whether to display the raw list object or not
#' @author Reinhard Simon
#' @return a vector of crop names or NULL
#' @export
crops <- function(rclass = "vector"){
  brapi::check(FALSE)
  crops_list = paste0(get_brapi(), "crops")
  rclass <- df2tibble(rclass)

  tryCatch({
    res <- brapiGET(crops_list)
    res <- httr::content(res, "text",encoding = "UTF-8")

    dat2tbl(res, rclass)
    }, error = function(e){
    NULL
  })

}
