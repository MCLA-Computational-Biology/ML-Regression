dropYear14<-function()
{
     #Loads "droppedRejected.csv"
     data<-read.csv("./Generated/Stage 1 - Cleaning/droppedRejected.csv")
     
     #Forces "SZVADMN_APPL_DATE" column to date format and subsets
     #all rows containing dates less than "2014-01-01"
     data$SZVADMN_APPL_DATE<-as.Date(data$SZVADMN_APPL_DATE, format="%d-%b-%y")
     newData<-subset(data,data$SZVADMN_APPL_DATE<"2014-01-01")
     
     #Creates new file "dropped14.csv" in /Generated/Stage 1 - Cleaning
     write.csv(newData,row.names=FALSE,file="./Generated/Stage 1 - Cleaning/dropped14.csv")
}