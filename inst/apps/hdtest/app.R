
library(shiny)
library(brapi)
library(shinydashboard)
library(d3heatmap)
library(rhandsontable)
library(shinyURL)
library(qtlcharts)
library(leaflet)
library(dplyr)
library(withr)

brapi_host = "sgn:eggplant@sweetpotatobase-test.sgn.cornell.edu"



ui <- dashboardPage(skin = "yellow",

                    dashboardHeader(title = "HIDAP"),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Phenotype", icon = icon("leaf"),
                                 menuSubItem("Analysis",
                                             tabName = "phe_dashboard", icon = icon("calculator"))
                                 ,
                                 numericInput("fbaInput", "Fieldbook ID", 142, 1, 9999)


                        ),

                        menuItem("Environment", tabName = "env_dashboard", icon = icon("globe")


                        )
                      )
                    ),
                    dashboardBody(

                      tabItems(
                        tabItem(tabName = "env_dashboard",
                                fluidRow(
                                  column(width = 8,
                                         tabBox(width = NULL, id = "tabLocation",
                                                tabPanel("Map",
                                                         leafletOutput("mapLocs")
                                                ),
                                                tabPanel("Report",
                                                         htmlOutput("rep_loc")
                                                         #HTML("<h1>Under development!</h1>")
                                                )
                                         )
                                  )
                                  ,
                                  column(width = 4,
                                         tabBox(width = NULL, title = "Site",
                                                tabPanel("Histogram",
                                                         plotOutput("histogram")
                                                ),
                                                tabPanel("Info",
                                                         htmlOutput("siteInfo")
                                                ), tabPanel("Fieldtrials",
                                                            htmlOutput("site_fieldtrials")
                                                ),
                                                tabPanel("Genotypes",
                                                         htmlOutput("site_genotypes")
                                                )

                                         )
                                  )
                                ),


                                fluidRow(
                                  column(width = 8,
                                         box(width = NULL,
                                             title = "Location table",
                                             #p(class = 'text-center', downloadButton('locsDL', 'Download Filtered Data')),
                                             DT::dataTableOutput("tableLocs")
                                             #locationsUI("location")
                                         )
                                  )
                                )
                        ),
                        tabItem(tabName = "phe_dashboard",
                                fluidRow(
                                  column(width = 12,
                                         box(width = NULL,
                                             title = "Fieldbook",
                                             #p(class = 'text-center', downloadButton('locsDL', 'Download Filtered Data')),
                                             rHandsontableOutput("hotFieldbook", height = 400)
                                             #locationsUI("location")
                                         )
                                  )

                                )
                                ,
                                fluidRow(
                                  column(width = 12,
                                         tabBox(width = NULL, selected = "Map", id = "tabAnalysis",
                                                tabPanel("Correlation",
                                                         div(id = "plot-container",

                                                             qtlcharts::iplotCorr_output('vcor_output', height = 400)
                                                         )
                                                ),
                                                tabPanel("Map",
                                                         d3heatmap::d3heatmapOutput("fieldbook_heatmap")
                                                ),
                                                tabPanel(title = "Report",
                                                         #htmlOutput("fb_report")
                                                         #htmlOutput("fbRep"),
                                                         HTML("<h1>Under development!</h1>"),


                                                         HTML("<div style='display:none'>"),
                                                         shinyURL.ui(label = "",width=0, copyURL = F, tinyURL = F),
                                                         #shinyURL.ui("URL", tinyURL = F)
                                                         HTML("</div>")

                                                )



                                         )
                                  )

                                )
                        )

                      )        )
)



