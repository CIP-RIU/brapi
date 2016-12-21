

#' brapi_db
#'
#' @return list; white list of brapi databases
#' @export
brapi_db <- function(){
  sweetpotatobase = as.brapi_db(
    crop = "sweetpotato",
    protocol = "https://",
    db = "sweetpotatobase.org",
    port = 80,
    multi = FALSE
  )

  mockbase = as.brapi_db(
    crop = "sweetpotato",
    protocol = "http://",
    db = "127.0.0.1",
    port = 2021,
    multi = FALSE
  )

  out <- list(
    sweetpotatobase = sweetpotatobase,
    mockbase = mockbase
    )
  class(out) = "brapi_db_list"
  out
}
