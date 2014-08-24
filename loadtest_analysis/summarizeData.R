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


summarize.data <- function(in.data, in.tran, in.low=.05, in.high=.95) {

    source("helper_functions.R")

    if(exists("trimmed_data")) {rm(trimmed_data)}

    listTranNames <- levels(as.factor(in.data$trans_name))
    
	for (n in listTranNames) {
		ss <- subset(in.data, trans_name == n)
        
        remove_indx <- trimOutliers(ss$trans_resp_time, low=in.low, high=in.high)
		
		if (exists("trimmed_data")) {
		    #cat(" in.log = ", in.low, "  in.high = ", in.high, "    SS   = ", n,  "nrows ss = ", nrow(ss), " nrow trimmed = ", nrow(trimmed_data), " remove index = ", remove_indx, "\n")
			trimmed_data <- rbind(trimmed_data, ss[-remove_indx,])
		} else {
            trimmed_data <- ss[-remove_indx,]
		}
		
	}
    
	summ_data <- summarizeData(in.data, "FULL_DATA")
	summ_data <- rbind(summ_data, summarizeData(trimmed_data, "TRIM_DATA"))
	

    if (in.tran == 'All') {
        
        out_data <- summ_data[order(as.character(summ_data$TransNames)),]
        
    } else {
        
        out_data <- subset(summ_data, TransNames == in.tran)
        
    }

	return(out_data)
	
} ## END OF FUNCTION
