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


  # lst <- jsonlite::fromJSON(txt = res)
  # if (length(lst$result) == 0) {
  #   return(NULL)
  # }
  # dat <- jsonlite::toJSON(x = lst$result$data)
  # dat <- jsonlite::fromJSON(txt = dat)
  # nms <- unique(lapply(X = dat, FUN = names) %>% unlist)
  # # TODO vectorize the next
  # n <- length(dat)
  # x <- character(n)
  # for (i in 1:n) {
  #   x <- c(x, names(dat[[i]]$additionalInfo))
  # }
  # nms <- c(nms, unique(x))
  # nms <- nms[!nms %in% c("", "additionalInfo")]
  # # construct basic data.frame
  # df <- as.data.frame(x = matrix(data = NA, ncol = length(nms), nrow = n),
  #                     stringsAsFactors = FALSE)
  # names(df) <- nms
  # names(df)[10:length(nms)] <- paste0("additionalInfo.", nms[10:length(nms)])
  # for (i in 1:length(dat)) {
  #   df[i, 1:7] <- dat[[i]][1:7]
  #   an <- paste0("additionalInfo.", names(dat[[i]]$additionalInfo))
  #   if (ncol(dat[[i]]$additionalInfo) > 0) {
  #     df[i, an] <- dat[[i]]$additionalInfo
  #   }
  # }
  # # TODO gather data for studies in separate table and then join; get data of additionalInfo (1st)
  # dfs <- as.data.frame(x = cbind(trialDbId = character(),
  #                                studyDbId = character(),
  #                                studyName = character(),
  #                                locationName = character()))
  # for (i in 1:length(dat)) {
  #   rec <- dat[[i]]$studies[[1]]
  #   if (nrow(rec) > 0) {
  #     trialDbId <- rep(x = dat[[i]]$trialDbId, times = nrow(rec))
  #     dfr <- cbind(trialDbId, rec)
  #     dfs <- rbind(dfs, dfr)
  #   }
  # }
  # names(dfs)[2:4] <- paste0("studies.", names(dfs)[2:4])
  # out <- merge(x = df, y = dfs)
  # out <- out[, -c(8)]
  # m <- ncol(out)
  # n <- m - 2
  # out <- out[, c(1:7, n:m, 8:(n - 1))]
  if (rclass == "tibble") {
    out <- tibble::as_tibble(out)
  }
  return(out)
}
