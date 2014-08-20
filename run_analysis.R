## Getting & Cleaning Data Course project
# Smartphones and activity data from UCI repository.

## Set working directory
setwd("~/Documents/coursera/DataAnalysis/3GettingCleaningData/courseProject")

########################################################################################
### Read data
# file with variable names (to label both to train & test data)
labels <- read.table(file="./UCI HAR Dataset/features.txt",header=FALSE)

# data in 'test' directory
subject_test <- read.table(file="./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
#--> Use feature labels recorded in labels$V2
X_test <-  read.table(file="./UCI HAR Dataset/test/X_test.txt", header=FALSE,
                      col.names=labels$V2)
Y_test <-  read.table(file="./UCI HAR Dataset/test/Y_test.txt", header=FALSE)

# checks: test data
dim(subject_test);dim(X_test);dim(Y_test) #2947 rows in each
length(unique(subject_test$V1)) # 9 individuals in the test set
head(X_test[,1:6]) #some features
head(Y_test) #activities

# data in 'train' directory
subject_train <- read.table(file="./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
#--> Use feature labels recorded in labels$V2
X_train <-  read.table(file="./UCI HAR Dataset/train/X_train.txt", header=FALSE,
                       col.names=labels$V2)
Y_train <-  read.table(file="./UCI HAR Dataset/train/Y_train.txt", header=FALSE)

# checks: train data
dim(subject_train);dim(X_train);dim(Y_train) #7352 rows in each
length(unique(subject_train$V1)) # 9 individuals in the test set
head(X_train[,1:6]) #some features
head(Y_train) #activities

# activity labels 
activity_labels <- read.table(file="./UCI HAR Dataset/activity_labels.txt", header=FALSE)
activity_labels # id and label

########################################################################################
### Merge data
###--- STEP 1: Merge the training and the test sets to create one data set.
# Observe that rows are in the same order in the train / test set
# therefore it suffices to bind columns
test_data <- cbind(subject_test, X_test, Y_test)
train_data <- cbind(subject_train, X_train, Y_train)

# Create identifiers to distinguish between train/test data
## include variable 'type' with values 'test', 'train'
train_data$type <- "train"
test_data$type <- "test"

## Finally stack test and train data rows
data.all <- rbind(train_data, test_data)

#check data
dim(data.all)
head(data.all[,1:6])
tail(data.all[,(ncol(data.all)-6):ncol(data.all)])
#Be aware! there are two V1's, we change names fo avoid confussion,
#change names to identify individuals variable (1st V1) and labels variable (last V1)
names(data.all)[1] <- "subject"
names(data.all)[ncol(data.all)-1] <- "activity.no"
#(And we check again)

#Now merge with activity_labels to recover activity lavels
activity_labels
names(activity_labels) <- c("activity.no", "activity")

# merge data
data.all <- merge(x=data.all, y=activity_labels, by="activity.no")

# Check
dim(data.all) # added 1 column, OK
head(data.all[,1:6])
tail(data.all[,(ncol(data.all)-6):ncol(data.all)])
########################################################################################
### Extract columns
###--- STEP 2: Extract only the measurements on the mean and standard deviation for each measurement. 
# We need to identify variable names containing "mean" or "std" strings
length(unique(grep(pattern="mean",x=names(data.all)))) #46 variable names contain "mean"
length(unique(grep(pattern="std",x=names(data.all)))) #33 variable names contain "std"

#combine both patterns
# keep subject identification and activity labels
vars <- c("subject","activity", 
          names(data.all)[unique(grep(pattern="mean",x=names(data.all)))],
          names(data.all)[unique(grep(pattern="std",x=names(data.all)))])
length(vars) # 46+33+2=81, ok

# Produce tidy data set
data.tidy <- as.data.frame(data.all[,vars])

# Checks
dim(data.tidy)
head(data.tidy)

# The tidy data set contains (in order):
#---> subject identification
#---> activity labels
#---> mean and standard deviation of each measurement 
########################################################################################
### Aggregated tidy data set
###--- STEP 3: Create a second tidy data set with the average of each variable for each activity and subject
library(plyr)

# prueba <- ddply(DTT, .(subject),summarise, FUN=mean)

data.tidy2 <- aggregate(data.tidy[,3:length(names(data.tidy))],
                    by=list(data.tidy$activity,data.tidy$subject),
                    FUN=mean, na.rm= TRUE)
nrow(data.tidy2) 
# Same as:
length(unique(data.tidy$activity)) * length(unique(data.tidy$subject)) #OK
# Change labels for 1st 2 columns
names(data.tidy2)[1] <- "activity"
names(data.tidy2)[2] <- "subject"

# Check final data set
str(data.tidy2) # ok.
# Export data to txt format
write.table(data.tidy2, file="TidyDataSetFinal.txt", row.names=FALSE)
