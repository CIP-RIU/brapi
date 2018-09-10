sov2tbl <- function(res, rclass) {
  lst <- jsonlite::fromJSON(txt = res)
  resultJSON <- jsonlite::toJSON(x = lst$result)
  resultList <- jsonlite::fromJSON(txt = resultJSON)
  # check if resultList has data element
  if ("data" %in% names(resultList)) {
    # split off data from resultList
    dataDF <- resultList$data
    dataDFJSON <- jsonlite::toJSON(x = dataDF)
    # reform flattened dataDF
    dataDF <- jsonlite::fromJSON(txt = dataDFJSON,
                                 simplifyDataFrame = TRUE,
                                 flatten = TRUE)
    dataDF <- as.data.frame(lapply(X = dataDF,
                                   FUN = function(x) {
                                     if (class(x) == "list") {
                                       x <- sapply(X = x ,
                                                   FUN = paste0,
                                                   collapse = "; ")
                                     } else {
                                       x <- x
                                     }
                                   }),
                            stringsAsFactors = FALSE)
    # remove data from resultList
    resultList$data <- NULL
    # process remainder of resultList
    temp <- NULL
    if (length(resultList) != 0) {# remainder of resultList exists
      if (nrow(dataDF) == 1) {# one row in dataDF
        temp <- as.data.frame(x = resultList, stringsAsFactors = FALSE)
      } else {# multiple rows in dataDF
        for (i in 1:nrow(dataDF)) {
          temp <- rbind(temp,
                        as.data.frame(x = resultList, stringsAsFactors = FALSE))
        }
      }
      out <- cbind(temp, dataDF)
    } else {# remainder of resultList is empty
      out <- dataDF
    }
  } else {#resultList has no data element
    # Clean resultList of empty elements
    resultList[lengths(resultList) == 0] <- NULL
    for (i in names(resultList)) {
      resultList[[i]][lengths(resultList[[i]]) == 0] <- NULL
      if (length(resultList[[i]]) > 1) {
        if (class(resultList[[i]]) == "character") {
          resultList[[i]] <- paste0(resultList[[i]], collapse = "; ")
        } else if (class(resultList[[i]]) == "list") {
          resultList[[i]] <- lapply(X = resultList[[i]],
                                    FUN = function(x) {
                                      if (length(x) > 1 && class(x) == "character") {
                                        x <- paste0(x, collapse = "; ")
                                        names(x) <- NULL
                                      } else {
                                        x <- x
                                      }
                                    })
        }
        for (j in names(resultList[[i]])) {
          resultList[[i]][[j]][lengths(resultList[[i]][[j]]) == 0] <- NULL
          if (length(resultList[[i]][[j]]) > 1) {
            if (class(resultList[[i]][[j]]) == "character") {
              resultList[[i]][[j]] <- paste0(resultList[[i]][[j]], collapse = "; ")
            } else if (class(resultList[[i]][[j]]) == "list") {
              resultList[[i]][[j]] <- lapply(X = resultList[[i]][[j]],
                                             FUN = function(x) {
                                               if (length(x) > 1 && class(x) == "character") {
                                                 x <- paste0(x, collapse = "; ")
                                               } else {
                                                 x <- x
                                               }
                                             })
            }
          }
        }
      }
    }
    out <- as.data.frame(x = resultList, stringsAsFactors = FALSE)
  }
  # remove columns fully filled with "" from out
  for (i in ncol(out):1) {
    if (class(out[[i]]) == "character" && all(out[[i]] == "")) {
      out[[i]] <- NULL
    }
  }
  if (rclass == "tibble") {
    out <- tibble::as_tibble(out)
  }
  return(out)
}
