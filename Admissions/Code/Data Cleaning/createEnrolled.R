createEnrolled<-function()
{
     #Reads in "dropped14.csv" and "enr_new_students_09f_13f.csv"
     main<-read.csv("./Generated/Stage 1 - Cleaning/dropped14.csv")
     enrolled<-read.csv("./Admissions/enr_new_students_09f_13f.csv")
     
     #Create temp names
     tempPIDM<-"SZVADMN_PIDM"
     tempTERM_CODE_ENTRY<-"SZVADMN_TERM_CODE_ENTRY"
     tempSTYP_CODE<-"SZVADMN_STYP_CODE"
     colnames(main)[1]<-"PIDM"
     colnames(main)[2]<-"TERM_CODE_ENTRY"
     colnames(main)[15]<-"STYP_CODE"
     
     #Creates "ENROLLED" column in "enrolled" data set, populates with "1"
     enrolled$ENROLLED<-1
     
     #Merges "main" and "enrolled" by "PIDM","TERM_CODE_ENTRY","STYP_CODE"
     combined<-merge(main,enrolled,by=c("PIDM","TERM_CODE_ENTRY","STYP_CODE"),all.x=TRUE,all.y=FALSE,sort=FALSE)
     
     #Renames columns
     colnames(combined)[1]<-tempPIDM
     colnames(combined)[2]<-tempTERM_CODE_ENTRY
     colnames(combined)[3]<-tempSTYP_CODE
     
     #Replaces all "NA" in "ENROLLED" column with "0"
     combined$ENROLLED<-replace(combined$ENROLLED,is.na(combined$ENROLLED),0)
     
     #Outputs file to "enrolledField.csv"
     write.csv(combined,row.names=FALSE,file="./Generated/Stage 1 - Cleaning/enrolledField.csv")
}