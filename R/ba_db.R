#' ba_db
#'
#' A white list of known brapi databases.
#'
#' @return list
#' @author Reinhard Simon
#' @example inst/examples/ex-ba_db.R
#' @family brapiutils
#' @export
ba_db <- function() {
    sweetpotatobase <- as.ba_db(crop = "sweetpotato", secure = TRUE, protocol = "https://",
                                db = "sweetpotatobase.org", port = 80, multicrop = FALSE,
        bms = FALSE)
    yambase <- as.ba_db(crop = "yam", secure = TRUE, protocol = "https://",
                        db = "yambase.org", port = 80, multicrop = FALSE, bms = FALSE)
    musabase <- as.ba_db(crop = "musa", secure = TRUE, protocol = "https://",
                         db = "musabase.org", port = 80, multicrop = FALSE, bms = FALSE)
    cassavabase <- as.ba_db(crop = "cassava", secure = TRUE, protocol = "https://",
                            db = "cassavabase.org", port = 80, multicrop = FALSE, bms = FALSE)
    germinate <- as.ba_db(crop = "cactuar", secure = TRUE, protocol = "https://",
                          db = "ics.hutton.ac.uk", port = 80, multicrop = FALSE,
                          apipath = "germinate-demo/cactuar",
        bms = FALSE)
    bms_test <- as.ba_db(crop = "wheat", secure = FALSE, protocol = "http://",
                         db = "104.196.40.209", port = 48080, apipath = "bmsapi", user = "",
        password = "", multicrop = TRUE, bms = TRUE)
    mockbase <- as.ba_db(crop = "sweetpotato", secure = FALSE, protocol = "http://",
                         db = "127.0.0.1", port = 2021, multicrop = FALSE, bms = FALSE)
    snpseek <- as.ba_db(crop = "rice", secure = FALSE, protocol = "http://",
                        db = "snp-seek.irri.org", port = 80, apipath = "ws", user = "snpseek-user",
        password = "snpseek-user-pass", multicrop = FALSE, token = "", bms = TRUE)
    eu_sol <- as.ba_db(crop = "tomato", secure = TRUE, db = "www.eu-sol.wur.nl",
                       apipath = "webapi", multicrop = TRUE, bms = FALSE)
    mgis <- as.ba_db(crop = "musa", secure = TRUE, protocol = "https://",
                    db = "www.crop-diversity.org", port = 80, apipath = "mgis", user = "",
        password = "", multicrop = FALSE, bms = FALSE)
    t3s <- as.ba_db(crop = "wheatplus", secure = TRUE, protocol = "https://",
                    db = "t3sandbox.org", port = 80, apipath = "t3", user = "", password = "",
        multicrop = TRUE, bms = FALSE)
    tto <- as.ba_db(crop = "oat", secure = TRUE, protocol = "https://",
                    db = "triticeaetoolbox.org", port = 80, apipath = "", user = "", password = "",
        multicrop = TRUE, bms = FALSE)
    ttw <- as.ba_db(crop = "wheat", secure = TRUE, protocol = "https://",
                    db = "triticeaetoolbox.org", port = 80, apipath = "", user = "", password = "",
        multicrop = TRUE, bms = FALSE)
    out <- list(sweetpotatobase = sweetpotatobase, yambase = yambase, musabase = musabase,
                cassavabase = cassavabase, germinate_test = germinate,
        bms_test = bms_test, mockbase = mockbase, snpseek = snpseek, eu_sol = eu_sol,
        mgis = mgis, t3s = t3s, tto = tto, ttw = ttw)
    class(out) <- "ba_db_list"
    return(out)
}
