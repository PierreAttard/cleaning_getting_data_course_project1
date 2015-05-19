---
title: "codebook"
output: html_document
---

**We read the needed files**

```r
#on lit needed file
  #training set
  train_set<-read.csv("X_train.txt",  sep = " ", header = FALSE, row.names = NULL) 
  train_lab<-read.csv("y_train.txt"            , header = FALSE)                
  stra     <-read.csv("subject_train.txt"      , header = FALSE)                
 
  #test set
  test_set<-read.csv("X_test.txt", sep = " ", header = FALSE, row.names = NULL)
  test_lab<-read.csv("y_test.txt"           , header = FALSE)
  strt    <-read.csv("subject_test.txt"     , header = FALSE)
```

*Preparation of the variables names*

```r
  #features
  features<-read.csv("features.txt", sep = " ", header = FALSE)
  features<-features[,2]
  features<-as.character(features)
  features<-c("a", features)
  f       <-c(features,"Subject" , "Activity" )
```

**Merges the training and the test sets to create one data set.**

```r
#On merge les deux sets
  
  lab       <-rbind(train_lab,     test_lab)
  subject   <-rbind(stra     ,         strt)
  mergedSet <-rbind(train_set,     test_set)
  set       <-cbind(mergedSet, subject, lab)
  names(set)<-f
  set       <-subset(set     ,select = -c(a))
```

**Extracts only the measurements on the mean and standard deviation for each measurement.**

```r
#Extracts only the measurements on the mean and standard deviation for each measurement.
 
  stdMean<-f[grep("mean\\(\\)|std\\(\\)", f)]
  StdMean<-c(as.character(stdMean), "Subject", "Activity" )
  set_std_mean<-subset(set,select=StdMean)
  names(set_std_mean)
```

```
##  [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
##  [3] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
##  [5] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
##  [7] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
##  [9] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
## [11] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
## [13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
## [15] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
## [17] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
## [19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
## [21] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
## [23] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
## [25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
## [27] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
## [29] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
## [31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
## [33] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
## [35] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
## [37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
## [39] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
## [41] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
## [43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
## [45] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
## [47] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
## [49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
## [51] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
## [53] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
## [55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
## [57] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
## [59] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
## [61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
## [63] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
## [65] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 
## [67] "Subject"                     "Activity"
```

**Uses descriptive activity names to name the activities in the data set**

```r
#name of activity labels
  
  nameLabel<-read.csv("activity_labels.txt", sep = " ", header = FALSE)
  set_std_mean$Activity<-nameLabel[set_std_mean$Activity,2]
  head(set_std_mean$Activity, n = 20)
```

```
##  [1] STANDING STANDING STANDING STANDING STANDING STANDING STANDING
##  [8] STANDING STANDING STANDING STANDING STANDING STANDING STANDING
## [15] STANDING STANDING STANDING STANDING STANDING STANDING
## 6 Levels: LAYING SITTING STANDING WALKING ... WALKING_UPSTAIRS
```

**Appropriately labels the data set with descriptive variable names. **

```r
#question 4
  names(set_std_mean)<-gsub("^t"      , "time"         , names(set_std_mean))
  names(set_std_mean)<-gsub("^f"      , "frequency"    , names(set_std_mean))
  names(set_std_mean)<-gsub("Acc"     , "Accelerometer", names(set_std_mean))
  names(set_std_mean)<-gsub("Gyro"    , "Gyroscope"    , names(set_std_mean))
  names(set_std_mean)<-gsub("Mag"     , "Magnitude"    , names(set_std_mean))
  names(set_std_mean)<-gsub("BodyBody", "Body"         , names(set_std_mean))
  names(set_std_mean)
```

