#load packages
library(reshape2)
library(ggplot2)
library(ggpubr)
library(psych)
library(tidyverse)
library(rstatix)
library(Hmisc)
library(Rmisc)
# plot and analyse average flow scores by dispositional flow
#extract relevant data from combined_eeg dataframe (aov stands for "data we want to fit an analysis of variance model on" )
aov_dataset <- combined_eeg[,c("Participant","Flow_average","NF_average","NDFS_Flo","DFS_Flow")] #median split of dispositional flow scores done in SPSS

#rename variable names 
names(aov_dataset)[names(aov_dataset) == "NDFS_Flo"] <- "Dispositional Flow Group"
names(aov_dataset)[names(aov_dataset) == "DFS_Flow"] <- "Dispositional Flow"
names(aov_dataset)[names(aov_dataset) == "Flow_average"] <- "Flow"
names(aov_dataset)[names(aov_dataset) == "NF_average"] <- "Non-flow"

#reshape dataframe and rename columns in output
long_aov <- melt(aov_dataset, id.vars = c("Participant","Dispositional Flow Group","Dispositional Flow"))

names(long_aov)[names(long_aov) == "variable"] <- "Condition"
names(long_aov)[names(long_aov) == "value"] <- "Flow state scores"

long_aov$`Dispositional Flow Group` <- factor(long_aov$`Dispositional Flow Group`, 
                       levels = c(1, 2),
                       labels = c("High", "Low"))

#Fig 1: plot line plot for effect of dispositional flow with dots for individual subjects
DFS_plot <- ggline(long_aov, x = "Condition", y = "Flow state scores", color = "Dispositional Flow Group",
       add = c("mean_se", "dotplot"),
       palette = c("#00AFBB", "#E7B800"))
DFS_plot

#check assumptions
long_aov %>%
  group_by(Condition, `Dispositional Flow Group`) %>%
  identify_outliers(`Flow state scores`)

ggqqplot(long_aov,"Flow state scores", ggtheme = theme_bw()) +
  facet_grid(long_aov$Condition)
  
long_aov %>%
  group_by(`Dispositional Flow Group`) %>%
  levene_test(`Flow state scores` ~ Condition)

box_m(long_aov[, "Flow state scores", drop = FALSE], long_aov$Condition)

#analyse influence of dispositional flow on flow state scores
res.aov2 <- aov(long_aov$`Flow state scores` ~ long_aov$`Dispositional Flow`* Condition, data = long_aov)
summary(res.aov2)

long_aov <- as.data.frame(long_aov)
long_aov$Participant<-as.factor(long_aov$Participant)
names(long_aov)[names(long_aov) == "Dispositional Flow Group"] <- "DFSGroup"
names(long_aov)[names(long_aov) == "Dispositional Flow"] <- "DFS"
res.aovDFS <- anova_test(
  data = long_aov, dv = `Flow state scores`, wid = Participant,
  between = DFSGroup, within = Condition
)
get_anova_table(res.aovDFS)

# plot and analyse effect on flow scores by repetition (shortened to "time")
#extract relevant data from larger dataframe
aov_time_dataset <- combined_eeg[,c("Participant","F1_Flow","F2_Flow","F3_Flow","NF1_Flow","NF2_Flow","NF3_Flow")]

#rename columns
names(aov_time_dataset)[names(aov_time_dataset) == "F1_Flow"] <- "1Flow"
names(aov_time_dataset)[names(aov_time_dataset) == "F2_Flow"] <- "2Flow"
names(aov_time_dataset)[names(aov_time_dataset) == "F3_Flow"] <- "3Flow"
names(aov_time_dataset)[names(aov_time_dataset) == "NF1_Flow"] <- "1Non-flow"
names(aov_time_dataset)[names(aov_time_dataset) == "NF2_Flow"] <- "2Non-flow"
names(aov_time_dataset)[names(aov_time_dataset) == "NF3_Flow"] <- "3Non-flow"

#reshape into long form data to plot and run analyses
long <- melt(aov_time_dataset, id.vars = c("Participant"))

#split column names for easy labelling
colsplit(long$variable,"", names = c("condition", "time"))
long<-separate(long, variable, c("time", "Condition"), sep = 1)

#name columns in long dataframe
names(long)[names(long) == "variable"] <- "Condition"
names(long)[names(long) == "value"] <- "Flow state scores"

