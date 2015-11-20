##Repo Description
This repo is part of the final course project assignment from Coursera's Getting and Cleaning Data course.  Three items are part of the assignment:
-README.md, this document
-Codebook.md, high-level description of the analysis and detailed description of the data
-run_Analysis.R, the R script which performs the assigned analysis

##README Description
This document serves to explain the steps taken in the R script, with description of my reasoning where appropriate
It is structured as follows:
-Assignment
-Input raw data
-Assignment part 1
-Assignment part 2
-Assignment part 3
-Assignment part 4
-Assignment part 5
-Note on final form chosen for tidy data set

##Assignment
Taken directly from course assignment page, https://class.coursera.org/getdata-034/human_grading/view/courses/975118/assessments/3/submissions
  The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

  One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

  Here are the data for the project:

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

  You should create one R script called run_analysis.R that does the following.

    1.  Merges the training and the test sets to create one data set.
    2.  Extracts only the measurements on the mean and standard deviation for each measurement.
    3.  Uses descriptive activity names to name the activities in the data set
    4.  Appropriately labels the data set with descriptive variable names.
    5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  Good luck!

##Input raw data
The raw data for this assignment exist in eight different files, each of which need to be loaded separately.  They are all stored in a directory "/UCI HAR Dataset", which sits in the working directory.  The vector of data labels, features.txt, and activity labels, activity_labels.txt.  The data had been split into two different sets, for training and testing purposes.  Each of these sits in their own folder, "/UCI HAR Dataset/train" and "/test", respectively.  Within the training folder sit subject_train.txt, a vector of the subject of each observation, y_train.txt, a vector of the activities being performed in each observation, and X_train.txt, a matrix of 561 different observations of data.  The data structure is analogous for "/test".

For more description of the raw data, see the CodeBook.md file in this repo https://github.com/jmmark/TidyAssignment

##Assignment part 1
The first thing that needs to be done is to load all of the separate pieces of data, which can be done with read.table.  For the labels files, I found it useful to set stringsAsFactors to FALSE, so that makes it marginally easier to manipulate them later.  Also for the labels taking the subset of the second column of the original table converts them to character vectors, useful later.

Once the data are loaded, the question becomes how to stitch them together.  The subject and activity vectors have the same length and order as the overall data matrix, for each of the testing and training data set.  They are bound to the main data using cbind for each of the training and testing subsets, and the resulting matrices are bound together using rbind.  This could be done in either combination, but binding the columns first made it easier for me conceptually.

The final step here is to add the column names using the colnames() function.  The activity and subject vectors were added at the end, so two column names need to be appended to the names from features.txt to get names for all of the columns in the data set.

Note: The features.txt file contains a small number of non-unique label names.  I chose not to address this, as those columns end up being dropped in the next step in any case.

##Assignment part 2
The assignment tells us to keep the measurements of the mean and standard deviation of the observations.  This information is stored in the column name: those that contain "mean()" or "std()" in their name are what we are looking for.  In addition to the variables which actually measure the mean or standard deviation of the signal, some variables measure the angle between other variables, which may contain "mean".  We do not want these, so we want to be sure we include "()" in the selection criteria.

The actual selection is done by subsetting the dataset and using the grep() function to identify the proper columns.  grep() searches a passed character vector for a passed pattern, which can take regular expressions.  Since "(" and ")" are reserved characters in regular expressions, they either need to be escaped or placed in square brackets--I chose to use square brackets.

Note: I chose to use the subset(grep()) approach rather than the select(contains()) approach in dplyr because the repeat column names caused some trouble for dplyr

##Assignment part 3
There are many different ways to change the integer labels currently held in the Activity_Labels variable--merge, a series of assignment statements, etc.  I chose to convert the variable to a factor, and use the descriptive activity labels to label the levels of the factor using the factor() function.

##Assignment part 4
Renaming the variables to make them more readable is pretty subjective--one could even argue that the variables are already well named.  I chose to use a more regular structure which would both make it more readable (to my eye) and make it easier to melt the data set should I decide to later.

I chose to rename everything using the following convention:
Names take the following pattern: *Domain_Force_Device_MeasType_Dimension_CalcType*, where:
*  Domain_ is the wave Domain of the signal: Time or Freq(uency)
*  Force_ is the source of the force: Body or Grav(ity)
*  Device_ is the device generating the signal: Accel(erometer) or Gyro(scope)
*  MeasType_ is whether the signal is a standard signal or a derived Jerk signal: Stan(dard) or Jerk
*  Dimension_ is whether the signal was in the X, Y, or Z axis, or is the euclidian norm: X, Y, Z, or Norm
*  CalcType_ is the summary measure applied: Mean or StDev

Functionally I do this using the sub() function, which finds one pattern in a vector and replaces it with another, and the column names as a character vector.  This took several steps, but was much shorter than changing things by hand.

Note: In this process I changed the order of the Mean or StDev from the middle of the variable name to the end.  I did this solely for more practice with regular expressions.

##Assignment part 5
The first part of this is made very straightforward with dplyr.  First I use group_by() to group the data set by both Activity and Subject, and then summarize_each() to apply the mean() function to each of the other variables, grouped by Activty and Subject.  I put the two together using the chain operator, "%>%", rather than assigning it to an intermediate variable.

After many different intermediate versions of the script, I ultimately decided that the form the data is now in it's best tidy format, so all that is left to do is write it out using write.table()

##Note on final form chosen for tidy data set
This was the part of this assignment I spent the most time going back and forth on.  I started out with the option that the variable names really were variables themselves that described the observation, and so I should melt and deconstruct the column names, with a single numeric column reading signal.  However, I had two problems with this--first, the units reported by the Accelerometer and the Gyroscope are different, so they should not be in the same column in a tidy data set, and second mean() and standard deviation() seem to be two different observations.  I tried spreading the data back out along those axes, but since there are relatively fewer observations from the Gyroscope this ended up adding a large number of NA's, actually making the data messier.

At the end of the day I talked myself around to the point of view that the 66 columns really are separate variables relating to the observation of the subject/activity pair and shouldn't be combined.  Finally I went back and checked the three criteria from Hadley Wickham's tidy data paper http://vita.had.co.nz/papers/tidy-data.pdf

1.  Each variable forms a column.
2.  Each observation forms a row.
3.  Each type of observational unit forms a table

The data as it came out of the final step satisfied these three statements and makes the most sense internally, and so I chose to submit this form.
