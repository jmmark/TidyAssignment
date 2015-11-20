## Script for Getting and Cleaning Data course project
## assumes raw data sits in ./UCI HAR Dataset
## assumes filenames and folder structure as downloaded

##load libraries up front
library(dplyr)


## Part 1 - sew all the data together
## Data starts in several pieces--three training sets, three test sets, and data labels

## first read all the data labes in as a string, as well as activity labels

myPath <- "./UCI HAR Dataset"
varNames <- read.table(paste(myPath, "features.txt", sep="/")
                       , header = FALSE, stringsAsFactors = FALSE)[,2]
actLabels <- read.table(paste(myPath, "activity_labels.txt", sep="/")
                       , header = FALSE, stringsAsFactors = FALSE)[,2]

actLabels <- sub("^([A-Z])(.*)","\\U\\1\\L\\2",actLabels,perl=TRUE)


## now read in all of the train componenets--main data, activity ID, subject ID
trainData <- read.table(paste(myPath, "train", "X_train.txt", sep = "/"), header = FALSE)
trainActivity <- read.table(paste(myPath, "train", "y_train.txt", sep = "/"), header = FALSE)
trainSubject <- read.table(paste(myPath, "train", "subject_train.txt", sep = "/"), header = FALSE)

## now read in all of the test components
testData <- read.table(paste(myPath, "test", "X_test.txt", sep = "/"), header = FALSE)
testActivity <- read.table(paste(myPath, "test", "y_test.txt", sep = "/"), header = FALSE)
testSubject <- read.table(paste(myPath, "test", "subject_test.txt", sep = "/"), header = FALSE)

## cbind all train items and all test items to keep observations aligned
trainAll <- cbind(trainData, trainActivity, trainSubject)
testAll <- cbind(testData, testActivity, testSubject)

## rbind to combine into single data set, remove all intermediates
fullUCIHAR <- rbind(trainAll, testAll)
rm("trainData", "trainActivity","trainSubject",
     "testData","testActivity","testSubject")

##add column names
colnames(fullUCIHAR) <- c(varNames, "Activity_Labels", "Subject_Labels")

## part 1 complete!

##for part 2, subset using grep
##keep the activity and subject labels in there
subcolsUCIHAR <- fullUCIHAR[,grep("mean[(]|std[(]|Label", colnames(fullUCIHAR))]

## part 2 complete!

##for part 3, convert Activity_Labels to a factor
##add appropriate labels given in the activity_labels.txt file
subcolsUCIHAR[,"Activity_Labels"] = factor(subcolsUCIHAR[,"Activity_Labels"],labels=actLabels)

## part 3 complete!

##part 4 is renaming the variables
##use the following pattern:
##Domain_Force_Device_MeasType_Dimension_CalcType
##Where:
##Domain_ is the wave Domain of the signal: Time or Freq(uency)
##Force_ is the source of the force: Body or Grav(ity)
##Device_ is the device generating the singal: Accel(erometer) or Gyro(scope)
##MeasType_ is whether the signal is a standard signal or a derived Jerk signal: Stan(dard) or Jerk
##Dimension_ is whether the signal was in the X, Y, or Z axis, or is the euclidian norm: X, Y, Z, or Norm
##CalcType_ is the summary measure applied: Mean or StDev

##Step one is to hold the column names in a separate vector for transformation
newColNames <- colnames(subcolsUCIHAR)

##now perform the transformations - remembering sometimes Body is repeated
##us sub and regex to avoid having to rename things individually
newColNames <- sub("BodyBody","Body", newColNames)
newColNames <- sub("^f","Freq_", newColNames)
newColNames <- sub("^t","Time_", newColNames)
newColNames <- sub("Body","Body_", newColNames)
newColNames <- sub("Gravity","Grav_", newColNames)
newColNames <- sub("Acc[-Mag]{1,4}","Accel_Stan_", newColNames)
newColNames <- sub("AccJerk[-Mag]{1,4}","Accel_Jerk_", newColNames)
newColNames <- sub("Gyro[-Mag]{1,4}","Gyro_Stan_", newColNames)
newColNames <- sub("GyroJerk[-Mag]{1,4}","Gyro_Jerk_", newColNames)
newColNames <- sub("-([XYZ])$","_\\1",newColNames)
newColNames <- sub("(\\(\\))$","\\1_Norm",newColNames)
newColNames <- sub("(.*)_mean\\(\\)(.*)","\\1\\2_Mean", newColNames)
newColNames <- sub("(.*)_std\\(\\)(.*)","\\1\\2_StDev", newColNames)
newColNames[67] <- "Activity"
newColNames[68] <- "Subject"

##finally reapply the colnames
colnames(subcolsUCIHAR) <- newColNames

##part 4 complete!

##for part 5, calculate the mean of 
##each variable by Activity and Subject--dplyr makes this quick


##find the mean using dplyr
tidyOut <- group_by(subcolsUCIHAR, Subject, Activity) %>%
    summarize_each("mean")

##After careful consideration, file is already in the best 
##tidy format--collapsing the columns is not warrented

##part 5 complete!  All that's left to do is write out the table

write.table(tidyOut, file = "Tidy_Assignment_Table.txt", row.names = FALSE)
