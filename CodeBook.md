#Getting and Cleaning Data
##Codebook

Sven Richters

A full description of the data used in this project can be found at here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data for this project can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the authores captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Attribute Information

For each record in the dataset it is provided:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.
Section 1. Merge the training and the test sets to create one data set.

## R Script
The script run_analysis.R performs the 5 steps in the assignment

### 1 Merge Data

First the training and test data files are loaded into R using read.table and merged using the cbind() and rbind() commands. Resulting testData and trainingData are then merged together once again using cbind(). All dataframes are verified using head()

### 2 Extract measurement for mean and standard deviation

Columns with the mean and standard deviation measures are extracted from the dataset using the logical vector "logicVector". The resulting subset "subData" is then inspected using the head() command

### 3 Uses descriptive activity names to name the activities in the data set
The resulting frame subData is merged with the acticit descriptions

### 4 Clean up column names
For the subData frame, columns with unclear column names are corrected using the gsub() command

### 5 Create Tidydata
A new dataset tidyData is created, containing all the average measures for each subject and acticity type, containing 180 observations. The output file is created

## Variables
xTrain, yTrain, xTest, yTest, subjectTrain and subjectTest contain the raw downloaded data
trainingData and testData, contained the merged datsets 
Data contains the completed dataset
logicVector contains the argument to extract subData
acticityType contains the activity types
subData contains the subset created in step 2
tidyData contains the final dataset featuring the relevant averages

