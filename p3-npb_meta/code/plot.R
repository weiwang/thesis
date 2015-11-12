# set up ggplot theme
theme_set(theme_bw())
theme_update(legend.background = element_rect(colour="transparent", fill="transparent"),
	panel.grid.major = element_blank(),
	panel.grid.minor = element_blank()
  )

data <- read.csv("xnew.csv", header=FALSE)
names(data) <- c('mean', 'std', 'trt', 'schoolid', 'gen', 'eth', 'lunch', 'lunch_rate')
school_info <- unique(data[, c('schoolid', 'lunch_rate')])
data$schoolid <- factor(data$schoolid, levels=school_info$schoolid[order(school_info$lunch_rate)])
data$trt <- as.factor(data$trt)
library(plyr)
data$trt <- mapvalues(data$trt, from=c("1", "0", "2"), to=c("small", "regular", "regular+aide"))
data$gen <- as.factor(data$gen)
data$gen <- mapvalues(data$gen, from=c("0", "1"), to=c("female", "male"))
data$eth <- as.factor(data$eth)
data$eth <- mapvalues(data$eth, from=c("0","1"), to=c("minority","white"))
data$lunch <- as.factor(data$lunch)
data$lunch <- mapvalues(data$lunch, from=c("0", "1"), to=c("paid", "free"))


library(ggplot2)
p1 <- ggplot(data=subset(data, (lunch=="free") & (eth=="minority")), aes(x=schoolid, y=mean))
p1 <- p1 + geom_pointrange(aes(ymax=mean+std, ymin=mean-std)) + facet_grid(gen~trt) + xlab("School ID (from the most affluent to the most deprived)") + ylab("Scaled Math Score with 1 SD")
ggsave("../figures/f1.pdf")

p2 <- ggplot(data=subset(data, (lunch=="paid") & (eth=="minority")), aes(x=schoolid, y=mean))
p2 <- p2 + geom_pointrange(aes(ymax=mean+std, ymin=mean-std)) + facet_grid(gen~trt) + xlab("School ID (from the most affluent to the most deprived)") + ylab("Scaled Math Score with 1 SD")
ggsave("../figures/f2.pdf")

p3 <- ggplot(data=subset(data, (lunch=="free") & (eth=="white")), aes(x=schoolid, y=mean))
p3 <- p3 + geom_pointrange(aes(ymax=mean+std, ymin=mean-std)) + facet_grid(gen~trt) + xlab("School ID (from the most affluent to the most deprived)") + ylab("Scaled Math Score with 1 SD")
ggsave("../figures/f3.pdf")

p4 <- ggplot(data=subset(data, (lunch=="paid") & (eth=="white")), aes(x=schoolid, y=mean))
p4 <- p4 + geom_pointrange(aes(ymax=mean+std, ymin=mean-std)) + facet_grid(gen~trt) + xlab("School ID (from the most affluent to the most deprived)") + ylab("Scaled Math Score with 1 SD")
ggsave("../figures/f4.pdf")
