---
title: "CodeBook"
author: "Archie"
date: "15/03/2020"
output: html_document
---


## R Markdown

The run_analysis.R script retrieves the data from the zip file into multiple datasets and then creates a tidy dataset by the 5 steps as required in the course project statement.

 1. **Download the dataset**
	Datasets downloaded and extracted under the 	folder called UCI HAR Dataset
 2. **Assign each dataset to variables**
	**features <- features.txt** : 
		The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
**activities <- activity_labels.txt** : 
List of activities performed when the corresponding measurements were taken and its codes
**subject_test <- test/subject_test.txt** : 
contains test data of test subjects being observed
**x_test <- test/X_test.txt** : 
contains test data recorded 
**y_test <- test/y_test.txt** : 
contains test data with activities’ codes 
**subject_train <- test/subject_train.txt** : 
contains training data
**x_train <- test/X_train.txt** : 
contains training data recorded
**y_train <- test/y_train.txt** : 
contains training data with activities’ codes

 3. **Merge the training and the test data sets as specified in requirement**
all_x  is created by merging x_train and x_test using rbind() function
all_y  is created by merging y_train and y_test using rbind() function
all_subject is created by merging subject_train and subject_test using rbind() function
final_data  is created by merging all_subject, all_y and all_x using cbind() function

 4. **Extract only the measurements based on the mean and standard deviation** 
tidy_data is created by  selecting only columns: subject, code and the measurements on the mean and standard deviation.

 5. **Set descriptive activity names in the data set**
All numbers in code column of the tidy_data are replaced with corresponding activity taken from second column of the activities dataset.

 6. **Label the data set with descriptive variable names**
Subject and code columns are renamed as Subject and activities respectively.
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

 7. **From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.**
avg_final_data is created by grouping tidy_data on subject and activity and then taking the mean of each variable.

 8. **Export avg_final_data into tidydata.txt file**.