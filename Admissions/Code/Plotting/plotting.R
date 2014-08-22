plotting<-function(barPlotWidths,barPlotTitles,mainCol)
{
     #Source plot functions
     sourcePlotFunctions()

     #Creates directories if not exists
     if(!file.exists("./Generated/Stage 2 - Training/Numbers"))
          dir.create("./Generated/Stage 2 - Training/Numbers")
     if(!file.exists("./Generated/Stage 2 - Training/Barplots"))
          dir.create("./Generated/Stage 2 - Training/Barplots")
     if(!file.exists("./Generated/Stage 2 - Training/2Var"))
          dir.create("./Generated/Stage 2 - Training/2Var")
     
     #Plots and gets numbers for "main.csv"
     plotsAndNumbers(barPlotWidths,barPlotTitles)
     
     #Plots 2 variables
     twoVar(barPlotWidths,barPlotTitles)
}

sourcePlotFunctions<-function()
{
     source("./Code/Plotting/1D/plotsAndNumbers.R")
     source("./Code//Plotting/2D/twoVar.R")
}