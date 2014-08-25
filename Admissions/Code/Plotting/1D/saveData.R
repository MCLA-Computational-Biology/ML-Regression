savePlot<-function(newData,title)
{
     #Opens graphics device
     png(paste("./Generated/Stage 2 - Training/Barplots/",title,".png",sep=""), width=1059, height=773)
     
     #Main plotting function
     labels<-newData$Groups
     x<-barplot(newData$Prob,main=title,ylab="Probability",xlab="Range",ylim=c(0,1),axes=FALSE,axisnames=FALSE)
     
     #X-Axis
     text(x,par("usr")[3],labels=labels,srt=45,adj=c(1.1,1.1),xpd=TRUE,cex=.9)
     
     #Top number labels
     text(x, newData[,2], labels=newData[,4], pos=3,offset=0.1,xpd=TRUE,cex=0.8)
     
     #Y-Axis
     axis(2,las=1)
     
     #Close graphics device
     dev.off()
}

saveNumbers<-function(data,title)
{
     write.csv(data,row.names=FALSE,file=paste("./Generated/Stage 2 - Training/Barplots/Numbers/",title,".csv",sep=""))
}