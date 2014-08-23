getNumData<-function(data,width)
{
     #Returns end results
     return(getNumFrame(data,width))
}

getNumFrame<-function(data,width)
{
     #Determines low and high numbers in column 1
     low<-min(data[,1])
     high<-max(data[,1])
     
     #Creates new data frame with column "Groups" going from low to high with specified width
     a<-data.frame(Groups=seq(low,high,width))
     
     #Adds "Prob" column via function
     a<-getNumProb(data,a)
     
     #Removes all rows with less than 10 people total
     a<-subset(a,a[,4] >= 10)
     
     #Returns data frame
     return(a)
}

getNumProb<-function(data,a)
{
     #Cycles through all rows
     for(i in 1:nrow(a))
     {
          #Place holder
          temp<-NA
          
          #Determines if last row and takes appropriate path
          if(i != nrow(a))
               temp<-subset(data,data[,1] >= a$Groups[i] & data[,1] < a$Groups[i+1])
          else
               temp<-subset(data,data[,1] >= a$Groups[i])
          
          #Calculates probability and saves as "p"
          p<-(sum(temp$ENROLLED == 1)) / nrow(temp)
          #Assigns "p" to "Prob" column
          a$Prob[i]<-p
          
          #Enters data into "Enrolled" and "OutOf" columns
          a$Enrolled[i]<-sum(temp$ENROLLED == 1)
          a$OutOf[i]<-nrow(temp)
     }
     
     #Returns data frame
     return(a)
}