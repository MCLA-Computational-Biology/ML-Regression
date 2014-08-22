removeNA<-function(data)
{    
     #Looks for all "" in data and replaces with "NA"
     for (i in 1:ncol(data))
     {
          data[i]<-replace(data[i],data[i] == "",NA)
     }
     
     #Creates "newData" containing rows with complete entries
     good<-complete.cases(data)
     return(data[good,])
}