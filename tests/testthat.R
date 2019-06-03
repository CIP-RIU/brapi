library(testthat)
library(brapi)

ba_show_info(FALSE)

skip_on_appveyor()
skip_on_travis()
test_check("brapi")
