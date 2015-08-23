#Getting and Cleaning Data Course Project

The goal of the project is to obtain a tidy data set from the original data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The R code is in the file called run_analysis.R.

At the beginning I'm loading two needed libraries: data.table and dplyr. Then I'm reading the training and test data.

In the next step, I follow the tasks from the project description page:

1) I merge the data. This data are stored in "merge_data".

2) I extract only the measurements on the mean and standard deviation for each measurement - they are stored in "extracts". 

3) I uses descriptive activity names to name the activities in the data set. 

4) I labels the data set with descriptive variable names.

5) From the data set in step 4, I create independent tidy data set with the average of each variable for each activity and each subject.
