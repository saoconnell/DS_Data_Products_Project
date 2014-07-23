
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny) # load shiny at beginning at both scripts

shinyUI(pageWithSidebar( # standard shiny layout, controls on the
    # left, output on the right
    
    headerPanel("Minimal example"), # give the interface a title
    sidebarPanel( # all the UI controls go in here
        
        sliderInput("inSlide", "Number of Samples", 100, 1000, 500, step=20),
        
        textInput(inputId = "comment",  # this is the name of the
                  # variable- this will be
                  # passed to server.R
                  
                  label = "Say something?", # display label for the
                  # variable
                  
                  value = "" # initial value
        )
    ),
    
    mainPanel( # all of the output elements go in here
        h3("This is you saying it"), # title with HTML helper
        textOutput("textDisplay"),  
        plotOutput("plotRnorm")
    )
))