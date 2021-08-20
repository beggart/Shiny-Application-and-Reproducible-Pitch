library(shiny)
library(ggplot2)
library(dplyr)
library(rsconnect)
# Select columns to be used in the analysis

beer_data <- data.table::fread(input = "https://www.opengov-muenchen.de/dataset/8d6c8251-7956-4f92-8c96-f79106aab828/resource/e0f664cf-6dd9-4743-bd2b-81a8b18bd1d2/download/oktoberfestgesamt19852019.csv"
                               , na.strings="?"
)

# Define server logic required to draw a plot
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    # Select diamonds depending of user input
    #beer <- filter(beer_data, grepl(input$conprice, ), grepl(input$col, color), grepl(input$clar, clarity))
    beer <- beer_data
    # build linear regression model
    fit <- lm( jahr~bier_konsum, beer)
    # predicts the price
    pred <- predict(fit, beer$jahr)
    
    # Draw the plot using ggplot2
    plot <- ggplot(data=diam, aes(x=carat, y = price))+
      geom_point(aes(color = cut), alpha = 0.3)+
      geom_smooth(method = "lm")+
      geom_vline(xintercept = input$car, color = "red")+
      geom_hline(yintercept = pred, color = "green")
    plot
  })
  output$result <- renderText({
    # Renders the text for the prediction below the graph
    diam <- filter(diamonds, grepl(input$cut, cut), grepl(input$col, color), grepl(input$clar, clarity))
    fit <- lm( price~carat, diam)
    pred <- predict(fit, newdata = data.frame(carat = input$car,
                                              cut = input$cut,
                                              color = input$col,
                                              clarity = input$clar))
    res <- paste(round(pred, digits = 1.5),"$" )
    res
  })
  
})