##Code for Course Project - Getting and Cleaning data

##STEP 1: Merge Train and Test Data
train<- read.table("X_train.txt")
test<- read.table("X_test.txt")
dataset<- rbind(train, test) # data frame with just the feature variables

# Combine Labels
trainLabels<- read.table("y_train.txt")
testLabels<- read.table("y_test.txt")
labels<- rbind(trainLabels, testLabels)

#Combine subjects list
trainSub<- read.table("subject_train.txt")
testSub<- read.table("subject_test.txt")
subjects<- rbind(trainSub, testSub)

#combine all three 
df<- cbind(dataset, labels, subjects) # This is the MERGED DATASET


##----------------------------------------------------------------------------
## STEP 2: Extract only the measurements on the mean and standard deviation for each measurement

f<- read.table("features.txt") #load 561 feature names

#find feature names ending with "mean()" or "std()"
f1<- grep("mean\\(\\)", f[,2])
f2<- grep("std\\(\\)", f[,2])

features<- sort(c(f1, f2)); 
# These rows correspond to row numbers in the feature names list where the name ends with mean() or std()

#create new dataset which has only the extracted mean and std values
extractedData<- dataset[,features]
extractedData<- cbind(extractedData, labels, subjects) #EXTRACTED DATA SET


##------------------------------------------------------------------------------
## STEP 3: Use descriptive activity names to name the activities in the data set

flabels<- factor(labels[,1])
activity<- factor(flabels, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
extractedData[,ncol(extractedData)-1]<- activity

# extractedData[last but one column has descriptive strings for "activity"]



##------------------------------------------------------------------------------
## STEP 4: Appropriately label the data set with descriptive variable names

datalabels<- f[features,2] # contains 66 labels for extracted data
datalabels<- gsub("\\(\\)", "", datalabels) # remove "()" from existing variable name
datalabels<- c(datalabels, "Activity", "Subject") # add labels for last two columns
names(extractedData)<- datalabels

##------------------------------------------------------------------------------
## STEP 5: From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

#use aggregate

# d<- aggregate(extractedData, by = list(extractedData$Subject, extractedData$Ativity), FUN = mean)
#tidydata<- d[1:68]
#colnames(tidydata)[1]<- "Subject"
#colnames(tidydata)[2]<- "Activity"

#-------------------------------------------------------------------------------


