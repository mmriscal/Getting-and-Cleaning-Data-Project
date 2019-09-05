# Getting-and-Cleaning-Data-Project
Project for the Getting and Cleaning Data course on JHU (week 4)

This code clean and sort the data collected from the accelerometers from the Samsung Galaxy S smartphone.

1. Merges the training and test sets to create one data set

Note: the working directory contains a folder called UCI HAR Dataset with all the important files. 
The names of the variables is taken from "features.txt"
The resulting data frame is called Experiment and has the following variables:

    column 1 -> Experiment: test or train
    column 2 -> Subject: number of the subject (from 1 to 30)
    column 3 -> Activity: kind of activity (from 1 to 6)
    columns 4:564 -> Vector of data from accelerometer

2. Extracts only the measurements on the mean and standard deviation for each measurement.

Analizing the text with regular expresions, it extracts only the variables in which the name contains "mean" or "std", and create a new data frame called Experiment_mean with only those variables.

3. Uses descriptive activity names to name the activities in the data set

Using the text file "activity_labels.txt" it changes the numbers in the column "Activity" for their proper names.
