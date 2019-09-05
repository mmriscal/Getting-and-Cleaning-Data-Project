####################
## COURSE PROJECT ## 
####################


# 1. Merges the training and the test sets to create one data set.

# Starting with test. First we read data
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Create a data frame with this three variables (X, Y, subjects)
test <- data.frame(subjects_test, Y_test, X_test)

# Rename the variables
colnames(test)[1] <- "Subject"
colnames(test)[2] <- "Activity"

# 4.Appropriately labels the data set with descriptive variable names
# Using the names in features.txt
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
for(i in 3: ncol(test)) {colnames(test)[i] <- features[[2]][i-2]}

# And we do the same with train
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- data.frame(subjects_train, Y_train, X_train)
colnames(train)[1] <- "Subject"
colnames(train)[2] <- "Activity"
for(i in 3: ncol(train)) {colnames(train)[i] <- features[[2]][i-2]}

# We add one new variable to specify whether it is performing a train or a test experiment
test$Experiment <- rep("test", nrow(test))
train$Experiment <- rep("train", nrow(train))

# We want to change the position of the new column (experiment) to the first place
test <- test[,c(564,1,2,3:563)]
train <- train[, c(564,1,2,3:563)]

# And merge the two tables by all the columns. Actually, is like we add the rows
Experiment <- merge(train, test, by = intersect(names(train), names(test)),  all = TRUE, sort = TRUE)



# --------------------
library(stringr)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# From features.txt we can extract the positions of the variables that measure mean and std
pos <- grepl("(mean|std)", features[[2]])

Experiment_mean <- Experiment[, pos]



# --------------------

# 3. Uses descriptive activity names to name the activities in the data set
install.packages("plyr")
library(plyr)

labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)

for (i in 1:nrow(labels))
{
        Experiment$Activity[Experiment$Activity == i] <- paste(labels[[2]][i])
}



# --------------------

# 4.Appropriately labels the data set with descriptive variable names.

# (Already done previously)




# --------------------

# 5.From the data set in step 4, creates a second, independent tidy data set
#   with the average of each variable for each activity and each subject.

library(dplyr)

# Note: we forget about the variable experiment=("test", "train") because it is not wanted

# I found the maximum number of subject among the two experiments
n <- max(subjects_test[[1]], subjects_train[[1]])

Averages <- data.frame()

# "row" is a vector with the mean of all the variables for a single activity and a single subject.
# In the j loop we change the subject while in the i loop we change the activity.
# Once we filter by activity and subject, we group_by and summarise the mean.
# Finally, we add the new row to the Averages data frame.

for (i in 1:nrow(labels))
{
        for (j in 1:n)
        {
                row <- Experiment %>% 
                            filter(Activity == labels[[2]][i]) %>%
                            filter(Subject == j)  %>%
                            group_by(Activity)    %>% 
                            summarise_if(is.numeric, mean, na.rm = TRUE)
                
                Averages <- rbind(Averages, row)  
        }
}

write.table(Averages, file = "DataSet_sorted.txt", row.name=FALSE)













