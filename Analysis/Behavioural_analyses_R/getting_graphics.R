aov_dataset <- combined_eeg[,c("Participant","Flow_average","NF_average","NDFS_Flo","")]

names(aov_dataset)[names(aov_dataset) == "NDFS_Flo"] <- "Dispositional Flow"
names(aov_dataset)[names(aov_dataset) == "Flow_average"] <- "Flow"
names(aov_dataset)[names(aov_dataset) == "NF_average"] <- "Non-flow"


long_aov <- melt(aov_dataset, id.vars = c("Participant","Dispositional Flow"))

names(long_aov)[names(long_aov) == "variable"] <- "Condition"
names(long_aov)[names(long_aov) == "value"] <- "Flow state scores"

long$`Dispositional Flow` <- factor(long$`Dispositional Flow`, 
                       levels = c(1, 2),
                       labels = c("High", "Low"))

ggline(long, x = "Condition", y = "Flow state scores", color = "Dispositional Flow",
       add = c("mean_se", "dotplot"),
       palette = c("#00AFBB", "#E7B800"))

res.aov2 <- aov(long$`Flow state scores` ~ long$`Dispositional Flow`* Condition, data = long)
summary(res.aov2)

aov_time_dataset <- combined_eeg[,c("Participant","F1_Flow","F2_Flow","F3_Flow","NF1_Flow","NF2_Flow","NF3_Flow")]

names(aov_time_dataset)[names(aov_time_dataset) == "F1_Flow"] <- "1Flow"
names(aov_time_dataset)[names(aov_time_dataset) == "F2_Flow"] <- "2Flow"
names(aov_time_dataset)[names(aov_time_dataset) == "F3_Flow"] <- "3Flow"
names(aov_time_dataset)[names(aov_time_dataset) == "NF1_Flow"] <- "1Non-flow"
names(aov_time_dataset)[names(aov_time_dataset) == "NF2_Flow"] <- "2Non-flow"
names(aov_time_dataset)[names(aov_time_dataset) == "NF3_Flow"] <- "3Non-flow"


long <- melt(aov_time_dataset, id.vars = c("Participant"))

colsplit(long$variable,"", names = c("condition", "time"))
long<-separate(long, variable, c("time", "Condition"), sep = 1)

names(long)[names(long) == "variable"] <- "Condition"
names(long)[names(long) == "value"] <- "Flow state scores"

long$time<- factor(long$time, 
                  levels = c(1, 2,3),
                  labels = c("1st", "2nd","3rd"))

long$Condition<- factor(long$Condition, 
                   levels = c("Flow","Non-flow")
                   )

ggline(long, x = "time", y = "Flow state scores", color = "Condition",
       add = c("mean_se", "dotplot"),
       palette = c( rgb(0.8,0.2,0.5,0.7),rgb(0.0,0.4,0.7,0.7)))

res.aov2time <- aov(long$`Flow state scores` ~ time* Condition, data = long)
summary(res.aov2time)

t.test(combined_eeg$Flow_average,combined_eeg$NF_average, paired = TRUE)

xy<- cor.test(combined_eeg$DFS_Flow,combined_eeg$Flow_average)
xz<- cor.test(combined_eeg$DFS_Flow,combined_eeg$NF_average)
yz<- cor.test(combined_eeg$Flow_average,combined_eeg$NF_average)
paired.r(xy$estimate,xz$estimate,yz$estimate,44)

names(sig_elecs)[names(sig_elecs) == "V1"] <- "Flow_alpha"
names(sig_elecs)[names(sig_elecs) == "V2"] <- "Non-Flow_alpha"
names(sig_elecs)[names(sig_elecs) == "V3"] <- "Flow_beta"
names(sig_elecs)[names(sig_elecs) == "V4"] <- "Non-Flow_beta"

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

cor_dataset <- sig_elecs_dataset[,c("diff_alpha","diff_beta","diff_flow","diff_Balance","diff_Merging","diff_Goals","diff_Feedback","diff_Concentration","diff_Control","diff_Consciousness","diff_Time","diff_Autotelic")]
cor_results <- rcorr(as.matrix(cor_dataset))
mydata.p = cor_results$P

cor_results2<- corr.test(cor_dataset, y = NULL, use = "pairwise",method="pearson",adjust="holm", 
          alpha=.05,ci=TRUE,minlength=5,normal=TRUE)
corr.p(cor_results2$r,cor_results2$n,adjust="holm",alpha=.05,minlength=5,ci=TRUE)
mydata.p = cor_results2$p
mydata.r = cor_results2$r

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
