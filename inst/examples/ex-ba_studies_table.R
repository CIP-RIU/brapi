if (interactive()) {
  library(brapi)

  con <- ba_db()$sweetpotatobase

  ba_studies_table(con, studyDbId = "1207")
}
