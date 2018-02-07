if (interactive()) {
  library(brapi)
  library(magrittr)

  ba_can_internet()

  con <- ba_db()$sweetpotatobase

  lcs <- ba_locations(con)
  lcs %>% ba_describe
}
