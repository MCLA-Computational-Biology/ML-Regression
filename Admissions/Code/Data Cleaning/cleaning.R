cleaning<-function(stypCode)
{
     #Sources cleaning functions
     sourceClean()
     
     #Creates "Generated" folder in root if does not exist
     if(!file.exists("./Generated"))
          dir.create("./Generated")
     
     #Creates "./Generated/Stage 1 - Cleaning" folder if does not exist
     if(!file.exists("./Generated/Stage 1 - Cleaning"))
          dir.create("./Generated/Stage 1 - Cleaning")
          
     dropRejected()
     dropYear14()
     createEnrolled()
     stypCode(stypCode)
     customColumns()
     colClean()
     
     #Creates "./Generated/Stage 2 - Training" folder if does not exist
     if(!file.exists("./Generated/Stage 2 - Training"))
          dir.create("./Generated/Stage 2 - Training")
     
     #Creates "./Generated/Stage 2 - Training/Data" folder if does not exist
     if(!file.exists("./Generated/Stage 2 - Training/Data"))
          dir.create("./Generated/Stage 2 - Training/Data")
     
     splitDataFrame()
}

sourceClean<-function()
{
     source("./Code/Data Cleaning/dropRejected.R")
     source("./Code/Data Cleaning/dropYear14.R")
     source("./Code/Data Cleaning/createEnrolled.R")
     source("./Code/Data Cleaning/stypCode.R")
     source("./Code/Data Cleaning/customColumns.R")
     source("./Code/Data Cleaning/colClean.R")
     source("./Code/Data Cleaning/splitDataFrame.R")
}