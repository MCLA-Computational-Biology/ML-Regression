plotsAndNumbers<-function(barPlotWidths,barPlotTitles)
{
     #Souce dataFrameFunctions
     dataFrameFunctions()
     
     #Reads "main.csv"
     data<-read.csv('./Generated/Stage 2 - Training/Data/main.csv')
     
     #Finds column number of "ENROLLED" column
     enrolledNum<-grep("^ENROLLED$",colnames(data))
     
     #Counters
     widthCounter<-1
     titleCounter<-1
     
     #Cycles through all columns in data frame
     for(i in 1:ncol(data))
     {
          #Skips "ENROLLED" column
          if(i != enrolledNum)
          {
               #Creates temp data frame with one column and "ENROLLED"
               temp<-data.frame(columnName=data[,i],ENROLLED=data$ENROLLED)
               
               #Determines if data in first column are numbers of characters and chooses appropriate path
               if(data.class(data[,i]) == "factor")
               {
                    #newData<-getAlphaFrame(temp)
                    newData<-getAlphaData(temp)
               }
               else
               {
                    newData<-getNumData(temp,barPlotWidths[widthCounter])
                    widthCounter<-widthCounter+1
               }
               
               #Custom sorting
               newData<-customSorting(newData,colnames(data)[i])
               
               #Saves data
               saveNumbers(newData,barPlotTitles[titleCounter])
               savePlot(newData,barPlotTitles[titleCounter])
               
               #Cycles through titles
               titleCounter<-titleCounter+1
          }
     }
}

dataFrameFunctions<-function()
{
     source('./Code/Plotting/1D/getNumData.R')
     source('./Code/Plotting/1D/getAlphaData.R')
     source('./Code/Plotting/1D/saveData.R')
     source('./Code/Plotting/1D/customSorting.R')
}