fieldbook_analysis <- function(input, output, session){

  dataInput <- reactive({
    fbId = input$fbaInput
    # DF = brapi::study_table(fbId)
    # list(fbId, DF)
    fbId
  })

  fbInput <- reactive({
    fbId = dataInput()
    brapi::study_table(fbId)
  })


  output$hotFieldbook <- renderRHandsontable({
    try({
      DF <- fbInput()
      if(!is.null(DF)){

        rh = rhandsontable::rhandsontable(DF,
                                          selectCallback = TRUE,
                                          readOnly = FALSE,useTypes = TRUE) %>%
          hot_table(highlightCol = TRUE, highlightRow = TRUE) %>%
          hot_cols( fixedColumnsLeft = 6)
        rh
      }
    })
  })

  output$vcor_output = qtlcharts::iplotCorr_render({

    DF <- fbInput()
    shiny::withProgress(message = 'Imputing missing values', {
      options(warn = -1)


      treat <- "germplasmName" #input$def_genotype
      trait <- names(DF)[c(7:ncol(DF))]  #input$def_variables
      DF = DF[, c(treat, trait)]

      DF[, treat] <- as.factor(DF[, treat])

      # exclude the response variable and empty variable for RF imputation
      datas <- names(DF)[!names(DF) %in% c(treat, "PED1")] # TODO replace "PED1" by a search
      x <- DF[, datas]

      for(i in 1:ncol(x)){
        x[, i] <- as.numeric(x[, i])
      }
      y <- DF[, treat]
      if (any(is.na(x))){
        capture.output(
          DF <- randomForest::rfImpute(x = x, y = y )
        )
        #data <- cbind(y, data)

      }
      names(DF)[1] <- treat

      DF = agricolae::tapply.stat(DF, DF[, treat])
      DF = DF[, -c(2)]
      names(DF)[1] = "Genotype"
      row.names(DF) = DF$Genotype
      DF = DF[, -c(1)]

      # iplotCorr(DF,  reorder=TRUE,
      #           chartOpts=list(cortitle="Correlation matrix",
      #                          scattitle="Scatterplot"))

      options(warn = 0)

    })
    iplotCorr(DF)
  })


  # TODO BUG?: somehow this section needs to go last!
  output$fieldbook_heatmap <- d3heatmap::renderD3heatmap({
    DF = fbInput()
    #if (!is.null(DF)) {
    ci = input$hotFieldbook_select$select$c
    #print(ci)
    trt = names(DF)[ncol(DF)]
    if (!is.null(ci)) trt = names(DF)[ci]
    #print(trt)
    fm <- fbmaterials::fb_to_map(DF, gt = "germplasmName", #input[["def_genotype"]],
                                 variable = trt,
                                 rep = "REP", #input[["def_rep"]],
                                 # blk = input[["def_block"]],
                                 plt = "PLOT"  #input[["def_plot"]]
    )
    amap = fm[["map"]]
    anot = fm[["notes"]]
    d3heatmap(x = amap,
              cellnote = anot,
              colors = "Blues",
              Rowv = FALSE, Colv = FALSE,
              dendrogram = "none")
  })


  #####################

  #observeEvent(input$butDoPhAnalysis, ({
  output$fbRep <- renderUI({
    DF <- fbInput()
    #y <- input$def_variables
    yn = names(DF)[c(7:ncol(DF))]
    report =  "report_anova.Rmd"

    report_dir = system.file("rmd", package = "brapi")
    report_src = file.path(report_dir, report)

    #report_dir <- file.path(getwd(),"inst", "rmd") # for quicker testing
    #wd = getwd()
    #result_dir  = file.path(wd, "www", "reports")
    #result_dir  =  system.file("app/www/reports", package = "hidap")


    result_dir = tempdir()
    result_html = "report_anova.html"
    report_html = file.path(result_dir, "report_anova.html")

    usr = Sys.getenv("USERNAME")
    if (usr=="") usr = Sys.getenv("USER")
    author =  paste0(usr, " using HIDAP")

    rps = "REP" # input$def_rep
    gtp = "germplasmName" #input$def_genotype
    xmt = list(title = attr(DF, "meta")$studyName, contact = "x y", site = attr(DF, "meta")$locationName, country = "Z", year = 2016 )

    #xfp = file.path(wd, "www")
    #cat(xfp)
    #print(xfp)
    message(result_dir)
    message(report)
    message(result_html)


    writeLines(paste(result_dir, result_html, report, collapse="\n"), con=file.path(result_dir, 'log.txt'))

    withProgress(message = "Creating report ...",
                 detail = "This may take a while ...", value = 0,{
                   try({
                     devtools::in_dir(report_dir, {
                       #print("X")
                       fn = rmarkdown::render(report_src,
                                         output_format = c(#"pdf_document", "word_document",
                                                           "html_document" )
                                         ,
                                         output_dir = result_dir,
                                         run_pandoc = TRUE,
                                         params = list(
                                           meta = xmt,
                                           trait = yn,
                                           treat = gtp,
                                           rep  = rps,
                                           data = DF,
                                           maxp = 0.1,
                                           author = author))
                       #print("Y")
                     }) # in_dir
                     incProgress(1/3)

                   }) # try

                   #try({
                   #report_html = stringr::str_replace(report, ".Rmd", ".html")
                   #})
                   output$fb_report <- renderUI("")
                   #report = file.path(result_dir, report_html)


                   incProgress(3/3)
                 })
    #output$fb_report <- renderUI(HTML(html))
    message("Finished running report")
    message(report_html)
    html = "Report created but cannot be read."
    try({
      html <- readLines(report_html)
      message("Seems ok till here")
      message(html[10])
    })
    HTML(html)

  })

}




################
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
      report = paste0(getwd(), "/reports/","report_location.Rmd")
      #report = file.path("inst", "rmd", "report_location.Rmd")
      #report = file.path(getwd(), "reports", "report_location.Rmd")
      report_dir <- paste0( "www/", "reports")

      setProgress(5)
      html_file = file.path(report_dir, "report_location.html")
      if(file.exists(html_file)){
        unlink(html_file)
      }
      fn = report_dir
      tryCatch({
        withr::with_dir(report_dir, {
        fn <- rmarkdown::render(report,
                                #output_dir = report_dir,
                                run_pandoc = TRUE,
                                params = list(
                                  locs = locs))
        setProgress(8)

        html <- readLines(fn)
        })

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



############################################################

sv <- function(input, output, session) ({

  set_brapi("http://sgn:eggplant@sweetpotatobase-test.sgn.cornell.edu", 80)
  brapi_auth("rsimon16", "sweetpotato")



  shinyURL.server()
  fieldbook_analysis(input, output, session)
  locations(input, output, session)
})

shinyApp(ui, sv)









