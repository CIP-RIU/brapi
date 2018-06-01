library(testthat)
library(brapi)

testthat::skip_on_cran()
testthat::skip_on_travis()
#if(!brapi::ba_can_internet()) skip("Skipping tests since no internet!")
ba_show_info(FALSE)
test_check("brapi")
