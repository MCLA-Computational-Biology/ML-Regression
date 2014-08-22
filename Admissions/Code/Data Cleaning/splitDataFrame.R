splitDataFrame<-function()
{
     #Reads data
     data<-read.csv("./Generated/Stage 1 - Cleaning/cleanData.csv")
     
     #Takes sample of data
     a<-data[sample(nrow(data),nrow(data)/2),]
     b<-a
     
     #Creates column "duplicate" and populates with "TRUE"
     b$duplicate<-TRUE
     
     #Merge with main
     c<-merge(data,b,by=colnames(data),all.x=TRUE,all.y=FALSE,sort=FALSE)
     
     #Replace all "NA" with "FALSE" in column "duplicate"
     c$duplicate<-replace(c$duplicate,is.na(c$duplicate),FALSE)
     
     #Creates subset containing rows with "FALSE"
     d<-subset(c,c$duplicate==FALSE)
     
     #Removes "duplicate" column
     d$duplicate<-NULL
     
     #Writes all files to "./Generated/Stage 2 - Training/Data"
     write.csv(data,row.names=FALSE,file="./Generated/Stage 2 - Training/Data/main.csv")
     write.csv(a,row.names=FALSE,file="./Generated/Stage 2 - Training/Data/training.csv")
     write.csv(d,row.names=FALSE,file="./Generated/Stage 2 - Training/Data/validation.csv")
}