#turn time and condition values into factors
long$time<- factor(long$time, 
                  levels = c(1, 2,3),
                  labels = c("1st", "2nd","3rd"))

long$Condition<- factor(long$Condition, 
                   levels = c("Flow","Non-flow")
                   )
#Fig 1: plot line plot for effect of time (1st, 2nd, or 3rd time playing within condition) with dots for individual subjects 
time_plot<- ggline(long, x = "time", y = "Flow state scores", color = "Condition",
       add = c("mean_se", "dotplot"),
       palette = c( rgb(0.8,0.2,0.5,0.7),rgb(0.0,0.4,0.7,0.7)))
time_plot 

#analyse effect of time
res.aov2time <- aov(long$`Flow state scores` ~ time* Condition, data = long)
summary(res.aov2time)

#t-test for average flow state scores between flow and non-flow conditions
t.test(combined_eeg$Flow_average,combined_eeg$NF_average, paired = TRUE)

#compare correlations for dispositional flow and average flow scores in both conditions
xy<- cor.test(combined_eeg$DFS_Flow,combined_eeg$Flow_average)
xz<- cor.test(combined_eeg$DFS_Flow,combined_eeg$NF_average)
yz<- cor.test(combined_eeg$Flow_average,combined_eeg$NF_average)
paired.r(xy$estimate,xz$estimate,yz$estimate,44)

#Plot differences in average FSS scores and subscales between flow and non-flow conditions
fss_condition <- combined_eeg[,c("Participant","Flow_average","NF_average")]
liking_rating_condition <- combined_eeg[,c("Participant","Flow_liking","Flow_familiarity","Non_liking","Non_familiarity")]

#rename columns
names(fss_condition)[names(fss_condition) == "NF_average"] <- "NonFlow_TotalFSS"
names(liking_rating_condition)[names(liking_rating_condition) == "Non_liking"] <- "NonFlow_Liking"
names(liking_rating_condition)[names(liking_rating_condition) == "Non_familiarity"] <- "NonFlow_Familiarity"
names(fss_condition)[names(fss_condition) == "Flow_average"] <- "Flow_TotalFSS"
names(liking_rating_condition)[names(liking_rating_condition) == "Flow_liking"] <- "Flow_Liking"
names(liking_rating_condition)[names(liking_rating_condition) == "Flow_familiarity"] <- "Flow_Familiarity"

fss_condition$Flow_Balance <- rowMeans(combined_eeg[,c("F1_Balance","F2_Balance","F3_Balance")])
fss_condition$Flow_Merging <- rowMeans(combined_eeg[,c("F1_Merging","F2_Merging","F3_Merging")])
fss_condition$Flow_Goals <- rowMeans(combined_eeg[,c("F1_Goals","F2_Goals","F3_Goals")])
fss_condition$Flow_Feedback <- rowMeans(combined_eeg[,c("F1_Feedback","F2_Feedback","F3_Feedback")])
fss_condition$Flow_Concentration <- rowMeans(combined_eeg[,c("F1_Concentration","F2_Concentration","F3_Concentration")])
fss_condition$Flow_Control <- rowMeans(combined_eeg[,c("F1_Control","F2_Control","F3_Control")])
fss_condition$Flow_Consciousness <- rowMeans(combined_eeg[,c("F1_Consciousness","F2_Consciousness","F3_Consciousness")])
fss_condition$Flow_Time <- rowMeans(combined_eeg[,c("F1_Time","F2_Time","F3_Time")])
fss_condition$Flow_Autotelic <- rowMeans(combined_eeg[,c("F1_Autotelic","F2_Autotelic","F3_Autotelic")])

fss_condition$NonFlow_Balance <- rowMeans(combined_eeg[,c("NF1_Balance","NF2_Balance","NF3_Balance")])
fss_condition$NonFlow_Merging <- rowMeans(combined_eeg[,c("NF1_Merging","NF2_Merging","NF3_Merging")])
fss_condition$NonFlow_Goals <- rowMeans(combined_eeg[,c("NF1_Goals","NF2_Goals","NF3_Goals")])
fss_condition$NonFlow_Feedback <- rowMeans(combined_eeg[,c("NF1_Feedback","NF2_Feedback","NF3_Feedback")])
fss_condition$NonFlow_Concentration <- rowMeans(combined_eeg[,c("NF1_Concentration","NF2_Concentration","NF3_Concentration")])
fss_condition$NonFlow_Control <- rowMeans(combined_eeg[,c("NF1_Control","NF2_Control","NF3_Control")])
fss_condition$NonFlow_Consciousness <- rowMeans(combined_eeg[,c("NF1_Consciousness","NF2_Consciousness","NF3_Consciousness")])
fss_condition$NonFlow_Time <- rowMeans(combined_eeg[,c("NF1_Time","NF2_Time","NF3_Time")])
fss_condition$NonFlow_Autotelic <- rowMeans(combined_eeg[,c("NF1_Autotelic","NF2_Autotelic","NF3_Autotelic")])

