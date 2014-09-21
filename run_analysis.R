#Requirements
#You should create one R script called run_analysis.R that does the following. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#read the training file
data_train<-read.table("./train/X_train.txt")
data_test<-read.table("./test/X_test.txt")

#merge the data
#Fulfil Requirement 1. Merges the training and the test sets to create one data set.
merged_data<-rbind(data_train,data_test)


#read the features name to label
features<-read.table("features.txt")

#extract only feature name column
features<-as.character(features[,2])

#now put the names to the columns/features over the data
names(merged_data) <- features


#now we will subset the data and extract only columns which are mean or std deviations
#following line will extract all the columns which have either mean or std in their names. So that 

#Fulfil Requirement 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std_measurements<-merged_data[,grep("mean\\(|std",colnames(merged_data))]





