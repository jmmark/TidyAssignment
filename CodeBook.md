---
title: "Tidy Data Assignment Codebook"
author: "Jake Markman"
date: "11/19/2015"
output:
  html_document:
    keep_md: yes
---

## Project Description
Final project for Coursera course Getting and Cleaning Data.  Paraphrasing the instructions: Assemble, subset, summarize, and tidy the assigned data

##Study design and data processing

###Collection of the raw data
From the README.txt provided with the raw data:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.  

Data can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Notes on the original (raw) data
Further description can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Creating the tidy datafile

###Guide to create the tidy data file
1.  Download the data from the link shown above
2.  Unzip download into your R working directly
3.  Source run_Analysis.R in R NOTE--requires dplyr package be installed
4.  Tidy data will be in your workspace as tidyOut, and written to Tidy_Assignment_Table.txt in your working directory

###Cleaning of the data
run_Analysis.R performs the following:
  -Read in all components of the raw data from the text files, including labels
  -Bind the subject and activity ID columns to the main data for both test and training sets
  -Bind the test and training data subsets into one data set
  -Assign column names to the data set
  -Subset the data to keep only the variables which contain mean() or std() in the name
  -Replace the integer activity labels with descriptive labels via converting to a factor
  -Rename the numeric variables for ease of understanding
  -Find the mean of each numeric variable, grouped by subject and activity
  -The dataset is now tidy! Write it to a .txt file

See README.md in this repo https://github.com/jmmark/TidyAssignment for more detailed description

##Description of the variables in the Tidy_Assignment_Table.txt file
180 obs. of  68 variables  
Variable names:  
 [1] "Subject"                         "Activity"                        "Time_Body_Accel_Stan_X_Mean"     "Time_Body_Accel_Stan_Y_Mean"      
 [5] "Time_Body_Accel_Stan_Z_Mean"     "Time_Body_Accel_Stan_X_StDev"    "Time_Body_Accel_Stan_Y_StDev"    "Time_Body_Accel_Stan_Z_StDev"     
 [9] "Time_Grav_Accel_Stan_X_Mean"     "Time_Grav_Accel_Stan_Y_Mean"     "Time_Grav_Accel_Stan_Z_Mean"     "Time_Grav_Accel_Stan_X_StDev"     
[13] "Time_Grav_Accel_Stan_Y_StDev"    "Time_Grav_Accel_Stan_Z_StDev"    "Time_Body_Accel_Jerk_X_Mean"     "Time_Body_Accel_Jerk_Y_Mean"      
[17] "Time_Body_Accel_Jerk_Z_Mean"     "Time_Body_Accel_Jerk_X_StDev"    "Time_Body_Accel_Jerk_Y_StDev"    "Time_Body_Accel_Jerk_Z_StDev"     
[21] "Time_Body_Gyro_Stan_X_Mean"      "Time_Body_Gyro_Stan_Y_Mean"      "Time_Body_Gyro_Stan_Z_Mean"      "Time_Body_Gyro_Stan_X_StDev"      
[25] "Time_Body_Gyro_Stan_Y_StDev"     "Time_Body_Gyro_Stan_Z_StDev"     "Time_Body_Gyro_Jerk_X_Mean"      "Time_Body_Gyro_Jerk_Y_Mean"       
[29] "Time_Body_Gyro_Jerk_Z_Mean"      "Time_Body_Gyro_Jerk_X_StDev"     "Time_Body_Gyro_Jerk_Y_StDev"     "Time_Body_Gyro_Jerk_Z_StDev"      
[33] "Time_Body_Accel_Stan_Norm_Mean"  "Time_Body_Accel_Stan_Norm_StDev" "Time_Grav_Accel_Stan_Norm_Mean"  "Time_Grav_Accel_Stan_Norm_StDev"  
[37] "Time_Body_Accel_Jerk_Norm_Mean"  "Time_Body_Accel_Jerk_Norm_StDev" "Time_Body_Gyro_Stan_Norm_Mean"   "Time_Body_Gyro_Stan_Norm_StDev"   
[41] "Time_Body_Gyro_Jerk_Norm_Mean"   "Time_Body_Gyro_Jerk_Norm_StDev"  "Freq_Body_Accel_Stan_X_Mean"     "Freq_Body_Accel_Stan_Y_Mean"      
[45] "Freq_Body_Accel_Stan_Z_Mean"     "Freq_Body_Accel_Stan_X_StDev"    "Freq_Body_Accel_Stan_Y_StDev"    "Freq_Body_Accel_Stan_Z_StDev"     
[49] "Freq_Body_Accel_Jerk_X_Mean"     "Freq_Body_Accel_Jerk_Y_Mean"     "Freq_Body_Accel_Jerk_Z_Mean"     "Freq_Body_Accel_Jerk_X_StDev"     
[53] "Freq_Body_Accel_Jerk_Y_StDev"    "Freq_Body_Accel_Jerk_Z_StDev"    "Freq_Body_Gyro_Stan_X_Mean"      "Freq_Body_Gyro_Stan_Y_Mean"       
[57] "Freq_Body_Gyro_Stan_Z_Mean"      "Freq_Body_Gyro_Stan_X_StDev"     "Freq_Body_Gyro_Stan_Y_StDev"     "Freq_Body_Gyro_Stan_Z_StDev"      
[61] "Freq_Body_Accel_Stan_Norm_Mean"  "Freq_Body_Accel_Stan_Norm_StDev" "Freq_Body_Accel_Jerk_Norm_Mean"  "Freq_Body_Accel_Jerk_Norm_StDev"  
[65] "Freq_Body_Gyro_Stan_Norm_Mean"   "Freq_Body_Gyro_Stan_Norm_StDev"  "Freq_Body_Gyro_Jerk_Norm_Mean"   "Freq_Body_Gyro_Jerk_Norm_StDev"   
>

###Variable 1
Name: Subject
Class: integer
Values: [1:30]
Units: N/A

Unique integer ID for the subject being observed, ranges from 1-30

###Variable 2
Name: Activity  
Class: Factor  
Values:  
  1:Walking  
  2:Walking_upstairs  
  3:Walking_downstairs  
  4:Sitting  
  5:Standing  
  6:Laying  
Units: N/A  

Description of what subject was doing during the observation

###Variables 3-66
Name: Descriptive name representing how the observation was taken, as follows:  
  Names take the following pattern: Domain_Force_Device_MeasType_Dimension_CalcType, where:  
    Domain_ is the wave Domain of the signal: Time or Freq(uency)  
    Force_ is the source of the force: Body or Grav(ity)  
    Device_ is the device generating the signal: Accel(erometer) or Gyro(scope)  
    MeasType_ is whether the signal is a standard signal or a derived Jerk signal: Stan(dard) or Jerk  
    Dimension_ is whether the signal was in the X, Y, or Z axis, or is the euclidian norm: X, Y, Z, or Norm  
    CalcType_ is the summary measure applied: Mean or StDev  
Class: numeric  
Values:[-1 to 1]  
Units: Data from the Accelerometer were recorded standard gravity units (g's), and data from the Gyroscope as Radians / Second.
  Data have been normalized and bounded in [-1,1]  

Observation of the motion recorded in the [Time/Frequency] domain, generated by [Body/Gravity], recorded on the [Accelerometer/Gyroscope], measured as a [Standard/Jerk] signal, in the [X/Y/Z/Normalized]-axis direction, summarized as [Mean/StDev]  

##Sources
The template for this codebook came from:  
https://gist.github.com/JorisSchut/dbc1fc0402f28cad9b41
