###---------------------------------------------------------
###   CheckLoadRunnerRawData:  
###   Author: Stephen O'Connell
###   Date: 06/20/2012
###   Description:
###
###   Change History: (why is always just because...)
###        Who         When            What
###        SAOB        2012-06-20     Initial Development
###---------------------------------------------------------

##-----------------------------------------------------------------------------------------


plot.data <- function(in_data, in.trans, in.low=.05, in.high=.95) {
    
    source("helper_functions.R")
    
    ####---------------------------------------------------------------------
    ####  SORT A DATA FRAME
    ####    
    ####---------------------------------------------------------------------
    sort.data.frame <- function(form,dat){
        # Author: Kevin Wright
        # Some ideas from Andy Liaw
        # http://tolstoy.newcastle.edu.au/R/help/04/07/1076.html
        
        # Use + for ascending, - for decending.
        # Sorting is left to right in the formula
        
        
        # Useage is either of the following:
        # sort.data.frame(~Block-Variety,Oats)
        # sort.data.frame(Oats,~-Variety+Block)
        
        
        # If dat is the formula, then switch form and dat
        if(inherits(dat,"formula")){
            f=dat
            dat=form
            form=f
        }
        if(form[[1]] != "~")
            stop("Formula must be one-sided.")
        
        # Make the formula into character and remove spaces
        formc <- as.character(form[2])
        formc <- gsub(" ","",formc)
        # If the first character is not + or -, add +
        if(!is.element(substring(formc,1,1),c("+","-")))
            formc <- paste("+",formc,sep="")
        # Extract the variables from the formula
        vars <- unlist(strsplit(formc, "[\\+\\-]"))   
        vars <- vars[vars!=""] # Remove spurious "" terms
        
        # Build a list of arguments to pass to "order" function
        calllist <- list()
        pos=1 # Position of + or -
        for(i in 1:length(vars)){
            varsign <- substring(formc,pos,pos)
            pos <- pos+1+nchar(vars[i])
            if(is.factor(dat[,vars[i]])){
                
                if(varsign=="-")
                    calllist[[i]] <- -rank(dat[,vars[i]])
                else
                    calllist[[i]] <- rank(dat[,vars[i]])
                
            }
            else {
                
                if(varsign=="-")
                    calllist[[i]] <- -dat[,vars[i]]
                else
                    calllist[[i]] <- dat[,vars[i]]
                
                
            }
        }
        dat[do.call("order",calllist),]
        
    }
    
    
    
    ##------------------------------------------  MAIN CODE ------------------------------------##
    ##------------------------------------------  MAIN CODE ------------------------------------##
    ##------------------------------------------  MAIN CODE ------------------------------------##

    start_time <- min(in_data$trans_start_time)
    end_time   <- max(in_data$trans_end_time)

    by_break <- 5
    myLabels <- seq(trunc(start_time, units='min'), trunc(end_time+900, units='min'), by='5 min')
    
	red <- "#E41A1C91"
	blue <- "#377EB891"
	
	srt_data <- sort.data.frame(~scenario_elapse_time,in_data)
	
	output = 'png'
	
	###
	### CREATE AN ALL TRANSACTION CHART
	###
	###  CLEAN UP THE OUTLYING RESPONSE TIMES TO SHOW DETAIL IN THE CHARTS
    
	srt_data$trans_name <- gsub("&", " ", srt_data$trans_name)
	listTranNames <- levels(as.factor(srt_data$trans_name))
	
    
	if (in.trans == 'All') {
		
		#in_data$trans_name <- "All_Transactions"
		srt_data$trans_name <- "All_Transactions"
		listTranNames <- levels(as.factor(srt_data$trans_name))
	} else {
        listTranNames <- c(in.trans)
	}
	
	
	
	for (Trn in listTranNames) {
		#ss <- subset(srt_data, FQ_test_name == Trn)
		
		ss <- subset(srt_data, trans_name == Trn)
		
		if (nrow(ss) >= 15) {
			remove_indx <- trimOutliers(ss$trans_resp_time, in.low, in.high)
			
			#openGdevice(type=output, file=paste(graphDir, analysisName, "DENSITY",  Trn, sep="_"), w=10, h=8, r=108, ps=12)
			
			avg <- round(mean(ss$trans_resp_time),2)
			trim_avg <- round(mean(ss$trans_resp_time[-remove_indx]),2)
			med  <- round(median(ss$trans_resp_time),2)
			trim_med <- round(median(ss$trans_resp_time[-remove_indx]),2)
			
			
			nf <- layout(matrix(c(1,2,3,3),2,2,byrow=TRUE), c(2,2), c(2,2), TRUE)
			nf <- layout(matrix(c(1,1,2,2,3,3,3,3,4,4,4,4),3,4,byrow=TRUE), c(1,1,1,1), c(1,1,1,1), TRUE)
				
			plot(density(ss$trans_resp_time),
					main=paste("FULL_DATA:", Trn, "\n", sep=""), #cex.main=.8, cex.sub=.7,
					sub=paste("FULL: mean=", avg, "median=", med, "TRIM: mean=", trim_avg, "median=", trim_med, sep=" "))
			
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
			
			if (length(ss$trans_resp_time[-remove_indx]) > 4) {
				plot(density(ss$trans_resp_time[-remove_indx]),
						main=( paste("TRIM_DATA:", Trn, "\n", sep="")), #cex.main=.8, cex.sub=.7,
						sub=paste("FULL: mean=", avg, "median=", med, "TRIM: mean=", trim_avg, "median=", trim_med, sep=" "))
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
			} else {
				cat("NOT ENOUGH POINTS = ", Trn, "\n")
			    plot(0,0, main="NOT ENOUGH DATA")
			}
			
			plot(myLabels,rep(0,length(myLabels)), pch='', ylim=c(0,max(ss$trans_resp_time)),
					main=( paste(Trn, sep="")), #cex.main=.6, cex.sub=.6,
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
			
		
			by_break <- 1
			myLabels <- seq(trunc(start_time, units='min'), trunc(end_time+900, units='min'), by=paste0(by_break, ' min'))
			
			ss$one <- cut(ss$trans_start_time, breaks=myLabels, include.lowest=TRUE, right=TRUE)
			plot(myLabels[1:length(as.numeric(table(ss$one)))], as.numeric(table(ss$one)), type='s', 
					main=Trn,
					ylab=paste0("Number of Transactions/", by_break, " mins"),
					xlab="Time")
			
			#dev.off()
			
		} ## END IF
		
	}
		

} ## END OF FUNCTION
