# Codebook for run_analysis.R

### Data Source:
The data used by this script comes from the UCI Machine Learning Repository from the database, "Human Activity Recognition Using Smartphones Data Set", which is available [**here**](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Specific measurements were taken of 30 individuals performing activities of daily living (ADL) while carrying a waist-mounted Samsung Galaxy S smartphone with embedded inertial sensors. All relevant measurements and associated files are found in this linked [**zip file**](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). When downloaded and unzipped into the current working directory, the folder, "UCI HAR Dataset" contains the required files of which there are 4 text files:

- activity_labels.txt &emsp; &nbsp; -a text file of factor labels for the activity field of datasets
- features_info.txt &emsp; &emsp; -a text file providing information about the measured and calculated variables 
- features.txt &emsp; &emsp; &emsp; &emsp; -a text file of factor labels for the variables (column names) of the datasets
- README.txt &emsp; &emsp; &emsp; &ensp; -an overall description of the intent of the "UCI HAR Dataset" with file desciptions and methods  

There are also two subfolders: "test" and "train" which refer to the two subsets of the subject population that were randomly selected; 30% were allocated to "test" and the remaining 70% to "train". Within each subfolder are three corresponding .txt files that are used for the run_analysis.R script and a further subfolder, "Inertial Signals", containing raw values, which is not used directly here. The three text files used (each with the _train.txt or _test.txt ending indicating subset) are:

- X &emsp; &emsp; &emsp; &emsp; &emsp; -A matrix of each measured or calculated variable in features.txt for each observation normalised and bounded within [-1,1]
- Y &emsp; &emsp; &emsp; &emsp; &emsp; -A vector of the activity codes (1-6) in order of each observation in the datatset
- subject &emsp; &emsp; &nbsp; -A vector of the subject codes (1-30) in order of each observation in the dataset

### Variables
#### Table Variables, Names, and Descriptions
The intent of this script is to combine the "test" and "train" datasets and extract only mean or standard deviation values of measured variables, then use these values to calculate means for each activity, by individual subject. As such, variables containing the phrase "meanFreq()" are discarded from the datasets as they are a "weighted average of the frequency components to obtain a mean frequency" and not a direct mean of a measurement. Also, only features containing the phrase "mean" or "std" from the features text files are included in the analysis. All data values are unitless as they have been normalised and bounded within [-1,1] 
For the final output, a table of means is written to a text file, "TidyDataSet.txt". This is a dataframe of 180 observations of 68 variables. Each observation represents the average of means or standard deviations of a measured variable for a given subject, participating in a given activity. The first column is **activity** the values for which are taken from the corresponding label in "activity_labels.txt", defining the activity being performed. This is then transformed to an appropriate format by removing spaces and converting to camelcase to clarify individual terms giving the following levels:

1. Walking
2. WalkingUpstairs
3. WalkingDownstairs
4. Sitting
5. Standing
6. Laying


The second column is **subject** which is a unique identifier for each subject (participant) in the experiment and is an integer value from 1 to 30. The six levels of **activity** and 30 levels of **subject** combine to give us the 180 possible observations of mean for each variable. The third through to the 68th columns are the means of the desired variables. The labels for which have been taken from the corresponding labels in "features.txt" which are then interpreted, expanded and refined to camelcase without punctuation marks to improve their readability and clarity. From the "features_info.txt" file, it can be seen that the labels in "features.txt" are modular. These modules combine to form the final labels so this approach was used to create the transformed column names. The terms "Frequency" and "Deviation" were reduced to "Freq" and "Dev" in order to limit the label names to 64 characters which is a standard variable name limit in [**SQL database systems**](https://dev.mysql.com/doc/refman/5.7/en/identifiers.html) that may potentially use such a table:


Module | Transformed Module      | Description  | 
---------|------------------|----------------------------------------------------------------|
t | TimeBased |  time domain signals captured at a rate of 50Hz
f | FreqBased | fast fourier transformed frequency domain signals
Body | Body | due to the subject's body
Gravity | Gravitational | due to gravitational acceleration
Acc | LinearAcceleration | acceleration component in one direction
Gyro | AngularVelocity | rate of change of angular position of the rotating body
Jerk | JerkSignal | rate of change of acceleration with respect to time
Mag | Magnitude | total length (absolute length across all dimensions) calculated using the Euclidian norm
-X | AlongX | in the X (first) axial direction
-Y | AlongY | in the Y (second) axial direction
-Z | AlongZ | in the Z (third) axial direction
mean() | Meanof | calculated mean of values that are median, noise, and 3rd order low pass Butterworth filtered
std() | StandardDevof | calculated standard deviations of values that are median, noise, and 3rd order low pass Butterworth filtered


This generates the following list of extracted readable, understandable variable column names:


Column | Transformed Feature Label
:----:|---
 [3] | "MeanofTimeBasedBodyLinearAccelerationAlongX"                    
 [4] | "MeanofTimeBasedBodyLinearAccelerationAlongY"                    
 [5] | "MeanofTimeBasedBodyLinearAccelerationAlongZ"                    
 [6] | "StandardDevofTimeBasedBodyLinearAccelerationAlongX"             
 [7] | "StandardDevofTimeBasedBodyLinearAccelerationAlongY"             
 [8] | "StandardDevofTimeBasedBodyLinearAccelerationAlongZ"             
 [9] | "MeanofTimeBasedGravitationalLinearAccelerationAlongX"           
[10] | "MeanofTimeBasedGravitationalLinearAccelerationAlongY"           
[11] | "MeanofTimeBasedGravitationalLinearAccelerationAlongZ"           
[12] | "StandardDevofTimeBasedGravitationalLinearAccelerationAlongX"    
[13] | "StandardDevofTimeBasedGravitationalLinearAccelerationAlongY"    
[14] | "StandardDevofTimeBasedGravitationalLinearAccelerationAlongZ"    
[15] | "MeanofTimeBasedBodyLinearAccelerationJerkSignalAlongX"          
[16] | "MeanofTimeBasedBodyLinearAccelerationJerkSignalAlongY"          
[17] | "MeanofTimeBasedBodyLinearAccelerationJerkSignalAlongZ"          
[18] | "StandardDevofTimeBasedBodyLinearAccelerationJerkSignalAlongX"   
[19] | "StandardDevofTimeBasedBodyLinearAccelerationJerkSignalAlongY"   
[20] | "StandardDevofTimeBasedBodyLinearAccelerationJerkSignalAlongZ"   
[21] | "MeanofTimeBasedBodyAngularVelocityAlongX"                       
[22] | "MeanofTimeBasedBodyAngularVelocityAlongY"                       
[23] | "MeanofTimeBasedBodyAngularVelocityAlongZ"                       
[24] | "StandardDevofTimeBasedBodyAngularVelocityAlongX"                
[25] | "StandardDevofTimeBasedBodyAngularVelocityAlongY"                
[26] | "StandardDevofTimeBasedBodyAngularVelocityAlongZ"                
[27] | "MeanofTimeBasedBodyAngularVelocityJerkSignalAlongX"             
[28] | "MeanofTimeBasedBodyAngularVelocityJerkSignalAlongY"             
[29] | "MeanofTimeBasedBodyAngularVelocityJerkSignalAlongZ"             
[30] | "StandardDevofTimeBasedBodyAngularVelocityJerkSignalAlongX"      
[31] | "StandardDevofTimeBasedBodyAngularVelocityJerkSignalAlongY"      
[32] | "StandardDevofTimeBasedBodyAngularVelocityJerkSignalAlongZ"      
[33] | "MeanofTimeBasedBodyLinearAccelerationMagnitude"                 
[34] | "StandardDevofTimeBasedBodyLinearAccelerationMagnitude"          
[35] | "MeanofTimeBasedGravitationalLinearAccelerationMagnitude"        
[36] | "StandardDevofTimeBasedGravitationalLinearAccelerationMagnitude" 
[37] | "MeanofTimeBasedBodyLinearAccelerationJerkSignalMagnitude"       
[38] | "StandardDevofTimeBasedBodyLinearAccelerationJerkSignalMagnitude"
[39] | "MeanofTimeBasedBodyAngularVelocityMagnitude"                    
[40] | "StandardDevofTimeBasedBodyAngularVelocityMagnitude"             
[41] | "MeanofTimeBasedBodyAngularVelocityJerkSignalMagnitude"          
[42] | "StandardDevofTimeBasedBodyAngularVelocityJerkSignalMagnitude"   
[43] | "MeanofFreqBasedBodyLinearAccelerationAlongX"                    
[44] | "MeanofFreqBasedBodyLinearAccelerationAlongY"                    
[45] | "MeanofFreqBasedBodyLinearAccelerationAlongZ"                    
[46] | "StandardDevofFreqBasedBodyLinearAccelerationAlongX"             
[47] | "StandardDevofFreqBasedBodyLinearAccelerationAlongY"             
[48] | "StandardDevofFreqBasedBodyLinearAccelerationAlongZ"             
[49] | "MeanofFreqBasedBodyLinearAccelerationJerkSignalAlongX"          
[50] | "MeanofFreqBasedBodyLinearAccelerationJerkSignalAlongY"          
[51] | "MeanofFreqBasedBodyLinearAccelerationJerkSignalAlongZ"          
[52] | "StandardDevofFreqBasedBodyLinearAccelerationJerkSignalAlongX"   
[53] | "StandardDevofFreqBasedBodyLinearAccelerationJerkSignalAlongY"   
[54] | "StandardDevofFreqBasedBodyLinearAccelerationJerkSignalAlongZ"   
[55] | "MeanofFreqBasedBodyAngularVelocityAlongX"                       
[56] | "MeanofFreqBasedBodyAngularVelocityAlongY"                       
[57] | "MeanofFreqBasedBodyAngularVelocityAlongZ"                       
[58] | "StandardDevofFreqBasedBodyAngularVelocityAlongX"                
[59] | "StandardDevofFreqBasedBodyAngularVelocityAlongY"                
[60] | "StandardDevofFreqBasedBodyAngularVelocityAlongZ"                
[61] | "MeanofFreqBasedBodyLinearAccelerationMagnitude"                 
[62] | "StandardDevofFreqBasedBodyLinearAccelerationMagnitude"          
[63] | "MeanofFreqBasedBodyLinearAccelerationJerkSignalMagnitude"       
[64] | "StandardDevofFreqBasedBodyLinearAccelerationJerkSignalMagnitude"
[65] | "MeanofFreqBasedBodyAngularVelocityMagnitude"                    
[66] | "StandardDevofFreqBasedBodyAngularVelocityMagnitude"             
[67] | "MeanofFreqBasedBodyAngularVelocityJerkSignalMagnitude"          
[68] | "StandardDevofFreqBasedBodyAngularVelocityJerkSignalMagnitude" 


#### R Script Variables
Variables used in the R script "run_analysis.R" for temperary holders of vectors and dataframes, used to create the final table. The following variables store the read information from the "UCI HAR Dataset" files:


Script Variable | Content
:--------------:|------------------------------------------------
subTest | subject integer vector from the Test subset from the subject_test.txt file
XTest | numeric dataset of observations for the Test subset from the X_test.txt file
YTest | factor vector of coded activities for each observation of the Test subset from the Y_test.txt file
subTrain | subject integer vector from the Train subset from the subject_train.txt file
XTrain | numeric dataset of observations for the Train subset from the X_train.txt file
YTrain | factor vector of coded activities for each observation of the Train subset from the Y_train.txt file
ActivityLabels | 2 column dataset of a numeric vector of codes and a corresponding character vector of activity names from the activity_labels.txt file
Features | 2 column dataset of a numeric vector of codes and a corresponding character vector of Feature names (X column names) from the Features.txt file


The following variables are created from transformation of the previous variables:


Script Variable | Content
:--------------:|------------------------------------------------
WantedVariables | Integer vector of indices of the columns desired from the "X" datasets
DF | A "tidy" merged dataset of extracted means and standard deviations of measured values
nms | character vector of transformed column names for the "tidied" datasets
Means | An indepedent "tidy" dataset of averages of the values in the DF dataset grouped for each acticity and participant (subject)

### Transformation/Analysis Process
The run_analysis.R script is an R script created on "Another Canoe" R version 3.3.3 (2017-03-06) running on macOS Sierra version 10.12.4. The script assumes the prior installation of the packages `dtplyr`, `dplyr`, and `data.table` and loads these packages with the `library()` command. These enable efficiency in reading files as well as in subsetting and transforming dataframes. The following method is then used to create the merged dataset, "tidy" the dataset, and then create the final output:

1. Read in the relevant .txt files from the unzipped file downloaded to the current working directory and allocate to data variables using the `fread()` command setting the `colClasses` as follows:
    * **subTest** - `"integer"`
    * **XTest** - `"numeric"`
    * **YTest** - `"factor"`
    * **subTrain** - `"integer"`
    * **XTrain** - `"numeric"`
    * **YTrain** - `"factor"`
    * **ActivityLabels** - `c("integer", "character")`
    * **Features** - `c("integer", "character")`
2. Using the pipe operator `%>%`, "tidy" the **ActivityLabels** variable by:
    1. extract the second "V2" column
    2. convert from upper to lower case using `tolower()`
    3. use `gsub()` to convert the first characters of words to uppercase
    4. use `gsub()` to remove underscores
    5. use `as.factor` to convert to a factor vector
3. Use `grep()` to identify the indices of the second "V2" column of the **Features** variable which contain either "std" or "mean" without an "F" immediately following as in mean**F**req which is to be discounted. Then assign to **WantedVariables**
4. Create a new data table **DF** using the `rbind()`, `cbind()`, and `select()` functions:
    * use `select()` on the X variables (**XTest** and **XTrain**) using the **WantedVariables** as a subset
    * use `cbind()` on the Y, sub, and subsetted X variables for the Test and Train versions
    * use `rbind()` on the Test and Train column bound datasets
    * allocate to **DF**
5. Use `sapply()` and a temporary function to replace the coded first column values of **DF** with their corresponding labels in the tidied **ActivityLabels**
6. Give names for each of the columns using `setnames()` by concatenating "activity" and "subject" with the second column of **Features** subsetted with the indices in **WantedVariables**
7. Using the pipe operator, `%>%`, "tidy" the column names and allocate to **nms** using `gsub()` to:
    1. replace "t" at the beginning with "TimeBased"
    2. replace "f" at the beginning with "FreqBased"
    3. replace "Gravity" with "Gravitational"
    4. replace "Body" occurring at least once with a single occurrence
    5. replace "Acc" with "LinearAcceleration"
    6. replace "Gyro" with "AngularVelocity"
    7. replace "Jerk" with "JerkSignal"
    8. replace "Mag" with "Magnitude"
    9. replace "-mean(" occurring after a string at the beginning with "Meanof" at the beginning
    10. replace "-std(" occurring after a string at the beginning with "StandardDevof" at the beginning
    11. remove ")"
    12. replace "-X" with AlongX
    13. replace "-Y" with AlongY
    14. replace "-Z" with AlongZ
8. Use `setnames()` to overwrite the column names of **DF** with values from **nms**
9. Use the pipe operator `%>%`, `melt.data.table()`, `dcast.data.table()` and `arrange()` to create the final data table **Means**. These versions of "melt" and "dcast" do not require the loading of the `reshape2` package and are an S3 method for melting/casting data.tables. They greatly increase the speed and memory efficiency:
    1. use `melt.data.table()` to "melt" **DF** using the `id.vars` "activity" and "subject"
    2. use `dcast.data.table()` to "cast" `variable` of the melted table based on "activity" then "subject" returning `mean`
    3. use `arrange` to order the data table by **activity** then **subject**
    4. allocate the resulting data table to the variable **Means**
10. Use `write.table()` to write **Means** to a text file "TidyDataSet.txt" without rownames

### Further Information and Acknowledgements
More in-depth information about the original data sets can be found in the **README.txt** and **features_info.txt** files of the unzipped "UCI HAR Dataset" folder or from the source website:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. In creating the R script and associated files I must give recognition to the assistance of David Hood's [**Getting and Cleaning the Assignment**](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) webpage and a page recommended by Coursera forum contributor, Nancy Irisarri, covering the restrictions on variable names used in SQL databases: https://dev.mysql.com/doc/refman/5.7/en/identifiers.html. I must also acknowledge the contribution of Coursera mentor, Leonard Greski, who gave clarification as to the suitability of camelcase in variables with multiple terms that may otherwise lose their clarity if left lowercase.
