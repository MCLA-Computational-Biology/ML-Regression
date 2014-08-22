plotting<-function(barPlotWidths,barPlotTitles)
{
     #Source plot functions
     sourcePlotFunctions()

     #Creates directories if not exists
     if(!file.exists("./Generated/Stage 2 - Training/Numbers"))
          dir.create("./Generated/Stage 2 - Training/Numbers")
     if(!file.exists("./Generated/Stage 2 - Training/Barplots"))
          dir.create("./Generated/Stage 2 - Training/Barplots")
     
     plotsAndNumbers(barPlotWidths,barPlotTitles)
}

sourcePlotFunctions<-function()
{
     source("./Code/Plotting/plotsAndNumbers.R")
}