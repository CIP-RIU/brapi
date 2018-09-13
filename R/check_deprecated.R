check_deprecated <- function(param, msg) {
  if (!is.null(param)) stop(paste0("This parameter is deprecated. Use '",
                                  msg, "' instead."))
  return(TRUE)
}
