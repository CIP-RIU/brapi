baps2rclass <- function(res2, rclass) {
  out <- NULL
  if (rclass %in% c("json", "list")) {
    out <- dat2tbl(res = res2, rclass = rclass)
  }
  if (rclass %in% c("tibble", "data.frame")) {
    out <- jsonlite::fromJSON(txt = res2, simplifyDataFrame = TRUE)
    out1 <- out$result$data
    n <- nrow(out1)
    if(is.null(n)) return(NULL) # no data
    nr <- sapply(X = out1$observations, FUN = nrow)
    nid <- rep.int(x = out1$observationUnitDbId, times = nr)
    out2 <- out1$observations[[1]]
    if (n > 1) {
      for (i in 2:n) {
        out2 <- rbind(out2, out1$observations[[i]])
      }
    }
    out2 <- cbind(observationUnitDbId = nid, out2)
    names(out2)[2:ncol(out2)] <- paste0("observations.",
                                        names(out2)[2:ncol(out2)])
    out3 <- merge(x = out1, y = out2, by = "observationUnitDbId")
    out3$observations <- NULL
    out <- out3
    trt <- as.data.frame(x = cbind(treatments.factor = rep("",
                                                           nrow(out)),
                                   treatments.modality = rep("", nrow(out))),
                         stringsAsFactors = FALSE)
    for (i in 1:nrow(out)) {
      if (length(out$treatments[[i]]) == 2) {
        trt[i, ] <- out$treatments[[i]]
      }
    }
    trt[, 1] <- as.factor(trt[, 1])
    trt[, 2] <- as.factor(trt[, 2])
    out$treatments <- NULL
    out <- cbind(out, trt)
    out <- out[, c(1:19, 27, 28, 20:26)]
    if (rclass == "data.frame") {
      out <- tibble::as_data_frame(x = out)
    } else {
      out <- tibble::as_tibble(x = out)
    }
  }
  return(out)
}
