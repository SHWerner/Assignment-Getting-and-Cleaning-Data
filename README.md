# Assignment-Getting-and-Cleaning-Data
Repository for the Coursera Course: Getting and Cleaning Data


# Run_analysis script - instructions

The script runs as a function, the parameter to be passed is the directory where the data has been unzipped. "UCI HAR Dataset" is a subdirectory within that directory, it is assumed that a directory named that way that contains all the data files in its original directory tree are present.


# Output

The script writes down in the directory passed two files:
"tidy_data.txt" -> is the result of step 4 of the assignment
"means_tidy_data.txt" -> is the result of step 5 of the assignment

# How it works

The script goes through each step of the assignement sequentially

Step 0: Reading the datasets
    "X_trainData" stores the X training data set 
    "Y_trainData" stores the Y training data set 
    "trainSubject" stores the training subject data set 

    "X_testData" stores the X test data set
    "Y_testData" stores the Y test data set
    "testSubject" stores the test subject data set
    
Step 1: Merges the datasets and creates a single dataset

    "X_mergedData" stores the merged X data set
    "Y_mergedData" stores the merged Y data set
    "mergeSubject" stores the merged Subject data set
    
Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

    "features" stores the features list (features.txt)
    "meanstdFeatures" stores the column pointers to features that have mean or std in the title
    "X_mergedData" is updated only with the columns that have mean or std in the title
  
 Step : 3.Uses descriptive activity names to name the activities in the data set  
 
    "activity" reads the list of activity labels
    "activityLabel" is the activity label related to each of the values for each row in Y_mergedData
    "Y_mergedData" is updated with the activity labels instead of activity codes
    
 Step : 4.Appropriately labels the data set with descriptive variable names
    "X_mergedData" column names are cleaned up (removal of parenthesis, hifens, capitalisation of M for means and S for std)
    "Y_mergedData" column name is labelled "activity"
    "mergedSubject" column name is labelled "subject"
    "tidyData" table holds the column merge of subject, activity and X Data
    
  Step 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  
  "means_tidy_data" is created empty, having in each row a combination of a subject and an activity. It is then pouplated with the mean for each of the combinations of subject and activity.
  
    
    
