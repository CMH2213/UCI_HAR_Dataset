#Getting and Cleaning Data Course Project 

#See README.md and CodeBook.md for further analysis detail and description of the 
#variables, the data, and any transformations or work performed to clean up the 
#data

#set the data directory 
WD <- getwd()
if (!is.null(WD)) setwd(WD) 

#load the data
library(data.table)
library(dplyr)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./Dataset.zip",method = "curl")
dateDownloaded <- date()
unzip("./Dataset.zip") #save unzipped files to local directory

# load the variables into RStudio for processing/analysis
train_X <- read.table("UCI HAR Dataset/train/X_train.txt",colClasses = "numeric", comment.char = "",fill = TRUE)
train_y <- read.csv("UCI HAR Dataset/train/y_train.txt",header = FALSE, sep = "")
train_subject <- read.csv("UCI HAR Dataset/train/subject_train.txt",header = FALSE, sep = "")

test_X <- read.table("UCI HAR Dataset/test/X_test.txt",colClasses = "numeric", comment.char = "",fill = TRUE)
test_y <- read.csv("UCI HAR Dataset/test/y_test.txt",header = FALSE, sep = "")
test_subject <- read.csv("UCI HAR Dataset/test/subject_test.txt",header = FALSE, sep = "")

features <- read.csv("UCI HAR Dataset/features.txt",header = FALSE, sep = "",stringsAsFactors = FALSE)
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt",header = FALSE, sep = "",stringsAsFactors = FALSE)

# Merge the training and the test sets to create one data set called trainPlustest.
# update column names with proper descriptors
train_data <- data.frame(train_subject,train_y,train_X)
names(train_data) <- c(c('Subject', 'Activity'), features[,2])
test_data <- data.frame(test_subject,test_y,test_X)
names(test_data) <- c(c('Subject', 'Activity'), features[,2])

trainPlustest  <- rbind(train_data,test_data) # merged single data set

# Extracts only the measurements on the mean and standard deviation 
# for each measurement
# save to variable meanStd_subset
meanStd_cols <- grep("mean|std", features[,2])
meanStd_subset <- trainPlustest[,c(1,2,(meanStd_cols+2))]

# Use descriptive activity names to name the activities in the data set
# activity_labels links the variable to the activity name
meanStd_subset$Activity <- activity_labels[meanStd_subset$Activity,2]

# Appropriately labels the data set with descriptive variable names.

names(meanStd_subset) <- gsub("^t", "Time", names(meanStd_subset))
names(meanStd_subset) <- gsub("^f", "Freq", names(meanStd_subset))
names(meanStd_subset) <- gsub("[/(/)]", "", names(meanStd_subset))
names(meanStd_subset) <- gsub("-mean-", "Mean", names(meanStd_subset),fixed = TRUE)
names(meanStd_subset) <- gsub("-std-", "StandardDeviation", names(meanStd_subset),fixed = TRUE)
names(meanStd_subset) <- gsub("-meanFreq-", "MeanFrequency", names(meanStd_subset),fixed = TRUE)
names(meanStd_subset) <- gsub("-mean$", "Mean", names(meanStd_subset))
names(meanStd_subset) <- gsub("-std$", "StandardDeviation", names(meanStd_subset))
names(meanStd_subset) <- gsub("-meanFreq$", "MeanFrequency", names(meanStd_subset))
names(meanStd_subset) <- gsub("BodyBody", "Body", names(meanStd_subset))

# create a second, independent tidy data set TidyOutput.txt with the average of each variable 
# for each activity and each subject.
TidyOutput <- meanStd_subset %>% group_by(Activity,Subject) %>%
  summarise_all(list(VariableMean = mean))

# create a final output file of the tidy data
write.table(TidyOutput, "TidyOutput.txt", row.names=FALSE)
