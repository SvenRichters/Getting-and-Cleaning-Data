

# Merge the training and the test sets to create one data set.

#Set working directory
setwd("~/Desktop/RProjects/Coursera/GettingAndCleaningData/UCI HAR Dataset");

# 1.  Merge Data
# 1.1 Read in the training data
features     = read.table('./features.txt',header=FALSE);
activityType = read.table('./activity_labels.txt',header=FALSE); 
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); 
xTrain       = read.table('./train/x_train.txt',header=FALSE); 
yTrain       = read.table('./train/y_train.txt',header=FALSE); 

    # display first rows of each dataframe
head(features)
head(activityType)
head(subjectTrain)
head(xTrain)
head(yTrain)

    # Assigin column names 
colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";

    # display first rows of each dataframe, column names assigned
head(activityType)
head(subjectTrain)
head(xTrain)
head(yTrain)

    # create trainingData by merging yTrain, subjectTrain and xTrain
trainingData = cbind(yTrain, subjectTrain, xTrain);

    #display trainingData
head(trainingData)

# 1.2 Read in the test data
subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTest       = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTest       = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt

    # display first rows of each dataframe
head(subjectTest)
head(xTest)
head(yTest)

    # Assign column names
colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";

    # display first rows of each dataframe
head(subjectTest)
head(xTest)
head(yTest)

    # Merging the xTest, yTest and subjectTest data
testData = cbind(yTest,subjectTest,xTest);

    # display testData
head(testData)

# 1.3 Combine trainingData & testData
Data = rbind(trainingData,testData);

# Create a vector for the column names to  be used
colNames  = colnames(Data); 
head(Data)

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a logic Vector to pick out measurments containing mean or SD
logicVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset finalData table based on the logicalVector to keep only desired columns
subData = Data[logicVector==TRUE];
#display data
head(subData)

# 3. Use descriptive activity names to name the activities in the data set

# Merge the subData set with the acitivityType table to include descriptive activity names
subData = merge(subData,activityType,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(subData); 

#display data
head(subData)

# 4. Appropriately label the data set with descriptive activity names. 

# Remove parentheses
names(subData) <- gsub('\\(|\\)',"",names(subData), perl = TRUE)

# Create syntactically valid names
names(subData) <- make.names(names(subData))

# Create clearer names
names(subData) <- gsub('Acc',"Acceleration",names(subData))
names(subData) <- gsub('GyroJerk',"AngularAcceleration",names(subData))
names(subData) <- gsub('Gyro',"AngularSpeed",names(subData))
names(subData) <- gsub('Mag',"Magnitude",names(subData))
names(subData) <- gsub('^t',"TimeDomain.",names(subData))
names(subData) <- gsub('^f',"FrequencyDomain.",names(subData))
names(subData) <- gsub('\\.mean',".Mean",names(subData))
names(subData) <- gsub('\\.std',".StandardDeviation",names(subData))
names(subData) <- gsub('Freq\\.',"Frequency.",names(subData))
names(subData) <- gsub('Freq$',"Frequency",names(subData))

# Reassigning the new descriptive column names to the finalData set
colnames(subData) = colNames;

# Check Results
names(subData)

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create tidyData
tidyData = aggregate(subData, by=list(subData$activityId, subData$subjectId), mean)
tidyData$Group1 <-NULL #remove redundant columns
tidyData$Group2 <-NULL #remove redundant columns

# Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');
