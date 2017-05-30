sou2tbl <- function(res,
                    rclass,
                    observationLevel) {
  observationUnitDbId <- NULL
  observationUnitName <- NULL
  germplasmDbId <- NULL
  germplasmName <- NULL
  pedigree <- NULL
  entryNumber <- NULL
  entryType <- NULL
  plotNumber <- NULL
  plantNumber <- NULL
  blockNumber <- NULL
  X <- NULL
  Y <- NULL
  replicate <- NULL
  observations.observationDbId <- NULL
  observations.observationVariableDbId <- NULL
  observations.observationVariableName <- NULL
  observations.collector <- NULL
  observations.observationTimeStamp <- NULL
  observations.value <- NULL
  out <- res %>%
         as.character %>%
         tidyjson::enter_object("result") %>%
         tidyjson::enter_object("data") %>%
         tidyjson::gather_array() %>%
         tidyjson::spread_values(observationUnitDbId = tidyjson::jstring("observationUnitDbId"),
                                 observationUnitName = tidyjson::jstring("observationUnitName"),
                                 germplasmDbId = tidyjson::jstring("germplasmDbId"),
                                 germplasmName = tidyjson::jstring("germplasmName"),
                                 pedigree = tidyjson::jstring("pedigree"),
                                 entryNumber = tidyjson::jnumber("entryNumber"),
                                 entryType = tidyjson::jstring("entryType"),
                                 plotNumber = tidyjson::jnumber("plotNumber"),
                                 plantNumber = tidyjson::jnumber("plantNumber"),
                                 blockNumber = tidyjson::jnumber("blockNumber"),
                                 X = tidyjson::jnumber("X"),
                                 Y = tidyjson::jnumber("Y"),
                                 replicate = tidyjson::jnumber("replicate")) %>%
         tidyjson::enter_object("observations") %>%
         tidyjson::gather_array() %>%
         tidyjson::spread_values(observations.observationDbId = tidyjson::jstring("observationDbId"),
                                 observations.observationVariableDbId = tidyjson::jstring("observationVariableDbId"),
                                 observations.observationVariableName = tidyjson::jstring("observationVariableName"),
                                 observations.collector = tidyjson::jstring("collector"),
                                 observations.observationTimeStamp = tidyjson::jstring("observationTimeStamp"),
                                 observations.value = tidyjson::jstring("value")) %>%
         dplyr::select(observationUnitDbId,
                       observationUnitName,
                       germplasmDbId,
                       germplasmName,
                       pedigree,
                       entryNumber,
                       entryType,
                       plotNumber,
                       plantNumber,
                       blockNumber,
                       X,
                       Y,
                       replicate,
                       observations.observationDbId,
                       observations.observationVariableDbId,
                       observations.observationVariableName,
                       observations.collector,
                       observations.observationTimeStamp,
                       observations.value)
  if (rclass == "tibble") {
    out <- tibble::as_tibble(x = out)
  } else {
    class(out) <- "data.frame"
  }
  return(out)
}
