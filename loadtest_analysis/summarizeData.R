###---------------------------------------------------------
###   summarizeData:  
###   Author: Stephen O'Connell
###   Date: 2014-07-25
###   Description:
###
###   Change History: (why is always just because...)
###        Who         When            What
###        SAOB        2014-07-25     Initial Development
###---------------------------------------------------------


summarize.data <- function(in_data, in.low=.05, in.high=.95) {
	
# 	suppressMessages(require(Hmisc, quietly=TRUE))
# 	suppressMessages(require(Hmisc, quietly=TRUE))
# 	suppressMessages(require(lattice, quietly=TRUE))
# 	suppressMessages(require(latticeExtra, quietly=TRUE))
# 	suppressMessages(require(Cairo, quietly=TRUE))
# 	suppressMessages(require(reshape, quietly=TRUE))
# 	suppressMessages(require(stringr, quietly=TRUE))
	
	
# 	##--------------------------------------------------
# 	## FUNCTION: trimOutliers
# 	##--------------------------------------------------
# 	trimOutliers <- function(x, low=.05, high=.95) {
# 		high_q <- as.numeric(quantile(x, prob=high)[1])
# 		low_q <- as.numeric(quantile(x, prob=low)[1])
# 		high_indx <- which(x >= high_q)
# 		low_indx <- which(x <= low_q)
# 		indx <- c(high_indx, low_indx)
# 		return(indx)
# 	}
# 	
# 	###-----------------------------------------
# 	###  SUMMARIZE THE FULL AND TRIMMED DATA
# 	###-----------------------------------------
# 	summarizeData <- function(df, label='DATA') {
# 		byTran <- tapply(df$trans_resp_time, df$trans_name, sao.func)
# 		byTran <- do.call("rbind", byTran)
# 		TransNames <- row.names(byTran)
# 		byTran <- cbind(TransNames, data.frame(round(byTran,3)))
# 		rownames(byTran) <- NULL
# 		#byTran$TransNames <- paste(byTran$TransNames, label, sep="_")
# 		byTran$label <- label
# 		
# 		return(byTran)
# 		
# 	}
# 	
# 	###-----------------------------------------
# 	###  SAO STAT SUMMARY FUNCTION
# 	###-----------------------------------------
# 	"sao.func" <- function(a)
# 	{
# 		#
# 		# my.func -- commonly used statistical metrics
# 		#
# 		if (is.integer(a)) a <- as.numeric(a)
# 		data <- c(length(a), mean(a), sqrt(var(a)), quantile(a, c(0., .25, 0.5, .75, 0.90, 0.95,
# 								1.), na.rm=TRUE))
# 		names(data) <- c("Count", "Mean", "SD", "Min", "p25", "Median", "p75", "p90", "p95", "Max")
# 		data
# 	}

    source("helper_functions.R")

    if(exists("trimmed_data")) {rm(trimmed_data)}
    
    ####  TRIM THE DATA TO 90%, REMOVE THE OUTLIERS
	listTranNames <- levels(as.factor(in_data$trans_name)) 
	
	for (n in listTranNames) {
		ss <- subset(in_data, trans_name == n)
    
        remove_indx <- trimOutliers(ss$trans_resp_time, low=in.low, high=in.high)
		
		if (exists("trimmed_data")) {
			trimmed_data <- rbind(trimmed_data, ss[-remove_indx,])
		} else {
			trimmed_data <- ss[-remove_indx,]
		}
		
	}
    
	summ_data <- summarizeData(in_data, "FULL_DATA")
	summ_data <- rbind(summ_data, summarizeData(trimmed_data, "TRIM_DATA"))
	
    out_data <- summ_data[order(as.character(summ_data$TransNames)),]
    
	return(out_data)
	
} ## END OF FUNCTION
