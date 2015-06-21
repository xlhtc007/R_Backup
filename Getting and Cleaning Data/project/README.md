##Getting and Cleaning Data project
===================================

This project is a part of the COURSERA Course " Getting and Cleaning Data " offered by John Hopkins university.

###Script
=======================

This file run_analysis.R contains the script for carrying out the tasks for cleaning and processing the raw datasets available at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

-Details and description of this data is available at [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) [1]

-The data involves data related to Acceleration, Frequency, Jerk, Gyroscope measurements along X,Y,Z Axis, etc the details are available in the features, features_info.txt document available in the dataset folder which can be downloaded from the link provided above. 

**Certain variables that are processed here are **

- mean() - corresponds to Mean value 
- std() - corresponds to Standard deviation
- X, Y , Z - correxpond to the X, Y, Z coordinates
- Subject - subject id in the experiment 
- Label - descriptive label of the activity 
- Types of activity(Levels) - LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS

### The whole process here can be categorised into sub-processes.

**-Reading data **

**-Cleaning data **

**-processing data **

**-Data output(write into output files)**


###Tidy data set

**Tidy data set follow certain renaming rules:**

*-No underscores or dots or white spaces or dashes or parentheses*

*-All lower case prefferable *

*-The variable names should be descriptive*

*- No duplications , should be unique*

###Reading data
======================
-This code is responsible for reading data from the files 

```{r}
filepath <- "./HARdata" 
""" Read the text file 'activity_labels' for activity labels and assign the data to a variable
activity_labels <- read.table(paste(filepath, 'activity_labels.txt', sep = '/'), header = FALSE)
names(activity_labels) <- c('id', 'name')
"""Read the text file 'features' for feature labels and assign the data to a variable
features <- read.table(paste(filepath, 'features.txt', sep = '/'), header = FALSE)
names(features) <- c('id', 'name')
""" Extracting the data from the text files , assign names
Xtrain <- read.table(paste(filepath, 'train', 'X_train.txt', sep = '/'), header = FALSE)
names(Xtrain) <- features$name
""" Extracting the data from the text files , assign names
ytrain <- read.table(paste(filepath, 'train', 'y_train.txt', sep = '/'), header = FALSE)
names(ytrain) <- c('activity')
""" Extracting the data from the text files , assign names
train.subject <- read.table(paste(filepath, 'train', 'subject_train.txt', sep = '/'), header = FALSE)
names(train.subject) <- c('subject')
""" Extracting the data from the text files , assign names
Xtest <- read.table(paste(filepath, 'test', 'X_test.txt', sep = '/'), header = FALSE)
names(Xtest) <- features$name
""" Extracting the data from the text files , assign names
ytest <- read.table(paste(filepath, 'test', 'y_test.txt', sep = '/'), header = FALSE)
names(ytest) <- c('activity')
""" Extracting the data from the text files , assign names
test.subject <- read.table(paste(filepath, 'test', 'subject_test.txt', sep = '/'), header = FALSE)
names(test.subject) <- c('subject')
```

###Training dataset and Test dataset are merged

```{r}
x <- rbind(Xtrain, Xtest)
y <- rbind(ytrain, ytest)
subject <- rbind(train.subject, test.subject)

"""Select for mean and standard deviations in the data """


x <- x[, grep('mean|std', features$name)]

y$activity <- activity_labels[y$activity,]$name #naming according to activity labels

""" Merge datasets subject, y and x """

cleandata <- cbind(subject, y, x)
"""Get rid of duplicated columns"""
cleandata1 <- cleandata[, unique(colnames(cleandata))]
```

### Find and replace the  patterns
-The patterns mentioned as a part of the project are to be found to achieve a good level of cleaning and tidying of the data 



