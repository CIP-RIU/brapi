brapi_status <- function(code, message){
  if(code == 100){
    pagination = list()

  }
  status =
    list(
      list(
        code = code,
        message = message
      )
    )
  list(pagination = NULL, status = status, data = list())
}
