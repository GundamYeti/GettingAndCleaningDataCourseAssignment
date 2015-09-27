require("data.table")
require("reshape2")

## Downloaded files from website; Unzipped and stored in a file called "data" in default directory

path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)

data.Activity.Test  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
data.Activity.Train <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

data.Subject.Train <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
data.Subject.Test  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

data.Features.Test  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
data.Features.Train <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

## Couldn't find a common variable to use merge()
## Merges the training and the test sets to create one data set.
data.Subject <- rbind(data.Subject.Train, data.Subject.Test)
data.Activity<- rbind(data.Activity.Train, data.Activity.Test)
data.Features<- rbind(data.Features.Train, data.Features.Test)

names(data.Subject)<-"subject"
names(data.Activity)<- "activity"
data.Features.Names <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(data.Features)<- data.Features.Names$V2

data.Combine <- cbind(data.Subject, data.Activity)
Data <- cbind(data.Features, data.Combine)

## Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
extract.features <- grep("mean|std", features)

##Create tidy data set
write.table(Data, "TidyData.txt", row.name=FALSE)
