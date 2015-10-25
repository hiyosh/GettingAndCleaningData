run_analysis <- function() {
  # File description:
  # 1. Merges the training and the test sets to create on data set
  # 2. Extracts only the measurements on the mean and standard deviation on each measurement
  # 3. Uses descriptive activity names to name the activities in the data set
  # 4. Appropriately labels the data set with descriptive variable names
  # 5. From the data set in step 4, creates a second, independent tidy data set with
  #    the average of each variable for each activity and each subject

  # Source files
  library(dplyr)
  
  # Read in the files that will act as column names first
  features <- read.table("./features.txt")
  activitylabels <- read.table("./activity_labels.txt")
  names(activitylabels)<- c("activityLabelValue", "activityLabel")
  
  # Read in all of the data for train and test by pieces
  subject_test <- read.table("./subject_test.txt") 
  subject_train <- read.table("./subject_train.txt")
  x_test <- read.table("./X_test.txt")
  x_train <- read.table("./X_train.txt")
  y_test <- read.table("./y_test.txt")
  y_train <- read.table("./y_train.txt")
  
  # (Step #1) Merge the subject data/x data/y data together and
  # (Step #4) provide a name for each column
  subject_data <- rbind(subject_test, subject_train)
  names(subject_data) <- c("volunteer_id")
  x_data <- rbind(x_test, x_train)
  names(x_data) <- features$V2
  y_data <- rbind(y_test, y_train)
  names(y_data) <- c("activity_label_value")
  
  # (Step #2) Filter only interesting columns from x_data that have -mean() or -std() in them
  interestingColumns <- grepl("-mean\\(\\)|-std\\(\\)", features$V2)
  x_data <- x_data[,interestingColumns]
  
  alldata <- cbind(subject_data, x_data, y_data)
  
  # (Step #3) Append the human readable label for the y activity using activitylabels as a lookup table
  alldata <- (merge(alldata,activitylabels, by.x = 'activity_label_value', by.y = 'activityLabelValue'))
  
  # (Step #5) Creates a tidy data set with the average of each variable
  # for each activity and each subject
  newTidyDataSet <- alldata %>% group_by(volunteer_id, activityLabel) %>% summarise_each(funs(mean), -c(activity_label_value))
  
  # Rename the column names for the values, calling them "Mean(XXX)" instead of just XXX
  oldcolnames <- names(newTidyDataSet)
  newcolnames <- c(oldcolnames[1], oldcolnames[2], paste("Mean(", oldcolnames[3:length(oldcolnames)], ")"))
  names(newTidyDataSet) <- newcolnames
  
  newTidyDataSet
}
