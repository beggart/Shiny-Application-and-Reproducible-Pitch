library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Price predictor for Beer at the Oktoberfest"),
  
  # Sidebar with options selectors
  sidebarLayout(
    sidebarPanel(
      helpText("This application is a predictor for the price of beer based on historical beer prices."),
      h3(helpText("Select:")),
      numericInput("year", label = h4("Year to predict"), step = 2009, value = 2100),
      selectInput("type", label = h4("Type"),
                  choices = list("Beer" = "Beer", "Chicken" = "Chicken")),
      selectInput("conprice", label = h4("Consumption/Price"),
                  choices = list("Consumption" = "Consumption", "Price"="Price")),
      selectInput("duration", label = h4("Duration"),
                  choices = list("Unknown" = "*", "16" = "16", "17" = "17", "18"="18"))
    ),
    
    # Show a plot with diamonds and regression line
    mainPanel(
      plotOutput("distPlot"),
      h4("Predicted value of this diamond is:"),
      h3(textOutput("result"))
    )
  )
))