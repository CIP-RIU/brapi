library(testthat)
library(brapi)

ba_show_info(FALSE)
test_check("brapi")

# capture.output(testthat::test_dir('tests/testthat/sp', reporter = testthat::TapReporter), file = 'tests/testthat/sp/log-test.txt')
# capture.output(testthat::test_dir('tests/testthat/ts', reporter = testthat::TapReporter), file = 'tests/testthat/ts/log-test.txt')
