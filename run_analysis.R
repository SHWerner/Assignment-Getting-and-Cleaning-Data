run_analysis <- function(root_directory) {

current_directory <- getwd();

setwd (root_directory);

###Step 0: Reads Datasets

  #Step 0.1: Read Train Data (X, Y, Subject)
    X_trainData <- read.table("./UCI HAR Dataset/train/X_train.txt") 
    Y_trainData <- read.table("./UCI HAR Dataset/train/y_train.txt") 
    trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt") 

  #Step 0.2: Read Test Data (X, Y, Subject)
    X_testData <- read.table("./UCI HAR Dataset/test/X_test.txt") 
    Y_testData <- read.table("./UCI HAR Dataset/test/y_test.txt")  
    testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt") 




###Step 1: Merges the training and the test sets to create one data set (X, Y, subject)

  X_mergedData <- rbind(X_trainData, X_testData) 
  Y_mergedData <- rbind(Y_trainData, Y_testData) 
  mergedSubject <- rbind(trainSubject, testSubject) 



###Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

  # Step 2.1: Read Column Names
    features <- read.table("./UCI HAR Dataset/features.txt")
  
  # Step 2.1: Obtain only the columns for measurements that are Standard Deviations or Means
    meanstdFeatures <- grep("mean\\(\\)|std\\(\\)", features[, 2])
    
  # Step 2.2: On the merged data, retrieves only the columns that are mean or standard deviation measurements
    X_mergedData <- X_mergedData[, meanstdFeatures]

  
      
###Step : 3.Uses descriptive activity names to name the activities in the data set    
    activity <- read.table("./UCI HAR Dataset/activity_labels.txt") 
    activity[, 2] <- tolower(gsub("_", "", activity[, 2])) 
    substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) 
    substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) 
    activityLabel <- activity[Y_mergedData[, 1], 2] 
    Y_mergedData[, 1] <- activityLabel 
  

    
###Step : 4.Appropriately labels the data set with descriptive variable names
    
    # Step 4.1 - variable names on the merged dataset for X values
    names(X_mergedData) <- gsub("\\(\\)", "", features[meanstdFeatures, 2]) # remove "()" 
    names(X_mergedData) <- gsub("mean", "Mean", names(X_mergedData)) # capitalize M 
    names(X_mergedData) <- gsub("std", "Std", names(X_mergedData)) # capitalize S 
    names(X_mergedData) <- gsub("-", "", names(X_mergedData)) # remove "-" in column names
    print(names(X_mergedData))
    
    # Step 4.2 - variable name "activity" on the merged dataset for Y values
    names(Y_mergedData) <- "activity" 
    print (names(Y_mergedData))
    
    # Step 4.3 - variable name "subject" on the merged dataset for subjects
    names(mergedSubject) <- "subject" 
    print(names(mergedSubject))
    
    #Step 4.4 - writes a single file with the tidy dataset
    tidyData <- cbind(mergedSubject, Y_mergedData, X_mergedData) 
    write.table(tidyData, "tidy_data.txt")  
    
    
###Step : 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
    # Step 5.1 - creates the output matrix "mean_tidy_data" with all combinations of subjects and activities
    subjectLength <- length(table(mergedSubject))
    activityLength <- dim(activity)[1]
    tidyColumnLength <- dim(tidyData)[2] 
    means_tidy_data <- matrix(NA, nrow=subjectLength*activityLength, ncol=tidyColumnLength)  
    means_tidy_data <- as.data.frame(means_tidy_data) 
    colnames(means_tidy_data) <- colnames(tidyData)
    
    
    # Step 5.2 - populates each combination of subject x activity in rows X means of every column
    active_row <- 1 
    for(i in 1:subjectLength) { 
       for(j in 1:activityLength) { 
           means_tidy_data[active_row, 1] <- sort(unique(mergedSubject)[, 1])[i] 
           means_tidy_data[active_row, 2] <- activity[j, 2] 
           bool1 <- i == tidyData$subject 
           bool2 <- activity[j, 2] == tidyData$activity 
           means_tidy_data[active_row, 3:tidyColumnLength] <- colMeans(tidyData[bool1&bool2, 3:tidyColumnLength]) 
           active_row <- active_row + 1 
        } 
      } 
    print(head(means_tidy_data))
    write.table(means_tidy_data, "means_tidy_data.txt")  
    
    
setwd (current_directory);

}