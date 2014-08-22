cleanIncome<-function(data)
{
     #Creates subset with income greater than "0" and less than or equal to "800000"
     newData<-subset(data,data$SZV_INC_FISAP_INC > 0 & data$SZV_INC_FISAP_INC <=800000 & !is.na(data$SZV_INC_FISAP_INC))
     
     return(newData)
}