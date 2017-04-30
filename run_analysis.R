# run_analysis.R
# load the relevant packages
library(dtplyr)
library(dplyr)
library(data.table)

# Read in the relevant .txt files from the unzipped file downloaded to the 
# current working directory and allocate to data variables
subTest <- fread("UCI HAR Dataset/test/subject_test.txt", 
                 colClasses = "integer")
XTest <- fread("UCI HAR Dataset/test/X_test.txt", 
               colClasses = "numeric")
YTest <- fread("UCI HAR Dataset/test/y_test.txt", 
               colClasses = "factor")
subTrain <- fread("UCI HAR Dataset/train/subject_train.txt", 
                  colClasses = "integer")
XTrain <- fread("UCI HAR Dataset/train/X_train.txt", 
                colClasses = "numeric")
YTrain <- fread("UCI HAR Dataset/train/y_train.txt", 
                colClasses = "factor")
ActivityLabels <- fread("UCI HAR Dataset/activity_labels.txt", 
                        colClasses = c("integer", "character"))
Features <- fread("UCI HAR Dataset/features.txt", 
                  colClasses = c("integer", "character"))

# Put ActivityLabels to lowercase, capitalising each word & remove underscores 
ActivityLabels <- ActivityLabels$V2 %>% tolower() %>% 
    gsub("^([a-z])|(_[a-z])","\\U\\1\\U\\2",., perl = TRUE) %>% 
    gsub("_", "",.) %>% as.factor

# Identify only the variable columns that denote the mean or standard deviation
# of a measurement (discount weighted average variables)
WantedVariables<- grep("mean[^F]|std", Features$V2)

# Create a data table combining the activities, subjects, and wanted variables
# from each of the Test and Train sets of data 
DF<- rbind(cbind(YTest,subTest,select(XTest,WantedVariables)),
           cbind(YTrain,subTrain,select(XTrain,WantedVariables)))
# Use the appropriate names for the activities
DF$V1<- sapply(DF$V1, function(x){ActivityLabels[as.numeric(x)]})

# Give names for each of the columns using the Features table
setnames(DF, c("activity", "subject", 
               as.character(Features$V2[WantedVariables])))
# Make the column names descriptive, camelCase, and without punctuation
nms <- names(DF) %>% gsub("^t","TimeBased",.) %>% 
    gsub("^f","FreqBased",.) %>% 
    gsub("Gravity","Gravitational",.) %>%
    gsub("(Body)+","Body",.) %>%
    gsub("Acc","LinearAcceleration",.) %>%
    gsub("Gyro","AngularVelocity",.) %>%
    gsub("Jerk","JerkSignal",.) %>%
    gsub("Mag","Magnitude",.) %>%
    gsub("^([a-zA-Z]*)-mean\\(","Meanof\\1",. ) %>%
    gsub("^([a-zA-Z]*)-std\\(","StandardDevof\\1",.) %>%
    gsub("\\)","",.) %>%
    gsub("-X","AlongX",.) %>%
    gsub("-Y","AlongY",.) %>%
    gsub("-Z","AlongZ",.)
setnames(DF, nms)

# Create a table of means of variables for each person for each activity 
Means <- melt.data.table(DF,id.vars=c("activity","subject")) %>%
    dcast.data.table(activity + subject ~ variable, mean) %>% 
    arrange(activity,subject)

# Write the table to a text file "TidyDataSet.txt"
write.table(Means, file = "TidyDataSet.txt", row.names = FALSE)