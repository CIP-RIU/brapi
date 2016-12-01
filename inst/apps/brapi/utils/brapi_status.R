brapi_status <- function(code, message){
  pagination = NULL
  if(code == 100){
    pagination = list(
      pageSize = 0,
      currentPage = 0,
      totalCount = 0,
      totalPages = 0
    )

  }
  status =
    list(
      list(
        code = code,
        message = message
      )
    )
  list(pagination = pagination, status = status)
}
