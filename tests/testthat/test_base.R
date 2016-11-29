
req <- tryCatch({
  curl::curl_fetch_memory('http://127.0.0.1:2021/brapi/v1/')
}, error = function(e){
  list(status_code = 555)
})


if (req$status_code == 555) {
  message("Server not found!\n")
  message("Start a new brapi server:\nsource('inst/apps/brapi/server.R') from a different R session!")
} else {
  context("Testing server")

  test_that("Base URL for brapi.", {
    expect_equal(req$status_code, 200)
  })
}
