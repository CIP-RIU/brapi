#' ba_vendor_plates_search
#'
#' Search for vendor plates
#'
#' @param con list, brapi connection object
#' @param vendorProjectDbId character,  default: ""
#' @param vendorPlateDbId character,  default: ""
#' @param clientPlateDbId character,  default: ""
#' @param sampleInfo logical,  default: TRUE
#' @param pageSize integer; default 1000
#' @param page integer; default 0
#' @param rclass character; default: "list" possible other values: "json"
#'
#' @return rclass as defined
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/ExternalVendorSamples/Vendor_PlatesSearch_GET.md}{github}
#'
#' @example inst/examples/ex-ba_vendor_plates_search.R
#'
#' @export
ba_vendor_plates_search <- function(con = NULL,
                                    vendorProjectDbId = "",
                                    vendorPlateDbId = "",
                                    clientPlateDbId = "",
                                    sampleInfo = TRUE,
                                    pageSize = 1000,
                                    page = 0,
                                    rclass = c("list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(vendorProjectDbId, vendorPlateDbId, clientPlateDbId)
  stopifnot(is.logical(sampleInfo))
  rclass <- match.arg(rclass)

  brp <- get_brapi(con) %>% paste0("vendor/plates-search")
  callurl <- get_endpoint(brp,
                          vendorProjectDbId = vendorProjectDbId,
                          vendorPlateDbId = vendorPlateDbId,
                          clientPlateDbId = clientPlateDbId,
                          sampleInfo = sampleInfo,
                          pageSize = pageSize,
                          page = page
                          )

  tryCatch({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")

    out <- dat2tbl(cont, rclass, result_level = "result")
    if (!is.null(out)) {
      class(out) <- c(class(out), "ba_vendor_plates_search")
    }
    return(out)
  })
}
