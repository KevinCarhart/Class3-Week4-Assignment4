Codebook<BR>
<BR>
I. Written Guide<BR>
This codebook is based on the files features_info.txt and README.txt.  For information on variables and units, please start there because everything I have done is based on that.  The units of measure can be found in features_info.txt and README.txt.  <BR><b>Instead of paraphrasing something I semi-understand, I am going to refer you to the original up to the point where my work diverges.</b><BR>

The work that was done on the captured data was highly technical and is out of scope for what I understand, so please refer back to the original for a deep understanding.  For example, in features_info, some typical language reads as follows: "Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise..."  At present, I am a generalist and do not have intimate knowledge of what this means.  However, everything that I have done in the submitted work is subsidiary, or "subtractive".  Therefore, you should refer to the original for a deep understanding, and with few exceptions, the present work is simply a subset of that.  What follows in this codebook is a guide to just the work that has been done above and beyond the original from UCI.  In the following list of steps, I will add notes that give implications for divergence, so that you have a record of what is new, and a justification.<BR>
<BR>
(1) I downloaded the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip<BR>
<BR>
(2) I gathered an understanding of the data from reading features_info.txt and README.txt.  In order to recreate this work, please do the same.<BR>
Differences from UCI dataset? None.<BR>
<BR>
(3) I wrote an R script to combine the test and train data.<BR>
Differences from UCI dataset? None, because this simply combines what is already there.  Detail about variables and units can still be taken from the original.<BR>
<BR>
(4) I added a tag which contains either 'test' or 'train'.<BR>
Differences from UCI dataset?  Yes, this is new.  You may consider it optional.  The reference to 'test' or 'train' is stored solely in the filenames.  So when the two sets are combined with rbind(), this will be lost.  If you consider it important, you should preserve it in a column.<BR>
<BR>
(5) I used grep to find just the column names and indices for the means and standard deviations, and store these indices in an R object called "indices_with_mean_or_std".  Then, I took a subset of the columns in the original by applying this collection of indices.<BR>
Differences from UCI dataset?  No, this is entirely subtractive.  Therefore, if you require deep information on the variables and units from after this filtering step, you can refer to the original.  Nothing has been added, only subtracted.<BR>
<BR>
(6) I read in the row headers for subjects and activities, within test and train.  I combined these so that they are suitable for being attached to the data with cbind().  So far, there is no change from the original. The original subjects and activities files have simply been read in.<BR>
Differences from UCI dataset?  None.<BR>  
<BR>
(7) It is now possible to represent the activities as a readable string rather than an ID, by joining on the small table contained in activity_labels.txt.  I used merge() to bring back this detail so that future work can be done more intuitively, and adhering to the guidelines of tidy data.<BR>
Differences from UCI dataset? The activity names are stored in a new field, activity_name.  This is one of the rare cases where I removed something from the original, because once the activity_name was available, I got rid of the activity_id.  <BR>
<BR>
(8) I am adding a note here about the variables that I did *NOT* change.  The rules of tidy data state that abbreviations should be spelled out to be human-readable.  However, I think the feature names in the original are about as good as possible.  There is also a countervailing consideration where you don't want the column names to get too long.  Over at the far right side of the field name, it tells whether that field is a mean or a standard deviation - so if you make the field names very long by spelling out all the words, it may become inconvenient in its own right to have to scroll or widen a width, in order to find out what the full name says.  I think the UCI researchers did a pretty good job finding a balance.  Therefore, I have not changed the following tokens which go into the variable names:<BR>
Gravity<BR>
Acc<BR>
Body<BR>
Jerk<BR>
Gyro<BR>
Mag<BR>
X<BR>
Y<BR>
Z<BR>
mean<BR>
std<BR>
t<BR>
f<BR>
<BR>
I have not bothered to widen 'Gyro' to 'Gyroscope', for example.  I do this concertedly and not out of neglect.  These abbreviations are reasonably good already.  Therefore, the 66 means and standard deviations still have the same variable names that they had in the original.<BR>
Differences from UCI dataset?  No.  In this codebook, I am not trying to provide a detailed description of what these prefixes mean, such as 't' for time, and 'f' for frequency domain signals.  Some are intuitive and some are not.  For more, please consult README.txt and features_info.txt, because I have not changed these naming conventions at all.<BR>
<BR>
(9) There is not a comparable change to the subjects, the way there is to the activities.  Subjects are anonymized, so they will remain as numbers in the final set.  There would be nowhere to get their names from.<BR>
Differences from UCI dataset? None.<BR>
<BR>
(10) At this point, I used write.csv to generate a file named tidy_data.csv<BR>
Differences from UCI dataset? None.<BR>
<BR>
(11) The final step is to create summary statistics.  From the data in tidy_data.csv, I generated a second set called tidy_data_averages.csv.  This set contains the averages of the means and standard deviations already found, per subject per activity.  So, it contains 180 rows, because there are 30 subjects and 6 activities.<BR>
Differences from UCI dataset? The values are new, but the variable names have been left alone.  The tag representing 'test' and 'train' has been removed, but this was my addition in the first place, so it isn't a variation from UCI.  The character variables 'subject_id' and 'activity_name' have been left alone also. <BR>
<BR>
II. Guide to New Variables<BR>
<BR>
A. In the main file, tidy_data.csv<BR>
<BR>
Variable Name: experiment_step<BR>
Values: 'test', 'train'<BR>
Class: character<BR>
<BR>
Variable Name: activity_name<BR>
Values: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING", "STANDING", "LAYING"<BR>
Class: character<BR>
<BR>
B. In the summary file, tidy_data_averages.csv<BR>
<BR>
No new variables.  For detailed information on the meaning of the variable names, please refer to README.txt and features_info.txt.  And, based on the file name and the small number of rows, you can tell that these are all averages.  The variable names have been left alone, because the fact that this file contains averages is already stored in the file name and does not need to be in the variable names also.  Also, tidy_data.csv and tidy_data_averages.csv will travel as a pack, and the one file name is based on the other.  So it should always be clear that tidy_data_averages.csv contains the averages from tidy_data.  And if you want to know what the roll-up was done by, it is clear from the layout of the data that the only two variables which are character rather than numeric also contain the cartesian product of all the subjects X all the activities, for a total of 180 rows.<BR>
