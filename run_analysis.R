#Requirements
#You should create one R script called run_analysis.R that does the following. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#read the features name to label
features<-read.table("features.txt")

#extract only feature name column
features<-as.character(features[,2])


#read the training data and training activity files data
data_train<-read.table("./train/X_train.txt")
activity_train<-read.table("./train/Y_train.txt")
subject_train<-read.table("./train/subject_train.txt")

#renaming the activity data and putting a column name activity_id
names(activity_train)<-c("activity_id")

#now put the names to the columns/features over the data
names(data_train) <- features

#put the column name to the subject data set
names(subject_train)<-c("subject")

#merge the training data and activity
merged_train_data<- cbind(data_train,subject_train,activity_train)


#load testing data and activity names
data_test<-read.table("./test/X_test.txt")
activity_test<-read.table("./test/Y_test.txt")
subject_test<-read.table("./test/subject_test.txt")


#renaming the activity data and putting a column name activity_id
names(activity_test)<-c("activity_id")
names(data_test) <- features
names(subject_test)<-c("subject")

#merge the training data and activity
merged_test_data<- cbind(data_test,subject_test,activity_test)

#merge the data
#Fulfil Requirement 1. Merges the training and the test sets to create one data set.
merged_data<-rbind(merged_train_data,merged_test_data)

#now we will subset the data and extract only columns which are mean or std deviations
#following line will extract all the columns which have either mean or std in their names. So that 

#Fulfil Requirement 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std_measurements<-merged_data[,grep("mean\\(|std|activity_id|subject",colnames(merged_data))]

#lets apply the label to the data.
#load the activity labels	
activity_label<-read.table("activity_labels.txt")

#give a proper name to the columns in the activity_label
names(activity_label)<-c("activity_id","activity_name")

#now activity_id column can be used to merge the mean_std_measurements and activity_label to put descriptive label to the activity
labeled_data_set<-merge(mean_std_measurements,activity_label,x.by="activity_id",y.by="activity_id")

#remove the activity_id column as its not needed in the tidy data set
labeled_data_set<-labeled_data_set[,-1] 

#melt the data and bring all measurements as variable/value combination
reshaped_data<-melt(labeled_data_set,id=c("subject","activity_name"),measure.vars=grep("mean\\(|std",colnames(labeled_data_set)))

#dcast the data using mean as the function for aggregation. this will shape data and calculate aggregate mean for every subject and activity
final_tidy_data_set<-dcast(reshaped_data,subject+activity_name ~ variable, value.var="value",fun.aggregate=mean)
	
#write the data to the tidy data set file.
write.table(final_tidy_data_set,"tidy_data.txt",row.names=FALSE)


