customColumns<-function()
{
     #Reads "./Generated/Stage 1 - Cleaning/stypCodeSubset.csv"
     data<-read.csv("./Generated/Stage 1 - Cleaning/stypCodeSubset.csv")
     
     #Creates "newData" based on columns in "./Data/Data Cleaning/customColumns.txt"
     temp<-paste(readLines("./Code/Data Cleaning/customColumns.txt"), sep=" ")
     newData<-data[,temp]
     
     #Writes "newData" to "./Generated/Stage 1 - Cleaning/customCol.csv"
     write.csv(newData,row.names=FALSE,file="./Generated/Stage 1 - Cleaning/customCol.csv")
}