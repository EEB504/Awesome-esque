download.file(url="https://github.com/EEB504/EEB504/raw/master/GitR/dirtivore.rda", destfile="dirtivore.rda") # you only have to do this once
load("dirtivore.rda"); ls() # load the dataset into the current R workspace and see what is in the workspace

non_numeric_indices <- which(is.na(as.numeric(dirtivore_df$rMax))) # may be helpful
non_numeric_indices # inspect which objects do not convert cleanly to numeric class
unique(gsub("\\d+\\.\\d+","", dirtivore_df$rMax[non_numeric_indices]))
unique(gsub("\\d+\\.\\d+","", dirtivore_df$MassKG[non_numeric_indices]))
unique(gsub("\\d+\\.\\d+","", dirtivore_df$Herbivory[non_numeric_indices]))

# delete the patterns
dirtivore_clean <- lapply(dirtivore_df, gsub, pattern="rmaxmaxmax", replacement="", fixed=TRUE)
dirtivore_clean <- lapply(dirtivore_clean, gsub, pattern="pewpewpew", replacement="", fixed=TRUE)

# back to df
dirtivore_df_clean <- data.frame(matrix(unlist(dirtivore_clean), nrow=168, byrow=F),stringsAsFactors=FALSE)
#names
colnames(dirtivore_df_clean) <- colnames(dirtivore_df)


#Check
non_numeric_indices2 <- which(is.na(as.numeric(dirtivore_df_clean$rMax))) # may be helpful
non_numeric_indices2 # inspect which objects do not convert cleanly to

head(dirtivore_df)

dirtivore_df <- dirtivore_df_clean
dirtivore_df$rMax <- log10(as.numeric(dirtivore_df$rMax))
dirtivore_df$MassKG <- log10(as.numeric(dirtivore_df$MassKG))

model <- lm(rMax~MassKG, data = dirtivore_df)

plot(dirtivore_df$MassKG, dirtivore_df$rMax, pch = 16, cex = 1.3, col = "grey", xlab = expression('Body Mass (Log'[10]*' Kg)'), ylab = expression('r'['max']*'(Log'[10]*') Kg)'))
abline(model)
