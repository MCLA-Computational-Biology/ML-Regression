customSorting<-function(data,cName)
{
     #If column is detected, go to sort function
     if(cName =="SZVADMN_PR_STAT_CODE")
     {
          data<-stateSort(data)
     }
     else if(cName =="SZVADMN_APP_MAJR_CODE_1")
     {
          data<-majorSort(data)
     }

     #Returns data
     return(data)
}

stateSort<-function(data)
{
     #Creates two subsets, "mainStates" and "everyoneElse"
     mainStates<-subset(data, data$Group == "MA" | data$Group == "NY" | data$Group == "CT" | data$Group == "VT")
     everyoneElse<-subset(data, data$Group != "MA" & data$Group != "NY" & data$Group != "CT" & data$Group != "VT")
     
     #Calculates probability of "everyoneElse"
     enrollNum<-sum(everyoneElse[,3])
     enrollTotal<-sum(everyoneElse[,4])
     enrollProb<-enrollNum/enrollTotal
     
     #Creates a temp data frame
     temp<-data.frame(Groups="Else",Prob=(enrollNum/enrollTotal),Enrolled=enrollNum,OutOf=enrollTotal)
     
     #Returns a combined data frame
     return(rbind(mainStates,temp))
}

majorSort<-function(data)
{
     #Stem List from: https://www.ice.gov/doclib/sevis/pdf/stem-list.pdf
     
     #Reads stem fields stored in file, edit to change
     stemList<-paste(readLines("./Code/Plotting/stemFields.txt"), sep=" ")
     
     #Stem field calculations
     sField<-subset(data,data$Group %in% stemList)
     enrollNum<-sum(sField[,3])
     enrollTotal<-sum(sField[,4])
     enrollProb<-enrollNum/enrollTotal
     sFrame<-data.frame(Groups="STEM",Prob=(enrollNum/enrollTotal),Enrolled=enrollNum,OutOf=enrollTotal)
     
     #Non-stem field calculations
     nonSField<-subset(data,!(data$Group %in% stemList) & data$Group != "IDST" & data$Group != "UND")
     enrollNum<-sum(nonSField[,3])
     enrollTotal<-sum(nonSField[,4])
     enrollProb<-enrollNum/enrollTotal
     nFrame<-data.frame(Groups="NONSTEM",Prob=(enrollNum/enrollTotal),Enrolled=enrollNum,OutOf=enrollTotal)
     
     #IDST/UND field calculations
     interDis<-subset(data,data$Group == "IDST" | data$Group == "UND")
     enrollNum<-sum(interDis[,3])
     enrollTotal<-sum(interDis[,4])
     enrollProb<-enrollNum/enrollTotal
     iFrame<-data.frame(Groups="IDST/UND",Prob=(enrollNum/enrollTotal),Enrolled=enrollNum,OutOf=enrollTotal)
     
     #Returns a combined data frame
     return(rbind(sFrame,nFrame,iFrame))
}