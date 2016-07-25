# Load necessary libraries
library(data.table)
library(dplyr)

# Create the GACD-Project Directory 
if(!file.exists("GACD-Project")){
  dir.create("GACD-Project")
}

# Download the smartphone dataset
if (!file.exists("./GACD-Project/smartphone.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./GACD-Project/smartphone.zip", mode="wb")
}

# Unzip the smartphone dataset
unzip (zipfile ="./GACD-Project/smartphone.zip",exdir = "./GACD-Project")

# Smartphone data is stored in GACD-Project/UCI HAR Dataset
smartphoneDataPath <- file.path("./GACD-Project","UCI HAR Dataset")

# Feature Names Path 
featuresPath <- file.path(smartphoneDataPath,"features.txt")
featureNames <- read.table(featuresPath)

# Activity Labels Path
activityLabelsPath <- file.path(smartphoneDataPath,"activity_labels.txt")
activityLabels <- read.table(activityLabelsPath)

# Training Data
subjectTrainPath <- file.path(smartphoneDataPath,"train","subject_train.txt")
activityTrainPath <- file.path(smartphoneDataPath,"train","y_train.txt")
featuresTrainPath <- file.path(smartphoneDataPath,"train","X_train.txt")

subjectTrain <- read.table(subjectTrainPath,header = FALSE)
activityTrain <- read.table(activityTrainPath, header = FALSE)
featuresTrain <- read.table(featuresTrainPath, header = FALSE)

# Test Data
subjectTestPath <- file.path(smartphoneDataPath,"test","subject_test.txt")
activityTestPath <- file.path(smartphoneDataPath,"test","y_test.txt")
featuresTestPath <- file.path(smartphoneDataPath,"test","X_test.txt")

subjectTest <- read.table(subjectTestPath,header = FALSE)
activityTest <- read.table(activityTestPath, header = FALSE)
featuresTest <- read.table(featuresTestPath, header = FALSE)

# Merge Subject Data
subjectData <- rbind(subjectTrain, subjectTest)

# Merge Activity Data
activityData <- rbind(activityTrain, activityTest)

# Merge Features Data
featuresData <- rbind(featuresTrain, featuresTest)

# Name Columns
colnames(featuresData) <- t(featureNames[2])
colnames(subjectData) <- "Subject"
colnames(activityData) <- "Activity"

# Merge Data
mergedData <- cbind(featuresData,activityData,subjectData)

# Extract mean and standard deviation for each measurement
meanAndStdColumns <- grep(".*Mean.*|.*Std.*", names(mergedData),ignore.case = TRUE)
usedColumns <- c(meanAndStdColumns,562,563)
extractedData <- mergedData[,usedColumns]

# dim(extractedData)
## Output: [1] 10299    88

# Name the activities in the extracted data set
extractedData$Activity <- as.character(extractedData$Activity)

# For each of the six labels
for (i in 1:6){
    # If the activity number matches, substitute the activity label for the number
    extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

extractedData$Activity <- as.factor(extractedData$Activity)

# Use the sub function to substitute readable terms for technical terms in the Extracted Dataset
names(extractedData)<-sub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-sub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-sub("BodyBody", "Body", names(extractedData))
names(extractedData)<-sub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-sub("^t", "Time", names(extractedData))
names(extractedData)<-sub("^f", "Frequency", names(extractedData))
names(extractedData)<-sub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-sub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-sub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-sub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-sub("angle", "Angle", names(extractedData))
names(extractedData)<-sub("gravity", "Gravity", names(extractedData))

# Set subject as factor variable for the extracted data
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

# Create Tidy Data set as an average for each activity and subject
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)

# Order the entries in the tidy data set by subject and activity
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]

# Write the tidy data to a text file
write.table(tidyData, file = "./GACD-Project/Tidy.txt", row.names = FALSE)