#get summary statistics
fss_meansd<- fss_condition %>% 
  get_summary_stats(Flow_TotalFSS,NonFlow_TotalFSS, 
                    Flow_Balance,Flow_Merging,Flow_Goals, Flow_Feedback,Flow_Concentration,Flow_Control,Flow_Consciousness,Flow_Time,Flow_Autotelic,
                    NonFlow_Balance,NonFlow_Merging,NonFlow_Goals, NonFlow_Feedback,NonFlow_Concentration,NonFlow_Control,NonFlow_Consciousness,NonFlow_Time,NonFlow_Autotelic,
                    type = "mean_sd")
liking_rating_meansd<- liking_rating_condition %>%
  get_summary_stats(Flow_Liking,Flow_Familiarity,NonFlow_Liking, NonFlow_Familiarity,type = "mean_sd")

names(fss_meansd)[names(fss_meansd) == "mean"] <- "Mean Rating"
names(liking_rating_meansd)[names(liking_rating_meansd) == "mean"] <- "Mean Rating"

fss_meansd$sem<-fss_meansd$sd/sqrt(fss_meansd$n)
fss_meansd<-fss_meansd %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')
liking_rating_meansd$sem<-liking_rating_meansd$sd/sqrt(liking_rating_meansd$n)
liking_rating_meansd<-liking_rating_meansd %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')
fss_meansd$Dimension<-factor(fss_meansd$Dimension, levels = c("TotalFSS","Balance","Merging","Goals","Feedback","Concentration","Control","Consciousness","Time","Autotelic"))
fss_dimension_plot <- ggplot(fss_meansd, aes( x = Dimension, y = `Mean Rating`, fill = Condition ) ) +
  geom_bar( position = position_dodge(), stat = "identity", alpha = .3 ) +
  geom_errorbar(aes(ymin=`Mean Rating`-sem, ymax=`Mean Rating`+sem), width=.1,
                position=position_dodge(.9)) +
  ggtitle("Flow State Scores - by Dimension")+
  scale_fill_manual(values=c( rgb(0.8,0.2,0.5,0.7),rgb(0.0,0.4,0.7,0.7))) +
  theme(legend.position = "top") +
  scale_y_continuous(breaks=seq(0,5,1)) +
  expand_limits(y=c(0,5))
fss_dimension_plot

liking_rating_meansd$Dimension<-factor(liking_rating_meansd$Dimension, levels = c("Familiarity","Liking"))
liking_rating_plot <- ggplot(liking_rating_meansd, aes( x = Dimension, y = `Mean Rating`, fill = Condition ) ) +
  geom_bar( position = position_dodge(), stat = "identity", alpha = .3 ) +
  geom_errorbar(aes(ymin=`Mean Rating`-sem, ymax=`Mean Rating`+sem), width=.1,
                position=position_dodge(.9)) +
  ggtitle("Liking and Familiarity Ratings")+
  scale_fill_manual(values=c( rgb(0.8,0.2,0.5,0.7),rgb(0.0,0.4,0.7,0.7))) +
  theme(legend.position = "top") +
  scale_y_continuous(breaks=seq(0,10,2)) +
  expand_limits(y=c(0,10))
liking_rating_plot

ggarrange(fss_dimension_plot,liking_rating_plot,
          labels= c("A","B"),
          ncol = 2, nrow = 1)
#load data from significant electrodes 
sig_elecs <- read.csv("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/alpha_beta_cluster_eeg_data.csv",header=TRUE)

