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