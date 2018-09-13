#' ba_germplasm_attributes
#'
#' germplasm_attibutes call.
#'
#' @param con brapi connection object
#' @param germplasmDbId character; \strong{REQUIRED ARGUMENT} with default: ''.
#' @param attributeList character vector;  \strong{DEPRECATED ARGUMENT} with default: NULL.
#' @param attributeDbIds character vector; default: ''
#' @param pageSize integer; default: 1000.
#' @param page integer; default: 0.
#' @param rclass character; default: tibble; or else: json, list, data.frame.
#'
#' @return rclass as defined
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/GermplasmAttributes/Germplasm_Attributes_GET.md}{github}
#'
#' @family germplasmattributes
#' @family genotyping
#'
#' @example inst/examples/ex-ba_germplasmattributes_details.R
#'
#' @import httr
#' @export
ba_germplasm_attributes <- function(con = NULL,
                                           germplasmDbId = "",
                                           attributeList = NULL,
                                           attributeDbIds = "",
                                           pageSize = 1000,
                                           page = 0,
                                           rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(germplasmDbId, attributeDbIds)
  check_req(germplasmDbId = germplasmDbId)
  check_deprecated(attributeList, "attributeDbIds")
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("germplasm/", germplasmDbId, "/attributes")
  callurl <- get_endpoint(brp,
                          attributeDbIds = attributeDbIds,
                          pageSize = pageSize,
                          page = page)

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    ms2tbl <- function(res) {
      lst <- tryCatch(
        jsonlite::fromJSON(txt = res)
      )

      assertthat::assert_that("data" %in% names(lst$result),
                              msg = "The json return object lacks a data element.")
      dat <- jsonlite::toJSON(x = lst$result$data)
      germplasmDbId <- lst$result$germplasmDbId

      df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE,
                               flatten = TRUE)
      df <- cbind(germplasmDbId, df)
      # assertthat::validate_that(nrow(df) > 0,
      #             msg = "The json return object lacks a data element.")

      return(df)
    }
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass == "data.frame") {
      out <- ms2tbl(res = res2)%>% tibble::as_tibble() %>% as.data.frame()
    }
    if (rclass == "tibble") {
      out <- ms2tbl(res = res2) %>% tibble::as_tibble()
    }
    class(out) <- c(class(out), "ba_germplasmattributes_details")
    show_metadata(res)
    return(out)
  })
}