# correlate differences between flow state scores and upper alpha and beta power from significant clusters
names(sig_elecs)[names(sig_elecs) == "V1"] <- "Flow_alpha"
names(sig_elecs)[names(sig_elecs) == "V2"] <- "Non-Flow_alpha"
names(sig_elecs)[names(sig_elecs) == "V3"] <- "Flow_beta"
names(sig_elecs)[names(sig_elecs) == "V4"] <- "Non-Flow_beta"

#build dataframe from data imported from Matlab - now in csv file
sig_elecs_dataset <- cbind(aov_dataset,sig_elecs)
sig_elecs_dataset$diff_flow <- sig_elecs_dataset$Flow - sig_elecs_dataset$`Non-flow`
sig_elecs_dataset$diff_alpha <- sig_elecs_dataset$Flow_alpha - sig_elecs_dataset$`Non-Flow_alpha`
sig_elecs_dataset$diff_beta <- sig_elecs_dataset$Flow_beta - sig_elecs_dataset$`Non-Flow_beta`

flow_cor_alpha<- cor.test(sig_elecs_dataset$diff_alpha,sig_elecs_dataset$diff_flow)
flow_cor_beta<- cor.test(sig_elecs_dataset$diff_beta,sig_elecs_dataset$diff_flow)

sig_elecs_dataset$Flow_Balance <- rowMeans(combined_eeg[,c("F1_Balance","F2_Balance","F3_Balance")])
sig_elecs_dataset$Flow_Merging <- rowMeans(combined_eeg[,c("F1_Merging","F2_Merging","F3_Merging")])
sig_elecs_dataset$Flow_Goals <- rowMeans(combined_eeg[,c("F1_Goals","F2_Goals","F3_Goals")])
sig_elecs_dataset$Flow_Feedback <- rowMeans(combined_eeg[,c("F1_Feedback","F2_Feedback","F3_Feedback")])
sig_elecs_dataset$Flow_Concentration <- rowMeans(combined_eeg[,c("F1_Concentration","F2_Concentration","F3_Concentration")])
sig_elecs_dataset$Flow_Control <- rowMeans(combined_eeg[,c("F1_Control","F2_Control","F3_Control")])
sig_elecs_dataset$Flow_Consciousness <- rowMeans(combined_eeg[,c("F1_Consciousness","F2_Consciousness","F3_Consciousness")])
sig_elecs_dataset$Flow_Time <- rowMeans(combined_eeg[,c("F1_Time","F2_Time","F3_Time")])
sig_elecs_dataset$Flow_Autotelic <- rowMeans(combined_eeg[,c("F1_Autotelic","F2_Autotelic","F3_Autotelic")])

sig_elecs_dataset$NonFlow_Balance <- rowMeans(combined_eeg[,c("NF1_Balance","NF2_Balance","NF3_Balance")])
sig_elecs_dataset$NonFlow_Merging <- rowMeans(combined_eeg[,c("NF1_Merging","NF2_Merging","NF3_Merging")])
sig_elecs_dataset$NonFlow_Goals <- rowMeans(combined_eeg[,c("NF1_Goals","NF2_Goals","NF3_Goals")])
sig_elecs_dataset$NonFlow_Feedback <- rowMeans(combined_eeg[,c("NF1_Feedback","NF2_Feedback","NF3_Feedback")])
sig_elecs_dataset$NonFlow_Concentration <- rowMeans(combined_eeg[,c("NF1_Concentration","NF2_Concentration","NF3_Concentration")])
sig_elecs_dataset$NonFlow_Control <- rowMeans(combined_eeg[,c("NF1_Control","NF2_Control","NF3_Control")])
sig_elecs_dataset$NonFlow_Consciousness <- rowMeans(combined_eeg[,c("NF1_Consciousness","NF2_Consciousness","NF3_Consciousness")])
sig_elecs_dataset$NonFlow_Time <- rowMeans(combined_eeg[,c("NF1_Time","NF2_Time","NF3_Time")])
sig_elecs_dataset$NonFlow_Autotelic <- rowMeans(combined_eeg[,c("NF1_Autotelic","NF2_Autotelic","NF3_Autotelic")])

