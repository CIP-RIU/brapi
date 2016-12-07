#' germplasm
#'
#' Gets germplasm details given an id.
#'
#' @param rclass character; tibble
#' @param germplasmDbId string; default 0; an internal ID for a germplasm
#' @import tidyjson
#' @import dplyr
#' @importFrom tibble, as_tibble
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/germplasm-details-by-germplasmdbid}
#' @return list
#' @export
germplasm <- function(germplasmDbId = 0, rclass = "tibble") {
  brapi::check(FALSE)
  germplasm = paste0(get_brapi(), "germplasm/", germplasmDbId, "/")

  tryCatch({
    res <- brapiGET(germplasm)
    res <- httr::content(res, "text", encoding = "UTF-8")
    out <- NULL
    ms2tbl <- function(res){
      #markerProfiles <- NULL
      res %>% as.character %>%
        enter_object("result") %>% enter_object("data") %>% gather_array() %>%
        spread_values(germplasmDbId = jnumber("germplasmDbId"),
                      defaultDisplayName = jstring('defaultDisplayName'),
                      accessionNumber = jstring("accessionNumber"),
                      germplasmName = jstring("germplasmName"),
                      germplasmPUI = jstring("germplasmPUI"),
                      pedigree = jstring("pedigree"),
                      germplasmSeedSource = jstring("germplasmSeedSource"),
                      synonyms = jstring("synonyms"),
                      commonCropName = jstring('commonCropName'),
                      instituteCode = jstring("instituteCode"),
                      instituteName = jstring("instituteName"),
                      biologicalStatusOfAccessionCode = jnumber("biologicalStatusOfAccessionCode"),
                      countryOfOriginCode = jstring('countryOfOriginCode'),
                      typeOfGermplasmStorageCode = jnumber('typeOfGermplasmStorageCode'),
                      genus = jstring('genus'),
                      species = jstring('species'),
                      speciesAuthority = jstring('speciesAuthority'),
                      subtaxa = jstring('subtaxa'),
                      subtaxaAuthority = jstring('subtaxaAuthority'),
                      acquisitionDate = jstring('acquisitionDate')
        ) %>%
        enter_object("donors") %>% gather_array %>%
        spread_values(
          donors.donorAccessionNumber = jstring("donorAccessionNumber"),
          donors.donorInstituteCode = jstring("donorInstituteCode"),
          donors.germplasmPUI = jstring("germplasmPUI")
        ) %>%
        dplyr::select(germplasmDbId, defaultDisplayName, accessionNumber,
                      germplasmName, germplasmPUI, pedigree, germplasmSeedSource,
                      synonyms, commonCropName, instituteCode, instituteName,
                      biologicalStatusOfAccessionCode, countryOfOriginCode,
                      typeOfGermplasmStorageCode, genus, species, speciesAuthority,
                      subtaxa, subtaxaAuthority,
                      donors.donorAccessionNumber,
                      donors.donorInstituteCode,
                      donors.germplasmPUI,
                      acquisitionDate)
    }

    if (rclass %in% c("json", "list")) out <- dat2tbl(res, rclass)
    if (rclass == "data.frame") out  <- ms2tbl(res)
    if (rclass == "tibble")     out  <- ms2tbl(res) %>% tibble::as_tibble()

    out
  }, error = function(e){
    NULL
  })

}
