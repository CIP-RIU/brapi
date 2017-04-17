library(testthat)
library(brapi)

#test_check("brapi")


source("tests/testthat/check_server_status.R")
test_file("tests/testthat/test_as.ba_db.R")
test_file("tests/testthat/test_ba_db.R")
#test_file("tests/testthat/test_abase.R")

test_file("tests/testthat/test_calls.R")
test_file("tests/testthat/test_can_internet.R")
test_file("tests/testthat/test_check.R")
test_file("tests/testthat/test_crops.R")
test_file("tests/testthat/test_germplasmattributes.R")
test_file("tests/testthat/test_germplasmattributes_categories.R")
test_file("tests/testthat/test_germplasm_details.R")
test_file("tests/testthat/test_locations.R")

test_file("tests/testthat/test_genomemaps.R")
test_file("tests/testthat/test_genomemaps_details.R")
test_file("tests/testthat/test_genomemaps_data.R")
test_file("tests/testthat/test_genomemaps_data_range.R")

test_file("tests/testthat/test_markers_details.R")
test_file("tests/testthat/test_markers_search.R")
test_file("tests/testthat/test_markerprofiles_search.R")
test_file("tests/testthat/test_markerprofiles_details.R")
test_file("tests/testthat/test_markerprofiles_allelematrix_search.R")

