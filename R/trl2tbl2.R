trl2tbl2 <- function(res, rclass) {
  lst <- jsonlite::fromJSON(txt = res)
  dat <- jsonlite::toJSON(x = lst$result$data)
  df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)


    jointrlstd <- function(dat) {


      dat2 <- jsonlite::toJSON(x = lst$result$data$studies)
      df2 <- jsonlite::fromJSON(txt = dat2, simplifyDataFrame = TRUE, flatten = TRUE)[[1]]
      df$studies <- NULL

      df3 <-  df[rep(seq_len(nrow(df)), each=nrow(df2)),]
      df <- cbind(df3, df2)
      row.names(df) <- 1:nrow(df)
      return(df)
    }

    out <- jointrlstd(df[1, ])
    n <- nrow(df)

    if(n > 1) {
      for (i in 2:n) {
        df <- rbind(out, df[i, ])
      }
    }

  return(out)
}
