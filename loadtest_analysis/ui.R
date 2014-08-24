
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
        
        h3("Filter Transaction Data:"),
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
        
        h3("loadtest Description:"),
        helpText("The loadtest shiny App analyzes transaction data generated during",
                 "an application loadtest to determine transaction response time.",
                 "The app allows the user to filter the data by transaction and set the",
                 "high and low trim to determine how many outliers will be removed from", 
                 "statistical analysis on the Summary Tab, the Transaction Tab has diagnostic",
                 "plots to aid in the analysis of the test by reviewing response time distributions",
                 "and showing the transaction over time and count by sampling period",
                 " See https://github.com/saoconnell/DS_Data_Products_Project for more details")
        
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