sig_elecs_dataset$diff_Balance <- sig_elecs_dataset$Flow_Balance - sig_elecs_dataset$NonFlow_Balance
sig_elecs_dataset$diff_Merging <- sig_elecs_dataset$Flow_Merging - sig_elecs_dataset$NonFlow_Merging
sig_elecs_dataset$diff_Goals <- sig_elecs_dataset$Flow_Goals - sig_elecs_dataset$NonFlow_Goals
sig_elecs_dataset$diff_Feedback <- sig_elecs_dataset$Flow_Feedback - sig_elecs_dataset$NonFlow_Feedback
sig_elecs_dataset$diff_Concentration <- sig_elecs_dataset$Flow_Concentration - sig_elecs_dataset$NonFlow_Concentration
sig_elecs_dataset$diff_Control <- sig_elecs_dataset$Flow_Control - sig_elecs_dataset$NonFlow_Control
sig_elecs_dataset$diff_Consciousness <- sig_elecs_dataset$Flow_Consciousness - sig_elecs_dataset$NonFlow_Consciousness
sig_elecs_dataset$diff_Time <- sig_elecs_dataset$Flow_Time - sig_elecs_dataset$NonFlow_Time
sig_elecs_dataset$diff_Autotelic <- sig_elecs_dataset$Flow_Autotelic - sig_elecs_dataset$NonFlow_Autotelic

cor_dataset <- sig_elecs_dataset[,c("Participant","diff_alpha","diff_beta","diff_flow","diff_Balance","diff_Merging","diff_Goals","diff_Feedback","diff_Concentration","diff_Control","diff_Consciousness","diff_Time","diff_Autotelic")]
cor_dataset %>%
  identify_outliers(diff_alpha)
excludeTheseSubjects<- c("MS")
cor_dataset<- cor_dataset[!cor_dataset$Participant%in% excludeTheseSubjects, ]

cor_results <- rcorr(as.matrix(cor_dataset))
mydata.p = cor_results$P

cor_dataset2 <- cor_dataset[,c("diff_alpha","diff_beta","diff_flow","diff_Balance","diff_Merging","diff_Goals","diff_Feedback","diff_Concentration","diff_Control","diff_Consciousness","diff_Time","diff_Autotelic")]

cor_results2<- corr.test(cor_dataset2, y = NULL, use = "pairwise",method="pearson",adjust="holm", 
          alpha=.05,ci=TRUE,minlength=5,normal=TRUE)
corr.p(cor_results2$r,cor_results2$n,adjust="holm",alpha=.05,minlength=5,ci=TRUE)
mydata.p = cor_results2$p
mydata.r = cor_results2$r
ggplot(cor_dataset2,aes(x=diff_alpha,y=diff_Time)) + 
  geom_point() +
  geom_smooth(method="lm", se=TRUE, fullrange=FALSE, level=0.95)+
  theme_classic()
print(corr.p(cor_results2$r,n=44),short=FALSE)

data_summary <- function(data, varname, groupnames){
  require(plyr)
  std_mean <- function(x) sd(x)/sqrt(length(x))
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE),
      se_mean=std_mean(x[[col]]),na.rm = TRUE)
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}


aov_plot <- data_summary(long_aov,varname = "Flow state scores",groupnames = "Condition")
aov_plot <- rename(aov_plot, c("Flow state scores" = "mean"))

p<-ggplot(data=aov_plot, aes(x=Condition, y=mean,fill=Condition)) +
  geom_bar(stat="identity" )+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c(rgb(0.8,0.2,0.5,0.5),rgb(0.0,0.4,0.7,0.5)))+
  theme(legend.position="none")+
  labs(title="Plot of average flow state scores by condition", 
       x="Condition", y = "Flow state scores")
p 

sig_elecs_beta <- sig_elecs_dataset[,c("Participant","Flow_beta","Non-Flow_beta","Dispositional Flow")]

sig_elecs_long <- melt(sig_elecs_beta, id.vars = c("Participant","Dispositional Flow"))
split_col<-colsplit(sig_elecs_long$variable,"_", names = c("condition", "powerband"))
sig_elecs_long$condition<-split_col[,1]
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long$`Dispositional Flow` <- factor(sig_elecs_long$`Dispositional Flow`, 
                                    levels = c(1, 2),
                                    labels = c("High", "Low"))

names(sig_elecs_long)[names(sig_elecs_long) == "Dispositional Flow"] <- "DFS"

sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("condition", "DFS")) 


p_beta<-ggplot(data=sig_elecs_plot, aes(x=DFS, y=mean,fill= condition)) +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#00AFBB", "#E7B800"))

p_beta

