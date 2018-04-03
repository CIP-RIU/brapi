#' ba_programs
#'
#' lists the breeding programs
#'
#' BRAPI discussion: Should this return also the crop?
#'
#' @note Tested against: sweetpotatobase, BMS
#'
#' @param con list, brapi connection object
#' @param page integer requested page number, default = 0 (1st page)
#' @param rclass character; default: "tibble" possible other values: "json"/"list"/"data.frame"
#' @param pageSize integer, items per page (default = 1000)
#' @param programName character; default: any
#' @param abbreviation character; default: any
#'
#' @import httr
#' @author Reinhard Simon, Maikel Verouden
#' @return rclass
#' @example inst/examples/ex-ba_programs.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Programs/ListPrograms.md}{github}
#' @family brapicore
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
                                                    abbreviation, "&"), "")
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
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res, rclass = rclass)
    class(out) <- c(class(out), "ba_programs")
    show_metadata(con, res)
    return(out)
  })
}
