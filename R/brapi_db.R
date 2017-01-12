

#' brapi_db
#'
#' @return list; white list of brapi databases
#' @export
brapi_db <- function(){
  sweetpotatobase <- as.brapi_db(
    crop = "sweetpotato",
    secure = TRUE,
    protocol = "https://",
    db = "sweetpotatobase.org",
    port = 80,
    multicrop = FALSE,
    bms = FALSE
  )
  #class(sweetpotatobase) <- c("list", "brapi_db")

  mockbase <- as.brapi_db(
    crop = "sweetpotato",
    secure = FALSE,
    protocol = "http://",
    db = "127.0.0.1",
    port = 2021,
    multicrop = FALSE,
    bms = FALSE
  )
  #class(mockbase) <- c("list", "brapi_db")

  eu_sol = as.brapi_db(
    crop = "tomato",
    secure = TRUE,
    db = "www.eu-sol.wur.nl",
    apipath = "webapi",
    multicrop = TRUE,
    bms = FALSE
  )
  # class(bms_test) <- c("list", "brapi_db", "brapi")

  bms_test = as.brapi_db(
    crop = "wheat",
    secure = FALSE,
    protocol = "http://",
    db = "104.196.40.209",
    port = 48080,
    apipath = "bmsapi",
    user = "rsimon",
    password = "",
    multicrop = TRUE,
    bms = TRUE
  )
  #class(bms_test) <- c("list", "brapi_db", "brapi")

  out <- list(
    sweetpotatobase = sweetpotatobase,
    eu_sol = eu_sol,
    bms_test = bms_test,
    mockbase = mockbase
    )
  class(out)  <-  "brapi_db_list"
  out
}
