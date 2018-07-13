#' ba_programs
#'
#' Retrieve a list of the breeding programs.
#'
#' @param con list, brapi connection object
#' @param programName character, filter by program name; default: "any"
#' @param abbreviation character, filter by program abbreviation; default: "any"
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returend; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing the breeding
#'         programs.
#'
#' @note Tested against: BMS, sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Programs/ListPrograms.md}{github}
#' @family brapicore
#' @example inst/examples/ex-ba_programs.R
#' @import httr
#' @export
ba_programs <- function(con = NULL,
                        programName = "any",
                        abbreviation = "any",
                        page = 0,
                        pageSize = 1000,
                        rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "programs")
  stopifnot(is.character(programName))
  stopifnot(is.character(abbreviation))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  # pprograms <- paste0(brp, "programs/?") # TO BE CONSIDERED v2
  pprograms <- paste0(brp, "programs?")
  pprogramName <- ifelse(programName != "any", paste0("programName=",
                                  gsub(" ", "%20", programName), "&"), "")
  pabbreviation <- ifelse(abbreviation != "any", paste0("abbreviation=",
                                  gsub(" ", "%20", abbreviation), "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                   pageSize, "&"), "")
  if (page == 0 & pageSize == 1000) {
    ppage <- ""
    ppageSize <- ""
  }
  pprograms <- sub("[/?&]$",
                   "",
                   paste0(pprograms,
                          pprogramName,
                          pabbreviation,
                          ppageSize,
                          ppage))
  try({
    res <- brapiGET(url = pprograms, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_programs")
    show_metadata(res)
    return(out)
  })
}
