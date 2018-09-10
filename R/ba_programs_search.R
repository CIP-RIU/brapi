#' ba_programs_search
#'
#' Search breeding programs via a POST method
#'
#' @param con list, brapi connection object
#' @param abbreviation character, search programs by program abbreviation;
#'                     default: ""
#' @param leadPerson character, search programs by program leader name; default:
#'                   ""
#' @param name character, search programs by program name; default: ""
#' @param objective character, search programs by program objective; default: ""
#' @param programDbId character, search programs by program database identifier;
#'                    default: ""
#' @param commonCropName character, search programs by commonCropName; default:
#'                       ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @details Searching by commonCropName has not be tested yet, because none of
#'          the databases support this feature yet (not even the test-server)!
#'
#' @return An object of class as defined by rclass containing the breeding
#'         programs matching the search criteria.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Programs/ProgramSearch.md}{github}
#' @family brapicore
#' @example inst/examples/ex-ba_programs_search.R
#' @import httr
#' @export
ba_programs_search <- function(con = NULL,
                               abbreviation = "",
                               leadPerson = "",
                               name = "",
                               objective = "",
                               programDbId = "",
                               commonCropName = "",
                               pageSize = 1000,
                               page = 0,
                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "programs-search")
  stopifnot(is.character(programDbId))
  stopifnot(is.character(name))
  stopifnot(is.character(abbreviation))
  stopifnot(is.character(objective))
  stopifnot(is.character(leadPerson))
  stopifnot(is.character(commonCropName))
  check_paging(pageSize, page)
  check_rclass(rclass)
  # fetch url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate specific brapi call url
  callurl <- paste0(brp, "programs-search")
  try({
    body <- list(abbreviation = ifelse(abbreviation != "",
                                       abbreviation,
                                       ""),
                 leadPerson = ifelse(leadPerson != "",
                                     leadPerson,
                                     ""),
                 name = ifelse(name != "",
                               name,
                               ""),
                 objective = ifelse(objective != "",
                                    objective,
                                    ""),
                 programDbId = ifelse(programDbId != "",
                                      programDbId,
                                      ""),
                 commonCropName = ifelse(commonCropName != "",
                                         commonCropName,
                                         ""),
                 pageSize = ifelse(pageSize != "",
                                   pageSize %>% as.integer(),
                                   ""),
                 page = ifelse(page != "",
                               page %>% as.integer(),
                               "")
                 )
    for (i in length(body):1) {
      if (body[[i]] == "") {
        body[[i]] <- NULL
      }
    }
    res <- brapiPOST(url = callurl, body = body, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_programs_search")
    show_metadata(res)
    return(out)
  })
}
