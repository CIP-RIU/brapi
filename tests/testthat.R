library(testthat)
library(brapi)

#testthat::skip_on_cran()
#if(!brapi::ba_can_internet()) skip("Skipping tests since no internet!")

test_check("brapi")
