###---------------------------------------------------------
###   plotData:  
###   Author: Stephen O'Connell
###   Date: 08/18/2014
###   Description:
###     All Plot functions
###        response.time.plot.data
###        trans.per.interval.plot.data
###
###   Change History: (why is always just because...)
###        Who         When            What
###        SAOB        2014-08-22     Initial Development
###---------------------------------------------------------

##-----------------------------------------------------------------------------------------
plot.2 <- function() {
    plot(rnorm(100), rnorm(100))
}

###--------------------------------------------------------------------------
###  PLOT THE PLOT TRANSACTION RESPONSE TIME OVER TIME
###--------------------------------------------------------------------------
response.time.plot.data <- function(in.data, in.tran, in.low=.05, in.high=.95, type="FULL") {
    source("helper_functions.R")
    
    
    ##  SELECT THE TIMEFRAME, 
    start_time <- min(in.data$trans_start_time)
    end_time   <- max(in.data$trans_end_time)
    
    by_break <- 5
    myLabels <- seq(trunc(start_time, units='min'), trunc(end_time+900, units='min'), by='5 min')
    
    red <- "#E41A1C91"
    blue <- "#377EB891"
    
    srt_data <- sort.data.frame(~scenario_elapse_time,in.data)
    
    output = 'png'
    
    ###
    ### CREATE AN ALL TRANSACTION CHART
    ###
    ###  CLEAN UP THE OUTLYING RESPONSE TIMES TO SHOW DETAIL IN THE CHARTS
    srt_data$trans_name <- gsub("&", " ", srt_data$trans_name)
    
    listTranNames <- levels(as.factor(srt_data$trans_name))
    
    if (in.tran == 'All') {
        
        srt_data$trans_name <- "All_Transactions"
        listTranNames <- levels(as.factor(srt_data$trans_name))
        in.tran <- "All_Transactions"
        
    } else {
        
        listTranNames <- c(in.tran)
        
    }
    
    ## SUBSET JUST THE TRANSACTION TO BE PLOTTED
    ss <- subset(srt_data, trans_name == in.tran)
    
    ## ONLY PRODUCE PLOT IF MORE THAN 15 DATA ELEMENTS ARE AVAILABLE
    if (nrow(ss) >= 15) {
        
        remove_indx <- trimOutliers(ss$trans_resp_time, in.low, in.high)
        
        ###  TRANSACTION RESPONSE TIME OVER TIME
        plot(myLabels,rep(0,length(myLabels)), pch='', ylim=c(0,max(ss$trans_resp_time)),
             main=( paste(in.tran, sep="")), ylab="Response Time", xlab="Time"
        )
        lines(ss$trans_start_time, ss$trans_resp_time, type='s')		
        
        
        legend("topright", c("FULL", "TRIMMED"),
               title="Resp Time",
               lty=c(1,1),
               lwd=c(1,1),
               pch=20,
               col=c(red,blue),
               cex=.6
        )
        
        #points(ss$scenario_elapse_time, ss$trans_resp_time, cex=1.5, pch=20, col=red)
        points(ss$trans_start_time, ss$trans_resp_time, cex=1, pch=20, col=red)
        points(ss$trans_start_time[remove_indx], ss$trans_resp_time[remove_indx], cex=1.1, pch=20, col=blue)
        
    }  ## END OF IF

} ## END OF FUNCTION


###--------------------------------------------------------------------------
###  PLOT THE TRANSACTIONS PER INTERVAL
###--------------------------------------------------------------------------
trans.per.interval.plot.data <- function(in.data, in.tran, in.low=.05, in.high=.95, type="FULL") {
    source("helper_functions.R")
    
    ##  SELECT THE TIMEFRAME, 
    start_time <- min(in.data$trans_start_time)
    end_time   <- max(in.data$trans_end_time)
    
    by_break <- 5
    myLabels <- seq(trunc(start_time, units='min'), trunc(end_time+900, units='min'), by='5 min')
    
    red <- "#E41A1C91"
    blue <- "#377EB891"
    
    srt_data <- sort.data.frame(~scenario_elapse_time,in.data)
    
    output = 'png'
    
    ###
    ### CREATE AN ALL TRANSACTION CHART
    ###
    ###  CLEAN UP THE OUTLYING RESPONSE TIMES TO SHOW DETAIL IN THE CHARTS
    srt_data$trans_name <- gsub("&", " ", srt_data$trans_name)
    
    listTranNames <- levels(as.factor(srt_data$trans_name))
    
    if (in.tran == 'All') {
        
        #in.data$trans_name <- "All_Transactions"
        srt_data$trans_name <- "All_Transactions"
        in.tran <- "All_Transactions"
        listTranNames <- levels(as.factor(srt_data$trans_name))
    } else {
        listTranNames <- c(in.tran)
    }
    
    ## SUBSET JUST THE TRANSACTION TO BE PLOTTED
    ss <- subset(srt_data, trans_name == in.tran)
    
    ## ONLY PRODUCE PLOT IF MORE THAN 15 DATA ELEMENTS ARE AVAILABLE
    if (nrow(ss) >= 15) {
        
        ## NUMBER TRANSACTION PER MINUTES
        by_break <- 1
        myLabels <- seq(trunc(start_time, units='min'), trunc(end_time+900, units='min'), by=paste0(by_break, ' min'))
        
        ss$one <- cut(ss$trans_start_time, breaks=myLabels, include.lowest=TRUE, right=TRUE)
        plot(myLabels[1:length(as.numeric(table(ss$one)))], as.numeric(table(ss$one)), type='s', 
             main=in.tran,
             ylab=paste0("Number of Transactions/", by_break, " mins"),
             xlab="Time")

    }  ## END OF IF
    
} ## END OF FUNCTION


