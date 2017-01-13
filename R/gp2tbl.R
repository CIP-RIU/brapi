gp2tbl <- function(res) {
    germplasmDbId <- NULL
    defaultDisplayName <- NULL
    accessionNumber <- NULL
    germplasmName <- NULL
    germplasmPUI <- NULL
    pedigree <- NULL
    germplasmSeedSource <- NULL
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
    res %>% as.character %>% enter_object("result") %>% enter_object("data") %>% gather_array() %>% spread_values(germplasmDbId = jnumber("germplasmDbId"), 
        defaultDisplayName = jstring("defaultDisplayName"), accessionNumber = jstring("accessionNumber"), 
        germplasmName = jstring("germplasmName"), germplasmPUI = jstring("germplasmPUI"), pedigree = jstring("pedigree"), 
        germplasmSeedSource = jstring("germplasmSeedSource"), synonyms = jstring("synonyms"), commonCropName = jstring("commonCropName"), 
        instituteCode = jstring("instituteCode"), instituteName = jstring("instituteName"), biologicalStatusOfAccessionCode = jnumber("biologicalStatusOfAccessionCode"), 
        countryOfOriginCode = jstring("countryOfOriginCode"), typeOfGermplasmStorageCode = jnumber("typeOfGermplasmStorageCode"), 
        genus = jstring("genus"), species = jstring("species"), speciesAuthority = jstring("speciesAuthority"), 
        subtaxa = jstring("subtaxa"), subtaxaAuthority = jstring("subtaxaAuthority"), acquisitionDate = jstring("acquisitionDate")) %>% 
        enter_object("donors") %>% gather_array %>% spread_values(donors.donorAccessionNumber = jstring("donorAccessionNumber"), 
        donors.donorInstituteCode = jstring("donorInstituteCode"), donors.germplasmPUI = jstring("germplasmPUI")) %>% 
        dplyr::select(germplasmDbId, defaultDisplayName, accessionNumber, germplasmName, germplasmPUI, pedigree, 
            germplasmSeedSource, synonyms, commonCropName, instituteCode, instituteName, biologicalStatusOfAccessionCode, 
            countryOfOriginCode, typeOfGermplasmStorageCode, genus, species, speciesAuthority, subtaxa, 
            subtaxaAuthority, donors.donorAccessionNumber, donors.donorInstituteCode, donors.germplasmPUI, 
            acquisitionDate)
}
