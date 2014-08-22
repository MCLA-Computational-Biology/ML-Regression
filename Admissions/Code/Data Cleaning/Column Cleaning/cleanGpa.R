cleanGpa<-function(data)
{
     #Gets GPA levels as numeric, suppresses "NAs introduced by coercion" warning
     data$SZVADMN_HS_GPA<-suppressWarnings(as.numeric(levels(data$SZVADMN_HS_GPA))[data$SZVADMN_HS_GPA])
     
     #Replaces all GPA cells with "NA" if greater than "5"
     data$SZVADMN_HS_GPA<-replace(data$SZVADMN_HS_GPA,data$SZVADMN_HS_GPA > 5.0,NA)
     
     return(data)
}