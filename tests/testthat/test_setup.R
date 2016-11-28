library(curl)
library(testthat)
library(brapi)

req <- tryCatch({
  curl_fetch_memory('http://127.0.0.1/brapi/v1/')
}, error = function(e){
  list(status_code = 555)
})


if (req$status_code == 555) {
  message("Server not found!\n")
  message("Start a new brapi server:\nsource('inst/apps/brapi/server.R') from a different R session!")
} else {
  message("Sever running ok!")

  context("Testing the call: crops")

  brapi <<- list(
    crop = "sweetpotato",
    db = '127.0.0.1',
    port = 80,
    user = "rsimon",
    password = "password",
    session = "",
    protocol = "http://"
  )

  test_that("Crops are listed.", {
    expect_equal(length(brapi::crops_list()), 4)
    expect_equal(brapi::crops_list()[1], "cassava")
  })

}
