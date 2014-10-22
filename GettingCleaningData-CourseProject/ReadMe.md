Analysis of the UCI HAR DATASET FOR COURSE PROJECT 2
=================================================

The analysis is being done by a single script - run_Analysis.R

### Assumptions: The data (.txt) files are all located in the working directory

### TASK -1 Merge training and test sets to create one set

I first read the X_train.txt and X_test.txt files and bind them row-wise using rbind()
They have 561 features/columns each, the resulting data.frame is 10299x561 (result variable = dataset)

Then read the y_train.txt and y_test.txt and concatenate them using rbind(). The result is a single column
that is 10299 rows long. (result variable = labels)

Lastly, read the subject_train.txt and subject_test.txt and concatenate them using rbind(). The result is a single column
that is 10299 rows long. (result variable = subject)

Combine the 3 data frames above (10299x561, 10299x1, 10299x1) using cbind() to form the merged dataset. 
Merged Dataset is in the variable 'df'.


### TASK -2 Extract only the measurements on the mean and standard deviation for each measurement
Read features.txt to get the list of feature names.

In order to extract columns which correspond to mean/std, I looked at the feature names and discovered that there are broadly 2 types - ones ending with 'mean()' (fBodyBodyGyroMag-mean()), ones that contain 'mean' but dont end with it(fBodyBodyGyroMag-meanFreq()
 or angle(tBodyGyroMean,gravityMean)). The first case is clearly measurement of the mean, but the second case a bit ambiguous, so I decided to extract only the feature names ending with 'mean()' or 'std()'

This has been done using grep(), which gives the row numbers in the features.txt file, that correspond to feature names ending with 'mean()' or 'std()'. The row numbers correspond to the required column numbers in the merged dataset created in the previous step.

In the script, variable 'features' stores the required column numbers, using which we extract the required columns from the original dataset. This is stored in variable 'extractedData'.

### TASK 3: Use descriptive activity names to name the activities in the data set

There are 6 activities listed in the 'activity_labels.txt' file which correspond to numbers 1-6 in the Label column. We replace numbers with descriptive name using factor().

### TASK 4: Appropriately label the data set with descriptive variable names

This is carried out on the premise that the original variable names are very descriptive and informative as such. Since the original names maybe difficult to read and violate some naming rules, I have removed some special characters like "()" using gsub() to make the names cleaner. Also, I decided not to remove '-' since it seems to improve readability in an otherwise long variable name. This covers variable names for the extracted columns from the original set of 561. The remaining two columns for "Subject" and "Activity" are named accordingly.

### TASK 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

This has been done using the 'aggregate()' function. It is a one step process wherein I pass the extractedData in step 4, to this function along with "Subject" and "Activity" as the columns to group by, and the FUN parameter is set to 'mean'. This results in two extra rows which are later removed. The final tidy dataset is stored in the variable 'tidydata' and is written to 'tidydata.txt'.