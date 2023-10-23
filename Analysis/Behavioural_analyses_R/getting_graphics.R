#load packages
library(reshape2)
library(ggplot2)
library(ggpubr)
library(psych)
library(tidyverse)
library(rstatix)
library(Hmisc)
library(Rmisc)
library(EBImage)
library(RGraphics)
library(magick)
library(PerformanceAnalytics)
library(scales)
library(ggpmisc)

combined_eeg <- read.csv("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/EEG_and_behavioural_data.csv",header=TRUE)
# plot and analyse average flow scores by dispositional flow
names(combined_eeg)[names(combined_eeg) == "NDFS_Flo"] <- "Dispositional Flow Group"
combined_eeg$`Dispositional Flow Group` <- factor(combined_eeg$`Dispositional Flow Group`, 
                                              levels = c(1, 2),
                                              labels = c("High", "Low"))

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

#extract relevant data from combined_eeg dataframe (aov stands for "data we want to fit an analysis of variance model on" )
aov_dataset <- combined_eeg[,c("Participant","Flow_average","NF_average","Dispositional Flow Group","DFS_Flow")] #median split of dispositional flow scores done in SPSS

#rename variable names 
names(aov_dataset)[names(aov_dataset) == "DFS_Flow"] <- "Dispositional Flow"
names(aov_dataset)[names(aov_dataset) == "Flow_average"] <- "Flow"
names(aov_dataset)[names(aov_dataset) == "NF_average"] <- "Non-flow"

#reshape dataframe and rename columns in output
long_aov <- melt(aov_dataset, id.vars = c("Participant","Dispositional Flow Group","Dispositional Flow"))

names(long_aov)[names(long_aov) == "variable"] <- "Condition"
names(long_aov)[names(long_aov) == "value"] <- "Flow state scores"

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

long_meansd<-data_summary(long,varname = "Flow state scores",groupnames = c("Condition", "time")) 

Fig2 <- ggarrange(DFS_plot,time_plot,
                  labels= c("A","B"),
                  ncol = 2, nrow = 1)

Fig2
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

fss_condition_long <- melt(fss_condition, id.vars = c("Participant"))
fss_condition_long<-fss_condition_long %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')
fss_condition_long %>%
  identify_outliers(value)

liking_long <- melt(liking_rating_condition, id.vars = c("Participant"))
liking_long<-liking_long %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')
liking_long %>%
  identify_outliers(value)

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
  ggtitle("Liking and Familiarity")+
  scale_fill_manual(values=c( rgb(0.8,0.2,0.5,0.7),rgb(0.0,0.4,0.7,0.7))) +
  theme(legend.position = "top") +
  scale_y_continuous(breaks=seq(0,10,2)) +
  expand_limits(y=c(0,10))
liking_rating_plot

fig1<-ggarrange(fss_dimension_plot,liking_rating_plot,
          labels= c("A","B"),widths = c(2,0.7),
          ncol = 2, nrow = 1, common.legend = TRUE)
fig1

fss_results<- fss_condition_long %>%
  group_by(Dimension) %>%
  t_test(data=., value ~ Condition) %>%
  adjust_pvalue(method = "holm") %>%
  add_significance("p.adj")

fss_results<- (fss_results[,!names(fss_results) %in% 
                    c(".y.")])

ggp_table_fss_results <- ggplot() +                             # Create empty plot with table
  theme_void() +
  annotate(geom = "table",
           x = 1,
           y = 1,
           label = list(fss_results)) 
title <- "Differences in FSS scores between flow and non-flow"  
ggp_table_fss_results + ggtitle(title) + theme(plot.title.position = "plot")

liking_results<- liking_long %>%
  group_by(Dimension) %>%
  t_test(data=., value ~ Condition) %>%
  adjust_pvalue(method = "holm") %>%
  add_significance("p.adj")

liking_results<- (liking_results[,!names(liking_results) %in% 
                             c(".y.")])

ggp_table_liking_results <- ggplot() +                             # Create empty plot with table
  theme_void() +
  annotate(geom = "table",
           x = 1,
           y = 1,
           label = list(liking_results)) 
title <- "Differences in liking and familiarity between flow and non-flow"  
ggp_table_liking_results + ggtitle(title) + theme(plot.title.position = "plot")

#load data from significant electrodes 
sig_elecs <- read.csv("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/alpha_beta_cluster_eeg_data.csv",header=TRUE)

# correlate differences between flow state scores and upper alpha and beta power from significant clusters
names(sig_elecs)[names(sig_elecs) == "Non.Flow_alpha"] <- "NonFlow_alpha"
names(sig_elecs)[names(sig_elecs) == "Non.Flow_beta"] <- "NonFlow_beta"

#build dataframe from data imported from Matlab - now in csv file
sig_elecs_dataset <- sig_elecs[,c("Flow_alpha","NonFlow_alpha","Flow_beta","NonFlow_beta")]
sig_elecs_dataset <- cbind(combined_eeg$Participant, sig_elecs_dataset)
names(sig_elecs_dataset)[names(sig_elecs_dataset) == "combined_eeg$Participant"] <- "Participant"

sig_elecs_dataset$diff_alpha <- sig_elecs_dataset$Flow_alpha - sig_elecs_dataset$NonFlow_alpha
sig_elecs_dataset$diff_beta <- sig_elecs_dataset$Flow_beta - sig_elecs_dataset$NonFlow_beta

flow_cor_alpha<- cor.test(sig_elecs_dataset$diff_alpha,sig_elecs_dataset$diff_Flow)
flow_cor_beta<- cor.test(sig_elecs_dataset$diff_beta,sig_elecs_dataset$diff_Flow)

sig_elecs_dataset$Flow <- rowMeans(combined_eeg[,c("F1_Flow","F2_Flow","F3_Flow")])
sig_elecs_dataset$Flow_Balance <- rowMeans(combined_eeg[,c("F1_Balance","F2_Balance","F3_Balance")])
sig_elecs_dataset$Flow_Merging <- rowMeans(combined_eeg[,c("F1_Merging","F2_Merging","F3_Merging")])
sig_elecs_dataset$Flow_Goals <- rowMeans(combined_eeg[,c("F1_Goals","F2_Goals","F3_Goals")])
sig_elecs_dataset$Flow_Feedback <- rowMeans(combined_eeg[,c("F1_Feedback","F2_Feedback","F3_Feedback")])
sig_elecs_dataset$Flow_Concentration <- rowMeans(combined_eeg[,c("F1_Concentration","F2_Concentration","F3_Concentration")])
sig_elecs_dataset$Flow_Control <- rowMeans(combined_eeg[,c("F1_Control","F2_Control","F3_Control")])
sig_elecs_dataset$Flow_Consciousness <- rowMeans(combined_eeg[,c("F1_Consciousness","F2_Consciousness","F3_Consciousness")])
sig_elecs_dataset$Flow_Time <- rowMeans(combined_eeg[,c("F1_Time","F2_Time","F3_Time")])
sig_elecs_dataset$Flow_Autotelic <- rowMeans(combined_eeg[,c("F1_Autotelic","F2_Autotelic","F3_Autotelic")])

