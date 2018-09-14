#' ba_vendor_plates_search_post
#'
#' Search for vendor plates
#'
#' @param con list, brapi connection object
#' @param vendorProjectDbIds character,  default: ""
#' @param vendorPlateDbIds character,  default: ""
#' @param clientPlateDbIds character,  default: ""
#' @param sampleInfo logical,  default: TRUE
#' @param pageSize integer; default 1000
#' @param page integer; default 0
#' @param rclass character; default: "list" possible other values: "json"
#'
#' @return rclass as defined
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/ExternalVendorSamples/Vendor_PlatesSearch_POST.md}{github}
#'
#' @example inst/examples/ex-ba_vendor_plates_search_post.R
#'
#' @export
ba_vendor_plates_search_post <- function(con = NULL,
                                    vendorProjectDbIds = "",
                                    vendorPlateDbIds = "",
                                    clientPlateDbIds = "",
                                    sampleInfo = TRUE,
                                    pageSize = 1000,
                                    page = 0,
                                    rclass = c("list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(vendorProjectDbIds, vendorPlateDbIds, clientPlateDbIds)
  stopifnot(is.logical(sampleInfo))
  rclass <- match.arg(rclass)

  callurl <- get_brapi(con) %>% paste0("vendor/plates-search")
  body <- get_body(vendorProjectDbIds = vendorProjectDbIds,
                  vendorPlateDbIds = vendorPlateDbIds,
                  clientPlateDbIds = clientPlateDbIds,
                  sampleInfo = sampleInfo,
                  pageSize = pageSize,
                  page = page
                  )

  tryCatch({
    resp <- brapiPOST(url = callurl, body = body, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")

    out <- dat2tbl(cont, rclass, result_level = "result")
    if (!is.null(out)) {
      class(out) <- c(class(out), "ba_vendor_plates_search_post")
    }
    return(out)
  })
}
