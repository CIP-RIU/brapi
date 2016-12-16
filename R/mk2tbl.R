mk2tbl <- function(res, include){
  markerDbId <- NULL
  defaultDisplayName <- NULL
  type <- NULL
  refAlt <- NULL
  analysisMethods <- NULL

  if(include != "synoyms") {
    out =  res %>% as.character %>%
      enter_object("result") %>% enter_object("data") %>% gather_array() %>%
      spread_values(markerDbId = jnumber("markerDbId"),
                    defaultDisplayName = jstring("defaultDisplayName"),
                    type = jstring("type")
      ) %>%
      enter_object("refAlt") %>% gather_array %>%
      spread_values(refAlt = jstring("refAlt")
      ) %>% enter_object("analysisMethods") %>% gather_array %>%
      spread_values(analysisMethods = jstring("analysisMethods")
      ) %>%
      dplyr::select(markerDbId, defaultDisplayName, type, refAlt, analysisMethods)
  } else {
    synonyms = NULL
    out = res %>% as.character %>%
      enter_object("result") %>% enter_object("data") %>% gather_array() %>%
      spread_values(markerDbId = jnumber("markerDbId"),
                    defaultDisplayName = jstring("defaultDisplayName"),
                    type = jstring("type")
      ) %>%
      gather_array %>% spread_values("synonyms") %>%
      #spread_values("synonyms") %>%
      enter_object("refAlt") %>%
      gather_array %>%
      append_values_string("refAlt") %>%
      #enter_object("analysisMethods") %>% gather_array %>%
      append_values_string("analysisMethods") %>%
      dplyr::select(markerDbId, defaultDisplayName, type, synonyms, refAlt, analysisMethods)
  }

  out
}