sig_elecs_dataset$NonFlow <- rowMeans(combined_eeg[,c("NF1_Flow","NF2_Flow","NF3_Flow")])
sig_elecs_dataset$NonFlow_Balance <- rowMeans(combined_eeg[,c("NF1_Balance","NF2_Balance","NF3_Balance")])
sig_elecs_dataset$NonFlow_Merging <- rowMeans(combined_eeg[,c("NF1_Merging","NF2_Merging","NF3_Merging")])
sig_elecs_dataset$NonFlow_Goals <- rowMeans(combined_eeg[,c("NF1_Goals","NF2_Goals","NF3_Goals")])
sig_elecs_dataset$NonFlow_Feedback <- rowMeans(combined_eeg[,c("NF1_Feedback","NF2_Feedback","NF3_Feedback")])
sig_elecs_dataset$NonFlow_Concentration <- rowMeans(combined_eeg[,c("NF1_Concentration","NF2_Concentration","NF3_Concentration")])
sig_elecs_dataset$NonFlow_Control <- rowMeans(combined_eeg[,c("NF1_Control","NF2_Control","NF3_Control")])
sig_elecs_dataset$NonFlow_Consciousness <- rowMeans(combined_eeg[,c("NF1_Consciousness","NF2_Consciousness","NF3_Consciousness")])
sig_elecs_dataset$NonFlow_Time <- rowMeans(combined_eeg[,c("NF1_Time","NF2_Time","NF3_Time")])
sig_elecs_dataset$NonFlow_Autotelic <- rowMeans(combined_eeg[,c("NF1_Autotelic","NF2_Autotelic","NF3_Autotelic")])

sig_elecs_dataset$diff_Flow <- sig_elecs_dataset$Flow - sig_elecs_dataset$NonFlow
sig_elecs_dataset$diff_Balance <- sig_elecs_dataset$Flow_Balance - sig_elecs_dataset$NonFlow_Balance
sig_elecs_dataset$diff_Merging <- sig_elecs_dataset$Flow_Merging - sig_elecs_dataset$NonFlow_Merging
sig_elecs_dataset$diff_Goals <- sig_elecs_dataset$Flow_Goals - sig_elecs_dataset$NonFlow_Goals
sig_elecs_dataset$diff_Feedback <- sig_elecs_dataset$Flow_Feedback - sig_elecs_dataset$NonFlow_Feedback
sig_elecs_dataset$diff_Concentration <- sig_elecs_dataset$Flow_Concentration - sig_elecs_dataset$NonFlow_Concentration
sig_elecs_dataset$diff_Control <- sig_elecs_dataset$Flow_Control - sig_elecs_dataset$NonFlow_Control
sig_elecs_dataset$diff_Consciousness <- sig_elecs_dataset$Flow_Consciousness - sig_elecs_dataset$NonFlow_Consciousness
sig_elecs_dataset$diff_Time <- sig_elecs_dataset$Flow_Time - sig_elecs_dataset$NonFlow_Time
sig_elecs_dataset$diff_Autotelic <- sig_elecs_dataset$Flow_Autotelic - sig_elecs_dataset$NonFlow_Autotelic

cor_dataset <- sig_elecs_dataset[,c("Participant","diff_alpha","diff_beta","diff_Flow","diff_Balance","diff_Merging","diff_Goals","diff_Feedback","diff_Concentration","diff_Control","diff_Consciousness","diff_Time","diff_Autotelic")]
cor_dataset %>%
  identify_outliers(diff_alpha)
excludeTheseSubjects<- c("MS")
cor_dataset<- cor_dataset[!cor_dataset$Participant%in% excludeTheseSubjects, ]
cor_dataset2 <- cor_dataset[,c("diff_alpha","diff_beta","diff_Flow","diff_Balance","diff_Merging","diff_Goals","diff_Feedback","diff_Concentration","diff_Control","diff_Consciousness","diff_Time","diff_Autotelic")]

cor_results2<- corr.test(cor_dataset2, y = NULL, use = "pairwise",method="pearson",adjust="holm", 
          alpha=.05,ci=TRUE,minlength=5,normal=TRUE)
corr.p(cor_results2$r,cor_results2$n,adjust="holm",alpha=.05,minlength=5,ci=TRUE)
mydata.p = cor_results2$p
mydata.r = cor_results2$r
time_alpha_corrplot<-ggplot(cor_dataset2,aes(x=diff_alpha,y=diff_Time)) + 
  geom_point() +
  geom_smooth(method="lm", se=TRUE, fullrange=FALSE, level=0.95)+
  theme_classic()
print(corr.p(cor_results2$r,n=44),short=FALSE)

flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}

flattenCorrMatrix_uncorrected <- function(cormat, pmat) {
  ut <- lower.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}

corrmatrix <- flattenCorrMatrix(cor_results2$r,cor_results2$p)
corrmatrix_organised <- corrmatrix[corrmatrix$row == "diff_alpha", ]
names(corrmatrix_organised)[names(corrmatrix_organised) == "cor"] <- "Pearson's R (after correction)"
names(corrmatrix_organised)[names(corrmatrix_organised) == "p"] <- "p-value (after correction)"

corrmatrix_uncorrected <- flattenCorrMatrix_uncorrected(cor_results2$r,cor_results2$p)
corrmatrix_uncorrected_organised <- corrmatrix_uncorrected[corrmatrix_uncorrected$column == "diff_alpha", ]

corr_matrix_alpha <- cbind(corrmatrix_organised,corrmatrix_uncorrected_organised$cor,corrmatrix_uncorrected_organised$p)
names(corr_matrix_alpha)[names(corr_matrix_alpha) == "corrmatrix_uncorrected_organised$cor"] <- "Pearson's R"
names(corr_matrix_alpha)[names(corr_matrix_alpha) == "corrmatrix_uncorrected_organised$p"] <- "p-value"

