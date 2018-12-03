context("sp crops")

message("Deprecated. Sweetpotatobase does not yet implement the new call 'commoncropnames'.")

# con <- ba_db()$sweetpotatobase
#
# test_that("Crops are present", {
#
#   res <- ba_crops(con = con)
#   expect_that(nrow(res) == 1, is_true())
#
# })
#
# test_that("Crops output formats work", {
#
#   res <- ba_crops(con = con, rclass = "json")
#   expect_that("json" %in% class(res), is_true())
#
#   res <- ba_crops(con = con, rclass = "list")
#   expect_that("list" %in% class(res), is_true())
#
#   res <- ba_crops(con = con, rclass = "vector")
#   expect_that("ba_crops" %in% class(res), is_true())
#
#   res <- ba_crops(con = con, rclass = "data.frame")
#   expect_that("data.frame" %in% class(res), is_true())
#
#
# })
