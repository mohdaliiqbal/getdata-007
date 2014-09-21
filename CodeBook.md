#Requirements
#   You should create one R script called run_analysis.R that does the following. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data from the following URL should be unzipped in this directory.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

So the folder structure of the current directory should look something like
/test (directory with all test data from the original zip file)
/train (directory with all training data from the original zip file)
activity_labels.txt
features.txt
features_info.txt
README.txt
run_analysis.R 

Variables
- feature - Names of the features in the  feature.txt file. The data is cleaned up to remove the feature number in the file
- data_train - Raw data from the training set X_train.txt containing all the features.
- activity_train - The activity number as per provided in the Y_train.txt
- data_test - Raw data from the test set X_test.txt containing all the features.
- activity_test - The activity number as per provided in the Y_test.txt

Transformation steps
1. Features names are applied first to the training and test data this will give us appropriate labels to the raw data

2. We apply label (activity_id) to the activity data as well

3. We merge the training and test data sets with its respective activity data using cbind

4. We merge two data sets (training, and test) using rbind

5. We grep the columns we are interested in i.e. mean, standard, activity id and store it in intermediate variable mean_std_measurements

6. We load the activity labels data

7. We merge the activity labels data with the data in the step 5.

8. We discard the activity_id column from the merged data

9. We output the data using write.table and we ask it not to write the row numbers. We use CSV format


tidy data set contains, all mean, std measurements from all the measurements and also the name of the activity