col_order <- c("row", "column", "Pearson's R",
               "p-value", "Pearson's R (after correction)", "p-value (after correction)")
corr_matrix_alpha <- corr_matrix_alpha[, col_order]

ggp_table_alpha <- ggplot() +                             # Create empty plot with table
  theme_void() +
  annotate(geom = "table",
           x = 1,
           y = 1,
           label = list(corr_matrix_alpha))
ggp_table_alpha                                           # Draw empty plot with table

corrmatrix_organised <- corrmatrix[corrmatrix$row == "diff_beta", ]
names(corrmatrix_organised)[names(corrmatrix_organised) == "cor"] <- "Pearson's R (after correction)"
names(corrmatrix_organised)[names(corrmatrix_organised) == "p"] <- "p-value (after correction)"

corrmatrix_uncorrected <- flattenCorrMatrix_uncorrected(cor_results2$r,cor_results2$p)
corrmatrix_uncorrected_organised <- corrmatrix_uncorrected[corrmatrix_uncorrected$column == "diff_beta", ]

corr_matrix_beta <- cbind(corrmatrix_organised,corrmatrix_uncorrected_organised$cor,corrmatrix_uncorrected_organised$p)
names(corr_matrix_beta)[names(corr_matrix_beta) == "corrmatrix_uncorrected_organised$cor"] <- "Pearson's R"
names(corr_matrix_beta)[names(corr_matrix_beta) == "corrmatrix_uncorrected_organised$p"] <- "p-value"

col_order <- c("row", "column", "Pearson's R",
               "p-value", "Pearson's R (after correction)", "p-value (after correction)")
corr_matrix_beta <- corr_matrix_beta[, col_order]

ggp_table_beta <- ggplot() +                             # Create empty plot with table
  theme_void() +
  annotate(geom = "table",
           x = 1,
           y = 1,
           label = list(corr_matrix_beta))
ggp_table_beta                                          # Draw empty plot with table

bottom_row = ggarrange(NULL, time_alpha_corrplot, NULL, ncol = 3, labels = c("", "C", ""), widths = c(1,2,1))
bottom_row

supp_plot<- ggarrange(ggp_table_alpha,ggp_table_beta,bottom_row, ncol = 1, labels = c("A","B"), font.label = list(size = 14, color = "black"))
supp_plot

#plot differences between conditions by expertise
fss_exp<-cbind(cor_dataset,combined_eeg$ExpGroup)
names(fss_exp)[names(fss_exp) == "combined_eeg$ExpGroup"] <- "Expertise"

fss_exp_long <- melt(fss_exp, id.vars = c("Participant", "Expertise"))
fss_exp_long<-fss_exp_long %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')
fss_exp_long %>%
  identify_outliers(value)

fss_exp_plot <- data_summary(fss_exp_long,varname = "value",groupnames = c("Dimension", "Expertise")) 
fss_exp_plot <- fss_exp_plot[!fss_exp_plot$Dimension %in% 
                               c("alpha","beta"),]
fss_exp_plot$Dimension<-factor(fss_exp_plot$Dimension, levels = c("Balance","Merging","Goals","Feedback","Concentration","Control","Consciousness","Time","Autotelic","Flow"))


ggplot(fss_exp_plot, aes( x = Dimension, y = value, fill = Expertise ) ) +
  geom_bar( position = position_dodge(), stat = "identity", alpha = .3 ) +
  geom_errorbar(aes(ymin=value-se_mean, ymax=value+se_mean), width=.1,
                position=position_dodge(.9)) +
  ggtitle("Flow State Scores - High and Low Expertise")+
  scale_fill_manual(values=c("#FF9933", "#9900FF")) +
  theme(legend.position = "top")

#plot differences in alpha and beta power between high and low dispositional flow
sig_elecs_data <- sig_elecs_dataset[,c("Flow_beta","NonFlow_beta")]
sig_elecs_data_and_behaviour <- cbind(combined_eeg$Participant,sig_elecs_data,combined_eeg$`Dispositional Flow Group`)
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Participant"] <- "Participant"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$`Dispositional Flow Group`"] <- "DFS"


sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","DFS"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "DFS")) 


p_beta_dfs<-ggplot(data=sig_elecs_plot, aes(x=DFS, y=mean,fill= Condition)) +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#00AFBB", "#E7B800")) + 
  ylab("Mean power in beta band") +
  xlab("Dispositional Flow Score")

p_beta_dfs

res.aovBeta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = DFS, within = Condition
)
get_anova_table(res.aovBeta)

#plot and calculate for upper alpha
sig_elecs_data <- sig_elecs_dataset[,c("Flow_alpha","NonFlow_alpha")]
sig_elecs_data_and_behaviour <- cbind(combined_eeg$Participant,sig_elecs_data,combined_eeg$`Dispositional Flow Group`)
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Participant"] <- "Participant"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$`Dispositional Flow Group`"] <- "DFS"

sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","DFS"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)
excludeTheseSubjects<- c("KC","MS")
sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]
sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "DFS")) 


p_alpha_dfs<-ggplot(data=sig_elecs_plot, aes(x=DFS, y=mean,fill= Condition)) +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#00AFBB", "#E7B800")) + 
  ylab("Mean power in upper alpha band") +
  xlab("Dispositional Flow Score")

p_alpha_dfs

res.aovAlpha <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = DFS, within = Condition
)
get_anova_table(res.aovAlpha)


#explore effect of expertise
#does it matter if I choose GMSI_F3, time spent on music or GMSI_FG? Run correlation test
exp_measures <- combined_eeg[,c("GMSI_FG","GMSI_F3","Years_played","DFS_Flow")]

chart.Correlation(exp_measures, histogram=TRUE, pch=19)
#General musical sophistication combines all measures into a multidimensional measure of musical expertise (Mullensiefen et al, 2014)

#median split
MedianValue <- median(combined_eeg$GMSI_FG)
for (row in 1:nrow(combined_eeg)) {
  if (combined_eeg$GMSI_FG[row] > MedianValue){combined_eeg$ExpGroup[row] = 1}
  else {combined_eeg$ExpGroup [row] = 2}
  
}

combined_eeg$ExpGroup <- factor(combined_eeg$ExpGroup, 
                                   levels = c(1, 2),
                                   labels = c("High", "Low"))

