#' ba_programs
#'
#' Retrieve a list of the breeding programs.
#'
#' @param con list, brapi connection object
#' @param programName character, filter programs by program name; default: ""
#' @param abbreviation character, filter programs by program abbreviation;
#'                     default: ""
#' @param commonCropName character, filter programs by a common crop name;
#'                       default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @details Filtering by commonCropName has not be tested yet, because none of
#'          the databases support this feature yet (not even the test-server)!
#'
#' @return An object of class as defined by rclass containing the breeding
#'         programs.
#'
#' @note Tested against: BMS, sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Programs/ListPrograms.md}{github}
#' @family brapicore
#' @example inst/examples/ex-ba_programs.R
#' @import httr
#' @export
ba_programs <- function(con = NULL,
                        programName = "",
                        abbreviation = "",
                        commonCropName = "",
                        pageSize = 1000,
                        page = 0,
                        rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "programs")
  check_character(programName, abbreviation, commonCropName)
  brp <- get_brapi(con = con) %>% paste0("programs")
  callurl <- get_endpoint(brp,
                          programName = programName,
                          abbreviation = abbreviation,
                          commonCropName = commonCropName,
                          pageSize = pageSize,
                          page = page
                          )
   try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_programs")
    show_metadata(res)
    return(out)
  })
}
