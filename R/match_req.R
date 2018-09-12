# intended for required scalar characters like required dbIds
match_req <- function(s) {
  stopifnot(is.character(s))
  stopifnot(s != "")
  return(s)
}
