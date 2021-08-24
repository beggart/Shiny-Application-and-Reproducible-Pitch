library(shiny)
library(ggplot2)
library(dplyr)
library(rsconnect)
# import data

beer_data <- data.table::fread(input = "https://www.opengov-muenchen.de/dataset/8d6c8251-7956-4f92-8c96-f79106aab828/resource/e0f664cf-6dd9-4743-bd2b-81a8b18bd1d2/download/oktoberfestgesamt19852019.csv"
                               , na.strings="?"
)

# Define server logic required to draw a plot
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    # build linear regression model
    fit <- lm( as.formula(paste(input$type, "~ jahr")), beer_data)
    # predictions upon input
    new.df <- data.frame(jahr=input$year)
    pred <- predict(fit, new.df)
    
    # Draw the plot using ggplot2
    plot <- ggplot(data=beer_data, aes(jahr, !!as.symbol(input$type)))+
      geom_point()+
      geom_line()+
      geom_smooth(method = "lm")+
      geom_vline(xintercept = input$year, color = "green")+
      geom_hline(yintercept = pred, color = "green")
    plot
  })
  output$result <- renderText({
    # build linear regression model
    fit <- lm( as.formula(paste(input$type, "~ jahr")), beer_data)
    #predictions
    new.df <- data.frame(jahr=input$year)
    pred <- predict(fit, new.df)
    res <- paste(round(pred, digits = 1.5),"" )
    res
  })
  
})