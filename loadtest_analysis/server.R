
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(lattice)
library(latticeExtra)

source("ReadData.R")
source("summarizeData.R")
source("plotData2.R")


# Define server logic for random distribution application
shinyServer(function(input, output, session) {
    
    df <- read.data()
    
    # Reactive expression to generate the requested distribution. This is 
    # called whenever the inputs change. The renderers defined 
    # below then all use the value computed from this expression
    data <- reactive({  
        dist <- switch(input$dist,
                       norm = rnorm,
                       unif = runif,
                       lnorm = rlnorm,
                       exp = rexp,
                       rnorm)
        
        dist(input$n)
    })
    
    observe({
        # We'll use the input$controller variable multiple times, so save it as x
        # for convenience.
        x <- input$selected.Trans
        
        df <- read.data()
        # Create a list of new options, where the name of the items is something
        # like 'option label x 1', and the values are 'option-x-1'.
        #rm(trans.list)
        trans.list <- list()
        
        trans <- as.character(unique(df$trans_name))
        trans <- c("All", trans)
        
        c <- 0
        for (t in trans) {
            c <- c + 1
            
            #trans.list[[sprintf("%s %s %d", t, x, c)]] <- sprintf("%s-%s-%d", t, x, c)
            trans.list[[sprintf("%s", t)]] <- sprintf("%s", t)
        }
        
        # Change values for input$inSelect
        updateSelectInput(session, "selected.Trans", choices = trans.list, selected=x)
    
    })
    
    

    output$density.plot <- renderPlot({
        
        #df <- read.data()
        ss <- subset(df, trans_name == input$selected.Trans)
        if (input$selected.Trans != "All") {
            plot(density(ss$trans_resp_time), main=paste0("Transaction = ", input$selected.Trans))
        } else {
            plot(density(df$trans_resp_time), main=paste0("Transaction = ", input$selected.Trans))
        }
        
    })

    output$transaction.plot <- renderPlot({
        
        #df <- read.data()
        
        plot.data(df, input$selected.Trans)
        
    })
    
    output$debug <- renderText({
        paste0("Selected TRansaction: ", input$selected.Trans, "\n")
        #paste0("LOW: ", input$low, " HIGH: ", input$high, "\n")
    })
    
    # Generate a summary of the data
    output$summary <- renderDataTable({
        df <- read.data()
        summarize.data(df, as.numeric(input$low), as.numeric(input$high))
    })
    
    # Generate an HTML table view of the data
    output$raw.data <- renderDataTable({
        read.data()
    })
})