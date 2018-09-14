#' ba_germplasm_search_post
#'
#' Lists germplasmm as result of a search.
#'
#' @param con brapi connection object
#' @param germplasmPUIs character default: ''
#' @param germplasmDbIds character default ''
#' @param germplasmSpecies character default ''
#' @param germplasmGenus character default ''
#' @param germplasmNames character default: ''
#' @param accessionNumbers character defautl ''
#' @param commonCropName character default: ''
#' @param pageSize integer default: 100
#' @param page integer default: 0
#' @param rclass character; default: tibble
#'
#' @return as defined by rclass
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1,0. 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Germplasm/GermplasmSearch_POST.md}{github}
#'
#' @family brapicore
#' @family genotyping
#' @family germplasm
#'
#' @example inst/examples/ex-ba_germplasm_search_post.R
#'
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
                                page = 0,
                                pageSize = 100,
                                rclass = c("tibble", "data.frame", "list", "json")) {
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

  get_data <- function(res2, typ = '1' )  {
    out <- dat2tbl(res = res2, rclass = rclass)
    if (rclass == "data.frame") {
      out <- gp2tbl(res2, typ)
    }
    if (rclass == "tibble") {
      out <- gp2tbl(res2, typ) %>% tibble::as_tibble()
    }
    out
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
