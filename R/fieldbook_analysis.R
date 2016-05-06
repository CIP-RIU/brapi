
#' fieldbook_analysis
#'
#' @param input shiny
#' @param output shiny
#' @param session shiny
# @import rhandsontable
#' @import d3heatmap
#' @import qtlcharts
#' @import agricolae
#' @author Reinhard Simon
# @return data.frame
#' @export
fieldbook_analysis <- function(input, output, session){

  brapi_host = "sgn:eggplant@sweetpotatobase-test.sgn.cornell.edu"

  get_plain_host <- function(){
    host = stringr::str_split(Sys.getenv("BRAPI_DB") , ":80")[[1]][1]
    if(host == "") host = brapi_host
    if(stringr::str_detect(host, "@")){
      if(stringr::str_detect(host, "http://")) {
        host = stringr::str_replace(host, "http://", "")
      }
      host = stringr::str_replace(host, "[^.]{3,8}:[^.]{4,8}@", "")
    }
    host
  }


  dataInput <- shiny::reactive({
    fbId = input$fbaInput
    # DF = brapi::study_table(fbId)
    # list(fbId, DF)
    fbId
  })

  fbInput <- shiny::reactive({
    fbId = dataInput()
    brapi::study_table(fbId)
  })


# output$hotFieldbook <- renderDataTable({
#   try({
#     DF <- fbInput()
#     if(!is.null(DF)){
#
#       rh = rhandsontable::rhandsontable(DF,
#                          selectCallback = TRUE,
#                          readOnly = FALSE,useTypes = TRUE) %>%
#         hot_table(highlightCol = TRUE, highlightRow = TRUE) %>%
#         hot_cols( fixedColumnsLeft = 6)
#       rh
#     }
#   })
# })

  output$hotFieldbook <- DT::renderDataTable({
    #renderRHandsontable({
    x = NULL
    withProgress(message = "Loading fieldbook ...",
                 detail = "This may take a while ...", value = 1, max = 4, {
                   try({
                     x <- fbInput()

                   })

                 })
    x
  },  server = FALSE,  extensions = 'FixedColumns',
  options = list(scrollX = TRUE
                 # ,
                 # fixedColumns = list(leftColumns = 6)
  ),
  selection = list(target = 'column', mode = "single")
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
      utils::capture.output(
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
# output$fieldbook_heatmap <- d3heatmap::renderD3heatmap({
#    DF = fbInput()
#    #if (!is.null(DF)) {
#      ci = input$hotFieldbook_select$select$c
#     #print(ci)
#     trt = names(DF)[ncol(DF)]
#     if (!is.null(ci)) trt = names(DF)[ci]
#     #print(trt)
#     fm <- fbmaterials::fb_to_map(DF, gt = "germplasmName", #input[["def_genotype"]],
#                                  variable = trt,
#                                  rep = "REP", #input[["def_rep"]],
#                                  # blk = input[["def_block"]],
#                                  plt = "PLOT"  #input[["def_plot"]]
#     )
#     amap = fm[["map"]]
#     anot = fm[["notes"]]
#     d3heatmap(x = amap,
#              cellnote = anot,
#              colors = "Blues",
#              Rowv = FALSE, Colv = FALSE,
#              dendrogram = "none")
# })

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
output$fbRep <- shiny::renderUI({
    DF <- fbInput()
    #y <- input$def_variables
    yn = names(DF)[c(7:ncol(DF))]
    report =  "report_anova.Rmd"
    report_dir = system.file("rmd", package = "brapi")
    #report_dir <- file.path(getwd(),"inst", "rmd") # for quicker testing
    wd = getwd()
    #result_dir  = file.path(wd, "www", "reports")
    #result_dir  =  system.file("app/www/reports", package = "hidap")
    result_dir = tempdir()
    usr = Sys.getenv("USERNAME")
    if (usr=="") usr = Sys.getenv("USER")
    author =  paste0(usr, " using HIDAP")

    rps = "REP" # input$def_rep
    gtp = "germplasmName" #input$def_genotype
    # xmt = attr(DF, "meta")
    # xmt = list(xmt, title = xmt$studyName)
    xmt = list(title = attr(DF, "meta")$studyName, contact = "x y", site = attr(DF, "meta")$locationName, country = "Z", year = 2016 )

    writeLines(file.path(wd, "www"), con="log.txt")

    shiny::withProgress(message = "Creating report ...",
                 detail = "This may take a while ...", value = 0,{
                   try({
                     withr::with_dir(report_dir, {
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
                                           author = author,
                                           host = get_plain_host()))
                       #print("Y")
                     }) # in_dir
                     incProgress(1/3)
                   }) # try

                   try({
                     report_html = stringr::str_replace(report, ".Rmd", ".html")
                   })
                   output$fb_report <- renderUI("")
                   report = file.path(wd, "www", report_html)


                   incProgress(3/3)
                 })
    #output$fb_report <- renderUI(HTML(html))
    html <- readLines(report)
    shiny::HTML(html)

})


# output$fbRep <- renderUI({
#   html <- readLines("/Users/reinhardsimon/Documents/packages/brapi/inst/apps/fieldbook_analysis/www/report_anova.html")
#   HTML(html)
# })
#)



}

