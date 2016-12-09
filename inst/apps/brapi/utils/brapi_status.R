brapi_status <- function(code = 100, message = "No matching records found.", status = NULL){
  if(code == 100){
    pagination = list()
  }

  if (is.null(status)) {
    status =
      list(
        list(
          code = code,
          message = message
        )
      )
  } else {
    status[[length(status) + 1]] <- list(code = code, message =  message)
  }

  list(pagination = NULL, status = status, data = list())
}
