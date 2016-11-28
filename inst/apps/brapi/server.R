library(jug)

#mw_crops = NULL
#mw_programs = NULL

res <- jug() %>%
  cors() %>%
  get("/brapi/v1/", function(req, res, err){
    "\nServer ready!\n\n"
  }) %>%
  include(mw_crops, "mw_crops.R") %>%
  include(mw_programs, "mw_programs.R") %>%
  simple_error_handler() %>%
  serve_it(port = 80)
