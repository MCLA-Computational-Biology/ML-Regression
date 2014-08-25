qRange<-function(data)
{
     #Returns vector of numbers based on quantile
     vec<-c()
     for(i in 1:length(quantile(data)))
          vec<-c(vec,quantile(data)[[i]])
     return(vec[1:4])
}