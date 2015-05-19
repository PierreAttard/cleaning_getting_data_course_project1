#on lit needed file
  #training set
  train_set<-read.csv("X_train1.txt", sep = " ", header = FALSE, row.names = NULL) #chaque ligne est une mesure
  train_lab<-read.csv("y_train.txt"            , header = FALSE)                #cjaque ligne est un mode de sport (walking...)
  stra     <-read.csv("subject_train.txt"      , header = FALSE)                #designe une des personnes volontaires
 
  #test set
  test_set<-read.csv("X_test.txt", sep = " ", header = FALSE, row.names = NULL)
  test_lab<-read.csv("y_test.txt"           , header = FALSE)
  strt    <-read.csv("subject_test.txt"     , header = FALSE)
  
  #features
  features<-read.csv("features.txt", sep = " ", header = FALSE)
  features<-features[,2]
  features<-as.character(features)
  features<-c("a", features)
  features
  f       <-c(features,"Subject" , "Activity" )
  
#On merge les deux sets
  
  lab       <-rbind(train_lab,     test_lab)
  subject   <-rbind(stra     ,         strt)
  mergedSet <-rbind(train_set,     test_set)
  set       <-cbind(mergedSet, subject, lab)
  names(set)<-f
  set       <-subset(set     ,select = -c(a))
  names(set)
  
#Extracts only the measurements on the mean and standard deviation for each measurement.
 
  stdMean<-f[grep("mean\\(\\)|std\\(\\)", f)]
  StdMean<-c(as.character(stdMean), "Subject", "Activity" )
  StdMean
  set_std_mean<-subset(set,select=StdMean)
  names(set_std_mean)
  
#name of activity labels
  
  nameLabel<-read.csv("activity_labels.txt", sep = " ", header = FALSE)
  nameLabel
  set_std_mean$Activity<-nameLabel[set_std_mean$Activity,2]
  set_std_mean$Activity
  
#question 4
  names(set_std_mean)<-gsub("^t"      , "time"         , names(set_std_mean))
  names(set_std_mean)<-gsub("^f"      , "frequency"    , names(set_std_mean))
  names(set_std_mean)<-gsub("Acc"     , "Accelerometer", names(set_std_mean))
  names(set_std_mean)<-gsub("Gyro"    , "Gyroscope"    , names(set_std_mean))
  names(set_std_mean)<-gsub("Mag"     , "Magnitude"    , names(set_std_mean))
  names(set_std_mean)<-gsub("BodyBody", "Body"         , names(set_std_mean))
  names(set_std_mean)
 #question 5
  library(plyr);
  set2<-aggregate(. ~Subject + Activity, set_std_mean, mean)
  set2<-set2[order(set2$Subject,set2$Activity),]
  write.table(set2, file = "tidydata.txt",row.name=FALSE)
  
  library(knitr)
  knit2html("codebook.Rmd")
