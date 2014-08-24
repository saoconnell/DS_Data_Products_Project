
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)

# Define UI for random distribution application 
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Transaction Analysis"),
    
    # Sidebar with controls to select the random distribution type
    # and number of observations to generate. Note the use of the br()
    # element to introduce extra vertical spacing
    sidebarPanel(
                
        selectInput("selected.Trans", "Transactions:",
                    c("All" = "All"
                      )),
        
        
        br(),
        h3("Trim Outliers:"),
        sliderInput("low", 
                    "Trim low:", 
                    value = .05,
                    min = .01, 
                    max = .48,
                    step=.01),
        
        sliderInput("high", 
                    "Trim high:", 
                    value = .95,
                    min = .52, 
                    max = .99,
                    step=.01),
        
        helpText("Note: The data was loaded from a funciton within the code.",
                 "The data was from an actual test, however, it has been",
                 "ananymozed due to requirements from the business...")
        
        #submitButton("Update View")
        
    ),
    
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
        tabsetPanel(
            tabPanel("Raw Data", textOutput("debug"), dataTableOutput("raw.data")),
            
            tabPanel("Summary", dataTableOutput("summary")), 
            
            tabPanel("Transaction", #plotOutput("denisty.FULL.plot"),
                     
                     h2("FULL DATA: Density Plot", align = "center"),
                     plotOutput("denisty.FULL.plot"),
                     h2("TRIMMED DATA: Density Plot", align = "center"),
                     plotOutput("denisty.TRIMMED.plot"),
                     h2("Transactions by Time", align = "center"),
                     plotOutput("response.time.plot"),
                     h2("Transactions per Interval", align = "center"),
                     plotOutput("trans.per.interval.plot")
                     )
        )
    )
))