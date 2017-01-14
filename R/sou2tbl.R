sou2tbl <- function(res, rclass, observationLevel){

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

  out <- res %>% as.character %>%
    enter_object("result") %>% enter_object("data") %>% gather_array() %>%
    spread_values(observationUnitDbId = jstring("observationUnitDbId"),
                  observationUnitName = jstring("observationUnitName"),
                  germplasmDbId = jstring("germplasmDbId"),
                  germplasmName = jstring("germplasmName"),
                  pedigree = jstring("pedigree"),
                  entryNumber = jnumber("entryNumber"),
                  entryType = jstring("entryType"),
                  plotNumber = jnumber("plotNumber"),
                  plantNumber = jnumber("plantNumber"),
                  blockNumber = jnumber("blockNumber"),
                  X = jnumber("X"),
                  Y = jnumber("Y"),
                  replicate = jnumber("replicate")

    ) %>%
    enter_object("observations") %>% gather_array %>%
    spread_values(
      observations.observationDbId = jstring("observationDbId"),
      observations.observationVariableDbId = jstring("observationVariableDbId"),
      observations.observationVariableName = jstring("observationVariableName"),
      observations.collector = jstring("collector"),
      observations.observationTimeStamp = jstring("observationTimeStamp"),
      observations.value = jstring("value")
    ) %>%
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
                  observations.value
                  )

  plantCol <- which(colnames(out) == "plantNumber")
  plotCol <- which(colnames(out) == "plotNumber")

  if (observationLevel == "plant"){
    out <- out[, -c(plotCol)]
  }
  if (observationLevel == "plot"){
    out <- out[, -c(plantCol)]
  }
  if (rclass == "tibble")
    out <- tibble::as_tibble(out)
  out
}
