Admissions
-----------------------------------------------------

Make sure settings are correct before running! (Or program may freeze!)

- Admissions files should be in root, in a folder named "Admissions"

- "customColumns.txt" in "./Code/Data Cleaning/customColumns.txt":
  - Create list of columns, making sure each entry is on a new line
  - First line will be the "main column", x-axis for the 2Var plots
  - Last entry MUST BE "ENROLLED" (without quotes)

- "runThis.R" in root under "SETTINGS":
  - stypCode
    - Must be "N", "T", or "R"
  - barPlotTitles
    - Enter titles to be used for plots and file names (make sure they are in the same order as "customColumns.txt")
  - barPlotWidths
    - If column is numerical, enter a specified width (if no width is entered or is too large/small, program may freeze!)
    - Enter in the same order as barPlotTitles
      - **If column is factor, simply skip over and enter next numerical width**
      - **Do not enter width for "ENROLLED"**

>Example
```
     ##########
     #SETTINGS#
     ##########
     stypCode<-"N"
     barPlotTitles<-c("SAT Math","Income","Gender","Race","Major","State")
     barPlotWidths<-c(25,10000)
     ##########
```
