
#' list locations via breeding API.
#'
#' Sweetpotatobase API uses internally paging; this call uses a pageSize of 10000 for now to retrieve all locations.
#'
#' @return a data.frame of locations
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/reference/locations/list/list-locations}
#' @import httr
#' @export
locations_list <- function(){
  locs = brapi_GET("locations?pageSize=10000&page=1&")
  req = httr::content(locs)$result$data
  n = length(req)
  rdf = data.frame(
    locationDbId = integer(n),
    name = character(n),
    countryName = character(n),
    countryCode = character(n),
    longitude = numeric(n),
    latitude = numeric(n),
    altitude = integer(n)
    , stringsAsFactors = F)
  for(i in 1:n){
    val = req[[i]]$locationDbId
    if(!is.na(val)) rdf$locationDbId[i] <- val %>% as.integer()
    val = req[[i]]$name
    if(!is.na(val)) rdf$name[i] = val
    val = req[[i]]$countryName
    if(!is.na(val)) rdf$countryName[i] = val
    val = req[[i]]$countryCode
    if(!is.na(val)) rdf$countryCode[i] = val
    val = req[[i]]$longitude[i]
    if(!is.null(val)) rdf$longitude[i] <- val %>% as.numeric()
    val = req[[i]]$latitude
    if(!is.null(val)) rdf$latitude[i] <- val %>% as.numeric()
    val = req[[i]]$altitude
    if(!is.null(val)) rdf$altitude[i] <- val %>% as.integer()
  }
  rdf
}
