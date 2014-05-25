## Code Book for the Tidy Dataset

### Dataset Summary

* Number of observations (rows): 180
* Number of variables (columns): 68
* Link to the dataset:
https://s3.amazonaws.com/coursera-uploads/user-ec31ba34b1b9f904e71c05dd/972136/asst-3/beaef8f0e17811e397a98f28471dd574.txt

### Variable Selection and Renaming

Variables with the key word `mean()` or `std()` in the original variable names are included in the tidy dataset for the calculation of averages.  After the selection process is done, variables are renamed so that they are R-compatible descriptive.  For example, `tBodyAcc-std()-Z` is renamed as `timeBodyAcceleration.std.Z`.

For details, see **Phase 2: Variable Selection and Renaming** in the **"Detailed steps taken to transform the data"** section of [readme.md](https://github.com/shaple1987/DataCleaningCourseProject/blob/master/README.md).

### Description of Variables

Variable Name | Variable Description | Variable Range/Possible Value
------------ | ------------- | -------------
subject.id | ID of volunteers in the experiment | 1, 2, ... , 30
activity | Activity performed in the experiment | WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
timeBodyAcceleration.mean.X | Normalized mean value of  time of body acceleration signal in the X direction  | [-1,1]
timeBodyAcceleration.mean.Y | Normalized mean value of  time of body acceleration signal in the Y direction  | [-1,1]
timeBodyAcceleration.mean.Z | Normalized mean value of  time of body acceleration signal in the Z direction  | [-1,1]
timeBodyAcceleration.std.X | Normalized standard deviation of  time of body acceleration signal in the X direction  | [-1,1]
timeBodyAcceleration.std.Y | Normalized standard deviation of  time of body acceleration signal in the Y direction  | [-1,1]
timeBodyAcceleration.std.Z | Normalized standard deviation of  time of body acceleration signal in the Z direction  | [-1,1]
timeGravityAcceleration.mean.X | Normalized mean value of  time of gravity acceleration signal in the X direction  | [-1,1]
timeGravityAcceleration.mean.Y | Normalized mean value of  time of gravity acceleration signal in the Y direction  | [-1,1]
timeGravityAcceleration.mean.Z | Normalized mean value of  time of gravity acceleration signal in the Z direction  | [-1,1]
timeGravityAcceleration.std.X | Normalized standard deviation of  time of gravity acceleration signal in the X direction  | [-1,1]
timeGravityAcceleration.std.Y | Normalized standard deviation of  time of gravity acceleration signal in the Y direction  | [-1,1]
timeGravityAcceleration.std.Z | Normalized standard deviation of  time of gravity acceleration signal in the Z direction  | [-1,1]
timeBodyAccelerationJerk.mean.X | Normalized mean value of  time of body acceleration jerk signal in the X direction  | [-1,1]
timeBodyAccelerationJerk.mean.Y | Normalized mean value of  time of body acceleration jerk signal in the Y direction  | [-1,1]
timeBodyAccelerationJerk.mean.Z | Normalized mean value of  time of body acceleration jerk signal in the Z direction  | [-1,1]
timeBodyAccelerationJerk.std.X | Normalized standard deviation of  time of body acceleration jerk signal in the X direction  | [-1,1]
timeBodyAccelerationJerk.std.Y | Normalized standard deviation of  time of body acceleration jerk signal in the Y direction  | [-1,1]
timeBodyAccelerationJerk.std.Z | Normalized standard deviation of  time of body acceleration jerk signal in the Z direction  | [-1,1]
timeBodyGyroscope.mean.X | Normalized mean value of  time of body gyroscope signal in the X direction  | [-1,1]
timeBodyGyroscope.mean.Y | Normalized mean value of  time of body gyroscope signal in the Y direction  | [-1,1]
timeBodyGyroscope.mean.Z | Normalized mean value of  time of body gyroscope signal in the Z direction  | [-1,1]
timeBodyGyroscope.std.X | Normalized standard deviation of  time of body gyroscope signal in the X direction  | [-1,1]
timeBodyGyroscope.std.Y | Normalized standard deviation of  time of body gyroscope signal in the Y direction  | [-1,1]
timeBodyGyroscope.std.Z | Normalized standard deviation of  time of body gyroscope signal in the Z direction  | [-1,1]
timeBodyGyroscopeJerk.mean.X | Normalized mean value of  time of body gyroscope jerk signal in the X direction  | [-1,1]
timeBodyGyroscopeJerk.mean.Y | Normalized mean value of  time of body gyroscope jerk signal in the Y direction  | [-1,1]
timeBodyGyroscopeJerk.mean.Z | Normalized mean value of  time of body gyroscope jerk signal in the Z direction  | [-1,1]
timeBodyGyroscopeJerk.std.X | Normalized standard deviation of  time of body gyroscope jerk signal in the X direction  | [-1,1]
timeBodyGyroscopeJerk.std.Y | Normalized standard deviation of  time of body gyroscope jerk signal in the Y direction  | [-1,1]
timeBodyGyroscopeJerk.std.Z | Normalized standard deviation of  time of body gyroscope jerk signal in the Z direction  | [-1,1]
timeBodyAccelerationMagnitude.mean | Normalized mean value of the magnitude of time of body acceleration signal | [-1,1]
timeBodyAccelerationMagnitude.std | Normalized standard deviation of the magnitude of time of body acceleration signal | [-1,1]
timeGravityAccelerationMagnitude.mean | Normalized mean value of the magnitude of time of gravity acceleration signal | [-1,1]
timeGravityAccelerationMagnitude.std | Normalized standard deviation of the magnitude of time of gravity acceleration signal | [-1,1]
timeBodyAccelerationJerkMagnitude.mean | Normalized mean value of the magnitude of time of body acceleration jerk signal | [-1,1]
timeBodyAccelerationJerkMagnitude.std | Normalized standard deviation of the magnitude of time of body acceleration jerk signal | [-1,1]
timeBodyGyroscopeMagnitude.mean | Normalized standard deviation of the magnitude of time of body gyroscope signal | [-1,1]
timeBodyGyroscopeMagnitude.std | Normalized mean value of the magnitude of time of gravity gyroscope signal | [-1,1]
timeBodyGyroscopeJerkMagnitude.mean | Normalized mean value of the magnitude of time of body gyroscope jerk signal | [-1,1]
timeBodyGyroscopeJerkMagnitude.std | Normalized standard deviation of the magnitude of time of body gyroscope jerk signal | [-1,1]
frequencyBodyAcceleration.mean.X | Normalized mean value of frequency of body acceleration signal in the X direction  | [-1,1]
frequencyBodyAcceleration.mean.Y | Normalized mean value of frequency of body acceleration signal in the Y direction  | [-1,1]
frequencyBodyAcceleration.mean.Z | Normalized mean value of frequency of body acceleration signal in the Z direction  | [-1,1]
frequencyBodyAcceleration.std.X | Normalized standard deviation of frequency of body acceleration signal in the X direction  | [-1,1]
frequencyBodyAcceleration.std.Y | Normalized standard deviation of frequency of body acceleration signal in the Y direction  | [-1,1]
frequencyBodyAcceleration.std.Z | Normalized standard deviation of frequency of body acceleration signal in the Z direction  | [-1,1]
frequencyBodyAccelerationJerk.mean.X | Normalized mean value of frequency of body acceleration jerk signal in the X direction  | [-1,1]
frequencyBodyAccelerationJerk.mean.Y | Normalized mean value of frequency of body acceleration jerk signal in the Y direction  | [-1,1]
frequencyBodyAccelerationJerk.mean.Z | Normalized mean value of frequency of body acceleration jerk signal in the Z direction  | [-1,1]
frequencyBodyAccelerationJerk.std.X | Normalized standard deviation of frequency of body acceleration jerk signal in the X direction  | [-1,1]
frequencyBodyAccelerationJerk.std.Y | Normalized standard deviation of frequency of body acceleration jerk signal in the Y direction  | [-1,1]
frequencyBodyAccelerationJerk.std.Z | Normalized standard deviation of frequency of body acceleration jerk signal in the Z direction  | [-1,1]
frequencyBodyGyroscope.mean.X | Normalized mean value of frequency of body gyroscope signal in the X direction  | [-1,1]
frequencyBodyGyroscope.mean.Y | Normalized mean value of frequency of body gyroscope signal in the Y direction  | [-1,1]
frequencyBodyGyroscope.mean.Z | Normalized mean value of frequency of body gyroscope signal in the Z direction  | [-1,1]
frequencyBodyGyroscope.std.X | Normalized standard deviation of frequency of body gyroscope signal in the X direction  | [-1,1]
frequencyBodyGyroscope.std.Y | Normalized standard deviation of frequency of body gyroscope signal in the Y direction  | [-1,1]
frequencyBodyGyroscope.std.Z | Normalized standard deviation of frequency of body gyroscope signal in the Z direction  | [-1,1]
frequencyBodyAccelerationMagnitude.mean | Normalized mean value of the magnitude offrequency of body acceleration signal | [-1,1]
frequencyBodyAccelerationMagnitude.std | Normalized standard deviation of the magnitude offrequency of body acceleration signal | [-1,1]
frequencyBodyAccelerationJerkMagnitude.mean | Normalized mean value of the magnitude offrequency of body acceleration jerk signal | [-1,1]
frequencyBodyAccelerationJerkMagnitude.std | Normalized standard deviation of the magnitude offrequency of body acceleration jerk signal | [-1,1]
frequencyBodyGyroscopeMagnitude.mean | Normalized standard deviation of the magnitude offrequency of body gyroscope signal | [-1,1]
frequencyBodyGyroscopeMagnitude.std | Normalized mean value of the magnitude offrequency of gravity gyroscope signal | [-1,1]
frequencyBodyGyroscopeJerkMagnitude.mean | Normalized mean value of the magnitude offrequency of body gyroscope jerk signal | [-1,1]
frequencyBodyGyroscopeJerkMagnitude.std | Normalized standard deviation of the magnitude offrequency of body gyroscope jerk signal | [-1,1]


### Note
* Measurements under each varaible are normalized and bounded within [-1,1].
* Averages are calculated on each level of subject ID and activity combination (180 in total).
* See `features_info.txt` in the raw dataset for detailed description of the features.