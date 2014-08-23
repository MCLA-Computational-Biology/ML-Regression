getPlot<-function(dSet2,title,xTitle)
{
     #Creates plots from ggplot2
     p<-ggplot(dSet2, aes(Groups, Prob)) + 
          geom_bar(stat="identity") + 
          facet_wrap(~ LVL,scales="free") + 
          coord_cartesian(ylim = c(0,1)) + 
          geom_text(aes(label=OutOf), vjust=-0.25) + 
          ggtitle(title) + 
          ylab("Probability") + 
          xlab(xTitle)
     
     #Creates geom_smooth line if dSet2[,1] is numeric
     if(data.class(dSet2[,1]) == "numeric")
          p<-p+geom_smooth(method="lm")
     
     #Saves plot
     ggsave(filename = paste("./Generated//Stage 2 - Training/2Var/",title,".png",sep=""),p)
}