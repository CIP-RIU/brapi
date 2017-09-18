trl2tbl <- function(res, rclass) {
  programDbId <- NULL
  programName <- NULL
  trialDbId <- NULL
  trialName <- NULL
  active <- NULL
  additionalInfo <- NULL
  startDate <- NULL
  endDate <- NULL
  studyDbId <- NULL
  studyName <- NULL
  locationDbId <- NULL
  out <- res %>%
    as.character %>%
    tidyjson::enter_object("result") %>%
    tidyjson::enter_object("data") %>%
    tidyjson::gather_array() %>%
    tidyjson::spread_values(
       programDbId = tidyjson::jnumber("programDbId"),
       programName = tidyjson::jstring("programName"),
       trialDbId = tidyjson::jstring("trialDbId"),
       trialName = tidyjson::jstring("trialName"),
       active = tidyjson::jstring("active"),
       additionalInfo = tidyjson::jstring("additionalInfo"),
       startDate = tidyjson::jstring("startDate"),
       endDate = tidyjson::jstring("endDate")) %>%
    tidyjson::enter_object("studies") %>%
    tidyjson::gather_array() %>%
    tidyjson::spread_values(
      studyDbId = tidyjson::jnumber("studyDbId"),
      studyName = tidyjson::jstring("studyName"),
      locationDbId = tidyjson::jnumber("locationDbId")
    ) %>%
    dplyr::select(programDbId,
                  programName,
                  trialDbId,
                  trialName,
                  active,
                  additionalInfo,
                  startDate,
                  endDate,
                  studyDbId,
                  studyName,
                  locationDbId)
  out$additionalInfo = sapply(out$additionalInfo, function(x) ifelse(x == "list()", "", paste(x, collapse = ", ")))

  # TODO: still find a better way to deal with additionalInfo!

  if (rclass == "tibble") {
    out <- tibble::as_tibble(out)
  }
  return(out)
}
