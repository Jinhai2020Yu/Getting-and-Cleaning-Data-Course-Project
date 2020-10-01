#Create a R project and set working directory

#1.0 Download data set

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data.zip", "curl")
unzip(zipfile = "data.zip")

#1.1 Read files

#1.1.1 Read train files and check dim

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
dim(x_train)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
dim(y_train)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
dim(subject_train)

#1.1.2 Read test files and check dim

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
dim(x_test)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
dim(y_test)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
dim(subject_test)

#1.1.3 Read activity labels and check dim

Activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
dim(Activity_labels)

#1.1.4 Read features and check dims

Features <- read.table("UCI HAR Dataset/features.txt")
dim(Features)

#1.2 Rename the column names of each file
colnames(x_train) <- Features[, 2]
colnames(x_test) <- Features[, 2]
colnames(y_train) <- "activity_label"
colnames(y_test) <- "activity_label"
colnames(subject_train) <- "subject"
colnames(subject_test) <- "subject"
colnames(Activity_labels) <- c("activity_label", "activity")

#1.3 Combine data

#1.3.1 combine train/test files

train <- cbind(y_train, subject_train, x_train)
test <- cbind(y_test, subject_test, x_test)
dim(train)
dim(test)

#1.3.2 combine train and test

m_data <- rbind(train, test)
dim(m_data)

#2.0 Extract mean and sd of measurements

all_names <- colnames(m_data)

#2.1 Find mean/sd column position

P <- grepl("activity_label", all_names) | grepl("subject", all_names) | grepl("mean..", all_names) | grepl("std..", all_names)

#2.2 Subset data

summary_data <- m_data[, P == TRUE]

#3.0 Merge subsetted data with Activity_labels file by "activity_label"

tidydata1 <- merge(summary_data, Activity_labels, by = "activity_label", all.x = TRUE)

#4.0 Appropriately labels the data set with descriptive variable names

names(tidydata1) <- gsub("Acc", "accelerometer", names(tidydata1))
names(tidydata1) <- gsub("Gyro", "gyroscope", names(tidydata1))
names(tidydata1) <- gsub("BodyBody", "body", names(tidydata1))
names(tidydata1) <- gsub("Mag", "magnitude", names(tidydata1))
names(tidydata1) <- gsub("^t", "time", names(tidydata1))
names(tidydata1) <- gsub("^f", "frequency", names(tidydata1))

# 5.0 Average data

library(dplyr)
tidydata2 <- tidydata1 %>% select(-(activity_label)) %>% 
        group_by(subject, activity) %>% summarise_all(mean)
write.table(tidydata2, "tidydata2.txt", row.names = FALSE)