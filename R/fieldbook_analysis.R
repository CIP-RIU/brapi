
#' fieldbook_analysis
#'
#' @param input shiny
#' @param output shiyn
#' @param session shiny
#' @import shiny
#' @import rhandsontable
#' @import d3heatmap
#' @import qtlcharts
#' @import agricolae
#' @author Reinhard Simon
# @return data.frame
#' @export

fieldbook_analysis <- function(input, output, session){

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
    #if (!is.null(DF)) {
    #ci = input$hotFieldbook_select$select$c
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



}

