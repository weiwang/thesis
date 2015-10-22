library(AER)
data('STAR')
head(STAR)
dim(STAR) # [1] 11598    47
math1 <- subset(STAR, !is.na(math1) & !is.na(star1))
math1 <- math1[, c('gender', 'ethnicity', 'star1', 'math1', 'lunch1', 'school1', 'experience1', 'schoolid1')]
dim(math1) # [1] 6600   8

## ## install.packages("RcppOctave")
## require(RcppOctave)
## path_to_gpstuff <- '~/GPStuff-4.6/'
## path <- .O$genpath(path_to_gpstuff)
## .O$addpath(path)
## o_source(paste(path_to_gpstuff, "gp/demo_regression1.m", sep=""))

