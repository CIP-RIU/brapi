#' ba_germplasm_search_post
#'
#' Retrieve germplasm information as result of a POST search.
#'
#' @param con brapi connection object
#' @param germplasmPUIs character vector, search for germplasm information using
#'                      multiple Permanent Unique Identifiers (DOI, URI, etc.)
#'                      e.g. c("http://www.crop-diversity.org/mgis/accession/01BEL084609",
#'                      "doi:10.15454/328757862534E12"); default: ""
#' @param germplasmDbIds character vector, search for germplasm information using
#'                      internal germplasm database identifiers e.g. c("986",
#'                      "01BEL084609"); default: ""
#' @param germplasmSpecies character vector, search for germplasm information
#'                         using species names e.g. c("aestivum", "vinifera");
#'                         default: ""
#' @param germplasmGenus character vector, search for germplasm information
#'                       using genus names e.g. c("Solanum", "Triticum");
#'                       default: ""
#' @param germplasmNames character vector, search for germplasm information
#'                       using the names of germplasm e.g. c("XYZ1", "Pahang");
#'                       default: ""
#' @param accessionNumbers character vector, search for germplasm information
#'                         using accession numbers e.g. c("ITC0609", "ITC0685");
#'                         default: ""
#' @param commonCropName character, search for germplasm information using the
#'                       common crop name related to the germplasm e.g. "wheat";
#'                       default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the germplasm
#'         information fulfilling the search criteria.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1,0. 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Germplasm/GermplasmSearch_POST.md}{github}
#' @family brapicore
#' @family genotyping
#' @family germplasm
#' @example inst/examples/ex-ba_germplasm_search_post.R
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @export
ba_germplasm_search_post <- function(con = NULL,
                                     germplasmPUIs = "",
                                     germplasmDbIds = "",
                                     germplasmSpecies = "",
                                     germplasmGenus = "",
                                     germplasmNames = "",
                                     accessionNumbers = "",
                                     commonCropName = "",
                                     pageSize = 1000,
                                     pageSize = 0,
                                     rclass = c("tibble", "data.frame",
                                                "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "germplasm-search")
  check_character(germplasmPUIs, germplasmDbIds, germplasmSpecies, germplasmGenus,
                  germplasmNames, accessionNumbers, commonCropName)
  rclass <- match.arg(rclass)

  callurl <- get_brapi(con = con) %>% paste0("germplasm-search")
  body <- get_body(germplasmPUIs = germplasmPUIs,
                   germplasmDbIds = germplasmDbIds,
                   germplasmSpecies = germplasmSpecies,
                   germplasmGenus = germplasmGenus,
                   germplasmNames = germplasmNames,
                   accessionNumbers = accessionNumbers,
                   commonCropName = commonCropName,
                   pageSize = pageSize,
                   page = page)

  get_data <- function(res2, typ = '1') {
    out <- dat2tbl(res = res2, rclass = rclass)
    if (rclass == "data.frame") {
      out <- gp2tbl(res2, typ)
    }
    if (rclass == "tibble") {
      out <- gp2tbl(res2, typ) %>% tibble::as_tibble()
    }
    return(out)
  }

  resp <- brapiPOST(url = callurl, body = body, con = con)

  out <- try({
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    get_data(cont)
  })
  # }
  nms <- names(out)
  if (all(stringr::str_detect(nms, "data."))) {
    names(out) <- stringr::str_replace_all(nms, "data.", "")
  }
  class(out) <- c(class(out), "ba_germplasm_search_post")
  show_metadata(resp)
  return(out)
}