```{r}
variable_names <- colnames(cleandata1)
variable_names <- gsub("-mean()","mean",variable_names,fixed=TRUE)
variable_names <- gsub("-meanFreq()","meanfrequency",variable_names,fixed=TRUE)
variable_names <- gsub("-std()","standarddeviation",variable_names,fixed=TRUE)
variable_names <- gsub("bodybody","Body",variable_names,fixed=TRUE)
variable_names <- gsub("tBody","timeSeriesbody",variable_names,fixed=TRUE)
variable_names <- gsub("tGravity","timeSeriesgravity",variable_names,fixed=TRUE)
variable_names <- gsub("fBody","fastfouriertransformbody",variable_names,fixed=TRUE)
variable_names <- gsub("Acc","accelerometer",variable_names,fixed=TRUE)
variable_names <- sub("[[:punct:]]", "",variable_names) # removing all punctuations
variable_names <- gsub("X","xcoordinate",variable_names,fixed=TRUE)
variable_names <- gsub("Y","ycoordinate",variable_names,fixed=TRUE)
variable_names <- gsub("Z","zcoordinate",variable_names,fixed=TRUE)
variable_names <- tolower(gsub("Gyro","gyroscope",variable_names,fixed=TRUE)) # convert all names to lowercase
  
# sending back the tidy variable names back to the dataset
colnames(cleandata1) <- variable_names
```
### writing the dataset into a file 
```{r}
""" write the first dataset into a file ,into the same folder where the data is present """
write.csv(cleandata1,file=paste( filepath, "cleandata.csv", sep="/"))
""" write the first dataset into a text file (for project submission) """
write.table(cleandata1,file=paste( filepath, "cleandata.txt", sep="/"))

""" mean is calculated based on subject and activity"""

cleandata_avgs <- aggregate(cleandata1[, 3:dim(cleandata1)[2]], list(cleandata1$subject, cleandata1$activity), mean)
names(cleandata_avgs)[1:2] <- c('subject', 'activity')
"""Get rid of duplicated columns if any
cleandata1_avgs <- cleandata_avgs[, unique(colnames(cleandata_avgs))]



 mean is calculated based on subject and activity
cleandata_avgs <- aggregate(cleandata1[, 3:dim(cleandata1)[2]], list(cleandata1$subject, cleandata1$activity), mean)
names(cleandata_avgs)[1:2] <- c('subject', 'activity')
#Get rid of duplicated columns if any
cleandata1_avgs <- cleandata_avgs[, unique(colnames(cleandata_avgs))]
```

### Find and replace a few patterns
- Tidying up the variable names for easier understanding

```{r}
variable_names <- colnames(cleandata1_avgs)
variable_names <- gsub("-mean()","mean",variable_names,fixed=TRUE)
variable_names <- gsub("-meanFreq()","meanfrequency",variable_names,fixed=TRUE)
variable_names <- gsub("-std()","standarddeviation",variable_names,fixed=TRUE)
variable_names <- gsub("bodybody","Body",variable_names,fixed=TRUE)
variable_names <- gsub("tBody","timeSeriesbody",variable_names,fixed=TRUE)
variable_names <- gsub("tGravity","timeSeriesgravity",variable_names,fixed=TRUE)
variable_names <- gsub("fBody","fastfouriertransformbody",variable_names,fixed=TRUE)
variable_names <- gsub("Acc","accelerometer",variable_names,fixed=TRUE)
variable_names <- sub("[[:punct:]]", "",variable_names) # removing all punctuations
variable_names <- gsub("X","xcoordinate",variable_names,fixed=TRUE)
variable_names <- gsub("Y","ycoordinate",variable_names,fixed=TRUE)
variable_names <- gsub("Z","zcoordinate",variable_names,fixed=TRUE)
variable_names <- tolower(gsub("Gyro","gyroscope",variable_names,fixed=TRUE)) # convert all names to lowercase

```

- sending back the tidy variable names back to the dataset 
```{r}
colnames(cleandata1_avgs) <- variable_names
```
- write the second dataset into a file ,into the same folder where the data is present.
```{r}
write.csv(cleandata1_avgs,file=paste( filepath, "cleandata_avgs.csv", sep="/"))
```
- write the second dataset into a text file (for project submission)
```{r}
write.table(cleandata1_avgs,file=paste( filepath, "cleandata_avgs.txt", sep="/"))

```

###Patterns that were addressed here 
1. Remove Capital letters
2. Remove dots, parenthesis, white spaces
3. Make variables descriptive ( fullform of abbreviations be preferrably included)
4. Remove duplicates in names like "Body Body" to "body"
5. convert all names to lower case



**Reference:**

*[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012 *
