# getdataproj

This repo contains an R script called run_analysis.R that performs the following data cleaning steps on the UCI HAR Samsung accelerometer data:

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the 
6) average of each variable for each activity and each subject.

The Input data is the training and test data sets from the UCI HAR Samsung data.

The Output data file "UCI_summary.txt" is "tidy"-organized into 181 rows and 68 columns.
Each row is a single observation of a subject performing a single activity.

Column 1 is activityID
Column 2 is subjectID
Columns 3-35 are the mean components of Accelerometer data detailed in the file "features.txt"
Columns 36-68 are the std components of the Accelerometer data as above.
