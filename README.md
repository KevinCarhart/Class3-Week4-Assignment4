# Class3-Week4-Assignment4
JHU Data Science - Getting and Cleaning Data Course Project

README

This readme "explains how all of the scripts work and how they are connected."  For this exercise, the only script is run_analysis.R

I. General Overview 

In this folder you should find the following files:
README.md
codebook.md
run_analysis.R

There is only one R file.  The assumptions on how to use it are as follows:

(1) Your working directory should be "UCI HAR Dataset".  The script will not set this for you, which means that you may unzip the UCI data anywhere you want.  But please setwd() to "UCI HAR Dataset" before running, and this way the script will be able to find everything within the test and train folders.
(2) The script assumes the "dplyr" and "tidyr" libraries.  However, if you do not load these libraries before running run_analysis.R, the script will load them for you.

Given these two assumptions, it is a one-step process to run the script.  From the R prompt, execute run_analysis()


II. Description of script

The script has good comments along the way, but here is a description of what happens.

(1) load in the libraries
(2) read the training data and test data into objects
(3) read the row headers from features.txt
(4) Use grep to find the indices of just those variables which are a mean or a standard deviation
(5) Using the transpose function, arrange the features as one long horizontal data frame.  This will facilitate the use of 'select' to pull out just the ones that are needed.  There are other ways to do this.    Note: the lectures and swirl modules talk about the chain operator. (%>%)  It lets you avoid restating your context over and over.  I considered it slightly helpful to be forced to restate my context over and over, therefore I did not use chain/pipeline.
(6) Now that this one-row set of 'mean' and 'standard deviation' variables is available, use it as the basis for a select from the data as a whole - one from test and one from train.  The reason for subsetting first and concatenating these sets afterwards with rbind() is because of the slight possibility that there would be a performance hit from the rbind operation.  Since there is no point in waiting for rbind() to work on data which is only going to be thrown out afterwards, I select from the two pieces first and concatenate them afterwards.
(7) Read in the subject and activity data from the appropriate text files.  This data is also still stored as 'test' and 'train'.
(8) The fact of whether a given datapoint is from 'test' or 'train' is preserved solely in the filename.  When the sets are combined, this bit of information will be lost.   It may not matter, but just in case, I create a character variable in the separate test and train sets called 'experiment_step', which preserves the source of origin.  It is a way of fully qualifying.

(9) rbind() the subjects and rbind() the activities.

(10) Overwrite the generic names with explanatory name strings using names()

(11) cbind() the subjects and activities together

(12) Use merge() to bring in the activity names, joining on the activity ID.

(13) After a couple more nominal cleanups, do the major cbind between the large data set and the subjects-and-activities row headers.

(14) Write.csv of the filename "tidy_data.csv"

(15) Using aggregate(), create a new data frame that contains one average per variable, for each subject-activity pair.

(16) Write.csv of the filename "tidy_data_averages.csv"

(17) For the assignment itself, write.table of the averages file (in txt format and with row.names=FALSE) in order to be able to upload.


