#' crops
#'
#' lists crops available in a database
#'
#' @param format logical; default is FALSE; whether to display the raw json object or not
#' @author Reinhard Simon
#' @return a vector of crop names or NULL
#' @export
crops <- function(format = "json"){
  crops_list = paste0(get_brapi(), "crops")

  crops <- tryCatch({
    res <- httr::GET(crops_list)

    jsonlite::fromJSON( httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
                    ), simplifyVector = TRUE)
  }, error = function(e){
    NULL
  })

  if (format == "plain"){
    crops <- crops$result$data %>% unlist %>% sort
  }

  crops
}
