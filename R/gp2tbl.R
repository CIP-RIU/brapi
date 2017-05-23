gp2tbl <- function(res) {
  germplasmDbId <- NULL
  defaultDisplayName <- NULL
  accessionNumber <- NULL
  germplasmName <- NULL
  germplasmPUI <- NULL
  pedigree <- NULL
  seedSource <- NULL
  synonyms <- NULL
  commonCropName <- NULL
  instituteCode <- NULL
  instituteName <- NULL
  biologicalStatusOfAccessionCode <- NULL
  countryOfOriginCode <- NULL
  typeOfGermplasmStorageCode <- NULL
  genus <- NULL
  species <- NULL
  speciesAuthority <- NULL
  subtaxa <- NULL
  subtaxaAuthority <- NULL
  donors.donorAccessionNumber <- NULL
  donors.donorInstituteCode <- NULL
  donors.germplasmPUI <- NULL
  acquisitionDate <- NULL
  out <- res %>%
         as.character %>%
         tidyjson::enter_object("result") %>%
         tidyjson::enter_object("data") %>%
         tidyjson::gather_array %>%
         tidyjson::spread_values(germplasmDbId = tidyjson::jnumber("germplasmDbId"),
                                 defaultDisplayName = tidyjson::jstring("defaultDisplayName"),
                                 accessionNumber = tidyjson::jstring("accessionNumber"),
                                 germplasmName = tidyjson::jstring("germplasmName"),
                                 germplasmPUI = tidyjson::jstring("germplasmPUI"),
                                 pedigree = tidyjson::jstring("pedigree"),
                                 seedSource = tidyjson::jstring("seedSource"),
                                 synonyms = tidyjson::jstring("synonyms"),
                                 commonCropName = tidyjson::jstring("commonCropName"),
                                 instituteCode = tidyjson::jstring("instituteCode"),
                                 instituteName = tidyjson::jstring("instituteName"),
                                 biologicalStatusOfAccessionCode = tidyjson::jnumber("biologicalStatusOfAccessionCode"),
                                 countryOfOriginCode = tidyjson::jstring("countryOfOriginCode"),
                                 typeOfGermplasmStorageCode = tidyjson::jnumber("typeOfGermplasmStorageCode"),
                                 genus = tidyjson::jstring("genus"),
                                 species = tidyjson::jstring("species"),
                                 speciesAuthority = tidyjson::jstring("speciesAuthority"),
                                 subtaxa = tidyjson::jstring("subtaxa"),
                                 subtaxaAuthority = tidyjson::jstring("subtaxaAuthority"),
                                 acquisitionDate = tidyjson::jstring("acquisitionDate")) %>%
         tidyjson::enter_object("donors") %>%
         tidyjson::gather_array %>%
         tidyjson::spread_values(donors.donorAccessionNumber = tidyjson::jstring("donorAccessionNumber"),
                                 donors.donorInstituteCode = tidyjson::jstring("donorInstituteCode"),
                                 donors.germplasmPUI = tidyjson::jstring("germplasmPUI")) %>%
         dplyr::select(germplasmDbId,
                       defaultDisplayName,
                       accessionNumber,
                       germplasmName,
                       germplasmPUI,
                       pedigree,
                       seedSource,
                       synonyms,
                       commonCropName,
                       instituteCode,
                       instituteName,
                       biologicalStatusOfAccessionCode,
                       countryOfOriginCode,
                       typeOfGermplasmStorageCode,
                       genus,
                       species,
                       speciesAuthority,
                       subtaxa,
                       subtaxaAuthority,
                       donors.donorAccessionNumber,
                       donors.donorInstituteCode,
                       donors.germplasmPUI,
                       acquisitionDate)
  return(out)
}
