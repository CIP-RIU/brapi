
#' locations
#'
#' @param input shiny
#' @param output shiyn
#' @param session shiny
#' @import shiny
#' @importFrom magrittr '%>%'
#' @author Reinhard Simon
# @return data.frame
#' @export
locations <- function(input, output, session){

  get_plain_host <- function(){
    host = stringr::str_split(Sys.getenv("BRAPI_DB") , ":80")[[1]][1]
    if(stringr::str_detect(host, "@")){
      host = stringr::str_replace(host, "http://[^.]{3,8}:[^.]{4,8}@", "")
    }
    host
  }


  dat <- reactive({
    dat <- brapi::locations_list()
    dat[!is.na(dat$latitude), ]
  })

  #vls <- reactiveValues()

  #vls$dat_sel <- dat()

  dat_sel <- reactive({
    sel = input$table_rows_all
    if(is.null(sel)){
      pts = dat()
    } else {
      pts = dat()[sel, ]
    }
    pts
  })

  output$table <- DT::renderDataTable( dat()
                                      , server = FALSE,
                                       options = list(scrollX = TRUE))

  output$map <- leaflet::renderLeaflet({
    pts <- dat_sel()

    leaflet::leaflet(pts, height = "100%") %>%
      leaflet::addTiles() %>%
      leaflet::addMarkers(clusterOptions = leaflet::markerClusterOptions(clickable = T)) %>%
      leaflet::fitBounds(
        ~min(pts$longitude), ~min(pts$latitude),
        ~max(pts$longitude), ~max(pts$latitude)
      )


  })



  # download the filtered data
  output$locsDL = downloadHandler('BRAPI-locs-filtered.csv', content = function(file) {
    utils::write.csv(dat_sel(), file)
  })


  mrks <- reactive({
    x = input$map_marker_click
    subset(dat_sel(), dat_sel()$latitude == as.numeric(x$lat) &
             dat_sel()$longitude == as.numeric(x$lng))
  })

  output$histogram <- renderPlot({
    graphics::hist(dat()$altitude, main = "Frequency of altitude of breeding locations.",
         xlab = "altitude [m]", sub = "Selected location frequencies are in red.")
    graphics::hist(dat_sel()$altitude, add = T, col = "red")
    if(length(mrks()) > 0){
      # print("abline")
      # print(mrks()$altitude)
      graphics::abline(v = mrks()$altitude, col="blue", lwd = 5)
    }
  })

  ##################################

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

  observeEvent(input$map_bounds, {
    #print("change view area!")
    mb = input$map_bounds
    #print(mb)


  })

  ############### report #########

  output$rep_loc <- renderUI({

    withProgress(message = 'Updating report', value = 0, max = 10, {

    locs <- dat_sel()
    n = nrow(locs)
    if(n<1) return("no locations in view!")
    report = paste0("report_location.Rmd")
    #report = file.path("inst", "rmd", "report_location.Rmd")
    report = file.path(system.file("rmd", package = "brapi"), "report_location.Rmd")
    rep_dir <- "www/reports/"
    if(!file.exists(rep_dir)){
      rep_dir = tempdir()
    }

    setProgress(5)

    fn <- rmarkdown::render(report,
                            #output_format = "all",
                            output_dir = rep_dir,
                            params = list(
                              locs = locs))
    setProgress(8)

    html <- readLines(file.path(rep_dir, "report_location.html"))
    }) # progress

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
      # REDO! Use all locations; group by country (rev. order by year; highlight the marked one!)
      sid = stds[stringr::str_detect(toupper(stds$name), locs$Uniquename), "studyDbId"]

    }

    setProgress(5)

    if(length(sid) != 0){
      host = get_plain_host()
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

      host = get_plain_host()

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
