# Getting and Cleaning Data Course Project CodeBook
## This file outlines the variables, data, and process used to clean the data.

### Setup
* The site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
  The data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* The run_analysis.R script performs the following procedures:

### Step 1:
* Read X_train.txt, y_train.txt, and subject_train.txt from "./UCI HAR Dataset/train" folder and store them in trainData, trainLabel, and trainSubject respectively.
* Read X_test.txt, y_test.txt, and subject_test.txt from "./UCI HAR Dataset/test" folder and store them in testData, testLabel, and testSubject respectively.
* Append the following data:
  * trainData (7352x561) to testData (2947x561) to create mergedData (10299x561).
  * trainLabel (7352x1) to testLabel (2947x1) to create mergedLabel (10299x1).
  * trainSubject(7352x1) to testSubject (2947x1) to create mergedSubject (10299x1).

### Step 2:
* Read features.txt file from the "./UCI HAR Dataset" folder and store the data in features. 
* Extract the measurements on the mean and standard deviation (66 columns) and store in subData variable
* Clean the column names of the resulting extract: remove the "()" and "-" symbols, capitalize the first letter of "mean" and "std"

### Step 3:
* Read the activity_label.txt file from the "./UCI HAR Dataset" folder and store the data in activity.
* Clean the second column of activity: convert all names to lower case, remove underscore, capitalize the first letter of the 2nd word
* Transform the value of mergedLabel according to the data in activity

### Step 4:
* Combine mergedSubject, mergedLabel, and subData to get a new 10299x68 data frame stored in tidyData.
* Properly name the first two columns as "subject" and "activity".
* Write the tidyData out to "tidy_data.txt" file in the current working directory.

### Step 5:
* Generate a second, independent tidy data set with the average of each variable for each activity and each subject.
* Store resulting data in finalData variable.
* Write the finalData out to "final_data.txt" file in the current working directory.
