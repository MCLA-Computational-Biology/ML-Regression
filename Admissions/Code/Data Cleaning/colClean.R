colClean<-function()
{
     #Reads "./Generated/Stage 1 - Cleaning/customCol.csv"
     data<-read.csv("./Generated/Stage 1 - Cleaning/customCol.csv")
     
     if("SZV_INC_FISAP_INC" %in% colnames(data))
     {
          source("./Code/Data Cleaning/Column Cleaning/cleanIncome.R")
          data<-cleanIncome(data)
     }
     if("SZVADMN_HS_GPA" %in% colnames(data))
     {
          source("./Code/Data Cleaning/Column Cleaning/cleanGpa.R")  
          data<-cleanGpa(data)
     }
     
     source("./Code/Data Cleaning/Column Cleaning/removeNA.R")  
     data<-removeNA(data)
     
     #Writes to "./Generated/Stage 1 - Cleaning/cleanData.csv"
     write.csv(data,row.names=FALSE,file="./Generated/Stage 1 - Cleaning/cleanData.csv")
}