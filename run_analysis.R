#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable
#for each activity and each subject.

#load libraries
library(dplyr)

#load the activity_labels

activity <- read.table("activity_labels.txt") 

#load the feature labels

features <- read.table("features.txt") 


#load the test data

setwd("./test")

sub_test <- read.table("subject_test.txt") 
X_test <- read.table("X_test.txt") 
Y_test <- read.table("y_test.txt") 

#load the training data

setwd("../train")

sub_train <- read.table("subject_train.txt") 
X_train <- read.table("X_train.txt") 
Y_train <- read.table("y_train.txt") 

#Relabel the columns for test and training feature sets using descriptive labels from features.txt  

colnames(X_test) <- features$V2
colnames(X_train) <- features$V2

#Relabel the Y_ column for test and training sets to "activityID"

colnames(Y_test) <- "activityID"
colnames(Y_train) <- "activityID"

#Relabel the sub_ column for test and training sets to "subjectID"

colnames(sub_test) <- "subjectID"
colnames(sub_train) <- "subjectID"

#Append activityID and subjectID columns to front of test and training feature data 

test <- cbind(Y_test, sub_test, X_test)
train <-  cbind(Y_train, sub_train, X_train)

#Merge test and training datasets into one

merged <- bind_rows(test, train)

#remove duplicate names
merged <- merged[ , !duplicated(colnames(merged))]

#Extract only columns whose names contain "mean()" or "std()" in the merged data set

extract_merged <- select(merged, activityID, subjectID, contains("mean()"), contains("std()")) 

#group by activityID and subjectID

by_activity_subject <- group_by(extract_merged, activityID, subjectID)


#calculate mean of every feature grouped by activityID and subjectID 

summary <- summarise_each(by_activity_subject, funs(mean))



#replace activityID values by descriptive names from activity.txt

for (i in 1:length(summary$activityID)) {summary$activityID[i] <- as.character(activity$V2[match(summary$activityID[i], activity$V1)])}



#write out a text file
setwd("../")
write.table(summary, file="UCI_summary.txt", row.names=FALSE)