sig_elecs_alpha <- sig_elecs_dataset[,c("Participant","Flow_alpha","Non-Flow_alpha","Dispositional Flow")]

sig_elecs_long <- melt(sig_elecs_alpha, id.vars = c("Participant","Dispositional Flow"))
split_col<-colsplit(sig_elecs_long$variable,"_", names = c("condition", "powerband"))
sig_elecs_long$condition<-split_col[,1]
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long$`Dispositional Flow` <- factor(sig_elecs_long$`Dispositional Flow`, 
                                              levels = c(1, 2),
                                              labels = c("High", "Low"))

names(sig_elecs_long)[names(sig_elecs_long) == "Dispositional Flow"] <- "DFS"

sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("condition", "DFS")) 


p_alpha<-ggplot(data=sig_elecs_plot, aes(x=condition, y=mean,fill=condition)) +
  geom_bar(stat="identity" )+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c(rgb(0.8,0.2,0.5,0.5),rgb(0.0,0.4,0.7,0.5))) +
  theme(legend.position="none")

p_alpha<-ggplot(data=sig_elecs_plot, aes(x=DFS, y=mean,fill= condition)) +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#00AFBB", "#E7B800"))

p_alpha

ggline(sig_elecs_long, x = "condition", y = "mean", color = "DFS",
       add = c("mean_se", "dotplot"),
       palette = c("#00AFBB", "#E7B800"))
res.aov2 <- aov(sig_elecs_long$mean ~ sig_elecs_long$DFS* sig_elecs_long$condition, data = sig_elecs_long)
summary(res.aov2)

chart.Correlation(cor_dataset, histogram=TRUE, pch=19)

#explore effect of expertise
#does it matter if I choose GMSI_F3, time spent on music or GMSI_FG? Run correlation test
exp_measures <- combined_eeg[,c("GMSI_FG","GMSI_F3","Years_played","DFS_Flow")]
library(PerformanceAnalytics)
chart.Correlation(exp_measures, histogram=TRUE, pch=19)
#General musical sophistication combines all measures into a multidimensional measure of musical expertise (Mullensiefen et al, 2014)

#median split
MedianValue <- median(combined_eeg$GMSI_FG)
for (row in 1:nrow(combined_eeg)) {
  if (combined_eeg$GMSI_FG[row] < MedianValue){combined_eeg$ExpGroup[row] = 1}
  else {combined_eeg$ExpGroup [row] = 2}
  
}

expertise_dataset <- combined_eeg[,c("Participant","Flow_average","NF_average","ExpGroup")] #median split of dispositional flow scores done in SPSS

#rename variable names 
names(expertise_dataset)[names(expertise_dataset) == "ExpGroup"] <- "Expertise"
names(expertise_dataset)[names(expertise_dataset) == "Flow_average"] <- "Flow"
names(expertise_dataset)[names(expertise_dataset) == "NF_average"] <- "Non-flow"



#reshape dataframe and rename columns in output
long_aov_exp <- melt(expertise_dataset, id.vars = c("Participant","Expertise"))

names(long_aov_exp)[names(long_aov_exp) == "variable"] <- "Condition"
names(long_aov_exp)[names(long_aov_exp) == "value"] <- "Flow state scores"

long_aov_exp$`Expertise` <- factor(long_aov_exp$`Expertise`, 
                                                  levels = c(1, 2),
                                                  labels = c("Low", "High"))

# plot and analyse average flow scores by expertise
#Fig 1: plot line plot for effect of expertise on flow with dots for individual subjects
exp_plot <- ggline(long_aov_exp, x = "Condition", y = "Flow state scores", color = "Expertise",
                   add = c("mean_se", "dotplot"),
                   palette = c("#FF9933", "#9900FF"), size = 1.0)
exp_plot

#check assumptions
long_aov_exp %>%
  group_by(Condition, Expertise) %>%
  identify_outliers(`Flow state scores`)

ggqqplot(long_aov_exp,"Flow state scores", ggtheme = theme_bw()) +
  facet_grid(long_aov_exp$Condition)

long_aov_exp %>%
  group_by(Expertise) %>%
  levene_test(`Flow state scores` ~ Condition)

box_m(long_aov_exp[, "Flow state scores", drop = FALSE], long_aov_exp$Condition)

#analyse influence of expertise on flow state scores
long_aov_exp <- as.data.frame(long_aov_exp)
long_aov_exp$Participant<-as.factor(long_aov_exp$Participant)

