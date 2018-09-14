#' ba_vendor_plates_details
#'
#' Details of the plate.
#'
#' @param con list, brapi connection object
#' @param vendorPlateDbId character, \strong{REQUIRED ARGUMENT} with default: ""
#' @param rclass character; default: "list" possible other values: "json"
#'
#' @return rclass as defined
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/ExternalVendorSamples/Vendor_Plates_GET.md}{github}
#'
#' @example inst/examples/ex-ba_vendor_plates_details.R
#'
#' @export
ba_vendor_plates_details <- function(con = NULL,
                                     vendorPlateDbId = "",
                       rclass = c("list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_req(vendorPlateDbId)
  check_character(vendorPlateDbId)
  rclass <- match.arg(rclass)

  callurl <- get_brapi(con) %>% paste0("vendor/plates/", vendorPlateDbId)

  tryCatch({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")

    out <- dat2tbl(cont, rclass, result_level = "result")
    if (!is.null(out)) {
      class(out) <- c(class(out), "ba_vendor_plates_details")
    }
    return(out)
  })
}
