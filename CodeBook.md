The run_analysis.R download the data set and then use 5 steps as required to
meet the project's request.

1.0 Download the data set and extract to directory "UCI HAR Dataset"

1.1 Read files using "read.table"
1.1.1 Read train files and check dim
1.1.2 Read test files and check dim
1.1.3 Read activity labels and check dim
1.1.4 Read features and check dims

1.2 Rename the column names of each file using "colnames"

1.3 Combine data
1.3.1 combine train/test files using "cbind"
1.3.2 combine train and test using "rbind"

2.0 Extract mean and sd of measurements

2.1 Find mean/sd column position using "grepl"

2.2 Subset data by using result from 2.1

3.0 Merge subsetted data with Activity_labels file by "activity_label" using "merge"

4.0 Appropriately labels the data set with descriptive variable names using "gsub"

5.0 Average data to get a final data by using library(dplyr) "group_by", "select", "summarise_all", and "write.table" to export to txt file