expertise_dataset <- combined_eeg[,c("Participant","Flow_average","NF_average","ExpGroup")] #median split of dispositional flow scores done in SPSS

#rename variable names 
names(expertise_dataset)[names(expertise_dataset) == "ExpGroup"] <- "Expertise"
names(expertise_dataset)[names(expertise_dataset) == "Flow_average"] <- "Flow"
names(expertise_dataset)[names(expertise_dataset) == "NF_average"] <- "Non-flow"

#reshape dataframe and rename columns in output
long_aov_exp <- melt(expertise_dataset, id.vars = c("Participant","Expertise"))

names(long_aov_exp)[names(long_aov_exp) == "variable"] <- "Condition"
names(long_aov_exp)[names(long_aov_exp) == "value"] <- "Flow state scores"

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
dfs_expertise_long <- melt(dfs_expertise, id.vars = c("Participant", "ExpGroup"))
dfs_expertise_long<-dfs_expertise_long %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')
dfs_expertise_long %>%
  identify_outliers(value)

dfs_expertise_results<- dfs_expertise_long %>%
  group_by(Dimension) %>%
  t_test(data=., value ~ ExpGroup) %>%
  adjust_pvalue(method = "holm") %>%
  add_significance("p.adj")

dfs_expertise_results<- (dfs_expertise_results[,!names(dfs_expertise_results) %in% 
                                   c(".y.")])

ggp_table_dfsExp <- ggplot() +                             # Create empty plot with table
  theme_void() +
  annotate(geom = "table",
           x = 1,
           y = 1,
           label = list(dfs_expertise_results)) 
title <- "Differences in DFS scores between high and low expertise"  
ggp_table_dfsExp + ggtitle(title) + theme(plot.title.position = "plot")

#plot differences in alpha and beta power between high and low expertise
sig_elecs_data <- sig_elecs_dataset[,c("Flow_beta","NonFlow_beta")]
sig_elecs_data_and_behaviour <- cbind(combined_eeg$Participant,sig_elecs_data,combined_eeg$ExpGroup)
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Participant"] <- "Participant"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$ExpGroup"] <- "Expertise"


sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Expertise"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "Expertise")) 


p_beta_exp<-ggplot(data=sig_elecs_plot, aes(x=Expertise, y=mean,fill= Condition)) +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#9900FF","#FF9933")) + 
  ylab("Mean power in beta band")

p_beta_exp

res.aovBeta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Expertise, within = Condition
)
get_anova_table(res.aovBeta)

#plot and calculate for upper alpha
sig_elecs_data <- sig_elecs_dataset[,c("Flow_alpha","NonFlow_alpha")]
sig_elecs_data_and_behaviour <- cbind(combined_eeg$Participant,sig_elecs_data,combined_eeg$ExpGroup)
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Participant"] <- "Participant"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$ExpGroup"] <- "Expertise"

sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Expertise"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

excludeTheseSubjects<- c("KC","MS")
sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]

sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "Expertise")) 


p_alpha_exp<-ggplot(data=sig_elecs_plot, aes(x=Expertise, y=mean,fill= Condition)) +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c( "#9900FF", "#FF9933")) + 
  ylab("Mean power in upper alpha band")

p_alpha_exp

res.aovAlpha <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Expertise, within = Condition
)
get_anova_table(res.aovAlpha)
#Expertise is not a significant between subject variable for either upper alpha or beta power

alpha_topoplot <- magick::image_read("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/upper_alpha_signficant_cluster.png")
beta_topoplot <- magick::image_read("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/beta_signficant_cluster.png")

p1 <-image_ggplot(alpha_topoplot) + labs(caption = "Upper Alpha (10-12Hz)") + theme(plot.caption = element_text(hjust = 0.5,size = 12))
p2<-image_ggplot(beta_topoplot) + labs(caption = "Beta (12-30Hz)") + theme(plot.caption = element_text(hjust = 0.5,size = 12))

dfs_row <- ggarrange(p_alpha_dfs,p_beta_dfs, ncol = 2, labels = c("C", "D"), font.label = list(size = 14, color = "black"), common.legend = TRUE, legend = "right")
dfs_row

exp_row <- ggarrange(p_alpha_exp,p_beta_exp, ncol = 2, labels = c("E", "F"), font.label = list(size = 14, color = "black"), common.legend = TRUE, legend = "right")
exp_row
toprow<- ggarrange(p1,p2,ncol = 2, labels = c("A","B"), font.label = list(size = 14, color = "black"))
toprow
fig6<- ggarrange(toprow, dfs_row, exp_row, ncol = 1)
fig6

right_frontal_theta_cluster<-read.csv("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/theta_connectivity_cluster_data.csv")
names(combined_eeg)[names(combined_eeg) == "ï..flow_right_cluster"] <- "flow_right_cluster"

#plot and calculate for theta connectivity
right_frontal_theta_cluster <- combined_eeg[,c("Participant","flow_right_cluster","nonflow_right_cluster","ExpGroup")]
names(right_frontal_theta_cluster)[names(right_frontal_theta_cluster) == "ExpGroup"] <- "Expertise"

sig_elecs_long <- melt(right_frontal_theta_cluster, id.vars = c("Participant","Expertise"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','extra','extra2'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

#excludeTheseSubjects<- c("DB","ES")
#sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]
sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "Expertise")) 


theta_psi_exp<-ggplot(data=sig_elecs_plot, aes(x=Expertise, y=mean,fill= Condition)) +
  theme_classic()+
  ylab("Mean connectivity (PSI) in right frontal cluster in the 5Hz frequency") + xlab("Participants' Musical Expertise") + labs(caption = "Error bars: S.E.M.") +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#9900FF","#FF9933"))

theta_psi_exp

res.aovTheta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Expertise, within = Condition
)
get_anova_table(res.aovTheta)

sig_elecs_data_and_behaviour <- combined_eeg[,c("Participant","flow_right_cluster","nonflow_right_cluster","GMSI_FG")]
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"


sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Expertise"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

res.aovTheta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Expertise, within = Condition
)
get_anova_table(res.aovTheta)
#Expertise is not a significant between subject variable for theta connectivity. No significant interaction between expertise and condition

#plot and calculate for theta connectivity (test for DFS)
right_frontal_theta_cluster <- combined_eeg[,c("Participant","flow_right_cluster","nonflow_right_cluster","Dispositional Flow Group")]
names(right_frontal_theta_cluster)[names(right_frontal_theta_cluster) == "Dispositional Flow Group"] <- "DFS"

