runThis<-function()
{
     #******EDIT "./Code/Data Cleaning/customColumns.txt" BEFORE RUNNING!!!!!******
     #******"ENROLLED" COLUMN MUST BE LISTED******
     #******FIRST COLUMN IN DATA FRAME WILL BE THE "MAIN"******
     
     ##########
     #SETTINGS#
     ##########
     stypCode<-"N"
     barPlotTitles<-c("Gender","State")
     barPlotWidths<-NA#c(25,10000)
     ##########
     
     #Confirms "ENROLLED" is listed
     if(checkEnrolled() == FALSE)
          stop("\"ENROLLED\" NOT IN \"CUSTOMCOLUMNS.txt\"")
     
     #Sets seed to 3
     set.seed(3)
     
     #Sources main functions
     sourceFunctions()
          
     #Data cleaning
     cleaning(stypCode)
     
     #Plotting
     plotting(barPlotWidths,barPlotTitles)
}

sourceFunctions<-function()
{
     source("./Code/Data Cleaning/cleaning.R")
     source("./Code/Plotting/plotting.R")
}

checkEnrolled<-function()
{
     temp<-readLines("./Code/Data Cleaning/customColumns.txt")
     if("ENROLLED" %in% temp)
          return(TRUE)
     else
          return(FALSE)
}