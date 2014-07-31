##--------------------------------------------------
## FUNCTION: trimOutliers
##--------------------------------------------------
trimOutliers <- function(x, low=.05, high=.95) {
    high_q <- as.numeric(quantile(x, prob=high)[1])
    low_q <- as.numeric(quantile(x, prob=low)[1])
    high_indx <- which(x >= high_q)
    low_indx <- which(x <= low_q)
    indx <- c(high_indx, low_indx)
    return(indx)
}

###-----------------------------------------
###  SUMMARIZE THE FULL AND TRIMMED DATA
###-----------------------------------------
summarizeData <- function(df, label='DATA') {
    byTran <- tapply(df$trans_resp_time, df$trans_name, sao.func)
    byTran <- do.call("rbind", byTran)
    TransNames <- row.names(byTran)
    byTran <- cbind(TransNames, data.frame(round(byTran,3)))
    rownames(byTran) <- NULL
    #byTran$TransNames <- paste(byTran$TransNames, label, sep="_")
    byTran$label <- label
    
    return(byTran)
    
}

###-----------------------------------------
###  SAO STAT SUMMARY FUNCTION
###-----------------------------------------
"sao.func" <- function(a)
{
    #
    # my.func -- commonly used statistical metrics
    #
    if (is.integer(a)) a <- as.numeric(a)
    data <- c(length(a), mean(a), sqrt(var(a)), quantile(a, c(0., .25, 0.5, .75, 0.90, 0.95,
                                                              1.), na.rm=TRUE))
    names(data) <- c("Count", "Mean", "SD", "Min", "p25", "Median", "p75", "p90", "p95", "Max")
    data
}
