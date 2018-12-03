context("ts germplasm_progeny")

con <- ba_db()$testserver

test_that("Germplasm_progeny results are present", {

  res <- ba_germplasm_progeny(con = con, germplasmDbId = "1")
  expect_that(nrow(res) == 3, is_true())
  expect_that(ncol(res) >= 5, is_true())
  expect_that(all(names(res) %in% c("germplasmDbId",
                    "defaultDisplayName",
                    "progeny.defaultDisplayName",
                    "progeny.germplasmDbId",
                    "progeny.parentType"
                    )
  ))
})

test_that("out formats work", {

  res <- ba_germplasm_progeny(con = con, germplasmDbId = "1", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_germplasm_progeny(con = con, germplasmDbId = "1", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_germplasm_progeny(con = con, germplasmDbId = "1", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

