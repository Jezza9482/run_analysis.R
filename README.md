# README
# run_analysis.R 
### A Coursera "Getting and Cleaning Data" Project
**Firstly:**

1. Download and unzip files to the current working directory from this [**link**](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). If interested, further explanation of the original experimental design and setup can be viewed [**here**](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

2. Using R or Rstudio, ensure that `dtplyr`, `dplyr`, and `data.table` packages have been installed (the script will load them if they have not been loaded in the current session)

**run_analysis.R** is an R script that extracts data components from the "UCI HAR Dataset" folder of the current working directory. This folder contains inertial sensor measurements taken from waist-mounted Samsung Galaxy S smartphones worn by 30 subjects (experimental participants), split into "test" and "train" groups whilst they completed 6 activities of daily living (ADL). The script then combines the "test" and "train" subsets of data and selects only the **mean** and **standard deviation** columns of measurements. Appropriate descriptive labels are then provided in camelcase with punctuation and spaces removed to create a tidy dataset. This dataset is then used to create a new, independent, tidy dataset of the averages of each variable for each activity for each subject (participant) which is then written to a text file, "TidyDataSet.txt", in the current working directory. This text file is a tab separated file so although could be viewed in Excel or similar, it is recommended to use a `read.table()` or `fread()` type command in R with `header = TRUE`. 

**Codebook.md** is a markdown file that thoroughly breaks down the **run_analysis.R** script covering the following topics:

  * Data Source
  * Variables
      - Table Variables, Names, and Descriptions
      - R Script Variables
  * Transformation/Analysis Process
  * Further Information and Acknowledgements