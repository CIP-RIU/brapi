#' programs_search
#'
#' lists the breeding programs
#'
#' BRAPI discussion: Should this return also the crop?
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param name string; default: any
#' @param abbreviation string; default: any
#' @param programDbId string; default: any
#' @param objective string; default: any
#' @param leadPerson string; default: any
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Programs/ProgramSearch.md}{github}
#' @family brapicore
#' @export
programs_search <- function(con = NULL,
                            programDbId = "any",
                            name = "any", abbreviation = "any",
                            objective = "any", leadPerson = "any",
                            rclass = "tibble") {
  brapi::check(con, FALSE, "programs-search")
  brp <- get_brapi(con)

  pprograms = paste0(brp, "programs-search/")

  # pprogramName <- ifelse(programName != "any",
  #                        paste0("programName=", programName, "&"), "")
  # pabbreviation <- ifelse(abbreviation != "any",
  #                         paste0("abbreviation=", abbreviation, "&"), "")
  #
  # ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
  # ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  # if(pageSize == 10000){
  #   ppage = ""
  #   ppageSize = ""
  # }

  #pprograms <- paste0(pprograms, pprogramName, pabbreviation, ppageSize, ppage)

  try({
    body <- list(programDbId = programDbId,
                 name = name,
                 abbreviation = abbreviation,
                 objective = objective,
                 leadPerson = leadPerson)
    res <- brapiPOST(pprograms, body, con = con)
    res <- httr::content(res, "text", encoding = "UTF-8")

    out <- dat2tbl(res, rclass)
    class(out) <- c(class(out), "brapi_programs_search")
    out
  })
}
