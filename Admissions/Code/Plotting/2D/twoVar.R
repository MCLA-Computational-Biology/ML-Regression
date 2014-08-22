twoVar<-function()
{
     #TO PASS IN
     barPlotTitles<-c("SAT Math","Income","Gender","Race","Major","State")
     barPlotWidths<-c(25,10000)
     mainCol<-"SZVADMN_SAT_MATH"
     numOfPlots<-8
     
     #########################################
     
     source('./Code/Plotting/2D/customGroup.R')
     
     library(ggplot2)
     
     data<-read.csv("./Generated//Stage 2 - Training/Data/training.csv")
     
     mainWidth<-barPlotWidths[1]
     barPlotWidths<-barPlotWidths[-1]
     barPlotTitles<-barPlotTitles[-1]
     
     mainNum<-grep(paste("^",mainCol,"$",sep=""),colnames(data))
     
     exSet<-data.frame(Main=data[,mainNum],ENROLLED=data$ENROLLED)
     data[,mainNum]<-NULL
     data$ENROLLED<-NULL
     
     #DELETE###########################
     #data[,1]<-NULL
     #t<-data.frame(SZVADMN_APP_MAJR_CODE_1=data$SZVADMN_APP_MAJR_CODE_1,SZVADMN_PR_STAT_CODE=data$SZVADMN_PR_STAT_CODE)
     #data<-t
     
     #Counters
     widthCounter<-1
     titleCounter<-1
     
     mainRange<-seq(min(exSet[,mainNum]),max(exSet[,mainNum]),mainWidth)
     
     for(i in 1:ncol(data))
     {
          dSet<-data.frame(Main=exSet[,1],Second=data[,i],ENROLLED=exSet[,2])
          
          ###
          dSet<-customGroup(dSet,colnames(data)[i])
          
          dSet2<-getProb(dSet,mainRange)
          dSet2$LVL<-"ALL"
          if(data.class(data[,i])=="factor")
          {
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
               #secondRange<-getWidth(data[,i],numOfPlots)
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
          titleCounter<-titleCounter+1
          ggsave(filename = paste("./Generated//Stage 2 - Training/2Var/",i,".png",sep=""),k)
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