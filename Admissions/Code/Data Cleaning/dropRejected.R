dropRejected<-function()
{
     #Reads main data set
     data<-read.csv("./Admissions/szvadmn_09f_14f_no_names.csv")
     
     #Creates subset not including "RI","RJ","","NA"
     newData<-subset(data,data$SZVADMN_APDC_CODE!="RI" & data$SZVADMN_APDC_CODE!="RJ" & !is.na(data$SZVADMN_APDC_CODE) & data$SZVADMN_APDC_CODE!="")
     
     #Writes data set to ".csv" file named "droppedRejected.csv"
     write.csv(newData,row.names=FALSE,file="./Generated/Stage 1 - Cleaning/droppedRejected.csv")
}