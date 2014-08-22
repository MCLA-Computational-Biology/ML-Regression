twoVar<-function(barPlotWidths,barPlotTitles)
{
     #TO PASS IN
     #barPlotTitles<-c("SAT Math","Income","Gender","Race","Major","State")
     #barPlotWidths<-c(25,10000)
     
     #########################################
     print("TwoVar")
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
          return(dSet2)
          dSet2$LVL<-"ALL"
          
          #Determines if column is numerical or alpha
          if(data.class(data[,i])=="factor")
          {
               #Creates range based on levels
               secondRange<-levels(dSet[,2])
               for(j in 1:length(secondRange))
               {
                    temp<-subset(dSet,dSet[,2] == secondRange[j])
                    temp[,2]<-NULL
                    temp<-getProb(temp,mainRange)
                    temp$LVL<-secondRange[j]
                    dSet2<-rbind(dSet2,temp)
               }
               dSet2<-subset(dSet2,dSet2[,4] >= 10)
               #return(dSet2)
          }
          else
          {
               secondRange<-qRange(data[,i])
               #return(secondRange)
               for(j in 1:length(secondRange))
               {
                    if(j != length(secondRange))
                         temp<-subset(dSet,dSet[,2] >= secondRange[j] & dSet[,2] < secondRange[j+1])
                    else
                         temp<-subset(dSet,dSet[,2] >= secondRange[j])
                    temp[,2]<-NULL
                    temp<-getProb(temp,mainRange)
                    temp$LVL<-secondRange[j]
                    dSet2<-rbind(dSet2,temp)
               }
               dSet2<-subset(dSet2,dSet2[,4] >= 10)
               #return(dSet2)
          }
          
          #Stop warnings
          options(warn=-1)
          
          k<-getPlot(dSet2,barPlotTitles[i],mainCol) + geom_smooth(method="lm")
          ggsave(filename = paste("./Generated//Stage 2 - Training/2Var/",barPlotTitles[i],".png",sep=""),k)
          titleCounter<-titleCounter+1
          #return(k)
     }
}

qRange<-function(data)
{
     vec<-c()
     for(i in 1:length(quantile(data)))
          vec<-c(vec,quantile(data)[[i]])
     return(vec)
}

getPlot<-function(dSet2,title,xTitle)
{
     p<-ggplot(dSet2, aes(Groups, Prob)) + 
          geom_bar(stat="identity") + 
          facet_wrap(~ LVL,scales="free") + 
          coord_cartesian(ylim = c(0,1)) + 
          geom_text(aes(label=OutOf), vjust=-0.25) + 
          ggtitle(title) + 
          ylab("Probability") + 
          xlab(xTitle)
     return(p)
}

getProb<-function(data,mainRange)
{
     newData<-data.frame(Groups=mainRange)
     print(newData)
     for(i in 1:nrow(newData))
     {
          if(i != nrow(newData))
               temp<-subset(data,data[,1] >= newData$Groups[i] & data[,1] < newData$Groups[i+1])
          else
               temp<-subset(data,data[,1] >= newData$Groups[i])
          
          p<-(sum(temp$ENROLLED == 1)) / nrow(temp)
          newData$Prob[i]<-p
          
          newData$Enrolled[i]<-sum(temp$ENROLLED == 1)
          newData$OutOf[i]<-nrow(temp)
     }
     newData<-subset(newData,!is.na(newData[,2]))
     return(newData)
}

getWidth<-function(data,numOfPlots)
{
     low<-min(data)
     high<-max(data)
     width<-round((high-low)/numOfPlots)
     return(seq(low,high,width)[1:length(seq(low,high,width))-1])
}

sourceTwoVarFunctions<-function()
{
     source('./Code/Plotting/2D/customGroup.R')
}