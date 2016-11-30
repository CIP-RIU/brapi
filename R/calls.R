#' calls
#'
#' lists calls available on a brapi server
#'
#' @param raw logical; default is FALSE; whether to display the raw json object or not
#' @author Reinhard Simon
#' @return a data.frame
#' @export
calls <- function(raw = FALSE){
  calls_list = paste0(get_brapi(), "calls")

  calls <- tryCatch({
    res <- httr::GET(calls_list)
    jsonlite::fromJSON(
      httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
                    ), simplifyVector = FALSE
    )
  }, error = function(e){
    NULL
  })

  # if(!raw & !is.null(calls)){
  #   calls <- calls$result$data %>% jsonlite::fromJSON(simplifyVector = TRUE)
  # }

  calls
}
