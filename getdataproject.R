## Create the data directory if it does not exist
if(!file.exists("./GetProjectdata")) {
    dir.create("./GetProjectdata")
}

## Download the dataset
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temporaryfile <- tempfile()
download.file(URL , temporaryfile)
unzip(temporaryfile , exdir = "./GetProjectdata")

## read  the data sets
subjecttest<- read.table("./GetProjectdata/UCI HAR Dataset/test/subject_test.txt", header = F, stringsAsFactors = F, fill = T)
Xtest <- read.table("./GetProjectdata/UCI HAR Dataset/test/X_test.txt", header = F, stringsAsFactors = F, fill = T)
Ytest <- read.table("./GetProjectdata/UCI HAR Dataset/test/y_test.txt", header = F, stringsAsFactors = F, fill = T)
subjecttrain <- read.table("./GetProjectdata/UCI HAR Dataset/train/subject_train.txt", header = F, stringsAsFactors = F, fill = T)
Xtrain <- read.table("./GetProjectdata/UCI HAR Dataset/train/X_train.txt", header = F, stringsAsFactors = F, fill = T)
Ytrain <- read.table("./GetProjectdata/UCI HAR Dataset/train/y_train.txt", header = F, stringsAsFactors = F, fill = T)
##----------------------------------------------------------------------------------------------------------------

## 1. Merge the training and the test sets to create one data set.

## merge the data sets 
mergeddatasets <- cbind(rbind(subjecttest, subjecttrain ), rbind(Ytest , Ytrain ), rbind(Xtest , Xtrain ))

## get the features
features <- read.table("./GetProjectdata/UCI HAR Dataset/features.txt", header = F, stringsAsFactors = F, fill = T)

## Name the variables using the features
colnames(mergeddatasets ) <- c("Subject", "Label", features[, 2])
##----------------------------------------------------------------------------------------------------------------

## 2. Extract only the measurements on the mean and standard deviation for each measurement. 

mergeddatasets <- mergeddatasets [, grepl("mean()|std()|Subject|Label", colnames(mergeddatasets )) & !grepl("meanFreq", colnames(mergeddatasets ))]
##----------------------------------------------------------------------------------------------------------------

## 3. Use descriptive activity names to name the activities in the data set

## read the activity names from activity_labels.txt
activitynames <- read.table("./GetProjectdata/UCI HAR Dataset/activity_labels.txt", header = F, stringsAsFactors = F, fill = T)

## label the data set with activity names.
mergeddatasets$Label <- factor(mergeddatasets$Label, levels = activitynames [, 1], labels = activitynames [, 2])
##----------------------------------------------------------------------------------------------------------------

## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr)
newtidyData <- ddply(mergeddatasets , .(Subject, Label ), .fun=function(x) { colMeans(x[ ,-c(1:2)]) })
write.table(newtidyData , "./GetProjectdata/newtidyData.txt", row.names = FALSE)
