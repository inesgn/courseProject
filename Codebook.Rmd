CODEBOOK
========

This file contains the Codebook for the final tidy data set.

Original Data
-------------
This section describes the sources and meaning of the data used in this project.

#### Links

The data sets used for this project contain measures collected from the accelerometers from the Samsumg Galaxy S smartphone. A full description is available at this site:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data itself can be downloaded from this url

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#### Description of the experiments

(Taken from README file in original data)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

#### Measures
For each record the original data provides measures for:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.


Transformed Data
----------------

This section describes which files were used, what transformations were applied to them and the variables contained in the final data set.

### Files

For this project the following files (divided into two groups, training and test files) were read into R:

* 'features.txt': List of all features, from which we took variable names.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set with measurement values.
* 'train/y_train.txt': Training labels.
* 'train/subject_train.txt': Subjects in the train set.
* 'test/X_test.txt': Test set with measurement values.
* 'test/y_test.txt': Test labels.
* 'test/subject_test.txt': Subjects in the test set.

### Transformations

#### Merging and Reading
1. Feature labels were read: `features.txt`
2. For each files in train and test directories data for measurements (`X_train.txt`, `X_test.txt`), activity values (`y_train.txt`, `y_test.txt`) and subject identifiers (`subject_train.txt`, `subject_test.txt`) were read. For the measurements files, feature labels read from `features.txt` were applied to the columns.
3. Measurements (X) were merged with activities (Y) and with subject identifiers, and train/test observations were stacked with `rbind()` function in a single data frame.
4. Finally activity labels were retrieved and applied to the merged data set from `activity_labels.txt`

#### Selecting columns
Columns with `mean` and `standard deviation` values were retrieved by using regular expressions, and selected to form a first tidy data set.

#### Aggregation

Finally a second tidy data set was created by computing the mean (average value, with removal of `NA` values) of the selected columns for each activity and subject. 

This data was exported to the file `TidyDataSetFinal.txt` in this repo.


### Variable names

Here we list the variable names for the final data set, as you will find them in `TidyDataSetFinal.txt`.

The first two columns contain identifiers for each activity value and each subject. The file contains a row for each combination of these two variables (180 in total).

As explained before, the rest of columns contain mean (average) values for the `mean` and `standard deviation` columns in the original features (X measures).

* activity
* subject 
* tBodyAcc.mean...X
* tBodyAcc.mean...Y
* tBodyAcc.mean...Z 
* tGravityAcc.mean...X
* tGravityAcc.mean...Y 
* tGravityAcc.mean...Z 
* tBodyAccJerk.mean...X 
* tBodyAccJerk.mean...Y 
* tBodyAccJerk.mean...Z 
* tBodyGyro.mean...X 
* tBodyGyro.mean...Y 
* tBodyGyro.mean...Z 
* tBodyGyroJerk.mean...X 
* tBodyGyroJerk.mean...Y 
* tBodyGyroJerk.mean...Z 
* tBodyAccMag.mean..
* tGravityAccMag.mean.. 
* tBodyAccJerkMag.mean.. 
* tBodyGyroMag.mean..
* tBodyGyroJerkMag.mean.. 
* fBodyAcc.mean...X
* fBodyAcc.mean...Y 
* fBodyAcc.mean...Z 
* fBodyAcc.meanFreq...X 
* fBodyAcc.meanFreq...Y 
* fBodyAcc.meanFreq...Z 
* fBodyAccJerk.mean...X 
* fBodyAccJerk.mean...Y 
* fBodyAccJerk.mean...Z 
* fBodyAccJerk.meanFreqz..X 
* fBodyAccJerk.meanFreq...Y 
* fBodyAccJerk.meanFreq...Z 
* fBodyGyro.mean...X
* fBodyGyro.mean...Y 
* fBodyGyro.mean...Z 
* fBodyGyro.meanFreq...X 
* fBodyGyro.meanFreq...Y 
* fBodyGyro.meanFreq...Z 
* fBodyAccMag.mean..
* fBodyAccMag.meanFreq.. 
* fBodyBodyAccJerkMag.mean.. 
* fBodyBodyAccJerkMag.meanFreq.. 
* fBodyBodyGyroMag.mean..
* fBodyBodyGyroMag.meanFreq.. 
* fBodyBodyGyroJerkMag.mean.. 
* fBodyBodyGyroJerkMag.meanFreq.. 
* tBodyAcc.std...X
* tBodyAcc.std...Y 
* tBodyAcc.std...Z 
* tGravityAcc.std...X 
* tGravityAcc.std...Y 
* tGravityAcc.std...Z 
* tBodyAccJerk.std...X 
* tBodyAccJerk.std...Y 
* tBodyAccJerk.std...Z 
* tBodyGyro.std...X
* tBodyGyro.std...Y 
* tBodyGyro.std...Z 
* tBodyGyroJerk.std...X 
* tBodyGyroJerk.std...Y 
* tBodyGyroJerk.std...Z 
* tBodyAccMag.std..
* tGravityAccMag.std.. 
* tBodyAccJerkMag.std.. 
* tBodyGyroMag.std..
* tBodyGyroJerkMag.std.. 
* fBodyAcc.std...X
* fBodyAcc.std...Y 
* fBodyAcc.std...Z 
* fBodyAccJerk.std...X 
* fBodyAccJerk.std...Y 
* fBodyAccJerk.std...Z 
* fBodyGyro.std...X
* fBodyGyro.std...Y 
* fBodyGyro.std...Z 
* fBodyAccMag.std.. 
* fBodyBodyAccJerkMag.std.. 
* fBodyBodyGyroMag.std..
* fBodyBodyGyroJerkMag.std.. 
