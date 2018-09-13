check_character <- function(...) {
  args <- list(...)
  if (!lapply(args, is.character) %>% unlist %>% all()) {
    stop("All must be character.")
  }
}
