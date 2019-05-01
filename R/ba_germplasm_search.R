#' ba_germplasm_search
#'
#' Retrieve germplasm information as result of a GET search.
#'
#' @param con list, brapi connection object
#' @param germplasmPUI character, search for germplasm information using a
#'                     Permanent Unique Identifier (DOI, URI, etc.); default: ""
#' @param germplasmDbId character, search for germplasm information using an
#'                      internal germplasm database identifier; default: ""
#' @param germplasmName character, search for germplasm information using the
#'                      name of the germplasm; default: ""
#' @param commonCropName character, search for germplasm information using the
#'                       common crop name related to the germplasm; default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the germaplasm
#'         information result of the search.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Germplasm/GermplasmSearch_GET.md}{github}
#'
#' @family brapicore
#' @family genotyping
#' @family germplasm
#'
#' @example inst/examples/ex-ba_germplasm_search.R
#'
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @export
ba_germplasm_search <- function(con = NULL,
                                germplasmPUI = "",
                                germplasmDbId = "",
                                germplasmName = "",
                                commonCropName = "",
                                pageSize = 1000,
                                page = 0,
                                rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "germplasm-search")
  check_character(germplasmPUI, germplasmDbId, germplasmName, commonCropName)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("germplasm-search")
  callurl <- get_endpoint(brp,
                          germplasmPUI = germplasmPUI,
                          germplasmDbId = germplasmDbId,
                          germplasmName = germplasmName,
                          commonCropName = commonCropName,
                          pageSize = pageSize,
                          page = page)

  get_data <- function(cont, typ = "1") {
    out <- dat2tbl(res = cont, rclass = rclass)
    if (rclass == "data.frame") {
      out <- gp2tbl(cont, typ)
    }
    if (rclass == "tibble") {
      out <- gp2tbl(cont, typ) %>% tibble::as_tibble()
    }
    out
  }

  out <- try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")

    get_data(cont)
  })
  # }
  nms <- names(out)
  if (all(stringr::str_detect(nms, "data."))) {
    names(out) <- stringr::str_replace_all(nms, "data.", "")
  }
  class(out) <- c(class(out), "ba_germplasm_search")
  show_metadata(resp)
  return(out)
}