sig_elecs_long <- melt(right_frontal_theta_cluster, id.vars = c("Participant","DFS"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','extra','extra2'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long$Condition<- factor(sig_elecs_long$Condition, 
                                               levels = c("flow", "nonflow"),
                                               labels = c("Flow", "Non-flow"))
sig_elecs_long %>%
  identify_outliers(mean)

#excludeTheseSubjects<- c("DB","ES")
#sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]

sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "DFS")) 


theta_psi_dfs<-ggplot(data=sig_elecs_plot, aes(x=DFS, y=mean,fill= Condition)) +
  theme_classic()+
  ylab("Mean connectivity (PSI) in right frontal cluster in the 5Hz frequency") + xlab("Participants' Dispositional Flow") + labs(caption = "Error bars: S.E.M.") +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#00AFBB", "#E7B800"))

theta_psi_dfs

res.aovTheta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = DFS, within = Condition
)
get_anova_table(res.aovTheta)

theta_plots<-ggarrange(theta_psi_exp,theta_psi_dfs,
                     ncol = 2, nrow = 1)
theta_plots

#Dispositional flow, however, IS a significant between-subject variable for theta connectivity. There is a significant interaction between dispositional flow and condition.

#check for any effect introduced by improvisors
combined_eeg['Improvisors'] <- 0
improvisors<- c("CP","MS","DG","EC","KH","NF","RC","RS","WPL","NT","LM")

for (row in 1:nrow(combined_eeg)) {
  if (combined_eeg$Participant[row] %in% improvisors){combined_eeg$Improvisors[row] = 1}
}
combined_eeg$Improvisors<- factor(combined_eeg$Improvisors, 
                                      levels = c(0, 1),
                                      labels = c("Non-improvisors", "Improvisors"))

improv_dataset <- combined_eeg[,c("Participant","Flow_average","NF_average","Improvisors")] 

#rename variable names 
names(improv_dataset)[names(improv_dataset) == "Flow_average"] <- "Flow"
names(improv_dataset)[names(improv_dataset) == "NF_average"] <- "Non-flow"

#reshape dataframe and rename columns in output
long_aov<- melt(improv_dataset, id.vars = c("Participant","Improvisors"))

names(long_aov)[names(long_aov) == "variable"] <- "Condition"
names(long_aov)[names(long_aov) == "value"] <- "Flow state scores"

# plot and analyse average flow scores by expertise
#Fig 1: plot line plot for effect of expertise on flow with dots for individual subjects
exp_plot <- ggline(long_aov, x = "Condition", y = "Flow state scores", color = "Improvisors",
                   add = c("mean_se", "dotplot"),
                   palette = c("#DE3163", "#6495ED"), size = 1.0)
exp_plot

#check assumptions
long_aov %>%
  group_by(Condition, Improvisors) %>%
  identify_outliers(`Flow state scores`)

ggqqplot(long_aov,"Flow state scores", ggtheme = theme_bw()) +
  facet_grid(long_aov$Condition)

long_aov %>%
  group_by(Improvisors) %>%
  levene_test(`Flow state scores` ~ Condition)

box_m(long_aov[, "Flow state scores", drop = FALSE], long_aov$Condition)

#analyse influence of improvisors on flow state scores
long_aov <- as.data.frame(long_aov)
long_aov$Participant<-as.factor(long_aov$Participant)

res.aovImp <- anova_test(
  data = long_aov, dv = `Flow state scores`, wid = Participant,
  between = Improvisors, within = Condition
)
get_anova_table(res.aovImp)
#Being an improvisor is not a significant predictor of flow state scores and neither is the interaction between the between subjects-factor and within-subjects factor.

#Plot differences in DFS scores and subscales between high and low expertise
dfs_improv <- combined_eeg[,c("Participant","DFS_Flow","DFS_Balance","DFS_Merging","DFS_Goals","DFS_Feedback","DFS_Concentration","DFS_Control","DFS_Consciousness","DFS_Time","DFS_Autotelic","Improvisors")]
dfs_meansd<- dfs_improv %>% 
  group_by(Improvisors) %>%
  get_summary_stats(DFS_Flow,DFS_Balance,DFS_Merging,DFS_Goals, DFS_Feedback,DFS_Concentration,DFS_Control,DFS_Consciousness,DFS_Time,DFS_Autotelic, type = "mean_sd")
names(dfs_meansd)[names(dfs_meansd) == "mean"] <- "Mean Rating"

dfs_meansd$sem<-dfs_meansd$sd/sqrt(dfs_meansd$n)
dfs_meansd<-dfs_meansd %>% separate(col= variable, into = c('extra','Dimension'), sep='_')
dfs_meansd$Dimension<-factor(dfs_meansd$Dimension, levels = c("Balance","Merging","Goals","Feedback","Concentration","Control","Consciousness","Time","Autotelic","Flow"))
ggplot(dfs_meansd, aes( x = Dimension, y = `Mean Rating`, fill = Improvisors ) ) +
  geom_bar( position = position_dodge(), stat = "identity", alpha = .3 ) +
  geom_errorbar(aes(ymin=`Mean Rating`-sem, ymax=`Mean Rating`+sem), width=.1,
                position=position_dodge(.9)) +
  ggtitle("Dispositional Flow Scores - Improvisors and non-improvisors")+
  scale_fill_manual(values=c("#DE3163", "#6495ED")) +
  theme(legend.position = "top")

#t-test DFS and subscales between improvisors and non-improvisors
dfs_results<-dfs_improv %>% t_test(DFS_Flow ~ Improvisors)
dfs_results[2,] <- dfs_improv %>% t_test(DFS_Balance ~ Improvisors)
dfs_results[3,] <-dfs_improv %>% t_test(DFS_Merging ~ Improvisors)
dfs_results[4,] <-dfs_improv %>% t_test(DFS_Goals ~ Improvisors)
dfs_results[5,] <-dfs_improv %>% t_test(DFS_Feedback ~ Improvisors)
dfs_results[6,] <-dfs_improv %>% t_test(DFS_Concentration ~ Improvisors)
dfs_results[7,] <-dfs_improv %>% t_test(DFS_Control ~ Improvisors)
dfs_results[8,] <-dfs_improv %>% t_test(DFS_Consciousness ~ Improvisors)
dfs_results[9,] <-dfs_improv %>% t_test(DFS_Time ~ Improvisors)
dfs_results[10,] <-dfs_improv %>% t_test(DFS_Autotelic ~ Improvisors)
write.csv(dfs_results, "improvisors_dfs_nonsig_differences.csv", row.names = F)
#No significant differences between groups

