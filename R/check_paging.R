check_paging <- function(pageSize = NULL, page = NULL) {
  msg <- "pageSize and page must be integer objects with values page >= 0 and pageSize > 0."
  if (is.null(pageSize)) stop(msg)
  if (is.null(page)) stop(msg)
  if (!is.numeric(pageSize)) stop(msg)
  if (!is.numeric(page)) stop(msg)
  if (pageSize < 1) stop(msg)
  if (page < 0) stop(msg)
  return(invisible())
}
