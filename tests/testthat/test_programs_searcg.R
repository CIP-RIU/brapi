con <- ba_db()$apiary

test_that("Programs_search is present", {

  res <- ba_programs_search(con = con,
                            programDbId = "123",
                            name = "Wheat Resistance Program",
                            abbreviation = "DRP1",
                            objective = "Disease Resistance",
                            leadPerson = "Dr. Henry Beachell"
                            # ,
                            # pageSize = 1000,
                            # page = 0
                          )
  expect_that("Ghana" %in% res$name, is_true())

})

test_that("Programs output formats work", {

  res <- ba_programs(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

})
