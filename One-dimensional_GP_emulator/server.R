#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library("shiny")
library("ggplot2")

f <- function(x) sin(2*x)

values <- reactiveValues()

xx <- seq(0, 1, by=0.01)


shinyServer(function(input, output) {
   
  # Computer model evaluation
  observeEvent(input$addx, {
    print(input$addx)
    if (input$addx == 1) {
      values$df <- data.frame(x =   c(0,1),
                              y = f(c(0,1)))
    } else {
      values$df <- rbind(values$df, c(input$newx, f(input$newx)))
    }
    print(values$df)
  })
  
  output$distPlot <- renderPlot({
    
    ggplot(values$df, aes(x,y)) + 
      geom_line() + 
      theme_bw()
    
  })
  
  output$dt <- renderDataTable({
    values$df
  })
  
})
