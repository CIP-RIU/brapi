
observationlevels_data = readLines(system.file("apps/brapi/data/observationlevels.txt", package = "brapi"))

observationlevels = list(
  metadata = list(
    pagination =
      list(
        pageSize = 0,
        currentPage = 0,
        totalCount = 0,
        totalPages = 0
      )
    ,
    status = list(),
    datafiles = list()
  ),
  result = list(data = observationlevels_data)
)

process_call <- function(req, res, err){
  #get("[/a-z]*/brapi/v1/observationlevels[/]?", function(req, res, err){
    prms <- names(req$params)
    if('format' %in% prms){
      #message("ok")
      if(req$params$format == "plain") {
        #message("ok")

        res$set_header("ContentType", "text/plain")
        res$set_status(200)
        res$text(paste(observationlevels_data, collapse = ", "))
      } else {
        res$json(observationlevels)
      }
    } else {
      res$json(observationlevels)
    }
    res

}

mw_observationlevels <<-
  collector() %>%
  get("/brapi/v1/observationLevels[/]?", function(req, res, err){
    process_call(req, res, err)
  })  %>%
  put("/brapi/v1/observationLevels[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/observationLevels[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/observationLevels[/]?", function(req, res, err){
    res$set_status(405)
  })