#plot differences in alpha and beta power between high and low expertise
sig_elecs_data <- sig_elecs_dataset[,c("Flow_beta","NonFlow_beta")]
sig_elecs_data_and_behaviour <- cbind(combined_eeg$Participant,sig_elecs_data,combined_eeg$Improvisors)
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Participant"] <- "Participant"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Improvisors"] <- "Improvisors"


sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Improvisors"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "Improvisors")) 


p_beta<-ggplot(data=sig_elecs_plot, aes(x=Improvisors, y=mean,fill= Condition)) +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  ylab("Mean power in beta band (13-30Hz)") + xlab("Participants' status as improvisors") + labs(caption = "Error bars: S.E.M.") +
  scale_fill_manual(values = c("#DE3163", "#6495ED"))

p_beta

res.aovBeta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Improvisors, within = Condition
)
get_anova_table(res.aovBeta)

#plot and calculate for upper alpha
sig_elecs_data <- sig_elecs_dataset[,c("Flow_alpha","NonFlow_alpha")]
sig_elecs_data_and_behaviour <- cbind(combined_eeg$Participant,sig_elecs_data,combined_eeg$Improvisors)
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Participant"] <- "Participant"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Improvisors"] <- "Improvisors"


sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Improvisors"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

excludeTheseSubjects<- c("KC","MS")
sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]

sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "Improvisors")) 


p_alpha<-ggplot(data=sig_elecs_plot, aes(x=Improvisors, y=mean,fill= Condition)) +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  ylab("Mean power in upper alpha band (10-12Hz)") + xlab("Participants' status as improvisors") + labs(caption = "Error bars: S.E.M.") +
  scale_fill_manual(values = c("#DE3163", "#6495ED"))

p_alpha

res.aovAlpha <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Improvisors, within = Condition
)
get_anova_table(res.aovAlpha)
#Expertise is not a significant between subject variable for either upper alpha or beta power

right_frontal_theta_cluster<-read.csv("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/theta_connectivity_cluster_data.csv")
names(right_frontal_theta_cluster)[names(right_frontal_theta_cluster) == "flow_right_cluster"] <- "Flow_right_cluster"
names(right_frontal_theta_cluster)[names(right_frontal_theta_cluster) == "nonflow_right_cluster"] <- "NonFlow_right_cluster"

#plot and calculate for theta connectivity
sig_elecs_data_and_behaviour <- cbind(combined_eeg$Participant,right_frontal_theta_cluster,combined_eeg$Improvisors)
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Participant"] <- "Participant"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Improvisors"] <- "Improvisors"

sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Improvisors"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','extra','extra2'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

excludeTheseSubjects<- c("DB","ES")
sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]
sig_elecs_plot <- data_summary(sig_elecs_long,varname = "mean",groupnames = c("Condition", "Improvisors")) 


theta_psi<-ggplot(data=sig_elecs_plot, aes(x=Improvisors, y=mean,fill= Condition)) +
  theme_classic()+
  ylab("Mean connectivity (PSI) in right frontal cluster in the 5Hz frequency") + xlab("Participants' status as improvisors") + labs(caption = "Error bars: S.E.M.") +
  geom_bar(stat="identity", position = position_dodge())+
  geom_errorbar(aes(ymin=mean-se_mean, ymax=mean+se_mean), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual(values = c("#DE3163", "#6495ED"))

theta_psi

res.aovTheta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Improvisors, within = Condition
)
get_anova_table(res.aovTheta)
#Being an improvisor is not a significant between subject variable for theta connectivity. No significant interaction between improvisor status and condition
imp_plots<-ggarrange(p_alpha,p_beta,theta_psi,
                labels= c("A","B","C"), common.legend = TRUE,
                ncol = 3, nrow = 1)
imp_plots

#testing mod2rm toolbox
library(mod2rm)

#Test for moderating effect on FSS scores
sig_elecs_data_and_behaviour <- combined_eeg[,c("Participant","Flow_average", "NF_average","GMSI_FG","DFS_Flow")]

names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "DFS_Flow"] <- "DFS"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "Flow_average"] <- "Flow_FSS"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "NF_average"] <- "NonFlow_FSS"

#test for moderating effect of expertise
res = mod2rm(sig_elecs_data_and_behaviour, Flow_FSS, NonFlow_FSS, Expertise, jn = TRUE)
summary.mod2rm(res, plotjn = TRUE, plotstyle = "simple")
#Expertise is not a significant moderator of FSS scores between conditions. F(1,42) = 0.5196, p = 0.475. 
#Across different levels of expertise, there's a similar effect of condition, i.e. there is a difference in FSS across conditions despite difference in expertise. 

#test for moderating effect of dispositional flow
res = mod2rm(sig_elecs_data_and_behaviour, Flow_FSS, NonFlow_FSS, DFS, jn = TRUE)
summary.mod2rm(res, plotjn = TRUE, plotstyle = "simple")
#Dispositional flow is not a significant moderator of FSS across conditions, though it is more significant than expertise was (F(1,42) = 3.238, p =  0.07913).
#There's a larger moderating effect of DFS in the non-flow condition (F(1,42) = 16.19, p = 0.0002338.)
#There is a slightly larger effect of condition for those lower in DFS. Which fits the previous graph. The condition matters more for those lower in DFS. Those high in dispositional flow still scored highly in the non-flow condition.

#test for effect of both moderators (additive)
res1 = mod2rm(sig_elecs_data_and_behaviour, Flow_FSS, NonFlow_FSS, Expertise, DFS, method = 1)
summary.mod2rm(res1)
#Not sure this is good but DFS becomes a significant moderator when expertise is included. p = 0.0036.
#When you look at the conditional effects, the largest effects are actually in low dispositional flow and higher expertise.So the more skilled musicians that experience less flow usually report larger differences between conditions. Could be that they are more precise. Those that experience a lot of flow report flow higher flow regardless of condition.

