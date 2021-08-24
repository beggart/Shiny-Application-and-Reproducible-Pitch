library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Oktoberfest Predictor"),
  
  # Sidebar with options selectors
  sidebarLayout(
    sidebarPanel(
      helpText("This application is a predictor for Oktoberfest related data based on historical data from 1985 to 2019."),
      h3(helpText("Select:")),
      numericInput("year", label = h4("Year to predict"), value = 2022),
      selectInput("type", label = h4("Data"),
                  choices = list("Visitors"="besucher_gesamt","Beer Consumption" = "bier_konsum",  "Chicken Consumption" = "hendl_konsum", "Beer Price" = "bier_preis", "Chicken Price" = "hendl_preis"))
    ),
    
    # Show a plot with diamonds and regression line
    mainPanel(
      plotOutput("distPlot"),
      h4("Prediction:"),
      h3(textOutput("result"))
    )
  )
))