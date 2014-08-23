getProb<-function(data,mainRange)
{
     #Creates new data frame containing columns: Groups, Prob, Enrolled, OutOf
     newData<-data.frame(Groups=mainRange)
     
     #Determines if first column is factor or numeric and runs loop
     if(data.class(data[,1])=="factor")
     {
          for(i in 1:nrow(newData))
          {
               #Subsets based on levels() and passes to function
               temp<-subset(data,data[,1]==newData$Groups[i])
               newData<-calculateProb(temp,newData,i)
          }
     }
     else
     {
          for(i in 1:nrow(newData))
          {
               #Subsets based on value range and passes to function
               if(i != nrow(newData))
                    temp<-subset(data,data[,1] >= newData$Groups[i] & data[,1] < newData$Groups[i+1])
               else
                    temp<-subset(data,data[,1] >= newData$Groups[i])
               newData<-calculateProb(temp,newData,i)
          }
     }
     #Removes rows where NA exists
     newData<-subset(newData,!is.na(newData[,2]))
     return(newData)
}

calculateProb<-function(temp,newData,i)
{
     #Calculates probability based on enrolled and total. Adds to data frame as well.
     p<-(sum(temp$ENROLLED == 1)) / nrow(temp)
     newData$Prob[i]<-p
     newData$Enrolled[i]<-sum(temp$ENROLLED == 1)
     newData$OutOf[i]<-nrow(temp)
     return(newData)
}