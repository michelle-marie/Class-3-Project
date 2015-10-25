mergedData <- merge(X_test,X_train, all = TRUE)
library(sqldf)
featuresSubset <- sqldf("select * from features where V2 like '%mean()%' or V2 like '%std()%' ")
extract <- sqldf("select 
      V1,	V2,	V3,	V4,	V5,	V6,	V41,	V42,	V43,	V44,	V45,	V46,	V81,	V82,	V83,	V84,	V85,	V86,
V121,	V122,	V123,	V124,	V125,	V126,	V161,	V162,	V163,	V164,	V165,	V166,	V201,	V202,	V214,	V215,	V227,
V228,	V240,	V241,	V253,	V254,	V266,	V267,	V268,	V269,	V270,	V271,	V345,	V346,	V347,	V348,	V349,	V350,
V424,	V425,	V426,	V427,	V428,	V429,	V503,	V504,	V516,	V517,	V529,	V530,	V542,	V543
      from mergedData
      ")
mergedLabels <- rbind(y_test,y_train)
df <- cbind(mergedLabels, extract)
colnames(df)[1] <- "Activity_ID"
colnames(activities) <- c("Activity_ID","Activity")
df2 <- merge(activities,df)
colnames(df2) <- c("Activity_ID","Activity", "tBodyAcc-mean-X",	"tBodyAcc-mean-Y",	"tBodyAcc-mean-Z",	"tBodyAcc-std-X",	"tBodyAcc-std-Y",	"tBodyAcc-std-Z",	"tGravityAcc-mean-X",	"tGravityAcc-mean-Y",	"tGravityAcc-mean-Z",	"tGravityAcc-std-X",	"tGravityAcc-std-Y",	"tGravityAcc-std-Z",	"tBodyAccJerk-mean-X",	"tBodyAccJerk-mean-Y",	"tBodyAccJerk-mean-Z",	"tBodyAccJerk-std-X",	"tBodyAccJerk-std-Y",	"tBodyAccJerk-std-Z",	"tBodyGyro-mean-X",	"tBodyGyro-mean-Y",	"tBodyGyro-mean-Z",	"tBodyGyro-std-X",	"tBodyGyro-std-Y",	"tBodyGyro-std-Z",	"tBodyGyroJerk-mean-X",	"tBodyGyroJerk-mean-Y",	"tBodyGyroJerk-mean-Z",	"tBodyGyroJerk-std-X",	"tBodyGyroJerk-std-Y",	"tBodyGyroJerk-std-Z",	"tBodyAccMag-mean",	"tBodyAccMag-std",	"tGravityAccMag-mean",	"tGravityAccMag-std",	"tBodyAccJerkMag-mean",	"tBodyAccJerkMag-std",	"tBodyGyroMag-mean",	"tBodyGyroMag-std",	"tBodyGyroJerkMag-mean",	"tBodyGyroJerkMag-std",	"fBodyAcc-mean-X",	"fBodyAcc-mean-Y",	"fBodyAcc-mean-Z",	"fBodyAcc-std-X",	"fBodyAcc-std-Y",	"fBodyAcc-std-Z",	"fBodyAccJerk-mean-X",	"fBodyAccJerk-mean-Y",	"fBodyAccJerk-mean-Z",	"fBodyAccJerk-std-X",	"fBodyAccJerk-std-Y",	"fBodyAccJerk-std-Z",	"fBodyGyro-mean-X",	"fBodyGyro-mean-Y",	"fBodyGyro-mean-Z",	"fBodyGyro-std-X",	"fBodyGyro-std-Y",	"fBodyGyro-std-Z",	"fBodyAccMag-mean",	"fBodyAccMag-std",	"fBodyBodyAccJerkMag-mean",	"fBodyBodyAccJerkMag-std",	"fBodyBodyGyroMag-mean",	"fBodyBodyGyroMag-std",	"fBodyBodyGyroJerkMag-mean",	"fBodyBodyGyroJerkMag-std")
subjects <- merge(subject_test,subject_train,all = TRUE)
df3 <- cbind(subjects,df2)
colnames(df3)[1] <- "Subject"
library(dplyr)
final <- 
  df3 %>%
  select(-Activity_ID) %>%
  group_by(Subject,Activity) %>%
  summarise_each(funs(sum))
write.table(final, file = "tidyData.txt", row.names = FALSE)
