This repositry contains the code for the project of the Getting and Cleaning Data project
 
The following is done in run_analysis.R script:
1. Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Read the "subject_test.txt","X_test.txt","Y_test.txt","X_train.txt" and "y_train.txt"
3. Merge the read files into a single data set, using subject as the first column, label as the second column and the data as the rest of the columns.
4. Read the features names found in "features.txt".
5. Update the column names of the merged data set.
6. Extract only the columns with mean and std in their names.
7. Use the activity names in "activity_labels.txt" to update the activity names in the data set.
8. Create a new tidy data set with the average of each variable for each subject for each activity.