res.aovExp <- anova_test(
  data = long_aov_exp, dv = `Flow state scores`, wid = Participant,
  between = Expertise, within = Condition
)
get_anova_table(res.aovExp)
#Expertise is not a significant predictor of flow state scores and neither is the interaction

#Plot differences in DFS scores and subscales between high and low expertise
dfs_expertise <- combined_eeg[,c("Participant","DFS_Flow","DFS_Balance","DFS_Merging","DFS_Goals","DFS_Feedback","DFS_Concentration","DFS_Control","DFS_Consciousness","DFS_Time","DFS_Autotelic","ExpGroup")]
dfs_meansd<- dfs_expertise %>% 
  group_by(ExpGroup) %>%
  get_summary_stats(DFS_Flow,DFS_Balance,DFS_Merging,DFS_Goals, DFS_Feedback,DFS_Concentration,DFS_Control,DFS_Consciousness,DFS_Time,DFS_Autotelic, type = "mean_sd")
dfs_meansd$ExpGroup<- factor(dfs_meansd$ExpGroup, 
                                   levels = c(1, 2),
                                   labels = c("Low", "High"))
names(dfs_meansd)[names(dfs_meansd) == "mean"] <- "Mean Rating"
names(dfs_meansd)[names(dfs_meansd) == "ExpGroup"] <- "Expertise"

dfs_meansd$sem<-dfs_meansd$sd/sqrt(dfs_meansd$n)
dfs_meansd<-dfs_meansd %>% separate(col= variable, into = c('extra','Dimension'), sep='_')
dfs_meansd$Dimension<-factor(dfs_meansd$Dimension, levels = c("Balance","Merging","Goals","Feedback","Concentration","Control","Consciousness","Time","Autotelic","Flow"))
ggplot(dfs_meansd, aes( x = Dimension, y = `Mean Rating`, fill = Expertise ) ) +
  geom_bar( position = position_dodge(), stat = "identity", alpha = .3 ) +
  geom_errorbar(aes(ymin=`Mean Rating`-sem, ymax=`Mean Rating`+sem), width=.1,
                position=position_dodge(.9)) +
  ggtitle("Dispositional Flow Scores - High and Low Expertise")+
  scale_fill_manual(values=c("#FF9933", "#9900FF")) +
  theme(legend.position = "top")

#t-test DFS and subscales between high and low expertise
dfs_results<-dfs_expertise %>% t_test(DFS_Flow ~ ExpGroup)
dfs_results[2,] <- dfs_expertise %>% t_test(DFS_Balance ~ ExpGroup)
dfs_results[3,] <-dfs_expertise %>% t_test(DFS_Merging ~ ExpGroup)
dfs_results[4,] <-dfs_expertise %>% t_test(DFS_Goals ~ ExpGroup)
dfs_results[5,] <-dfs_expertise %>% t_test(DFS_Feedback ~ ExpGroup)
dfs_results[6,] <-dfs_expertise %>% t_test(DFS_Concentration ~ ExpGroup)
dfs_results[7,] <-dfs_expertise %>% t_test(DFS_Control ~ ExpGroup)
dfs_results[8,] <-dfs_expertise %>% t_test(DFS_Consciousness ~ ExpGroup)
dfs_results[9,] <-dfs_expertise %>% t_test(DFS_Time ~ ExpGroup)
dfs_results[10,] <-dfs_expertise %>% t_test(DFS_Autotelic ~ ExpGroup)

#plot differences in alpha and beta power between high and low expertise
sig_elecs_beta_exp <- sig_elecs_dataset[,c("Participant","Flow_beta","Non-Flow_beta")]
sig_elecs_beta_exp <- cbind(sig_elecs_beta_exp,combined_eeg$ExpGroup) 
names(sig_elecs_beta_exp)[names(sig_elecs_beta_exp) == "combined_eeg$ExpGroup"] <- "Expertise"
sig_elecs_beta_exp$Expertise<- factor(sig_elecs_beta_exp$Expertise, 
                             levels = c(1, 2),
                             labels = c("Low", "High"))


sig_elecs_long <- melt(sig_elecs_beta_exp, id.vars = c("Participant","Expertise"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "Expertise")) 


p_beta<-ggplot(data=sig_elecs_plot, aes(x=Expertise, y=mean,fill= Condition)) +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#9900FF","#FF9933"))

