CODEBOOK.md

DATA
One of the most exciting areas in all of data science right now is 
wearable computing - see for example this article . Companies like 
Fitbit, Nike, and Jawbone Up are racing to develop the most advanced 
algorithms to attract new users. The data linked to from the course 
website represent data collected from the accelerometers from the 
Samsung Galaxy S smartphone. A full description is available at the 
site where the data was obtained:
  
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
  
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


VARIABLES

1. check for a working directory and if it doesn't exist create it
WD <- getwd()

2. Download data and variables into RStudio environment
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


train_X:   7352 obs. of 561 variables <- Training set
train_y:   7352 obs. of 1 variable    <- Training labels

test_X:   2947 obs. of 561 variables  <- Test set
test_y:   2947 obs. of 561 variables  <- Test labels

features:  561 obs. of 561 variables   <- List of all features
activity_labels: 6 obs. of 2 variables <- Links the class labels with their  
                                          activity name

3. Merged Data: - Merges the training and the test sets to create one data set.

train_data: 7352 obs. of 563 variables <- merged training set w/ training   
                                          labels
test_data: 2947 obs. of 563 variables  <- merged test set with test labels


trainPlustest: 10299 obs. of 563 variables  <- merged traing set plus test 
                                               set 

4. Extracts only the measurements on the mean and standard deviation 
    for each measurement.

meanStd_subset: 10299 obs. of 81 variables  <- subset of merged set of only 
                                               mean and standard deviation  
                                               features

5. Appropriately label the data set with descriptive variable names.

 - replace "t" with "Time"
 - replace "f" with "Freq"
 - remove "()" 
 - replace "mean" with "Mean"
 - replace "std" with "StandardDeviation"
 - replace "meanFreq" with "MeanFrequency"
 - replace "-mean" with "Mean"
 - replace "-std" with "StandardDeviation"
 - replace "-meanFreq" with "MeanFrequency"
 - replace "BodyBody" with "Body"

 
From the data set in step 5, creates a second, independent tidy 
data set with the average of each variable for each activity and 
each subject.

6.creates a second, independent tidy data set with the average of each variable for each activity and each subject


TidyOutput.txt: 180 obs. of 81 variables   <- output file
