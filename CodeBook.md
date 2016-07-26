## CodeBook

This document contains descriptions of the data and transformations in run_analysis.R as well as
definitions of the variables in Tidy.txt

### Data Information:

The data was collected from a series of experiments using the Samsung Galaxy S II Smartphone's embedded 
accelerometers and gyroscopes.
The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, data was captured from 3-axial linear acceleration 
and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments were  video-recorded to label the data manually. 
The obtained dataset was randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### Data Files
* X_train.txt contains variables associated with the training group
* y_train contains the activities associated with X_train.txt
* X_test.txt contains variables associated with testing group
* y_test.txt contains the activities associated with X_test.txt
* subject_train.txt contains information about the subjects the train data is collected from
* subject_test.txt contains information about the subjects the test data is collected from
* activity_labels.txt contains data describing the different activities
* features.txt contains the name of the features in the datasets

### Transformations/Data Storage
* featuresPath stores the address of the features file
* featureNames stores the features file in a table
* activityLabelsPath stores the address of the activity_labels.txt file
* activityLabels stores the activity_labels.txt file as a table
* subjectTrainPath stores the location of the subject_train.txt file
* activityTrainPath stores the address of the y_train.txt file
* featuresTrainPath stores the address of the X_train.txt file
* subjectTrain stores the subject_train.txt file as a table
* activityTrain stores the y_train.txt file as a table
* featuresTrain stores the X_train.txt file as a table
* subjectTestPath stores the location of the subject_test.txt file
* activityTestPath stores the address of the y_test.txt file
* featuresTestPath stores the address of the X_test.txt file
* subjectTest stores the subject_test.txt file as a table
* activityTest stores the y_test.txt file as a table
* featuresTest stores the X_test.txt file as a table
* subjectData binds subjectTrain and subjectTest
* activityData binds activityTrain and activityTest 
* featuresData binds featuresTrain and featuresTest 
* mergedData binds subjectData, activityData and featuresData
* meanAndStdColumns extracts any columns that have a name containing Mean or Std (Standard Deviation)
* usedColumns is a table that contains the extracted columns for meanAndStdColumns
* extractedData contains the mean and std columns that are in mergedData 
* Technical terms and abbreviations in extractedData like 'Acc', 'Gyro', 'Mag', 'BodyBody' etc. are replaced
  with more readable and straightforward labels such as 'Accelerometer', 'Gyroscope','Magnitude', 'Body' etc.
* tidyData is created as a set with an average for each activity and subject in extractedData. Entries in tidyData are organized
  by activity and subject
* tidyData is written to Tidy.txt

### Output:

The output text file 'Tidy.txt' is a space-delimited value file with a header that contains the names of the variables.
It contains the mean and standard deviations of the data contained in the input files.