twoVar<-function()#barPlotWidths,barPlotTitles,mainCol)
{
     #DELETE
     barPlotTitles<-c("SAT Math","Income","Gender","Race","Major","State")
     barPlotWidths<-c(25,10000)
     mainCol<-"SZVADMN_SAT_MATH"
     mainWidth<-barPlotWidths[1]
     plotWidth<-c(6)
     par(mfrow=c(3,2))
     
     #Reads "training.csv"
     data<-read.csv('./Generated/Stage 2 - Training/Data/training.csv')
     
     #Gets "main" column number
     mainNum<-grep(paste("^",mainCol,"$",sep=""),colnames(data))
     
     #Extracts "main" and "ENROLLED" columns and deletes "ENROLLED" from "data"
     exCol<-data.frame(Main=data[,mainNum],ENROLLED=data$ENROLLED)
     data[,mainNum]<-NULL
     data$ENROLLED<-NULL
     
     #Counters
     titleCounter<-1
     numCounter<-1
     
     for(i in 1:ncol(data))
     {
          #RUN EVERYTHING HERE
          exDSet<-data.frame(Main=exCol[,1],Second=data[,i],ENROLLED=exCol[,2])
          if(data.class(data[,i])=="numeric")
          {
               ranges<-getTwoVarWidth(exDSet[,2],plotWidth[numCounter])
               #png(paste("./Generated/Stage 2 - Training/2Var/",colnames(exDSet)[2],".png",sep=""), width=1059, height=773)
               for(i in 1:length(ranges))
               {
                    if(i != length(ranges))
                    {
                         temp<-subset(exDSet,exDSet[,2] >= ranges[i] & exDSet[,2] < ranges[i+1])
                    }
                    else
                    {
                         temp<-subset(exDSet,exDSet[,2] >= ranges[i])
                    }
                    temp[,2]<-NULL
                    temp<-getCustomNumFrame(temp,mainWidth)
                    #plot(temp[,1],temp[,2],main=paste(ranges[i]," - ",ranges[i]-1,sep=""))
                    plotTwoVar(temp,paste(ranges[i]," - ",ranges[i]-1,sep=""))
               }
               #dev.off()
          }
          else
          {
               ranges<-levels(exDSet[,2])
               for(i in 1:length(ranges))
               {
                    temp<-subset(exDSet,exDSet[,2] == ranges[i])
                    temp[,2]<-NULL
                    temp<-getCustomNumFrame(temp,mainWidth)
                    #plot(temp[,1],temp[,2],main=ranges[i])
               }
               #return("hi")
          }
     }
}

plotTwoVar<-function(newData,title)
{
     labels<-newData$Groups
     x<-barplot(newData$Prob,main=title,ylab="Probability",xlab="Range",ylim=c(0,1),axes=FALSE,axisnames=FALSE)
     text(x,par("usr")[3],labels=labels,srt=45,adj=c(1.1,1.1),xpd=TRUE,cex=.9)
     text(x, newData[,2], labels=newData[,4], pos=3,offset=0.1,xpd=TRUE,cex=0.8)
     axis(2,las=1)
}

getCustomNumFrame<-function(data,width)
{
     #Determines low and high numbers in column 1
     low<-min(data[,1])
     high<-max(data[,1])
     
     #Creates new data frame with column "Groups" going from low to high with specified width
     a<-data.frame(Groups=seq(low,high,width))
     
     #Adds "Prob" column via function
     a<-getNumProb(data,a)
     
     #Returns data frame
     return(a)
}

getTwoVarWidth<-function(data,plotWidth)
{
     low<-min(data)
     high<-max(data)
     width<-round((high-low)/plotWidth)
     return(seq(low,high,width)[1:length(seq(low,high,width))-1])
}