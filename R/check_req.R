# intended for required scalar characters like required dbIds
check_req <- function(...) {
  args <- list(...)
  non_empty <- function(s) {nchar(s) > 0}
  if (!lapply(args, non_empty) %>% unlist %>% all()) {
    stop("All required parameters must have at least a length of one.")
  }

}
