library(shiny)
load('./data/pugesound.RData')
shinyServer(function(input, output) {
  df <- reactive({
    subset(pugetsound, latitude>input$rangeN[1] & latitude<input$rangeN[2] & longitude>input$rangeW[1] & longitude<input$rangeW[2])    
  })
  output$plot <- renderPlot({
    if (!input$get) return(NULL)
    df <- df()
    args <- switch(input$var,
                   "depth" = df[,4],
                   "TOC" = df[,5],
                   "TF" = df[,6])
    pcbs <- df[,7]
    plot(y=pcbs,x=args, pch = 20, col = rgb(0, 0, 0, 0.5),ylab = 'Total PCBs concertration (pg/g)', xlab = input$var, main = 'relationship explore')
    for (i in 1:input$integer){
      idx = sample(nrow(df), replace=TRUE)
      lines(lowess(y = pcbs[idx], x = args[idx]), col = rgb(0,0, 0, 0.05), lwd = 1.5) 
      }  
    })
  })