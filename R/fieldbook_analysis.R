
#' fieldbook_analysis
#'
#' @param input shiny
#' @param output shiyn
#' @param session shiny
#' @author Reinhard Simon
# @return data.frame
#' @export

fieldbook_analysis <- function(input, output, session){

  #library(ggvis)

  output$sessionInfo = renderPrint("Highly Interactive Data Analysis Platform for Root and Tuber Crop breeding.")

  dataInput <- reactive({
    fbId = input$fbaInput
    # DF = brapi::study_table(fbId)
    # list(fbId, DF)
    fbId
  })

  fbInput <- reactive({
    #fbId = dataInput()
    brapi::study_table(dataInput())
  })


  output$hotFieldbook <- DT::renderDataTable({
    DF <- NULL
    shiny::withProgress(message = 'Importing fieldbook', {
      DF <- fbInput()
    })
    DF
  } , server = FALSE
  # , filter = 'bottom'
  , selection = list(mode = 'single', target='column')
  , options = list(scrollX = TRUE)

  )


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
    ci = input$hotFieldbook_columns_selected
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

  do_report <- function(fmt = "html_document"){
    DF <- fbInput()
    yn = names(DF)[c(7:ncol(DF))]
    report = paste0("reports/report_anova.Rmd")

    usr = Sys.getenv("USERNAME")
    if (usr=="") usr = Sys.getenv("USER")
    author =  paste0(usr, " using HIDAP")

    rps = "REP" # input$def_rep
    gtp = "germplasmName" #input$def_genotype
    xmt = list(title = attr(DF, "meta")$studyName, contact = "x y", site = attr(DF, "meta")$locationName, country = "Z", year = 2016 )
    fn = NULL
    withProgress(message = "Creating reports ...",
                 detail = "This may take a while ...", value = 1, max = 4, {
                   try({
                     incProgress(1, message = fmt)
                     fn = rmarkdown::render(report,
                                            output_format = fmt,
                                            run_pandoc = TRUE,
                                            output_dir = "www/reports",
                                            params = list(
                                              meta = xmt,
                                              trait = yn,
                                              treat = gtp,
                                              rep  = rps,
                                              data = DF,
                                              maxp = 0.1,
                                              author = author))
                     incProgress(1, message = "Loading")

                   }) # try

                 })
    fn
  }


  output$fbRepHtml <- renderUI({
    out = "Report created but cannot be read."

    try({
      fn = do_report()
      out <- readLines(fn)
    })
    HTML(out)

  })

  output$fbRepPdf <- renderUI({
    out = "Report created but cannot be read."
    fn = do_report("pdf_document")
    try({
      out <- paste0("<a href='reports/report_anova.pdf' target='_new'>PDF</a>")
    })
    HTML(out)

  })

  output$fbRepWord <- renderUI({
    out = "Report created but cannot be read."
    fn = do_report("word_document")
    try({
      out <- paste0("<a href='reports/report_anova.docx' target='_new'>Word</a>")
    })
    HTML(out)

  })

  output$fieldbook_histogram <- renderPlot({
    DF = fbInput()
    ci = input$hotFieldbook_columns_selected

    s1 = input$hotFieldbook_rows_all  # rows on all pages (after being filtered)
    s2 = input$hotFieldbook_rows_current


    # message(paste(class(ci)))
    # message(paste(str(ci)))
    # message(paste("CI:", ci))
    #
    if(is.null(ci)) ci = ncol(DF)
    dt = DF[, ci]

    cnm = colnames(DF)[ci]
    mnt = paste( cnm)
    if(is.factor(DF[, ci])) {
      dt <- dt %>% as.character() %>% as.integer()
    }
    message(paste(s2))

    if(is.numeric(dt)){
      hist(dt, main = mnt, xlab = "In red: values from selection by search; in blue: visible records", ylab = "Count" )
      # solid dots (pch = 19) for current page
      if (length(s1)) {
        #message(paste(dt[s1], collapse = ", "))
        hist(dt[s1], col = "red", add = T)
      }
      if (length(s2) > 0 && length(s2) < length(dt)) {
        abline(v = dt[s2], col = 'blue')
      }
    }

  })

  output$fieldbook_scatter <- renderPlot({
    DF = fbInput()
    ci = input$hotFieldbook_columns_selected
    if(is.null(ci)) ci = ncol(DF)

    s1 = input$hotFieldbook_rows_current  # rows on the current page
    s2 = input$hotFieldbook_rows_all      # rows on all pages (after being filtered)

    cx = which(stringr::str_detect(names(DF), "Harvest index"))
    DT = DF

    if(is.factor(DF[, ci])) {
      DF[, ci] <- DF[, ci] %>% as.character() %>% as.integer()
    }
    DF = DF[, c(cx, ci)]

    par(mar = c(4, 4, 1, .1))

    plot(DF, pch = 21)
    #gv = DF %>% ggvis %>% layer_points()

    #solid dots (pch = 19) for current page
    if (length(s1)) {
      points(DF[s1, , drop = FALSE], pch = 19, cex = 2)
      #gv <- layer_points(gv, fill = "black", size = 19)
    }

    # show red circles when performing searching
    if (length(s2) > 0 && length(s2) < nrow(DT)) {
      points(DF[s2, , drop = FALSE], pch = 21, cex = 3, col = 'red')
      #gv <- layer_points(gv, color = "red", size = 21)
    }

    # dynamically change the legend text
    s = input$hotFieldbook_search
    txt = if (is.null(s) || s == '') 'Filtered data' else {
      sprintf('Data matching "%s"', s)
    }

    legend(
      'topright', c('Original data', 'Data on current page', txt),
      pch = c(21, 19, 21), pt.cex = c(1, 2, 3), col = c(1, 1, 2),
      y.intersp = 2, bty = 'n'
    )

  })

  output$scatterplotHover_info2 <- renderUI({
    DF = fbInput()
    ci = input$hotFieldbook_columns_selected
    if(is.null(ci)) ci = ncol(DF)

    s1 = input$hotFieldbook_rows_current  # rows on the current page
    s2 = input$hotFieldbook_rows_all      # rows on all pages (after being filtered)

    cx = which(stringr::str_detect(names(DF), "Harvest index"))
    DT = DF

    if(is.factor(DF[, ci])) {
      DF[, ci] <- DF[, ci] %>% as.character() %>% as.integer()
    }
    DF = DF[, c(cx, ci)]

    hover = input$plot_hover
    point <- nearPoints(DF, hover, threshold = 5)

    if (nrow(point) == 0) return(NULL)

    # calculate point position INSIDE the image as percent of total dimensions
    # from left (horizontal) and from top (vertical)
    left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
    top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)

    # calculate distance from left and bottom side of the picture in pixels
    left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
    top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)

    # create style property fot tooltip
    # background color is set so tooltip is a bit transparent
    # z-index is set so we are sure are tooltip will be on top
    style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                    "left:", left_px + 2, "px; top:", top_px + 2, "px;")

    # actual tooltip created as wellPanel
    wellPanel(
      style = style#,
      # p(HTML(paste0("<b> Car: </b>", rownames(point), "<br/>",
      #               "<b> mpg: </b>", point$mpg, "<br/>",
      #               "<b> hp: </b>", point$hp, "<br/>",
      #               "<b> Distance from left: </b>", left_px, "<b>, from top: </b>", top_px)))
    )

  })



}

