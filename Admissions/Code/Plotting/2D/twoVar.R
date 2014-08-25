twoVar<-function(barPlotWidths,barPlotTitles)
{
     #TO PASS IN
     #barPlotTitles<-c("SAT Math","Income","Gender","Race","Major","State")
     #barPlotWidths<-c(25,10000)
     
     #########################################

     #Source Functions
     sourceTwoVarFunctions()
     
     #Installs GGPlot2 if not already installed
     if("ggplot2" %in% rownames(installed.packages()) == FALSE)
          install.packages("ggplot2")
     if(require(ggplot2)==FALSE)
          library(ggplot2)
     
     #Reads data
     data<-read.csv("./Generated//Stage 2 - Training/Data/training.csv")
     
     #Stores name of first column
     mainCol<-colnames(data)[1]
     exSet<-data.frame(Main=data[,1],ENROLLED=data$ENROLLED)
     
     #Deletes unused variables
     if(data.class(data[,1])=="numeric")
     {
          mainWidth<-barPlotWidths[1]
          barPlotWidths<-barPlotWidths[-1]
     }
     barPlotTitles<-barPlotTitles[-1]
     data[,1]<-NULL
     data$ENROLLED<-NULL
     
     #Gets width of "mainCol"
     if(data.class(exSet[,1])=="numeric")
          mainRange<-seq(min(exSet[,1]),max(exSet[,1]),mainWidth)
     else
          mainRange<-levels(exSet[,1])
     
     #Counters
     widthCounter<-1
     titleCounter<-1
     
     for(i in 1:ncol(data))
     {
          #Creates data frame and passes to "customGroup"
          dSet<-data.frame(Main=exSet[,1],Second=data[,i],ENROLLED=exSet[,2])
          dSet<-customGroup(dSet,colnames(data)[i])
          
          #Creates new data frame from "getProb" and populates "LVL" with "ALL"
          dSet2<-getProb(dSet,mainRange)
          #return(dSet2)
          dSet2$LVL<-"ALL"
          
          #Determines if column is numerical or alpha
          if(data.class(data[,i])=="factor")
          {
               #Creates range based on levels
               secondRange<-levels(dSet[,2])
               for(j in 1:length(secondRange))
               {
                    #Creates subset and passes to function
                    temp<-subset(dSet,dSet[,2] == secondRange[j])
                    dSet2<-subsetBinding(temp,secondRange[j],dSet2,mainRange)
               }
          }
          else
          {
               #Creates range based on quantile
               secondRange<-qRange(data[,i])
               for(j in 1:length(secondRange))
               {
                    #Creates subset and passes to function
                    if(j != length(secondRange))
                         temp<-subset(dSet,dSet[,2] >= secondRange[j] & dSet[,2] < secondRange[j+1])
                    else
                         temp<-subset(dSet,dSet[,2] >= secondRange[j])
                    dSet2<-subsetBinding(temp,secondRange[j],dSet2,mainRange)
               }
          }
          #Removes all rows where "OutOf" is less than 10
          dSet2<-subset(dSet2,dSet2[,4] >= 10)
          
          write.csv(dSet2,row.names=FALSE,file=paste("./Generated//Stage 2 - Training/2Var/Numbers/",barPlotTitles[i],".csv",sep=""))
          
          #Stops "NaNs" produced warning
          options(warn=-1)
          
          #Creates and saves plots
          getPlot(dSet2,barPlotTitles[i],mainCol)
          
          #Iterates to next title
          titleCounter<-titleCounter+1
     }
}

subsetBinding<-function(temp,sRange,dSet2,mainRange)
{
     #Creates data frame and binds to dSet2
     temp[,2]<-NULL
     temp<-getProb(temp,mainRange)
     temp$LVL<-sRange
     dSet2<-rbind(dSet2,temp)
     return(dSet2)
}

sourceTwoVarFunctions<-function()
{
     source('./Code/Plotting/2D/customGroup.R')
     source('./Code/Plotting/2D/qRange.R')
     source('./Code/Plotting/2D/getPlot.R')
     source('./Code/Plotting/2D/getProb.R')
}