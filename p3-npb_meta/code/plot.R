data <- read.csv("xnew.csv", header=FALSE)
names(data) <- c('mean', 'std', 'trt', 'schoolid', 'gen', 'eth', 'lunch', 'lunch_rate')
school_info <- unique(data[, c('schoolid', 'lunch_rate')])
data$schoolid <- factor(data$schoolid, levels=school_info$schoolid[order(school_info$lunch_rate)])
data$trt <- as.factor(data$trt)

library(ggplot2)
p <- ggplot(data=subset(data, (lunch==1) & (eth==0)), aes(x=schoolid, y=mean))
p + geom_pointrange(aes(ymax=mean+std, ymin=mean-std), position='jitter') + facet_grid(gen~trt)
