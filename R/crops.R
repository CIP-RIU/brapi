#' crops_list
#'
#' lists crops available in a database
#'
#' @param raw logical; default is FALSE; whether to display the raw json object or not
#' @author Reinhard Simon
#' @return a vector of crop names or NULL
#' @export
crops_list <- function(raw = FALSE){
  crops_list = paste0(get_brapi(), "crops/")

  crops <- tryCatch({
    res <- httr::GET(crops_list)
    jsonlite::fromJSON(
      httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
                    ), simplifyVector = FALSE
    )
  }, error = function(e){
    NULL
  })

  if(!raw & !is.null(crops)){
    crops <- crops$result$data %>% unlist %>% sort
  }

  crops
}
