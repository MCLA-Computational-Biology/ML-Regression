stypCode<-function(c)
{
     #Reads "./Generated/Stage 1 - Cleaning/enrolledField.csv"
     data<-read.csv("./Generated/Stage 1 - Cleaning/enrolledField.csv")
     
     #Creates subset based on "c"
     newData<-subset(data,data$SZVADMN_STYP_CODE == c)
     
     #Writes new data to "./Generated/Stage 1 - Cleaning/stypCodeSubset.csv"
     write.csv(newData,row.names=FALSE,file="./Generated/Stage 1 - Cleaning/stypCodeSubset.csv")
}