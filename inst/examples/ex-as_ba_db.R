if (interactive()) {

  con <- as.ba_db(
    crop = "potato",
    user = "myself"
    )

  print(con)
}
