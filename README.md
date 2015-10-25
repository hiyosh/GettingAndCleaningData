==================================================================
#Getting and Cleaning Data
Course Project
==================================================================

This contains the following files:
==================================================================

- README.txt

- Run_Analysis.R : The file contains a function run_analysis() that does the following:
  
  - Read in the files that will act as column names first
  - Read in all of the data for train and test by pieces
  - Merge the subject data/x data/y data together and
  -  provide a name for each column
  - Filter only interesting columns from x_data that have -mean() or -std() in them
  - Append the human readable label for the y activity using activitylabels as a lookup table
  - Creates a tidy data set with the average of each variable
     for each activity and each subject
  - Rename the column names for the values, calling them "Mean(XXX)" instead of just XXX

- RunAnalysisCodeBook.txt : Code book describing the results of RunAnalysis.R.

Notes:
==================================================================
- Run_Analysis.R assumes that the following files are in the same directory:
	- features.txt
	- activity_labels.txt
	- subject_test.txt
	- subject_train.txt
	- X_test.txt
	- X_train.txt
	- y_test.txt
	- y_train.txt