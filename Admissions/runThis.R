runThis<-function()
{
     #******EDIT "./Code/Data Cleaning/customColumns.txt" BEFORE RUNNING!!!!!******
     #******"ENROLLED" COLUMN MUST BE LISTED******
     
     ##########
     #SETTINGS#
     ##########
     stypCode<-"N"
     barPlotTitles<-c("SAT Math","Income","Gender","Race","Major","State")
     barPlotWidths<-c(25,10000)
     mainCol<-"SZVADMN_SAT_MATH"
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