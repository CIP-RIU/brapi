
#' fieldbook_analysis
#'
#' @param input shiny
#' @param output shiyn
#' @param session shiny
#' @import shiny
#' @import rhandsontable
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


output$hotFieldbook <- renderRHandsontable({
  try({
    fbId = dataInput()
    DF = brapi::study_table(fbId)
    # print(str(DF))
    # print(head(DF[, 1:10]))
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

output$fieldbook_map <- d3heatmap::renderD3heatmap({
  #print("ok")
  fbId = dataInput()
  DF = brapi::study_table(fbId)

  if (!is.null(fbId)) {
    #DF <- fbmaterials::get_fieldbook_data(  input[["fbaInput"]])
    #print(head(DF))
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
    #print(head(fm))
    amap = fm[["map"]]
    anot = fm[["notes"]]
    #print(head(amap))
    # print(head(anot))
    d3heatmap::d3heatmap(x = amap,
                         cellnote = anot,
                         colors = "Blues",
                         Rowv = FALSE, Colv = FALSE,
                         dendrogram = "none")
  }

})






}

