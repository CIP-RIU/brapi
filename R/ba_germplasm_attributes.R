#' ba_germplasm_attributes
#'
#' Retrieve germplasm attibute values by a specified gerplasm database
#' identifier.
#'
#' @param con brapi connection object
#' @param germplasmDbId character, the internal database identifier for a
#'                      germplasm of which the germplasm attribute values are to
#'                      be retrieved e.g. "9932"; \strong{REQUIRED ARGUMENT}
#'                      with default: ""
#' @param attributeList character vector; \strong{DEPRECATED ARGUMENT} with
#'                      default: NULL
#' @param attributeDbIds character vector, restrict the response to only the
#'                       listed internal attribute database identifiers, supplied
#'                       as a character vector, e.g. c("123", "234", "345");
#'                       default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the germplasm
#'         attribute values.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/GermplasmAttributes/Germplasm_Attributes_GET.md}{github}
#'
#' @family germplasmattributes
#' @family genotyping
#'
#' @example inst/examples/ex-ba_germplasm_attributes.R
#'
#' @import httr
#' @export
ba_germplasm_attributes <- function(con = NULL,
                                    germplasmDbId = "",
                                    attributeList = NULL,
                                    attributeDbIds = "",
                                    pageSize = 1000,
                                    page = 0,
                                    rclass = c("tibble", "data.frame",
                                               "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(germplasmDbId, attributeDbIds)
  check_req(germplasmDbId = germplasmDbId)
  check_deprecated(attributeList, "attributeDbIds")
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("germplasm/", germplasmDbId, "/attributes")
  callurl <- get_endpoint(pointbase = brp,
                          attributeDbIds = attributeDbIds,
                          pageSize = pageSize,
                          page = page)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
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
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass == "data.frame") {
      out <- ms2tbl(res = cont) %>% tibble::as_tibble() %>% as.data.frame()
    }
    if (rclass == "tibble") {
      out <- ms2tbl(res = cont) %>% tibble::as_tibble()
    }
    class(out) <- c(class(out), "ba_germplasmattributes_details")
    show_metadata(resp)
    return(out)
  })
}
