library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Plant Epidimeology Game"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      textInput("start.1", label = h5("Start position 1 c(<row>,<col>)"), 
                value = "c(12,12)"),
      textInput("start.2", label = h5("Start position 2 c(<row>,<col>)"), 
              value = "c(12,13)"),
      textInput("start.3", label = h5("Start position 3 c(<row>,<col>)"), 
            value = "c(13,12)"),
      textInput("start.4", label = h5("Start position 4 c(<row>,<col>)"), 
            value = "c(13,13)")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("outbreakPlot")
    )
  )
))