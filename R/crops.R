#' crops
#'
#' lists crops available in a database
#'
#' @param rclass logical; default is FALSE; whether to display the raw list object or not
#' @author Reinhard Simon
#' @return a vector of crop names or NULL
#' @export
crops <- function(rclass = "list"){
  brapi::check(FALSE)
  crops_list = paste0(get_brapi(), "crops")

  crops <- tryCatch({
    res <- httr::GET(crops_list)

    jsonlite::fromJSON( httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
                    ), simplifyVector = TRUE)
  }, error = function(e){
    NULL
  })

  if (rclass != "list"){
    crops <- crops$result$data %>% unlist %>% sort
  }

  crops
}
