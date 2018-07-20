complement_missing_fields <- function(DF, field_vector) {
  field_names <- colnames(DF)
  field_names_found <- field_vector %in% field_names
  missing_fields <- field_vector[!field_names_found]
  n_missing <- length(missing_fields)
  if ("additionalInfo" %in% field_names && n_missing != 0) {
    complement <- DF[["additionalInfo"]]
  } else {
    complement <- as.data.frame(x = matrix(data = NA,
                                           nrow = nrow(DF), ncol = n_missing))
    names(complement) <- missing_fields
  }
  DF_complete <- cbind(DF, complement)
  return(DF_complete)
}
