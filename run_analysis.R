##This R script creates a data set, 
#“CourseProject_TidyData.txt”, from the 
#“Human Activity Recognition Using Smartphones Data Set” 
#available at the UCI Machine Learning repository.

##The data set created has 
#the average of each of these variables 
#for each activity and each subject.

##The file “UCI HAR Dataset” should be in the working directory.

##read all data files into R
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/Y_test.txt")
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/Y_train.txt")

##create colnames from features
cname1 <- tolower(features[,2])
cname2 <- sub("\\()-","", cname1)
cname3 <- sub("-","", cname2)
cnamef <- sub("\\()","", cname3)

##for X data tables, assign column names from cnamef
colnames(xtest) <- cnamef
colnames(xtrain) <- cnamef

##add training label from Y and rename activity variables
activitylabels[,2] <- tolower(activitylabels[,2])
colnames(activitylabels) <- c("number", "activity")
ytest_act <- merge(ytest, activitylabels,by.x="V1", by.y="number",all=TRUE)
ytest_activity <- data.frame(ytest_act[,2])
colnames(ytest_activity) <- "activity"
ytrain_act <- merge(ytrain, activitylabels,by.x="V1", by.y="number",all=TRUE)
ytrain_activity <- data.frame(ytrain_act[,2])
colnames(ytrain_activity) <- "activity"

##add subject to X data table
colnames(subjecttest) <- "subject"
colnames(subjecttrain) <- "subject"

testdata <- cbind(subjecttest,ytest_activity,xtest)
traindata <- cbind(subjecttrain,ytrain_activity,xtrain)

##combine test and train data to one data frame
alldata <- rbind(testdata, traindata)

##create new data frame will only the mean and st columns
meanstddata <- alldata[,1:2]
for(i in 1:5) {
  meanstddata <- data.frame(meanstddata, alldata[,((i*40)-37):((i*40)-32)])
}
for(i in 1:5) {
  meanstddata <- data.frame(meanstddata, alldata[,((i*13)+190):((i*13)+191)])
}
for(i in 1:3) {
  meanstddata <- data.frame(meanstddata, alldata[,((i*79)+189):((i*79)+194)])
}
for(i in 1:4) {
  meanstddata <- data.frame(meanstddata, alldata[,((i*13)+492):((i*13)+493)])
}

##write tidy data summary file
library(reshape2)
datamelt <- melt(meanstddata, id=c("subject", "activity"))
datatidy <- dcast(datamelt, subject + activity ~ variable,mean)

write.table(datatidy, "CourseProject_TidyData.txt", sep = "\t")

