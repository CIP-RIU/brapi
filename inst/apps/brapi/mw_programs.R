library(jug)
library(jsonlite)

programs = read.csv("programs.csv", stringsAsFactors = FALSE)
programs = list(
  metadata = list(
    pagination = list(
      pageSize = 100,
      currentPage = 1,
      totalCount = length(crops),
      totalPages = 1
    ),
    status = NULL,
    datafiles = NULL
  ),
  result = list(data = list(as.list(programs[1, ]),
                            as.list(programs[2, ]))
                            )
)

mw_programs <-
  collector() %>%
  get("/brapi/v1/programs/", function(req, res, err){
    # if(exists(req$params$abbreviation)){
    #   abbr = req$params$abbreviation
    #   message(abbr)
    # } else {
    #   message("No params!")
    # }
    message(str(req$params))

    res$json(programs)
  })
