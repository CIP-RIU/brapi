#' ba_germplasmattributes_details
#'
#' attibutes call.
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble; or else: json, list, data.frame.
#' @param germplasmDbId character; default: 1.
#' @param attributeList character vector; default: 1.
#' @param page integer; default: 0.
#' @param pageSize integer; default: 10.
#'
#' @return rclass as set by parameter.
#' @example inst/examples/ex-ba_germplasmattributes_details.R
#' @import httr
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GermplasmAttributes/GermplasmAttributeValuesByGermplasmDbId.md}{github}
#' @family germplasmattributes
#' @family genotyping
#' @export
ba_germplasmattributes_details <- function(con = NULL,
                                           germplasmDbId = "1",
                                           attributeList = "1",
                                           page = 0,
                                           pageSize = 10,
                                           rclass = "tibble") {
  ba_check(con = con, verbose = FALSE)
  stopifnot(is.character(germplasmDbId))
  stopifnot(is.character(attributeList))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(brapi = con)
  # generate the specific brapi call url
  germplasm_attributes_list <- paste0(brp,
                                      "germplasm/",
                                      germplasmDbId,
                                      "/attributes/?attributeList=",
                                      paste(attributeList, collapse = ","),
                                      "&page=",
                                      page,
                                      "&pageSize=",
                                      pageSize)
  try({
    res <- brapiGET(url = germplasm_attributes_list, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    ms2tbl <- function(res) {
      attributeDbId <- NULL
      attributeCode <- NULL
      attributeName <- NULL
      value <- NULL
      dateDetermined <- NULL
      restbl <- res %>%
                as.character %>%
                tidyjson::enter_object("result") %>%
                tidyjson::spread_values(germplasmDbId = jnumber("germplasmDbId")) %>%
                tidyjson::enter_object("data") %>%
                tidyjson::gather_array %>%
                tidyjson::spread_values(attributeDbId = tidyjson::jnumber("attributeDbId"),
                                        attributeCode = tidyjson::jstring("attributeCode"),
                                        attributeName = tidyjson::jstring("attributeName"),
                                        value = tidyjson::jstring("value"),
                                        dateDetermined = tidyjson::jstring("dateDetermined")) %>%
                dplyr::select(germplasmDbId,
                              attributeDbId,
                              attributeName,
                              attributeCode,
                              value,
                              dateDetermined)
      return(restbl)
    }
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass == "data.frame") {
      out <- ms2tbl(res = res)
    }
    if (rclass == "tibble") {
      out <- ms2tbl(res = res) %>% tibble::as_tibble()
    }
    class(out) <- c(class(out), "ba_germplasmattributes_details")
    return(out)
  })
}
