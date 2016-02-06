# Assignment: Getting and Cleaning Data Course Project

# Step 1. Merges the training and the test sets 
# to create one data set
# setwd("C:/Users/shaun.que/Desktop/DS")

trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
dim(trainData); dim(trainLabel); dim(trainSubject) 
    # [1] 7352  561 [1] 7352    1   [1] 7352    1

testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
dim(testData); dim(testLabel); dim(testSubject)
    # [1] 2947  561 [1] 2947    1   [1] 2947    1

mergedData <- rbind(trainData, testData)
mergedLabel <- rbind(trainLabel, testLabel)
mergedSubject <- rbind(trainSubject, testSubject)
dim(mergedData); dim(mergedLabel); dim(mergedSubject)
    # [1] 10299   561   [1] 10299     1 [1] 10299     1

# Step 2. Extracts only the measurements on the mean and standard 
# deviation for each measurement.
features <- read.table("./UCI HAR Dataset/features.txt")
names(mergedData) <- features[,2]
MeanStdIndex <- grep("(mean\\(\\))|(std\\(\\))", names(mergedData))
subData <- mergedData[,MeanStdIndex]
dim(subData) # [1] 10299    66

names(subData) <- gsub("\\(\\)", "", names(subData))    # remove "()"
names(subData) <- gsub("-", "", names(subData))         # remove "-"
names(subData) <- gsub("mean", "Mean", names(subData))  # Proper(mean)
names(subData) <- gsub("std", "Std", names(subData))    # Proper(std)


# Step 3. Uses descriptive activity names to name the activities 
# in the data set
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[,2] <- tolower(activity[,2])           # lowercase
activity[,2] <- gsub("_", "", activity[,2])     # remove "_"
substr(activity[2,2], 8, 8) <- toupper(substr(activity[2,2], 8, 8)) # Proper(upstairs)
substr(activity[3,2], 8, 8) <- toupper(substr(activity[3,2], 8, 8)) # Proper(downstairs)

activityLabel <- activity[mergedLabel[,1],2]
mergedLabel[,1] <- activityLabel
names(mergedLabel) <- "activity"


# Step 4. Appropriately labels the data set with descriptive
# variable names
names(mergedSubject) <- "subject"
tidyData <- cbind(mergedSubject, mergedLabel, subData)
dim(tidyData)   # [1] 10299   68
write.table(tidyData, "tidy_data.txt")


# Step 5. Creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject
subjectLen <- length(sort(unique(tidyData$subject)))
activityLen <- length(tidyData$activity)
columnLen <- dim(tidyData)[2]
finalData <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen)
finalData <- as.data.frame(finalData)
colnames(finalData) <- colnames(tidyData)

row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        finalData[row, 1] <- sort(unique(mergedSubject)[, 1])[i]
        finalData[row, 2] <- activity[j, 2]
        bool1 <- i == tidyData$subject
        bool2 <- activity[j, 2] == tidyData$activity
        finalData[row, 3:columnLen] <- 
            colMeans(tidyData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}

head(finalData)
write.table(finalData, "final_data.txt")



