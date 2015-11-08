library(AER)
data('STAR')
head(STAR)
dim(STAR) # [1] 11598    47
math1 <- subset(STAR, !is.na(math1) & !is.na(star1))
math1 <- math1[, c('gender', 'ethnicity', 'star1', 'math1', 'lunch1', 'school1', 'experience1', 'schoolid1')]
math1 <- math1[complete.cases(math1),]
dim(math1) # [1] 6423  8
math1_raw <- math1

math1$gender <- as.numeric(math1$gender =="male") # male=1; female=0
math1$ethnicity <- as.numeric(math1$ethnicity == "cauc") # cauc=1; mino=0;
math1$lunch1 <- as.numeric(math1$lunch1 == "free") # free=1; paid=0
math1$star1 <- as.numeric(math1$star1)-1 # regular=0; small=1; regular+aide=2;
math1$school1 <- as.numeric(math1$school1) # inncer=1; suburban=2; rural=3; urban=4;
math1$schoolid1 <- as.numeric(as.character(math1$schoolid1))
lunch1_rate <- with(math1, tapply(lunch1, schoolid1, mean))
math1$lunch1_school <- lunch1_rate[match(math1$schoolid1, names(lunch1_rate))]
#math1 <- subset(math1, star1<2) # only two treatment arms
math1_8schools <- subset(math1, schoolid1 %in% c(19, 66, 32, 22,  9, 63, 27, 51)) # 8 largest schools in star1 

write.csv(math1_8schools, "math1_8schools.csv", row.names = F)
