## ReadMe for the Data Cleaning Project on UCI HAR Dataset

### Overview

This project involves cleaning, merging, and transforming data in the UCI HAR Dataset (available at [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)) in order to produce a tidy dataset that contains summary statistics of selected measurements in the raw dataset.

See [codebook.md](https://github.com/shaple1987/DataCleaningCourseProject/blob/master/codebook.md) for details on the variables in the tidy dataset.  This readme.md file instead focuses on the steps involved to transform the data from its very raw form to the final output (i.e. the tidy datset).

In short, there are two steps:

1. Download the raw data zip file, and save the unzipped dataset within the working directory of R.
2. Run the scripts in [run_analysis.R](https://github.com/shaple1987/DataCleaningCourseProject/blob/master/run_analysis.R).

### Raw Data

The raw data come in the form of a zip file.  The unzipped version contains four txt files (`activity_labels.txt`, `features.txt`, `features_info.txt`, and `README.txt`) and two folders (`test` and `train`).

#### The txt Files
It is recommended that the user of this dataset first reads `README.txt` and `features_info.txt` to gain an
understanding on the big picture of this dataset before continue reading this document.

The actual data are stored in `activity_labels.txt`, `features.txt`, as well as within the two folders.

`Activity_labels.txt` is a map between activity code (1 to 6) to the corresponding descriptive text (e.g. WALKING, STANDING, 

etc.)  `README.txt` provides the context of those six activities:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person 
performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

Analogusly, `features.txt` is a map between variable code (1 to 561) to the corresponding variable name.  Each variable, as 
a column in the raw dataset, represents a certain measurement (e.g. mean, standard deviation, etc.) on a list of "features", which in turn are estimated from the accelerometer and gyroscope 3-axial raw signals.  See `features_into.txt`
for details.

#### The Folders - Overview
The `test` and `train` folders contain the bulk of the data in the raw dataset.  The reason why there are two folders is 
because the raw dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for 
generating the training data and 30% the test data.

_The two folders have exactly the same internal strcture._  For the purposes of this project, the summary statistics are calculated on the **merged** dataset from the test and train data.  

#### The Folders - Internal Structure

Next I illustrate the internal strcture of those two folders using the test data as an example.

Within the `test` folder, there are three txt files (`X_test.txt`, `y_test.txt`, and `subject_test.txt`) and a subfolder (`Inertial Signals`).

* `X_test.txt` contains the measurements of all the 561 variables in the raw dataset for each observation. Note that the variable code (1 to 561) corresponds to the sequence of the variable in the raw dataset.
* `y_test.txt` contains the corresponding activity code for each observation.
* `subject_test.txt` records the subject ID (from 1 to 30) on which a certain experiment is performed from which the measurements were obtained.
* The subfolder`Inertial Signals` contains even "lower level" raw signal data from which the measurements in the `X_test.txt` are derived.  For the purposes of this project, the data in this folder are not used.


### Detailed Steps Taken to Transform the Data

Logically, the steps can be grouped into five phrases: **map cleaning, variable selection and renaming, measurement data cleaning and merging (for the selected variables), summary statistics calculation, and tidy data output.** 

#### Phase 1: Map Cleaning

The first phrase corresponds to steps 1 and 2 as described in the R script.  Step 1 cleans the map for activities (between 
code and descriptive text), and step 2 cleans the map for variables (between code, or sequence in the raw dataset, and variable name).  The map cleaning process is logically the same, so I will use "activities" to illustrate the process.

* First, read in raw data.

```
activity.labels.raw<-readLines("./UCI HAR Dataset/activity_labels.txt")
```

(Note that the raw data are in the form of strings of characters, delimited by space.)

* Then, use `strsplit` function to split the variables and `matrix` function to reshape the data.

```
activity.labels<-unlist(strsplit(activity.labels.raw," "))
activity.labels<-t(matrix(activity.labels,nrow=2,ncol=6))
```
* Finally, convert the data to data frame and label the columns.  The resulting data frame has **6 rows and 2 columns**.

```
activity.labels<-data.frame(activity.labels,stringsAsFactors = FALSE)
colnames(activity.labels)=c("activity.label.code","activity")
```

The same procedures apply for the map for variables.  The resulting data frame has **561 rows and 2 columns**.

```
features.raw<-readLines("./UCI HAR Dataset/features.txt")
features<-unlist(strsplit(features.raw," "))
features<-t(matrix(features,nrow=2,ncol=561))
features<-data.frame(features,stringsAsFactors = FALSE)
colnames(features)<-c("feature.code","feature.text")
```

#### Phase 2: Variable Selection and Renaming

The second phrase corresponds to step 3 as described in the R script.  According to the project instruction, the tidy dataset should only include summary statistics for the measurement of mean and standard deviation for the underlying features.  Therefore, one needs to subset a list of "relevant" variables from the complete set of 561 variables.  In addition, the variables are renamed so that the names are more descriptive.

* First, search for key words `mean()` and `std()` in the list of variable names in the map obtained in the previous phase.  Variables that contain either key word is considered "relevant" and will be included in the "short list".  As an auxiliary step, I store the column indices for those selected variables in a vector called `column.selected` in order for identifying the relevant columns in the raw dataset in the following steps.

```
meanlist<-grepl("mean()",features$feature.text,fixed=T)
stdlist<-grepl("std()",features$feature.text,fixed=T)
features.selected<-features[meanlist|stdlist,]
column.selected<-as.numeric(features.selected$feature.code)
```

* Then, rename the selected variables to make them R-compatible (e.g. removing `()`) and more descriptive (e.g. use "Acceleration" instead of "Acc", "frequency" instead of "f", etc.).  Also, typos in the original variable names are corrected (e.g. "fBodyBody" is corrected as "fBody").

```
s<-gsub("mean()","mean",features.selected$feature.text,fixed=T)
s<-gsub("std()","std",s,fixed=T)
s<-gsub("-",".",s,fixed=T)
s<-gsub("fBodyBody","fBody",s,fixed=T)
s<-gsub("Acc","Acceleration",s,fixed=T)
s<-gsub("Mag","Magnitude",s,fixed=T)
s<-gsub("Gyro","Gyroscope",s,fixed=T)
s1<-substr(s,1,1)
s[s1=="t"]<- sub("t","time",s[s1=="t"],fixed=T)
s[s1=="f"]<- sub("f","frequency",s[s1=="f"],fixed=T)
```

* Finally, append the new variable names as a new column to the original variable map.

```
features.selected<-cbind(features.selected,feature.text.standardized=s)
```

#### Phase 3: Measurement Data Cleaning and Merging

The third phrase corresponds to steps 4 through 6 as described in the R script.  This phrase is the first of the two "core" phrases in this data cleaning project, as opposed to the previous phases which are more "preparatory" in nature.  Steps 4 and 5 are logically the same, one for cleaning test data (step 4) and one for cleaning train data (step 5.)  I will illustrate the process using the test data.  Step 6 simply merges the cleaned test and train data.

Details on cleaning test data:

* First, read in raw data (which may take some time as the dataset is big.)

```
x.test.raw<-readLines("./UCI HAR Dataset/test/X_test.txt")
y.test.raw<-readLines("./UCI HAR Dataset/test/y_test.txt")
subject.test.raw<-readLines("./UCI HAR Dataset/test/subject_test.txt")
```

* Second, clean the measurements within `X_test.txt`.  Note that this process is encapsulated in a user-defined function `clean.measurement` which takes the raw data as the input and a cleaned dataframe (which only include the variables selected in the previous phase).  Let's look at the user-defined function in details.

```
clean.measurement <- function(input,output) {
    # code here (see below for details)
}
```

1. Use `strsplit` function to split the variables and `matrix` function to reshape the data.  The output matrix has `n` rows (where n is the number of observations (i.e. number of rows) in the raw dataset) and 561 columns.  Note at this stage, the dataset has not been subset in columns.

```
n<-length(input)
output<-unlist(strsplit(input," "))
output<-output[output!=""]
output<-t(matrix(output,nrow=561,ncol=n))
```

2. Column-subset the dataset to include only variables of interest (mean and  standard deviation related).

```
output<-output[,column.selected]
```

3. Convert measurement data to numerics.

```
output<-apply(output,2,as.numeric)
```

4. Convert the data to data frame, label the columns, and returned the cleaned data frame to the calling environment. 

```
output<-data.frame(output,stringsAsFactors = FALSE)
colnames(output)=features.selected$feature.text.standardizedoutput
```

* Third, append the subject ID and activity code column to the measurement columns.  Also, label the source of the observations as "test".

```
tidy.dataset.test<-cbind(source="test",subject.id=subject.test.raw,activity.label.code=y.test.raw,x.test)
```

* Fourth, merge the descriptive activity names onto the cleaned data frame

```
tidy.dataset.test<-merge(tidy.dataset.test,activity.labels,by="activity.label.code",sort=F)
```

* Lastly, reorganize the columns of the tidy dataset and clean up the memory space.  The final output of this step is `tidy.dataset.test`.

```
tidy.dataset.test<-tidy.dataset.test[,c("source","subject.id","activity",as.character(features.selected$feature.text.standardized))]
rm(x.test.raw)
rm(y.test.raw)
rm(subject.test.raw)
```

The same procedures apply (in step 5) for cleaning train data.  The final output of this step is `tidy.dataset.train`.  For brevity, the full R script is not reproduced.

Step 6 simply combines test and train data.

```
tidy.dataset<-rbind(tidy.dataset.test, tidy.dataset.train)
colnames(tidy.dataset)<-colnames(tidy.dataset.test)
```

#### Phase 4: Summary Statistics Calculation

The fourth phrase corresponds to step 7 as described in the R script.  This phrase is the second of the two "core" phrases in this data cleaning project, and is perhaps the most computationally-intensive phase.

* First, determine columns on which the average is calculated and define "group-by" variable as the interaction of subject ID and activity (i.e. average is calculate for each level of subject ID and activity combination.)

```
mean.col.index<-4:dim(tidy.dataset)[2]
group.by.var<-interaction(tidy.dataset$subject.id,tidy.dataset$activity)
```

* Second, split the cleaned dataset by the "group-by" variable, dropping empty levels by specifying `drop=TRUE`.

```
s<-split(tidy.dataset,group.by.var,drop=TRUE)
```

* Third, calculate average by each level of "group-by" variable.

```
tidy.dataset.average<-t(sapply(s,function(x) colMeans(x[,mean.col.index])))
```

* Fourth, append the original subject ID and activity label for each row of calculated average and drop the "group-by" variable in the final dataset output.

```
tidy.dataset.average<-cbind(key=rownames(tidy.dataset.average),tidy.dataset.average)
key.table<-unique(cbind(tidy.dataset[,c("subject.id","activity")],key=as.character(group.by.var)))
tidy.dataset.average<-merge(key.table,tidy.dataset.average,by="key",sort=F)
ncol<-dim(tidy.dataset.average)[2]
tidy.dataset.average<-tidy.dataset.average[,2:ncol]
```

#### Phase 5: Tidy Data Output

The fifth phrase corresponds to step 8 as described in the R script.  This is the last phase in this project, which simply outputs the tidy dataset (the one that contains calculated averages) as a tab-delimited txt file, and finally clean up the workspace.

```
write.table(tidy.dataset.average,"tidy_dataset_average.txt",sep="\t",row.names = FALSE)
rm(list=ls()) # clean up workspace
```