```
##  [1] "timeBodyAccelerometer-mean()-X"                
##  [2] "timeBodyAccelerometer-mean()-Y"                
##  [3] "timeBodyAccelerometer-mean()-Z"                
##  [4] "timeBodyAccelerometer-std()-X"                 
##  [5] "timeBodyAccelerometer-std()-Y"                 
##  [6] "timeBodyAccelerometer-std()-Z"                 
##  [7] "timeGravityAccelerometer-mean()-X"             
##  [8] "timeGravityAccelerometer-mean()-Y"             
##  [9] "timeGravityAccelerometer-mean()-Z"             
## [10] "timeGravityAccelerometer-std()-X"              
## [11] "timeGravityAccelerometer-std()-Y"              
## [12] "timeGravityAccelerometer-std()-Z"              
## [13] "timeBodyAccelerometerJerk-mean()-X"            
## [14] "timeBodyAccelerometerJerk-mean()-Y"            
## [15] "timeBodyAccelerometerJerk-mean()-Z"            
## [16] "timeBodyAccelerometerJerk-std()-X"             
## [17] "timeBodyAccelerometerJerk-std()-Y"             
## [18] "timeBodyAccelerometerJerk-std()-Z"             
## [19] "timeBodyGyroscope-mean()-X"                    
## [20] "timeBodyGyroscope-mean()-Y"                    
## [21] "timeBodyGyroscope-mean()-Z"                    
## [22] "timeBodyGyroscope-std()-X"                     
## [23] "timeBodyGyroscope-std()-Y"                     
## [24] "timeBodyGyroscope-std()-Z"                     
## [25] "timeBodyGyroscopeJerk-mean()-X"                
## [26] "timeBodyGyroscopeJerk-mean()-Y"                
## [27] "timeBodyGyroscopeJerk-mean()-Z"                
## [28] "timeBodyGyroscopeJerk-std()-X"                 
## [29] "timeBodyGyroscopeJerk-std()-Y"                 
## [30] "timeBodyGyroscopeJerk-std()-Z"                 
## [31] "timeBodyAccelerometerMagnitude-mean()"         
## [32] "timeBodyAccelerometerMagnitude-std()"          
## [33] "timeGravityAccelerometerMagnitude-mean()"      
## [34] "timeGravityAccelerometerMagnitude-std()"       
## [35] "timeBodyAccelerometerJerkMagnitude-mean()"     
## [36] "timeBodyAccelerometerJerkMagnitude-std()"      
## [37] "timeBodyGyroscopeMagnitude-mean()"             
## [38] "timeBodyGyroscopeMagnitude-std()"              
## [39] "timeBodyGyroscopeJerkMagnitude-mean()"         
## [40] "timeBodyGyroscopeJerkMagnitude-std()"          
## [41] "frequencyBodyAccelerometer-mean()-X"           
## [42] "frequencyBodyAccelerometer-mean()-Y"           
## [43] "frequencyBodyAccelerometer-mean()-Z"           
## [44] "frequencyBodyAccelerometer-std()-X"            
## [45] "frequencyBodyAccelerometer-std()-Y"            
## [46] "frequencyBodyAccelerometer-std()-Z"            
## [47] "frequencyBodyAccelerometerJerk-mean()-X"       
## [48] "frequencyBodyAccelerometerJerk-mean()-Y"       
## [49] "frequencyBodyAccelerometerJerk-mean()-Z"       
## [50] "frequencyBodyAccelerometerJerk-std()-X"        
## [51] "frequencyBodyAccelerometerJerk-std()-Y"        
## [52] "frequencyBodyAccelerometerJerk-std()-Z"        
## [53] "frequencyBodyGyroscope-mean()-X"               
## [54] "frequencyBodyGyroscope-mean()-Y"               
## [55] "frequencyBodyGyroscope-mean()-Z"               
## [56] "frequencyBodyGyroscope-std()-X"                
## [57] "frequencyBodyGyroscope-std()-Y"                
## [58] "frequencyBodyGyroscope-std()-Z"                
## [59] "frequencyBodyAccelerometerMagnitude-mean()"    
## [60] "frequencyBodyAccelerometerMagnitude-std()"     
## [61] "frequencyBodyAccelerometerJerkMagnitude-mean()"
## [62] "frequencyBodyAccelerometerJerkMagnitude-std()" 
## [63] "frequencyBodyGyroscopeMagnitude-mean()"        
## [64] "frequencyBodyGyroscopeMagnitude-std()"         
## [65] "frequencyBodyGyroscopeJerkMagnitude-mean()"    
## [66] "frequencyBodyGyroscopeJerkMagnitude-std()"     
## [67] "Subject"                                       
## [68] "Activity"
```

**From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

```r
 #question 5
  library(plyr);
  set2<-aggregate(. ~Subject + Activity, set_std_mean, mean)
  set2<-set2[order(set2$Subject,set2$Activity),]
  write.table(set2, file = "tidydata.txt",row.name=FALSE)
  data<-read.csv("tidydata.txt", sep =" ", header = TRUE)
  View(head(data, n = 30))

  library(knitr)
  knit2html("codebook.Rmd")
```

```
## 
## 
## processing file: codebook.Rmd
```

```
##   |                                                                         |                                                                 |   0%  |                                                                         |.....                                                            |   7%
##   ordinary text without R code
## 
##   |                                                                         |.........                                                        |  14%
## label: unnamed-chunk-8
##   |                                                                         |..............                                                   |  21%
##   ordinary text without R code
## 
##   |                                                                         |...................                                              |  29%
## label: unnamed-chunk-9
##   |                                                                         |.......................                                          |  36%
##   ordinary text without R code
## 
##   |                                                                         |............................                                     |  43%
## label: unnamed-chunk-10
##   |                                                                         |................................                                 |  50%
##   ordinary text without R code
## 
##   |                                                                         |.....................................                            |  57%
## label: unnamed-chunk-11
##   |                                                                         |..........................................                       |  64%
##   ordinary text without R code
## 
##   |                                                                         |..............................................                   |  71%
## label: unnamed-chunk-12
##   |                                                                         |...................................................              |  79%
##   ordinary text without R code
## 
##   |                                                                         |........................................................         |  86%
## label: unnamed-chunk-13
##   |                                                                         |............................................................     |  93%
##   ordinary text without R code
## 
##   |                                                                         |.................................................................| 100%
## label: unnamed-chunk-14
```

```
## output file: codebook.md
```
