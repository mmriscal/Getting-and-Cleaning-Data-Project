# Getting-and-Cleaning-Data-Project
Project for the Getting and Cleaning Data course on JHU (week 4)

"run_analysis.R" performs an analysis on the data collected from the accelerometers of the Samsung Galaxy S smartphone.

1. Merges the training and test sets to create an unique data set

The working directory contains a folder called UCI HAR Dataset with all the files about labels, subjects, etc. 
The variables names are appropriately labeled using the names from "features.txt"
The resulting data frame is called Experiment and has the following variables:

    column 1 -- Experiment: test or train
    column 2 -- Subject: number of the subject (from 1 to 30)
    column 3 -- Activity: kind of activity (from 1 to 6)
    columns 4:564 -- Vector of data from accelerometer

2. Extracts only the measurements on the mean and standard deviation for each measurement.

Analizing the text with regular expresions, it extracts only the variables in which the name contains "mean" or "std", and create a new data frame called Experiment_mean with only those variables. Note that it will include the mean of the frecuency components and the additional vectors obteined by averaging the signals.

3. Uses descriptive activity names to name the activities in the data set

Using the text file "activity_labels.txt" it changes the numbers in the column "Activity" for their proper names. We do this on Experiment_mean

4. From Experiment_mean, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It filters the data set first by activity and then by subject. For each activity, it calculates the average of each variable for all the subjects (maximum number is taken from comparing subject_train and subject_test). 

The resulting data set is called Averages and it is saved in disk as "Tidy_Data_Set.txt". Averages has the following variables:

    column 1 -- Activity: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
    column 2 -- Subject: a number from 1 to 30 sorted by activity
    columns 3:81 -- Vector of data from accelerometer but only the measurements on the mean and standar deviation.

The original data is available through https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


