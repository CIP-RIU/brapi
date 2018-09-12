#' ba_germplasm_search
#'
#' Lists germplasmm as result of a search.
#'
#' @param con brapi connection object
#' @param germplasmPUI character default: ''
#' @param germplasmDbId character default ''
#' @param germplasmName character default: ''
#' @param commonCropName character default: ''
#' @param pageSize integer default: 0
#' @param page integer default: 10
#' @param rclass character; default: tibble
#'
#' @return as defined by rclass
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1,0. 1.1, 1.2
#' @note BrAPI Status: active
#' @note Incomplete: Only GET implemented
#'
#' @author Reinhard Simon
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
                                page = 0,
                                pageSize = 10,
                                rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "germplasm-search")
  stopifnot(is.character(germplasmPUI))
  stopifnot(is.character(germplasmDbId))
  stopifnot(is.character(germplasmName))
  stopifnot(is.character(commonCropName))

  method <- "GET"

  check_paging(pageSize = pageSize, page = page)
  rclass <- match.arg(rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  brp <- paste0(brp, "germplasm-search?")

  ppages <- get_ppages(pageSize, page)

  callurl <- sub("[/?&]$",
                 "",
                 paste0(brp,
                        ifelse(germplasmPUI == "", "", paste0("germplasmPUI=", germplasmPUI)),
                        ifelse(germplasmDbId == "", "", paste0("germplasmDbId=", germplasmDbId)),
                        ifelse(germplasmName == "", "", paste0("germplasmName=", germplasmName)),
                        ifelse(commonCropName == "", "", paste0("commonCropName=", commonCropName)),

                        ppages$pageSize,
                        ppages$page))

  # if (germplasmPUI != "none") {
  #   germplasm_search <- paste0(brp, "germplasm-search/?germplasmPUI=",
  #                              germplasmPUI)
  # }

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


  # if (method == "POST") {
  #   body <- list(germplasmDbId = germplasmDbId,
  #                germplasmName = germplasmName,
  #                germplasmPUI = germplasmPUI,
  #                page = page,
  #                pageSize = pageSize)
  #   out <- try({
  #     germplasm_search <- paste0(brp, "germplasm-search/")
  #     res <- brapiPOST(url = germplasm_search, body = body, con = con)
  #     res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
  #     get_data(res2, '2')
  #   })
  # } else {
    out <- try({
      res <- brapiGET(url = callurl, con = con)
      res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")

      get_data(res2)
      })
  # }
  nms <- names(out)
  if (all(stringr::str_detect(nms, "data."))) {
    names(out) <- stringr::str_replace_all(nms, "data.", "")
  }
  class(out) <- c(class(out), "ba_germplasm_search")
  show_metadata(res)
  return(out)
}
