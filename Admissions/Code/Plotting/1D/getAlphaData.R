getAlphaData<-function(data)
{
     #Returns end results
     return(getAlphaFrame(data))
}

getAlphaFrame<-function(data)
{
     #Creates new data frame with groups based on "levels()" function
     a<-data.frame(Groups=levels(data[,1]))
     
     #Gets probability based on function
     a<-getAlphaProb(data,a)
     
     #Sorts data frame from highest to lowest and returns that subset
     index <- with(a, order(Prob,decreasing=TRUE))
     return(a[index,])
}

getAlphaProb<-function(data,a)
{
     #Place holder
     temp<-NA
     
     #Cycles through all levels
     lvls<-levels(data[,1])
     for(i in 1:length(lvls))
     {
          #Creates temp subset based on "lvls[i]"
          temp<-subset(data,data[,1] == lvls[i])
          
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