#test for effect of both moderators (multiplicative)
res1 = mod2rm(sig_elecs_data_and_behaviour, Flow_FSS, NonFlow_FSS, Expertise, DFS, method = 2)
summary.mod2rm(res1)
# When I test for an interaction between expertise and dispositional flow, I find a significant interaction (F(3,40) = 3.84, p = 0.01). Both expertise and dispositional flow are also now significant but with negative effects. The higher the expertise, the higher the dispositional flow, the lower the difference conditions.
#The best combinations for large contrasts between flow and non-flow are low expertise, low dispositional flow and high expertise and high flow. 

#Test for moderating effect of expertise and dispositional flow on alpha power
sig_elecs_data <- sig_elecs_dataset[,c("Flow_alpha","NonFlow_alpha")] #contains the extracted EEG power data from significant electrodes
sig_elecs_data_and_behaviour <- combined_eeg[, c("Participant", "GMSI_FG","DFS_Flow")] #get between subject moderators from main dataset
sig_elecs_data_and_behaviour<-cbind(sig_elecs_data_and_behaviour,sig_elecs_data)

#rename dataset variables
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "DFS_Flow"] <- "DFS"

#identify and remove extreme outliers
sig_elecs_data_and_behaviour %>%
  identify_outliers(Flow_alpha)

sig_elecs_data_and_behaviour %>%
  identify_outliers(NonFlow_alpha)

excludeTheseSubjects<- c("KC","MS")
sig_elecs_data_and_behaviour <- sig_elecs_data_and_behaviour[!sig_elecs_data_and_behaviour$Participant%in% excludeTheseSubjects, ]

#test for moderating effect of expertise
res = mod2rm(sig_elecs_data_and_behaviour, Flow_alpha, NonFlow_alpha, Expertise, jn = TRUE)
summary.mod2rm(res, plotjn = TRUE, plotstyle = "simple")
# Expertise is a significant moderator of alpha differences between flow and non-flow conditions (F(1,40) = 8.105, p = 0.006933)
#Looking at the conditional effects show larger differences between conditions in participants with high expertise.

#test for moderating effect of dispositional flow
res = mod2rm(sig_elecs_data_and_behaviour, Flow_alpha, NonFlow_alpha, DFS, jn = TRUE)
summary.mod2rm(res, plotjn = TRUE, plotstyle = "simple")
#Dispositional flow is NOT a significant moderator of alpha differences between flow and non-flow conditions(F(1,40)=0.7889, p = 0.3798)
#A closer look at conditional effects show that the moderating effect of dispositional flow on the alpha differences between flow and non-flow only occurs at mid-levels of DFS.

#test for effect of both moderators (additive)
res1 = mod2rm(sig_elecs_data_and_behaviour, Flow_alpha, NonFlow_alpha, Expertise, DFS, method = 1)
summary.mod2rm(res1)
#Expertise remains a significant moderator when DFS is included in the model (p = 0.01, which is less significant than when it was alone in the model.)
#DFS remains non-significant.

#test for effect of both moderators (multiplicative)
res1 = mod2rm(sig_elecs_data_and_behaviour, Flow_alpha, NonFlow_alpha, Expertise, DFS, method = 2)
summary.mod2rm(res1)
#when both expertise and dispositional flow are included and allowed to interact, none of them are significant moderators. 


#Test for moderating effect of expertise and dispositional flow on beta power
sig_elecs_data <- sig_elecs_dataset[,c("Flow_beta","NonFlow_beta")] #contains the extracted EEG power data from significant electrodes
sig_elecs_data_and_behaviour <- combined_eeg[, c("Participant", "GMSI_FG","DFS_Flow")] #get between subject moderators from main dataset
sig_elecs_data_and_behaviour<-cbind(sig_elecs_data_and_behaviour,sig_elecs_data)

#rename dataset variables
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "DFS_Flow"] <- "DFS"

#identify and remove extreme outliers
sig_elecs_data_and_behaviour %>%
  identify_outliers(Flow_beta)

sig_elecs_data_and_behaviour %>%
  identify_outliers(NonFlow_beta)
#no extreme outliers

#test for moderating effect of expertise
res = mod2rm(sig_elecs_data_and_behaviour, Flow_beta, NonFlow_beta, Expertise, jn = TRUE)
summary.mod2rm(res, plotjn = TRUE, plotstyle = "simple")
#Expertise is a significant moderator of beta differences between conditions (F(1,42)= 5.493, p = 0.0239)
#Expertise has a larger effect on differences in beta power between conditions at higher levels of expertise

#test for moderating effect of dispositional flow
res = mod2rm(sig_elecs_data_and_behaviour, Flow_beta, NonFlow_beta, DFS, jn = TRUE)
summary.mod2rm(res, plotjn = TRUE, plotstyle = "simple")
#DFS remains a non-significant moderator of beta differences between conditions (F(1,42)= 0.9715, p = 0.33)
#There are larger differences in beta power between conditions at DFS scores of 3.6 and higher.
#There is a larger significant effect of condition on beta power at DFS scores of 3.6 and higher.

#test for effect of both moderators (additive)
res1 = mod2rm(sig_elecs_data_and_behaviour, Flow_beta, NonFlow_beta, Expertise, DFS, method = 1)
summary.mod2rm(res1)
#Expertise becomes less significant when DFS is included in the model.
#DFS remains non-significant.

#test for effect of both moderators (multiplicative)
res1 = mod2rm(sig_elecs_data_and_behaviour, Flow_beta, NonFlow_beta, Expertise, DFS, method = 2)
summary.mod2rm(res1)
#When all variables are included and allowed to interact, none of them are significant moderators.

#Test for moderating effect of expertise and dispositional flow on theta connectivity
sig_elecs_data_and_behaviour <- combined_eeg[,c("Participant","flow_right_cluster","nonflow_right_cluster","GMSI_FG","DFS_Flow")]

#rename dataset variables
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "DFS_Flow"] <- "DFS"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "flow_right_cluster"] <- "Flow_theta"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "nonflow_right_cluster"] <- "NonFlow_theta"

#identify and remove extreme outliers
sig_elecs_data_and_behaviour %>%
  identify_outliers(Flow_theta)

sig_elecs_data_and_behaviour %>%
  identify_outliers(NonFlow_theta)
#no extreme outliers

#test for moderating effect of expertise
res = mod2rm(sig_elecs_data_and_behaviour, Flow_theta, NonFlow_theta, Expertise, jn = TRUE)
summary.mod2rm(res, plotjn = TRUE, plotstyle = "simple")
#Expertise is NOT a significant moderator of theta connectivity differences between conditions (F(1,42)= 1.143, p = 0.2912)
#There is a larger difference in theta connectivity between conditions at higher levels of expertise

