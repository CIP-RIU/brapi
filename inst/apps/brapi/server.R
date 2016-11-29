library(jug)
source("mw_crops.R")
source("mw_programs.R")

res <- jug() %>%
  cors() %>%
  get("/brapi/v1/", function(req, res, err){
    "\nServer ready!\n\n"
  }) %>%
  include(mw_crops) %>%
  include(mw_programs) %>%
  simple_error_handler() %>%
  serve_it(port = 2021)
