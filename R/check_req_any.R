# intended for required scalar characters like required dbIds
check_req_any <- function(...) {
  args <- list(...)
  non_empty <- function(s) {nchar(s) > 0}
  if (!lapply(args, non_empty) %>% unlist %>% any()) {
    stop("Any of these parameters must have at least a length of one.")
  }

}
