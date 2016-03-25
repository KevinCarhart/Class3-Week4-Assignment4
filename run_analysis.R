run_analysis <- function()
{
  
# assumption that the working directory is "UCI HAR Dataset"


# bring in a couple of libraries to have a lot of options available for how to work
library("dplyr")
library("tidyr")

# read in the training data
data_train <- read.table("train/X_train.txt")

# read in the testing data
data_test <- read.table("test/X_test.txt")

# read in the list of all the row headers
row_headers <- read.table("features.txt")

# select the indices of just the 'mean' and 'standard deviation' row headers
indices_with_mean_or_std <- grep("-mean\\(\\)|-std\\(\\)",row_headers$V2)

# Here I use the 't' function to transpose the list of headers to one long row
horizontal_headers <- as.data.frame(t(as.vector(t(row_headers$V2))))

# Using the collected indices, get just the 'mean' and 'std' row headers in horizontal form
# These are the literal names and will go in 'names' after the data is ready
headers_mean_or_std <- select(horizontal_headers,indices_with_mean_or_std)
variable_names <- as.matrix(headers_mean_or_std[,1:66])


# Select just the 'mean' and 'std' columns from the training and test data respectively
data_train_mean_or_std <- select(data_train,indices_with_mean_or_std)
data_test_mean_or_std <- select(data_test,indices_with_mean_or_std)

# Now that the two sets are reduced just to the means and std's, rbind them together
# If this had been done earlier, there might have been an unnecessary performance
# hit of working on data that was only going to be thrown out subsequently
data_test_and_train <- rbind(data_test_mean_or_std,data_train_mean_or_std)
names(data_test_and_train) <- variable_names


# Read in the following five things: subjects from test, activities from test,
# subjects from training, activities from training, and the lookup table with the
# activity labels

subjects_test <- read.table("test/subject_test.txt")
subjects_train <- read.table("train/subject_train.txt")
activities_test <- read.table("test/y_test.txt")
activities_train <- read.table("train/y_train.txt")
activity_labels <- read.table("activity_labels.txt")

# When the test and training data are rbind'ed together, the detail will be lost
# of which was which.  So create a tag that will preserve this
subjects_test <- mutate(subjects_test,experiment_step = 'test')
subjects_train <- mutate(subjects_train,experiment_step = 'train')
activities_test <- mutate(activities_test,experiment_step = 'test')
activities_train <- mutate(activities_train,experiment_step = 'train')



subjects_test_and_train <- rbind(subjects_test,subjects_train)
activities_test_and_train <- rbind(activities_test,activities_train)

# Lossy: the test/train label should be there but doesn't need to be duplicated
# Otherwise the merge will complain
activities_test_and_train = select(activities_test_and_train,1)

names(activity_labels) <- c('activity_id','activity_name')
names(activities_test_and_train) <- c('activity_id')
subjects_and_activities <- cbind(subjects_test_and_train,activities_test_and_train)
names(subjects_and_activities) = c('subject_id','experiment_step','activity_id')
subjects_and_labelled_activities <- merge(subjects_and_activities,activity_labels,"activity_id")



subjects_and_labelled_activities <- select(subjects_and_labelled_activities,2:4)
data_test_and_train_with_row_information <- cbind(subjects_and_labelled_activities,data_test_and_train)



write.csv(data_test_and_train_with_row_information,file="tidy_data.csv",row.names=FALSE)



averages <- aggregate(data_test_and_train_with_row_information,by=list(data_test_and_train_with_row_information$subject_id,data_test_and_train_with_row_information$activity_name),FUN=mean,na.rm=TRUE)
averages <- select(averages,1:2,6:71)
averages <- rename(averages, subject_id = Group.1)
averages <- rename(averages, activity_name = Group.2)
write.csv(averages,file="tidy_data_averages.csv",row.names=FALSE)
 
}

