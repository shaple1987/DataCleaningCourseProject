# clean.measurement: user-defined function for cleaning the measurement data
# used in steps 4.2 and 5.2
clean.measurement <- function(input,output) { # input: raw data (as TXT file), output: cleaned data (as R data.frame)
n<-length(input) # get number of observations
output<-unlist(strsplit(input," ")) # split the raw data character sequence by space
output<-output[output!=""] # remove "gaps" in measurement figures caused by extra spaces in the raw data file
output<-t(matrix(output,nrow=561,ncol=n)) # reshape the raw data sequence
output<-output[,column.selected] # subset the data to only include measures relating to mean and standard deviation
output<-apply(output,2,as.numeric) # convert measurements to numeric values
output<-data.frame(output,stringsAsFactors = FALSE) # convert the cleaned data to R data.frame
colnames(output)=features.selected$feature.text.standardized
output
}

setwd("D:\\My Documents\\ÍÃ Ñ§Ï°\\Coursera\\Getting and Cleaning Data\\Course Project")

# Step 1: Clean activity labels
activity.labels.raw<-readLines("./UCI HAR Dataset/activity_labels.txt")
activity.labels<-unlist(strsplit(activity.labels.raw," ")) # split the raw data character sequence by space
activity.labels<-t(matrix(activity.labels,nrow=2,ncol=6)) # reshape the raw data sequence
activity.labels<-data.frame(activity.labels,stringsAsFactors = FALSE) # convert the cleaned data to R data.frame
colnames(activity.labels)=c("activity.label.code","activity")

# Step 2: Clean features
features.raw<-readLines("./UCI HAR Dataset/features.txt")
features<-unlist(strsplit(features.raw," ")) # split the raw data character sequence by space
features<-t(matrix(features,nrow=2,ncol=561)) # reshape the raw data sequence
features<-data.frame(features,stringsAsFactors = FALSE) # convert the cleaned data to R data.frame
colnames(features)<-c("feature.code","feature.text")

# Step 3: Extract features of interest (mean and standard deviation only) and standardize feature names 

# 3.1: Extract features of interest
meanlist<-grepl("mean()",features$feature.text,fixed=T) # get the row indices for mean-related measurments (those with key word "mean()")
stdlist<-grepl("std()",features$feature.text,fixed=T) # get the row indices for standard deviation-related measurments (those with key word "std()")
features.selected<-features[meanlist|stdlist,]
column.selected<-as.numeric(features.selected$feature.code) # get the column indices in the complete measurement matrix for the measurements of interest

# 3.2: Standardize feature names and make them descriptive
s<-gsub("mean()","mean",features.selected$feature.text,fixed=T)
s<-gsub("std()","std",s,fixed=T)
s<-gsub("-",".",s,fixed=T)
s<-gsub("fBodyBody","fBody",s,fixed=T)
s<-gsub("Acc","Acceleration",s,fixed=T)
s<-gsub("Mag","Magnitude",s,fixed=T)
s<-gsub("Gyro","Gyroscope",s,fixed=T)
s1<-substr(s,1,1) # extract first letter of the variable name to determine whether it is a time dimension or frequency dimension variable
s[s1=="t"]<- sub("t","time",s[s1=="t"],fixed=T)
s[s1=="f"]<- sub("f","frequency",s[s1=="f"],fixed=T)

features.selected<-cbind(features.selected,feature.text.standardized=s)

# Step 4: Clean test data

# 4.1: Read in raw data X_test, y_test, and subject_test
x.test.raw<-readLines("./UCI HAR Dataset/test/X_test.txt")
y.test.raw<-readLines("./UCI HAR Dataset/test/y_test.txt")
subject.test.raw<-readLines("./UCI HAR Dataset/test/subject_test.txt")

# 4.2: Clean X_test (measurement in the test group)
x.test<-clean.measurement(x.test.raw)  # call user-defined function clean.measurement to clean the measurement data

# 4.3: Assemble the tidy dataset for test group and specify data source being "test"
tidy.dataset.test<-cbind(source="test",subject.id=subject.test.raw,activity.label.code=y.test.raw,x.test)

# 4.4: Obtain descriptive names for activities
tidy.dataset.test<-merge(tidy.dataset.test,activity.labels,by="activity.label.code",sort=F) # merge English descriptions with the numerical codes

# 4.5: Reorganize the columns of the tidy dataset
tidy.dataset.test<-tidy.dataset.test[,c("source","subject.id","activity",as.character(features.selected$feature.text.standardized))]

# 4.6: Remove raw data files from memory
rm(x.test.raw)
rm(y.test.raw)
rm(subject.test.raw)

# Step 5: Clean train data

# 5.1: Read in raw data X_train, y_train, and subject_train
x.train.raw<-readLines("./UCI HAR Dataset/train/X_train.txt")
y.train.raw<-readLines("./UCI HAR Dataset/train/y_train.txt")
subject.train.raw<-readLines("./UCI HAR Dataset/train/subject_train.txt")

# 5.2: Clean X_train (measurement in the train group)
x.train<-clean.measurement(x.train.raw) # call user-defined function clean.measurement to clean the measurement data

# 5.3: Assemble the tidy dataset for train group and specify data source being "train"
tidy.dataset.train<-cbind(source="train",subject.id=subject.train.raw,activity.label.code=y.train.raw,x.train)

# 5.4: Obtain descriptive names for activities
tidy.dataset.train<-merge(tidy.dataset.train,activity.labels,by="activity.label.code",sort=F) # merge English descriptions with the numerical codes

# 5.5: Reorganize the columns of the tidy dataset
tidy.dataset.train<-tidy.dataset.train[,c("source","subject.id","activity",as.character(features.selected$feature.text.standardized))]

# 5.6: Remove raw data files from memory
rm(x.train.raw)
rm(y.train.raw)
rm(subject.train.raw)

# Step 6: Combine test and train data
tidy.dataset<-rbind(tidy.dataset.test, tidy.dataset.train)
colnames(tidy.dataset)<-colnames(tidy.dataset.test)

# Step 7: Calculate measurement average by subject and activity
mean.col.index<-4:dim(tidy.dataset)[2] # index number of columns for which average is calculated
group.by.var<-interaction(tidy.dataset$subject.id,tidy.dataset$activity) # "group-by" variable in the average calculation
s<-split(tidy.dataset,group.by.var,drop=TRUE) # split the dataset by the "group-by" variable
tidy.dataset.average<-t(sapply(s,function(x) colMeans(x[,mean.col.index]))) # calculate column means for designated columns
tidy.dataset.average<-cbind(key=rownames(tidy.dataset.average),tidy.dataset.average) # retrieve the "group-by" variable from row names and set it as the key
key.table<-unique(cbind(tidy.dataset[,c("subject.id","activity")],key=as.character(group.by.var))) # key table which contains the map between the "group-by" variable and each underlying component
tidy.dataset.average<-merge(key.table,tidy.dataset.average,by="key",sort=F) # retrieve the two underlying component within the grouping
ncol<-dim(tidy.dataset.average)[2]
tidy.dataset.average<-tidy.dataset.average[,2:ncol] # drop the key in the final dataset output

# Step 8: Output the tidy dataset which contains measurement average to a tab-delimited TXT file and clean up workspace
write.table(tidy.dataset.average,"tidy_dataset_average.txt",sep="\t",row.names = FALSE)
rm(list=ls()) # clean up workspace