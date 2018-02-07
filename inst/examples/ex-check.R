if (interactive()) {
  library(brapi)
  library(magrittr)

  con <- as.ba_db(
    crop = "potato",
    user = "myself"
    )

  print(con)
}
