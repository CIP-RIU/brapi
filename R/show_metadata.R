show_metadata <- function( res) {
  #cat(str(res))
  res <- httr::content(res, "text")
  show_pagination(res)

}
