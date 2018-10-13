download.file(url="https://github.com/EEB504/EEB504/raw/master/GitR/dirtivore.rda", destfile="dirtivore.rda") # you only have to do this once
load("dirtivore.rda"); ls() # load the dataset into the current R workspace and see what is in the workspace

non_numeric_indices <- which(is.na(as.numeric(dirtivore_df$rMax))) # may be helpful
non_numeric_indices # inspect which objects do not convert cleanly to numeric class
unique(gsub("\\d+\\.\\d+","", dirtivore_df$rMax[non_numeric_indices]))
