
#' print.brapi
#'
#' @param x printable locations_list object
#' @param ... extended parameters
#'
#' @return data.frame of class brapi
#' @export
print.brapi <- function(x, ...){
  cat("Source: ", attr(x, "source"), "\n\n", sep = "")
  #n = min(5, nrow(x))
  #print(head(x[1:n, 1:7]))
  str(x, give.attr = FALSE)
  #cat(x)
  invisible(x)
}