#test for moderating effect of dispositional flow
res = mod2rm(sig_elecs_data_and_behaviour, Flow_theta, NonFlow_theta, DFS, jn = TRUE)
summary.mod2rm(res, plotjn = TRUE, plotstyle = "simple")
#DFS is a significant moderator of theta connectivity differences between conditions (F(1,42)= 10.42, p = 0.002423)
#DFS has a larger effect on differences in theta connectivity between conditions at DFS scores of 3.6 and higher, which happens to be the median value. (so I got lucky with the median split)

#test for effect of both moderators (additive)
res1 = mod2rm(sig_elecs_data_and_behaviour, Flow_theta, NonFlow_theta, Expertise, DFS, method = 1)
summary.mod2rm(res1)
#DFS becomes a little less significant when expertise is included in the model (p=0.00489).
#Expertise remains non-significant.

#test for effect of both moderators (multiplicative)
res1 = mod2rm(sig_elecs_data_and_behaviour, Flow_theta, NonFlow_theta, Expertise, DFS, method = 2)
summary.mod2rm(res1)
#When all variables are included and allowed to interact, none of them are significant moderators (likely due to insufficient data points).

#check for collinearity
library(car)
model<-lm(mean ~ Expertise + DFS + Condition, data = sig_elecs_long)
vif(model)
#no large VIF values hence no significant collinearity between expertise and DFS, our only continuous variables

#Check for relationship between expertise and DFS
plot(Expertise ~ DFS, data = sig_elecs_data_and_behaviour)
fit <- lm(Expertise ~ DFS, data = sig_elecs_data_and_behaviour)
abline(fit)
summary(fit)
#Expertise is somewhat predicted by dispositional flow, with an estimate of 6.523, p=0.037.
#histograms for DFS and Expertise
hist_DFS <- as.ggplot(~hist(combined_eeg$DFS_Flow,main="Distribution of dispositional flow scores",xlab = "Dispositional Flow Scores (DFS-2)",col = "lightblue"))
hist_Expertise <- as.ggplot(~hist(combined_eeg$GMSI_FG, main = "Distribution of Gold-MSI scores",xlab = "Musical Expertise, measured with Gold-MSI", col = "lightgreen"))

(hist_plots = ggarrange(hist_DFS, hist_Expertise, ncol = 1))
#analyse expertise and dispositional flow as covariates
#analyse for FSS
sig_elecs_data_and_behaviour <- combined_eeg[,c("Participant","Flow_average", "NF_average","GMSI_FG","DFS_Flow")]

names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "DFS_Flow"] <- "DFS"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "Flow_average"] <- "Flow_FSS"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "NF_average"] <- "NonFlow_FSS"

sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Expertise", "DFS"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','FSS'), sep='_')

names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"

sig_elecs_long %>%
  identify_outliers(mean)
#no extreme outliers
res.aovExp <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  covariate = Expertise, within = Condition
)
get_anova_table(res.aovExp)
#When expertise is treated a covariate, there is no interaction between condition and expertise. Expertise is not itself a significant predictor of alpha power.Condition is a significant predictor.

res.aovDFS <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  covariate = DFS, within = Condition
)
get_anova_table(res.aovDFS)
#When DFS is treated as a covariate, there is no interaction between DFS and condition.But both condition and DFS are significant main effects. 


#analyse for alpha power
sig_elecs_data <- sig_elecs_dataset[,c("Flow_alpha","NonFlow_alpha")]
sig_elecs_data_and_behaviour <- combined_eeg[, c("Participant", "GMSI_FG","DFS_Flow")]
sig_elecs_data_and_behaviour<-cbind(sig_elecs_data_and_behaviour,sig_elecs_data)

names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "DFS_Flow"] <- "DFS"

sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Expertise", "DFS"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')

names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"

sig_elecs_long %>%
  identify_outliers(mean)

excludeTheseSubjects<- c("KC","MS")
sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]

res.aovAlpha <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  covariate = Expertise, within = Condition
)
get_anova_table(res.aovAlpha)
#When expertise is treated a covariate, there remains a significant interaction effect between condition and expertise. However, expertise is not itself a significant predictor of alpha power.

res.aovDFS <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  covariate = DFS, within = Condition
)
get_anova_table(res.aovDFS)
#When DFS is treated as a covariate, there is no interaction between DFS and condition. Condition is a significant main effect but not DFS on its own. 

#analyse for beta power
sig_elecs_data <- sig_elecs_dataset[,c("Flow_beta","NonFlow_beta")]
sig_elecs_data_and_behaviour <- combined_eeg[, c("Participant", "GMSI_FG","DFS_Flow")]
sig_elecs_data_and_behaviour<-cbind(sig_elecs_data_and_behaviour,sig_elecs_data)

names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "DFS_Flow"] <- "DFS"

sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Expertise", "DFS"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')

names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"

sig_elecs_long %>%
  identify_outliers(mean)
#no extreme outliers

res.aovExp <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  covariate = Expertise, within = Condition
)
get_anova_table(res.aovExp)
#When expertise is treated a covariate, there remains a significant interaction effect between condition and expertise. However, expertise is not itself a significant predictor of alpha power.

res.aovDFS <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  covariate = DFS, within = Condition
)
get_anova_table(res.aovDFS)
#When DFS is treated as a covariate, there is no interaction between DFS and condition. Condition is a significant main effect but not DFS on its own. 

#analyses for theta connectivity
sig_elecs_data_and_behaviour <- combined_eeg[,c("Participant","flow_right_cluster","nonflow_right_cluster","GMSI_FG","DFS_Flow")]

#rename dataset variables
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "DFS_Flow"] <- "DFS"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "flow_right_cluster"] <- "Flow_theta"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "nonflow_right_cluster"] <- "NonFlow_theta"

sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Expertise", "DFS"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')

names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"

sig_elecs_long %>%
  identify_outliers(mean)
#no extreme outliers

res.aovExp <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  covariate = Expertise, within = Condition
)
get_anova_table(res.aovExp)
#When expertise is treated a covariate, there is no significant interaction effect between condition and expertise. Expertise is not itself a significant predictor of alpha power.Only condition is a significant predictor.

res.aovDFS <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  covariate = DFS, within = Condition
)
get_anova_table(res.aovDFS)
#When DFS is treated as a covariate, there is no significant interaction between DFS and condition. Condition is a significant main effect but not DFS on its own. 


