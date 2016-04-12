
#' locations
#'
#' @param input shiny
#' @param output shiyn
#' @param session shiny
#' @import shiny
#' @author Reinhard Simon
# @return data.frame
#' @export
locations <- function(input, output, session){
  dat <- reactive({
    dat <- brapi::locations_list()
    dat[!is.na(dat$latitude), ]
  })

  #vls <- reactiveValues()

  #vls$dat_sel <- dat()

  dat_sel <- reactive({
    sel = input$tableLocs_rows_all
    if(is.null(sel)){
      pts = dat()
    } else {
      pts = dat()[sel, ]
    }
    pts
  })

  output$tableLocs <- DT::renderDataTable( dat()
                                           , server = FALSE,
                                           options = list(scrollX = TRUE))

  output$mapLocs <- renderLeaflet({
    pts <- dat_sel()

    leaflet(pts, height = "100%") %>% addTiles() %>%
      addMarkers(clusterOptions = markerClusterOptions(clickable = T)) %>% fitBounds(
        ~min(longitude), ~min(latitude),
        ~max(longitude), ~max(latitude)
      )


  })



  # download the filtered data
  output$locsDL = downloadHandler('BRAPI-locs-filtered.csv', content = function(file) {
    write.csv(dat_sel(), file)
  })


  output$histogram <- renderPlot({
    hist(dat()$altitude, main = "Frequency of altitude of breeding locations.",
         xlab = "altitude [m]", sub = "Selected location frequencies are in red.")
    hist(dat_sel()$altitude, add = T, col = "red")
    if(length(mrks()) > 0){
      # print("abline")
      # print(mrks()$altitude)
      abline(v = mrks()$altitude, col="blue", lwd = 5)
    }
  })

  ##################################

  mrks <- reactive({
    x = input$mapLocs_marker_click
    subset(dat_sel(), latitude == as.numeric(x$lat) & longitude == as.numeric(x$lng))
  })

  rec2info <- function(rec){
    #rec %>% as.data.frame
    nms = names(rec)
    dat = t(rec)
    dat = cbind(nms, dat)
    #rint(str(dat))
    # print(nrow(dat))
    row.names(dat) = 1:nrow(dat)
    colnames(dat) = c("Attribute", "Value")
    dat = dat[c(1, 5, 9, 4, 3, 2, 6, 7, 8, 10, 12, 13, 14, 11), ]
    x = htmlTable::htmlTable(dat)
    paste0("<center>", x, "</center>") %>% HTML
  }

  observe({
    rec = mrks()
    if (nrow(rec)==1) {
      output$siteInfo <- renderUI({
        #str(rec) %>% paste %>% print
        rec2info(rec)
      })
    } else {
      output$siteInfo = renderPrint({
        ""
      })
    }

  })

  observeEvent(input$mapLocs_bounds, {
    #print("change view area!")
    mb = input$mapLocs_bounds
    #print(mb)


  })

  ############### report #########

  output$rep_loc <- renderUI({

    withProgress(message = 'Updating report', value = 0, max = 10, {

      locs <- dat_sel()
      n = nrow(locs)
      if(n<1) return("no locations in view!")
      report = paste0("reports/report_location.Rmd")
      message(report)
      #report = file.path("inst", "rmd", "report_location.Rmd")
      #report = file.path(getwd(), "reports", "report_location.Rmd")
      #report_dir <- paste0( "reports")

      setProgress(5)
      #html_file = file.path(report_dir, "report_location.html")
      # if(file.exists(html_file)){
      #   unlink(html_file)
      # }
      #fn = report_dir
      fn=""
      tryCatch({
        #withr::with_dir(report_dir, {
        fn <- rmarkdown::render(report,
                                output_dir = "reports",
                                run_pandoc = TRUE,
                                params = list(
                                  locs = locs))
        setProgress(8)

        html <- readLines(fn)
        #})

      }, finally = message(paste("Finished running report!", fn)))


    }) # progress
    message = paste("Report should be in:", fn)

    HTML(html)
  })


  output$site_fieldtrials <- renderUI({
    withProgress(message = 'Getting trial list ...', value = 0, max = 10, {
      stds = brapi::studies()
      #print(studies)
      locs = mrks()
      #print(locs)
      out = "No trials found for this location!"

      # 1st try to find via id if not use unique name
      sid = stds[stds$locationDbId == locs$locationDbId, "studyDbID"]
      if (length(sid) == 0) {
        sid = stds[stringr::str_detect(toupper(stds$name), locs$Uniquename), "studyDbId"]

      }

      setProgress(5)

      if(length(sid) != 0){
        host = stringr::str_split(Sys.getenv("BRAPI_DB") , "/")[[1]][1]
        host = brapi_host
        path = "/breeders/trial/"

        out = paste0("<br><a href='http://",host, path, sid, "' target='_blank'>", stds[stds$studyDbId==sid, "name"], "</a>") %>%
          paste(collapse = ", ")
      }

      setProgress(8)

      HTML(out)
    })
  })

  output$site_genotypes <- renderUI({
    withProgress(message = 'Getting trial list ...', value = 0, max = 10, {
      stds = brapi::studies()
      #print(studies)
      locs = mrks()
      #print(locs)
      out = "No trials found for this location!"
      setProgress(4)

      # 1st try to find via id if not use unique name
      sid = stds[stds$locationDbId == locs$locationDbId, "studyDbID"]
      if (length(sid) == 0) {
        sid = stds[stringr::str_detect(toupper(stds$name), locs$Uniquename), "studyDbId"]

      }
      if(length(sid) != 0){

        #TODO implement BRAPI call to study table!
        study = study_table(sid[1])
        topgp = get_top_germplasm(study)

        gid = topgp$germplasmDbId
        gnm = topgp$germplasmName
        hid = topgp$`Harvest index computing percent`

        host = stringr::str_split(Sys.getenv("BRAPI_DB") , "/")[[1]][1]
        host = brapi_host
        path = "/stock/"

        #TODO change for genotypes
        out = paste0("<a href='http://",host, path, gid,"/view' target='_blank'>", gnm, " (",hid,  ")</a>")
        txt = paste0("Top genotypes for trait (", "Harvest index" ,"):</br>") # TODO make trait choosable
        out = paste( out, collapse = ", ")
        out = paste(txt, out)
      }
      setProgress(8)
      HTML(out)
    })
  })

}

