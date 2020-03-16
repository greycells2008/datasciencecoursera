library(dplyr)

#Download archive if it doesn't pre-exist
if(!file.exists("dataset.zip"))
{
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                "dataset.zip",method = "curl")
}

#unzip to folder if not already done
if(!file.exists("UCI HAR Dataset"))
{
  unzip("dataset.zip")
}

#Reading data from all files to data frames
activities<-read.table("UCI HAR Dataset/activity_labels.txt",col.names = c("code","activity"))
features<-read.table("UCI HAR Dataset/features.txt",col.names = c("num","feature"))

subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt",col.names = c("subject"))
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt",col.names = c("subject"))

X_test<-read.table("UCI HAR Dataset/test/X_test.txt",col.names = features$feature)
X_train<-read.table("UCI HAR Dataset/train/X_train.txt",col.names = features$feature)

y_test<-read.table("UCI HAR Dataset/test/y_test.txt",col.names = "code")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt",col.names = "code")


#Merging data of test and train 
all_x<-rbind(X_test,X_train)
all_y<-rbind(y_test,y_train)
all_subject<-rbind(subject_test,subject_train)

final_data<-cbind(all_subject,all_y,all_x)

#Selecting all variables based on mean and standard deviation calculation

tidy_data<-select(final_data,subject,code,contains("mean"),contains("std"))

#Give descriptive names to activities in the tidy dataset from the activities dataset
tidy_data$code<-activities[tidy_data$code,2]


#Give descriptive names to tidy dataset variables
names(tidy_data)[1] = "Subject"
names(tidy_data)[2] = "Activity"
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data)<-gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("angle", "Angle", names(tidy_data))
names(tidy_data)<-gsub("gravity", "Gravity", names(tidy_data))


#Get average of each variable for each activity and each subject

avg_final_data<- tidy_data %>%
  group_by(Subject,Activity) %>%
  summarise_all(funs(mean))

#Write the final dataset to text file
write.table(avg_final_data,"tidydata.txt",row.name = FALSE)
