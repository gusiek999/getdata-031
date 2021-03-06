library(data.table)
library(dplyr)

### DATA PREPARING - TASK 0
feature <- read.table("UCI HAR Dataset/features.txt",header=TRUE)
activity <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

### TASK 1
### Merges the training and the test sets to create one data set.
subject <- rbind(subject_train, subject_test)
activities <- rbind(y_train, y_test)
features <- rbind(X_train, X_test)
colnames(features) <- t(feature[2])
colnames(activities) <- "Activity"
colnames(subject) <- "Subject"
merge_data <- cbind(features,activities,subject)

### TASK 2
### Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std <- grep(".*Mean.*|.*Std.*", names(merge_data), ignore.case=TRUE)
mean_std_new <- c(mean_std, 562, 563)
extracts <- merge_data[,mean_std_new]

### TASK 3
### Uses descriptive activity names to name the activities in the data set
extracts$Activity <- as.character(extracts$Activity)
for (i in 1:6){
  extracts$Activity[extracts$Activity == i] <- as.character(activity[i,2])
}
extracts$Activity <- as.factor(extracts$Activity)

### TASK 4
### Appropriately labels the data set with descriptive variable names. 
names(extracts)<-gsub("Acc", "Accelerometer", names(extracts))
names(extracts)<-gsub("Gyro", "Gyroscope", names(extracts))
names(extracts)<-gsub("-mean()", "Mean", names(extracts), ignore.case = TRUE)
names(extracts)<-gsub("-std()", "STD", names(extracts), ignore.case = TRUE)
names(extracts)<-gsub("BodyBody", "Body", names(extracts))
names(extracts)<-gsub("Mag", "Magnitude", names(extracts))
names(extracts)<-gsub("^t", "Time", names(extracts))
names(extracts)<-gsub("^f", "Frequency", names(extracts))
names(extracts)<-gsub("tBody", "TimeBody", names(extracts))
names(extracts)<-gsub("gravity", "Gravity", names(extracts))
names(extracts)<-gsub("-freq()", "Frequency", names(extracts), ignore.case = TRUE)
names(extracts)<-gsub("angle", "Angle", names(extracts))

### TASK 5
### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
extracts$Subject <- as.factor(extracts$Subject)
extracts <- data.table(extracts)
tidy_data <- aggregate(. ~Subject + Activity, extracts, mean)
tidy_data <- tidy_data[order(tidy_data$Subject,tidy_data$Activity),]
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)




