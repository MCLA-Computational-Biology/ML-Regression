runThis<-function()
{
     #******EDIT "./Code/Data Cleaning/customColumns.txt" BEFORE RUNNING!!!!!******
     #******"ENROLLED" COLUMN MUST BE LISTED******
     #******FIRST COLUMN IN DATA FRAME WILL BE THE "MAIN"******
     
     ##########
     #SETTINGS#
     ##########
     stypCode<-"N"
     barPlotTitles<-c("SAT Math","Income","Gender","Race","Major","State")
     barPlotWidths<-c(25,10000)
     ##########
     
     #Sets seed to 3, delete to remove
     set.seed(3)
     
     #Confirms "ENROLLED" is listed
     if(checkEnrolled() == FALSE)
          stop("\"ENROLLED\" NOT IN \"CUSTOMCOLUMNS.txt\"")
     
     #Sources main functions
     sourceFunctions()
          
     #Data cleaning
     cleaningMain(stypCode)
     
     #Plotting
     plottingMain(barPlotWidths,barPlotTitles)
}

sourceFunctions<-function()
{
     source("./Code/Data Cleaning/cleaningMain.R")
     source("./Code/Plotting/plottingmain.R")
}

checkEnrolled<-function()
{
     temp<-readLines("./Code/Data Cleaning/customColumns.txt")
     if("ENROLLED" %in% temp)
          return(TRUE)
     else
          return(FALSE)
}