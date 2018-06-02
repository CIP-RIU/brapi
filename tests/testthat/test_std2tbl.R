context("std2tbl")



test_that("Parameters work", {
  res <- '{
    "metadata": {
  "pagination": {
  "totalCount": 0,
  "currentPage": 0,
  "totalPages": 0,
  "pageSize": 0
  },
  "status": [],
  "datafiles": []
},
  "result": []
  }'
  res <- brapi:::std2tbl(res)
  expect_true(is.null(res))
})

test_that("Parameters work", {
  res <- '{
  "metadata": {
  "pagination": {
  "totalCount": 0,
  "currentPage": 0,
  "totalPages": 0,
  "pageSize": 0
  },
  "status": [],
  "datafiles": []
  },
  "result": []
}'
  res <- brapi:::stdd2tbl(res, "json")
  expect_true(is.null(res))
  })


