customGroup<-function(data,cName)
{
     #If column is detected, go to sort function
     if(cName =="SZVADMN_PR_STAT_CODE")
     {
          data<-stateGroup(data)
     }
     else if(cName =="SZVADMN_APP_MAJR_CODE_1")
     {
          data<-majorGroup(data)
     }

     #Returns data
     return(data)
}

majorGroup<-function(data)
{
     #Stem List from: https://www.ice.gov/doclib/sevis/pdf/stem-list.pdf
     
     #Reads stem fields stored in file
     stemList<-paste(readLines("./Code/Plotting/stemFields.txt"), sep=" ")
     
     levels(data[,2]) <- c(levels(data[,2]), "STEM","NONSTEM","IDST/UND") 
     data[,2][data[,2]=="IDST" | data[,2]=="UND"]<-"IDST/UND"
     data[,2][data[,2] %in% stemList]<-"STEM"
     data[,2][!(data[,2] %in% stemList) & data[,2] != "IDST/UND" & data[,2] !="STEM"]<-"NONSTEM"
     
     data[,2]<-droplevels(data[,2])
     
     return(data)
}

stateGroup<-function(data)
{
     sts<-c("NY","MA","CT","VT")
     levels(data[,2]) <- c(levels(data[,2]), "ELSE") 
     data[,2][!(data[,2] %in% sts)]<-"ELSE"
     data[,2]<-droplevels(data[,2])
     return(data)
}