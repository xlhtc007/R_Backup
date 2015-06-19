#setting the path to the folder on the computer where the data files are located.
filepath <- "./ucihardata" 
# Read the text file 'activity_labels' for activity labels and assign the data to a variable
activity_labels <- read.table(paste(filepath, 'activity_labels.txt', sep = '/'), header = FALSE)
names(activity_labels) <- c('id', 'name')
# Read the text file 'features' for feature labels and assign the data to a variable
features <- read.table(paste(filepath, 'features.txt', sep = '/'), header = FALSE)
names(features) <- c('id', 'name')
# Extracting the data from the text files , assign names
Xtrain <- read.table(paste(filepath, 'train', 'X_train.txt', sep = '/'), header = FALSE)
names(Xtrain) <- features$name
# Extracting the data from the text files , assign names
ytrain <- read.table(paste(filepath, 'train', 'y_train.txt', sep = '/'), header = FALSE)
names(ytrain) <- c('activity')
### Extracting the data from the text files , assign names
train.subject <- read.table(paste(filepath, 'train', 'subject_train.txt', sep = '/'), header = FALSE)
names(train.subject) <- c('subject')
### Extracting the data from the text files , assign names
Xtest <- read.table(paste(filepath, 'test', 'X_test.txt', sep = '/'), header = FALSE)
names(Xtest) <- features$name
### Extracting the data from the text files , assign names
ytest <- read.table(paste(filepath, 'test', 'y_test.txt', sep = '/'), header = FALSE)
names(ytest) <- c('activity')
### Extracting the data from the text files , assign names
test.subject <- read.table(paste(filepath, 'test', 'subject_test.txt', sep = '/'), header = FALSE)
names(test.subject) <- c('subject')
# Training dataset and Test dataset are merged
x <- rbind(Xtrain, Xtest)
y <- rbind(ytrain, ytest)
subject <- rbind(train.subject, test.subject)

#Select for mean and standard deviations in the data 
x <- x[, grep('mean|std', features$name)]

y$activity <- activity_labels[y$activity,]$name #naming according to activity labels

# Merge datasets subject, y and x 
cleandata <- cbind(subject, y, x)
#Get rid of duplicated columns
cleandata1 <- cleandata[, unique(colnames(cleandata))]

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



# write the first dataset into a file ,into the same folder where the data is present.
write.csv(cleandata1,file=paste( filepath, "cleandata.csv", sep="/"))
# write the first dataset into a text file (for project submission)
write.table(cleandata1,file=paste( filepath, "cleandata.txt", sep="/"))

# mean is calculated based on subject and activity
cleandata_avgs <- aggregate(cleandata1[, 3:dim(cleandata1)[2]], list(cleandata1$subject, cleandata1$activity), mean)
names(cleandata_avgs)[1:2] <- c('subject', 'activity')
#Get rid of duplicated columns if any
cleandata1_avgs <- cleandata_avgs[, unique(colnames(cleandata_avgs))]
# tidying up the variable names for easier understanding
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
# sending back the tidy variable names back to the dataset
colnames(cleandata1_avgs) <- variable_names
# write the second dataset into a file ,into the same folder where the data is present.
write.csv(cleandata1_avgs,file=paste( filepath, "cleandata_avgs.csv", sep="/"))
# write the second dataset into a text file (for project submission)
write.table(cleandata1_avgs,file=paste( filepath, "cleandata_avgs.txt", sep="/"))