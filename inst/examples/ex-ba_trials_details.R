if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_trials_details(con, trialDbId = "101")
}
