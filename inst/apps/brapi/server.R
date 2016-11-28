library(jug)

message(getwd())

res <- jug() %>%
  cors() %>%
  get("/brapi/v1/", function(req, res, err){
    "\nServer ready!\n\n"
  }) %>%
  include(mw_crops, "mw_crops.R") %>%
  simple_error_handler() %>%
  serve_it(port = 80)
