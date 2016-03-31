
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

observeEvent(input$butDoPhAnalysis, ({
    DF <- fbInput()
    #y <- input$def_variables
    yn = names(DF)[c(7:ncol(DF))]
    report =  "report_anova.Rmd"
    report_dir = system.file("rmd", package = "brapi")
    wd = getwd()
    #result_dir  = file.path(wd, "www", "reports")
    #result_dir  =  system.file("app/www/reports", package = "hidap")
    result_dir = tempdir()
    usr = Sys.getenv("USERNAME")
    if (usr=="") usr = Sys.getenv("USER")
    author =  paste0(usr, " using HIDAP")

    rps = "REP" # input$def_rep
    gtp = "germplasmName" #input$def_genotype
    xmt = attr(DF, "meta")
    xmt = list(xmt, title = xmt$studyName)

    withProgress(message = "Creating report ...",
                 detail = "This may take a while ...", value = 0,{
                   try({
                     devtools::in_dir(report_dir, {
                       #print("X")
                       rmarkdown::render(report,
                                         output_format = c("pdf_document", "word_document",
                                                           "html_document" )
                                         ,
                                         output_dir = file.path(wd, "www"),
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

                   try({
                     report_html = stringr::str_replace(report, ".Rmd", ".html")
                   })
                   output$fb_report <- renderUI("")
                   report = file.path(wd, "www", report_html)
                   print(report)
                   html <- readLines(report)
                   incProgress(3/3)
                 })
    output$fb_report <- renderUI(HTML(html))


})

)





}