###--------------------------------------------------------------------------
###  PLOT THE DENSITY OF THE RESPONSE TIMES
###--------------------------------------------------------------------------
density.plot.data <- function(in.data, in.tran, in.low=.05, in.high=.95, type="FULL") {
    source("helper_functions.R")
        
    ##  SELECT THE TIMEFRAME, 
    start_time <- min(in.data$trans_start_time)
    end_time   <- max(in.data$trans_end_time)
    
    by_break <- 5
    myLabels <- seq(trunc(start_time, units='min'), trunc(end_time+900, units='min'), by='5 min')
    
    red <- "#E41A1C91"
    blue <- "#377EB891"
    
    srt_data <- sort.data.frame(~scenario_elapse_time,in.data)
    
    output = 'png'
    
    ###
    ### CREATE AN ALL TRANSACTION CHART
    ###
    ###  CLEAN UP THE OUTLYING RESPONSE TIMES TO SHOW DETAIL IN THE CHARTS
    srt_data$trans_name <- gsub("&", " ", srt_data$trans_name)
    
    listTranNames <- levels(as.factor(srt_data$trans_name))
    
    if (in.tran == 'All') {
        
        #in.data$trans_name <- "All_Transactions"
        srt_data$trans_name <- "All_Transactions"
        in.tran <- "All_Transactions"
        listTranNames <- levels(as.factor(srt_data$trans_name))
    } else {
        listTranNames <- c(in.tran)
    }
    
    ## SUBSET JUST THE TRANSACTION TO BE PLOTTED
    ss <- subset(srt_data, trans_name == in.tran)
    
    #cat ("NROW SS = ", nrow(ss), " ", in.tran, "\n")
    ## ONLY PRODUCE PLOT IF MORE THAN 15 DATA ELEMENTS ARE AVAILABLE
    if (nrow(ss) >= 15) {
        
        remove_indx <- trimOutliers(ss$trans_resp_time, in.low, in.high)
        
        avg <- round(mean(ss$trans_resp_time),2)
        trim_avg <- round(mean(ss$trans_resp_time[-remove_indx]),2)
        med  <- round(median(ss$trans_resp_time),2)
        trim_med <- round(median(ss$trans_resp_time[-remove_indx]),2)
        
        #nf <- layout(matrix(c(1,2,3,3),2,2,byrow=TRUE), c(2,2), c(2,2), TRUE)
        #nf <- layout(matrix(c(1,1,2,2,3,3,3,3,4,4,4,4),3,4,byrow=TRUE), c(1,1,1,1), c(1,1,1,1), TRUE)
        
        if (type == 'FULL') {
            plot(density(ss$trans_resp_time),
                 main=paste("FULL_DATA:", in.tran, "\n", sep=""), #cex.main=.8, cex.sub=.7,
                 sub=paste("FULL: mean=", avg, "median=", med, "TRIM: mean=", trim_avg, "median=", trim_med, sep=" "))
        
        } else {
            plot(density(ss$trans_resp_time[-remove_indx]),
                 main=paste("TRMIMED_DATA:", in.tran, "\n", sep=""), #cex.main=.8, cex.sub=.7,
                 sub=paste("FULL: mean=", avg, "median=", med, "TRIM: mean=", trim_avg, "median=", trim_med, sep=" "))
        }
        
        axis(2, at = NULL, labels = FALSE, tick = FALSE)
        
        legend("topright", c("FULL: mean", "FULL: median", "TRIM: mean", "TRIM: median"),
               title="Metrics",
               lty=c(1,1,2,2),
               lwd=c(1,1,3,3),
               col=c('red','black','red','black'),
               cex=.6
        )
        segments(avg, 0,  avg, 100, col='red')
        segments(med, 0,  med, 100, col='black')
        segments(trim_avg, 0,  trim_avg, 100, col='red', lty=2, lwd=3)
        segments(trim_med, 0,  trim_med, 100, col='black', lty=2, lwd=3)
        
#         if (length(ss$trans_resp_time[-remove_indx]) > 4) {
#             plot(density(ss$trans_resp_time[-remove_indx]),
#                  main=( paste(type, ":", in.tran, "\n", sep="")), #cex.main=.8, cex.sub=.7,
#                  sub=paste("FULL: mean=", avg, "median=", med, "TRIM: mean=", trim_avg, "median=", trim_med, sep=" "))
#             legend("topright", c("FULL: mean", "FULL: median", "TRIM: mean", "TRIM: median"),
#                    title="Metrics",
#                    lty=c(1,1,2,2),
#                    lwd=c(1,1,3,3),
#                    col=c('red','black','red','black'),
#                    cex=.6
#             )
#             segments(avg, 0,  avg, 100, col='red')
#             segments(med, 0,  med, 100, col='black')
#             segments(trim_avg, 0,  trim_avg, 100, col='red', lty=2, lwd=3)
#             segments(trim_med, 0,  trim_med, 100, col='black', lty=2, lwd=3)
#             
#         } else {
#             
#             plot(0,0, main="NOT ENOUGH DATA")
#             
#         } ## END OF IF
        
    } ## END OF IF
        
} ## END OF FUNCTION