p_beta

res.aovBeta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Expertise, within = Condition
)
get_anova_table(res.aovBeta)

#plot and calculate for upper alpha
sig_elecs_alpha_exp <- sig_elecs_dataset[,c("Participant","Flow_alpha","Non-Flow_alpha")]
sig_elecs_alpha_exp <- cbind(sig_elecs_alpha_exp,combined_eeg$ExpGroup) 
names(sig_elecs_alpha_exp)[names(sig_elecs_alpha_exp) == "combined_eeg$ExpGroup"] <- "Expertise"
sig_elecs_alpha_exp$Expertise<- factor(sig_elecs_alpha_exp$Expertise, 
                                      levels = c(1, 2),
                                      labels = c("Low", "High"))

sig_elecs_long <- melt(sig_elecs_alpha_exp, id.vars = c("Participant","Expertise"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)
sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "Expertise")) 


p_alpha<-ggplot(data=sig_elecs_plot, aes(x=Expertise, y=mean,fill= Condition)) +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c( "#9900FF", "#FF9933"))

p_alpha

res.aovAlpha <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Expertise, within = Condition
)
get_anova_table(res.aovAlpha)
#Expertise is not a significant between subject variable for either upper alpha or beta power

right_frontal_theta_cluster<-read.csv("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/theta_connectivity_cluster_data.csv")
names(combined_eeg)[names(combined_eeg) == "ï..flow_right_cluster"] <- "flow_right_cluster"

#plot and calculate for theta connectivity
right_frontal_theta_cluster <- combined_eeg[,c("Participant","flow_right_cluster","nonflow_right_cluster","ExpGroup")]
names(right_frontal_theta_cluster)[names(right_frontal_theta_cluster) == "ExpGroup"] <- "Expertise"
right_frontal_theta_cluster$Expertise<- factor(right_frontal_theta_cluster$Expertise, 
                                       levels = c(1, 2),
                                       labels = c("Low", "High"))

sig_elecs_long <- melt(right_frontal_theta_cluster, id.vars = c("Participant","Expertise"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','extra','extra2'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

excludeTheseSubjects<- c("DB","ES")
sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]
sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "Expertise")) 


theta_psi<-ggplot(data=sig_elecs_plot, aes(x=Expertise, y=mean,fill= Condition)) +
  theme_classic()+
  ylab("Mean connectivity (PSI) in right frontal cluster in the 5Hz frequency") + xlab("Participants' Musical Expertise") + labs(caption = "Error bars: S.E.M.") +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#9900FF","#FF9933"))

theta_psi

res.aovTheta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Expertise, within = Condition
)
get_anova_table(res.aovTheta)
#Expertise is not a significant between subject variable for theta connectivity. No significant interaction between expertise and condition

#plot and calculate for theta connectivity (test for DFS)
right_frontal_theta_cluster <- combined_eeg[,c("Participant","flow_right_cluster","nonflow_right_cluster","NDFS_Flo")]
names(right_frontal_theta_cluster)[names(right_frontal_theta_cluster) == "NDFS_Flo"] <- "DFS"
right_frontal_theta_cluster$DFS<- factor(right_frontal_theta_cluster$DFS, 
                                               levels = c(1, 2),
                                               labels = c("High", "Low"))

sig_elecs_long <- melt(right_frontal_theta_cluster, id.vars = c("Participant","DFS"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','extra','extra2'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long$Condition<- factor(sig_elecs_long$Condition, 
                                               levels = c("flow", "nonflow"),
                                               labels = c("Flow", "Non-flow"))
sig_elecs_long %>%
  identify_outliers(mean)

excludeTheseSubjects<- c("DB","ES")
sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]

sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "DFS")) 


theta_psi<-ggplot(data=sig_elecs_plot, aes(x=DFS, y=mean,fill= Condition)) +
  theme_classic()+
  ylab("Mean connectivity (PSI) in right frontal cluster in the 5Hz frequency") + xlab("Participants' Dispositional Flow") + labs(caption = "Error bars: S.E.M.") +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#00AFBB", "#E7B800"))

theta_psi

res.aovTheta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = DFS, within = Condition
)
get_anova_table(res.aovTheta)
#Expertise is not a significant between subject variable for theta connectivity. No significant interaction between expertise and condition
