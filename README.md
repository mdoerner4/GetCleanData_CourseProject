
The R program run_analysis.R creates a data set, “CourseProject_TidyData.txt”, from the “Human Activity Recognition Using Smartphones Data Set” available at the UCI Machine Learning repository. For the program to run, the file “UCI HAR Dataset” should be in the working directory. This data is available from the UCI website.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The program combines the data from the “test” and “train” folders into one data frame. Column names are taken from the “features.txt” file, and activities are labeled using the “activity_labels.txt” file. 

Once the test and train subjects are combined, and labeling is completed, the program extracts the variables columns of the means and standard deviations of the measurements. Lastly, a tidy data set is created with the average of each of these variables for each activity and each subject.
