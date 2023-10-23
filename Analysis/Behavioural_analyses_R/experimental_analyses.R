#(layout_matrix <- matrix(c(1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 4), nrow = 2, byrow = TRUE))
flowPSI_topoplot <- readImage("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/Flow_5Hz_heads-in-head.png")
display(flowPSI_topoplot, method = "raster")
p1<-plot(flowPSI_topoplot)
nonflowPSI_topoplot <- readImage("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/Non-flow_5Hz_heads-in-head.png")
p2<-plot(nonflowPSI_topoplot, method = "raster")
flowVSnonflowPSI_topoplot <- readImage("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/flowVSnflow_arrowsPSI_5Hz.png")
p3<-display(flowVSnonflowPSI_topoplot, method = "raster")
p3

img1<- readPNG("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/Flow_5Hz_heads-in-head.png")
p1<- ggplot2::ggplot() + ggplot2::annotation_custom(grid::rasterGrob(img1,
                                                                     width=ggplot2::unit(1,"npc"),
                                                                     height=ggplot2::unit(1,"npc")),
                                                    -Inf, Inf, -Inf, Inf)
img2<- readPNG("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/Non-flow_5Hz_heads-in-head.png")
p2<- ggplot2::ggplot() + ggplot2::annotation_custom(grid::rasterGrob(img2,
                                                                     width=ggplot2::unit(1,"npc"),
                                                                     height=ggplot2::unit(1,"npc")),
                                                    -Inf, Inf, -Inf, Inf)
img3<- readPNG("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/flowVSnflow_arrowsPSI_5Hz.png")
p3<- ggplot2::ggplot() + ggplot2::annotation_custom(grid::rasterGrob(img3,
                                                                     width=ggplot2::unit(1,"npc"),
                                                                     height=ggplot2::unit(1,"npc")),
                                                    -Inf, Inf, -Inf, Inf)

flowPSI_topoplot <- magick::image_read("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/Flow_5Hz_heads-in-head.png")
nonflowPSI_topoplot <- magick::image_read("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/Non-flow_5Hz_heads-in-head.png")
flowVSnonflowPSI_topoplot <- magick::image_read("C:/Github/Flow_musicians/Analysis/Behavioural_analyses_R/Matlab_pictures/flowVSnflow_arrowsPSI_5Hz.png")

p1 <-image_ggplot(flowPSI_topoplot, interpolate = TRUE)
p2<-image_ggplot(nonflowPSI_topoplot)
p3<-image_ggplot(flowVSnonflowPSI_topoplot)

toprow = ggarrange(p1,p2, p3,ncol = 3, labels = c("A","B","C"), font.label = list(size = 12, color = "black"))
toprow
bottom_row = ggarrange(NULL, p4, p5, NULL, ncol = 4, labels = c("", "D" , "E", ""), widths = c(1,2,2,1))
final_plot = ggarrange(top_row, bottom_row, ncol = 1)

thetaPSI_plots<-ggarrange(p_alpha,p_beta,theta_psi,
                          labels= c("A","B","C"), common.legend = TRUE,
                          ncol = 3, nrow = 1)
thetaPSI_plots


ggline(sig_elecs_long, x = "condition", y = "mean", color = "DFS",
       add = c("mean_se", "dotplot"),
       palette = c("#00AFBB", "#E7B800"))
res.aov2 <- aov(sig_elecs_long$mean ~ sig_elecs_long$DFS* sig_elecs_long$condition, data = sig_elecs_long)
summary(res.aov2)

chart.Correlation(cor_dataset2, histogram=TRUE, pch=19)#
cor_results <- rcorr(as.matrix(cor_dataset))
mydata.p = cor_results$P

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

library(corrplot)
source("http://www.sthda.com/upload/rquery_cormat.r")
corrplot(cor_results2$r, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)
corr_matrix<- rquery.cormat(cor_dataset2, type="flatten", graph=FALSE)

#analyse regressions with continuous 
sig_elecs_data_and_behaviour <- combined_eeg[,c("Participant","flow_right_cluster","nonflow_right_cluster","GMSI_FG")]
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"


sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Expertise"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

excludeTheseSubjects<- c("DB","ES")
sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]

library(lme4)
lmeThetaExp<- lmer(mean ~ Condition+ Expertise+(1|Participant), data = sig_elecs_long)
lmeThetaExp


sig_elecs_data_and_behaviour <- combined_eeg[,c("Participant","flow_right_cluster","nonflow_right_cluster","DFS_Flow")]
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "DFS_Flow"] <- "DFS"


sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","DFS"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

excludeTheseSubjects<- c("DB","ES")
sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]

library(lme4)
lmeThetaDFS<- lmer(mean ~ Condition+ DFS+(1|Participant), data = sig_elecs_long)
lmeThetaDFS
vif(lmeThetaDFS)

sig_elecs_data <- sig_elecs_dataset[,c("Flow_alpha","NonFlow_alpha")]
sig_elecs_data_and_behaviour <- combined_eeg[, c("Participant", "GMSI_FG","DFS_Flow")]
sig_elecs_data_and_behaviour<-cbind(sig_elecs_data_and_behaviour,sig_elecs_data)

names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "GMSI_FG"] <- "Expertise"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "DFS_Flow"] <- "DFS"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "Flow_average"] <- "Flow_FSS"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "NF_average"] <- "NonFlow_FSS"

sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Expertise", "DFS"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')

names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"

sig_elecs_flow <- sig_elecs_dataset[,c("Flow","NonFlow")]
sig_elecs_flow <- cbind(combined_eeg$Participant,sig_elecs_flow)
names(sig_elecs_flow)[names(sig_elecs_flow) == "combined_eeg$Participant"] <- "Participant"
sig_elecs_flow_long <- melt(sig_elecs_flow, id.vars = c("Participant"))
names(sig_elecs_flow_long)[names(sig_elecs_flow_long) == "value"] <- "FSS"
names(sig_elecs_flow_long)[names(sig_elecs_flow_long) == "variable"] <- "Condition"

sig_elecs_long <- cbind(sig_elecs_long,sig_elecs_flow_long$FSS)
names(sig_elecs_long)[names(sig_elecs_long) == "sig_elecs_flow_long$FSS"] <- "FSS"


sig_elecs_long %>%
  identify_outliers(mean)

excludeTheseSubjects<- c("KC","MS")
sig_elecs_long <- sig_elecs_long[!sig_elecs_long$Participant%in% excludeTheseSubjects, ]

res.aovAlpha <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  covariate = Expertise, within = Condition
)
get_anova_table(res.aovAlpha)

res.aovFSS <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  covariate = DFS, within = Condition
)
get_anova_table(res.aovFSS)

ggscatter(
  sig_elecs_long, x = "Expertise", y = "mean",
  color = "Condition", add = "reg.line"
)+
  stat_regline_equation(
    aes(label =  paste(..eq.label.., ..rr.label.., sep = "~~~~"), color = Condition)
  )

sig_elecs_long %>% anova_test(mean ~ Condition*Expertise)

model <- lm(mean ~ Expertise + Condition, data = sig_elecs_long)
model.metrics <- augment(model) %>%
  select(-.hat, -.sigma, -.fitted) # Remove details
head(model.metrics, 3)

shapiro_test(model.metrics$.resid)
model.metrics %>% levene_test(.resid ~ Condition)

model.metrics %>% 
  filter(abs(.std.resid) > 3) %>%
  as.data.frame()

res.aov <- sig_elecs_long %>% anova_test(mean ~ Expertise + Condition)
get_anova_table(res.aov)


lmeAlphaExp<- lmer(mean ~ Condition + Expertise +(1|Participant), data = sig_elecs_long)
summary(lmeAlphaExp)
lmeAlphaExp1<- lmer(mean ~ Condition + (1|Participant), data = sig_elecs_long)
summary(lmeAlphaExp1)
lmeAlphaExp2<- lmer(mean ~ Expertise + (1|Participant), data = sig_elecs_long)
summary(lmeAlphaExp2)
anova(lmeAlphaExp,lmeAlphaExp1,lmeAlphaExp2)

lmeAlphaDFS<- lmer(mean ~ Condition + DFS +(1|Participant), data = sig_elecs_long)
summary(lmeAlphaDFS)
lmeAlphaDFS1<- lmer(mean ~ Condition + DFS + Expertise + (1|Participant), data = sig_elecs_long)
summary(lmeAlphaDFS1)
lmeAlphaDFS2<- lmer(mean ~ DFS + (1|Participant), data = sig_elecs_long)
summary(lmeAlphaDFS2)
anova(lmeAlphaDFS, lmeAlphaDFS1, lmeAlphaDFS2)

lmeAlphaExp<- lmer(mean ~ FSS + Expertise +(1|Participant), data = sig_elecs_long)
summary(lmeAlphaExp)
lmeAlphaDFS<- lmer(mean ~ FSS + DFS +(1|Participant), data = sig_elecs_long)
summary(lmeAlphaDFS)
lmeFSS<- lmer(mean ~ FSS + Condition + (1|Participant), data = sig_elecs_long)
summary(lmeFSS)
anova(lmeAlphaDFS, lmeAlphaExp, lmeFSS, lmeAlphaExp1)

sig_elecs_data <- sig_elecs_dataset[,c("Flow_beta","NonFlow_beta")]
sig_elecs_data_and_behaviour <- cbind(combined_eeg$Participant,sig_elecs_data,combined_eeg$GMSI_FG)
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$Participant"] <- "Participant"
names(sig_elecs_data_and_behaviour)[names(sig_elecs_data_and_behaviour) == "combined_eeg$GMSI_FG"] <- "Expertise"


sig_elecs_long <- melt(sig_elecs_data_and_behaviour, id.vars = c("Participant","Expertise"))
sig_elecs_long<-sig_elecs_long %>% separate(col= variable, into = c('Condition','Powerband'), sep='_')
names(sig_elecs_long)[names(sig_elecs_long) == "value"] <- "mean"
sig_elecs_long %>%
  identify_outliers(mean)

M1.lmer <- lmer(mean ~ Condition*Expertise + (1|Participant), data = sig_elecs_long, REML = TRUE)
summary(M1.lmer)
M2.lmer <- lmer(mean ~ Condition + (1|Participant), data = sig_elecs_long, REML = TRUE)
summary(M2.lmer)
anova(M1.lmer,M2.lmer)

res.aovBeta <- anova_test(
  data = sig_elecs_long, dv = mean, wid = Participant,
  between = Expertise, within = Condition
)
get_anova_table(res.aovBeta)


fss_condition<-cbind(fss_condition,combined_eeg$ExpGroup)
names(fss_condition)[names(fss_condition) == "combined_eeg$ExpGroup"] <- "Expertise"
fss_condition<- fss_condition[,!names(fss_condition) %in% 
                               c("Expertise")]

fss_condition_long <- melt(fss_condition, id.vars = c("Participant", "Expertise"))
fss_condition_long<-fss_condition_long %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')
fss_condition_long %>%
  identify_outliers(value)

fss_results<- fss_condition_long %>%
  group_by(Dimension) %>%
  anova_test(
    data = ., dv = value, wid = Participant,
    between = Expertise, within = Condition
  ) %>%
  adjust_pvalue(method = "holm") %>%
  add_significance("p.adj")

ggp_table_fss_results <- ggplot() +                             # Create empty plot with table
  theme_void() +
  annotate(geom = "table",
           x = 1,
           y = 1,
           label = list(fss_results)) 
title <- "Differences in FSS scores (dimensions) between high and low expertise"  
ggp_table_fss_results + ggtitle(title) + theme(plot.title.position = "plot")

corr_dfs_exp <- cbind(fss_condition,combined_eeg$DFS_Flow,combined_eeg$GMSI_FG)
corr_dfs_exp<-corr_dfs_exp[,!names(corr_dfs_exp) %in% c("Participant", "Expertise")]
cor_results <- corr.test(corr_dfs_exp, y = NULL, use = "pairwise",method="pearson",adjust="holm", 
                         alpha=.05,ci=TRUE,minlength=5,normal=TRUE)
flattenCorrMatrix_uncorrected(cor_results$r,cor_results$p)
chart.Correlation(corr_dfs_exp,histogram=TRUE, pch=19)

#Plot differences in DFS scores and subscales between high and low expertise
fss_expertise <- fss_condition[,c("Participant","Flow_TotalFSS","Flow_Balance","Flow_Merging","Flow_Goals","Flow_Feedback","Flow_Concentration","Flow_Control","Flow_Consciousness","Flow_Time","Flow_Autotelic","Expertise")]
fss_meansd<- fss_expertise %>% 
  group_by(Expertise) %>%
  get_summary_stats(Flow_TotalFSS,Flow_Balance,Flow_Merging,Flow_Goals, Flow_Feedback,Flow_Concentration,Flow_Control,Flow_Consciousness,Flow_Time,Flow_Autotelic, type = "mean_sd")

names(fss_meansd)[names(fss_meansd) == "mean"] <- "Mean Rating"

fss_meansd$sem<-fss_meansd$sd/sqrt(dfs_meansd$n)
fss_meansd<-fss_meansd %>% separate(col= variable, into = c('extra','Dimension'), sep='_')
fss_meansd$Dimension<-factor(fss_meansd$Dimension, levels = c("Balance","Merging","Goals","Feedback","Concentration","Control","Consciousness","Time","Autotelic","Flow"))
ggplot(fss_meansd, aes( x = Dimension, y = `Mean Rating`, fill = Expertise ) ) +
  geom_bar( position = position_dodge(), stat = "identity", alpha = .3 ) +
  geom_errorbar(aes(ymin=`Mean Rating`-sem, ymax=`Mean Rating`+sem), width=.1,
                position=position_dodge(.9)) +
  ggtitle("FSS Scores (Flow) - High and Low Expertise")+
  scale_fill_manual(values=c("#FF9933", "#9900FF")) +
  theme(legend.position = "top")

#t-test DFS and subscales between high and low expertise
fss_expertise_long <- melt(fss_expertise, id.vars = c("Participant", "Expertise"))
fss_expertise_long<-fss_expertise_long %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')
fss_expertise_long %>%
  identify_outliers(value)

fss_expertise_results<- fss_expertise_long %>%
  group_by(Dimension) %>%
  t_test(data=., value ~ Expertise) %>%
  adjust_pvalue(method = "holm") %>%
  add_significance("p.adj")

fss_expertise_results<- (fss_expertise_results[,!names(fss_expertise_results) %in% 
                                                 c(".y.")])

ggp_table_fssExp <- ggplot() +                             # Create empty plot with table
  theme_void() +
  annotate(geom = "table",
           x = 1,
           y = 1,
           label = list(fss_expertise_results)) 
title <- "Differences in FSS scores (Flow) between high and low expertise"  
ggp_table_fssExp + ggtitle(title) + theme(plot.title.position = "plot")

#Plot differences in DFS scores and subscales between high and low expertise
fss_expertise <- fss_condition[,c("Participant","NonFlow_TotalFSS","NonFlow_Balance","NonFlow_Merging","NonFlow_Goals","NonFlow_Feedback","NonFlow_Concentration","NonFlow_Control","NonFlow_Consciousness","NonFlow_Time","NonFlow_Autotelic","Expertise")]
fss_meansd<- fss_expertise %>% 
  group_by(Expertise) %>%
  get_summary_stats(NonFlow_TotalFSS,NonFlow_Balance,NonFlow_Merging,NonFlow_Goals, NonFlow_Feedback,NonFlow_Concentration,NonFlow_Control,NonFlow_Consciousness,NonFlow_Time,NonFlow_Autotelic, type = "mean_sd")

names(fss_meansd)[names(fss_meansd) == "mean"] <- "Mean Rating"

fss_meansd$sem<-fss_meansd$sd/sqrt(dfs_meansd$n)
fss_meansd<-fss_meansd %>% separate(col= variable, into = c('extra','Dimension'), sep='_')
fss_meansd$Dimension<-factor(fss_meansd$Dimension, levels = c("Balance","Merging","Goals","Feedback","Concentration","Control","Consciousness","Time","Autotelic","Flow"))
ggplot(fss_meansd, aes( x = Dimension, y = `Mean Rating`, fill = Expertise ) ) +
  geom_bar( position = position_dodge(), stat = "identity", alpha = .3 ) +
  geom_errorbar(aes(ymin=`Mean Rating`-sem, ymax=`Mean Rating`+sem), width=.1,
                position=position_dodge(.9)) +
  ggtitle("FSS Scores (Flow) - High and Low Expertise")+
  scale_fill_manual(values=c("#FF9933", "#9900FF")) +
  theme(legend.position = "top")

#t-test DFS and subscales between high and low expertise
fss_expertise_long <- melt(fss_expertise, id.vars = c("Participant", "Expertise"))
fss_expertise_long<-fss_expertise_long %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')
fss_expertise_long %>%
  identify_outliers(value)

fss_expertise_results<- fss_expertise_long %>%
  group_by(Dimension) %>%
  t_test(data=., value ~ Expertise) %>%
  adjust_pvalue(method = "holm") %>%
  add_significance("p.adj")

fss_expertise_results<- (fss_expertise_results[,!names(fss_expertise_results) %in% 
                                                 c(".y.")])

ggp_table_fssExp <- ggplot() +                             # Create empty plot with table
  theme_void() +
  annotate(geom = "table",
           x = 1,
           y = 1,
           label = list(fss_expertise_results)) 
title <- "Differences in FSS scores (Flow) between high and low expertise"  
ggp_table_fssExp + ggtitle(title) + theme(plot.title.position = "plot")

fss_condition_high<- fss_condition[ fss_condition$Expertise == "High",]

fss_meansd<- fss_condition_high %>% 
  get_summary_stats(Flow_TotalFSS,NonFlow_TotalFSS, 
                    Flow_Balance,Flow_Merging,Flow_Goals, Flow_Feedback,Flow_Concentration,Flow_Control,Flow_Consciousness,Flow_Time,Flow_Autotelic,
                    NonFlow_Balance,NonFlow_Merging,NonFlow_Goals, NonFlow_Feedback,NonFlow_Concentration,NonFlow_Control,NonFlow_Consciousness,NonFlow_Time,NonFlow_Autotelic,
                    type = "mean_sd")

names(fss_meansd)[names(fss_meansd) == "mean"] <- "Mean Rating"

fss_meansd$sem<-fss_meansd$sd/sqrt(fss_meansd$n)
fss_meansd<-fss_meansd %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')

fss_meansd$Dimension<-factor(fss_meansd$Dimension, levels = c("TotalFSS","Balance","Merging","Goals","Feedback","Concentration","Control","Consciousness","Time","Autotelic"))
fss_dimension_plot_high <- ggplot(fss_meansd, aes( x = Dimension, y = `Mean Rating`, fill = Condition ) ) +
  geom_bar( position = position_dodge(), stat = "identity", alpha = .3 ) +
  geom_errorbar(aes(ymin=`Mean Rating`-sem, ymax=`Mean Rating`+sem), width=.1,
                position=position_dodge(.9)) +
  ggtitle("Flow State Scores (High Expertise) - by Dimension")+
  scale_fill_manual(values=c( rgb(0.8,0.2,0.5,0.7),rgb(0.0,0.4,0.7,0.7))) +
  theme(legend.position = "top") +
  scale_y_continuous(breaks=seq(0,5,1)) +
  expand_limits(y=c(0,5))
fss_dimension_plot_high

fss_condition_low<- fss_condition[ fss_condition$Expertise == "Low",]

fss_meansd<- fss_condition_low %>% 
  get_summary_stats(Flow_TotalFSS,NonFlow_TotalFSS, 
                    Flow_Balance,Flow_Merging,Flow_Goals, Flow_Feedback,Flow_Concentration,Flow_Control,Flow_Consciousness,Flow_Time,Flow_Autotelic,
                    NonFlow_Balance,NonFlow_Merging,NonFlow_Goals, NonFlow_Feedback,NonFlow_Concentration,NonFlow_Control,NonFlow_Consciousness,NonFlow_Time,NonFlow_Autotelic,
                    type = "mean_sd")

names(fss_meansd)[names(fss_meansd) == "mean"] <- "Mean Rating"

fss_meansd$sem<-fss_meansd$sd/sqrt(fss_meansd$n)
fss_meansd<-fss_meansd %>% separate(col= variable, into = c('Condition','Dimension'), sep='_')

fss_meansd$Dimension<-factor(fss_meansd$Dimension, levels = c("TotalFSS","Balance","Merging","Goals","Feedback","Concentration","Control","Consciousness","Time","Autotelic"))
fss_dimension_plot_low <- ggplot(fss_meansd, aes( x = Dimension, y = `Mean Rating`, fill = Condition ) ) +
  geom_bar( position = position_dodge(), stat = "identity", alpha = .3 ) +
  geom_errorbar(aes(ymin=`Mean Rating`-sem, ymax=`Mean Rating`+sem), width=.1,
                position=position_dodge(.9)) +
  ggtitle("Flow State Scores (Low Expertise) - by Dimension")+
  scale_fill_manual(values=c( rgb(0.8,0.2,0.5,0.7),rgb(0.0,0.4,0.7,0.7))) +
  theme(legend.position = "top") +
  scale_y_continuous(breaks=seq(0,5,1)) +
  expand_limits(y=c(0,5))
fss_dimension_plot_low

fss_dimension_exp <- ggarrange(fss_dimension_plot_high,fss_dimension_plot_low,
                      labels= c("A","B"),
                      ncol = 1, nrow = 2, common.legend = TRUE)
fss_dimension_exp

sig_elecs_corr <- cbind(sig_elecs_dataset,combined_eeg$GMSI_FG)
names(sig_elecs_corr)[names(sig_elecs_corr) == "combined_eeg$GMSI_FG"] <- "Expertise"
cor.test(sig_elecs_corr$NonFlow_beta,sig_elecs_corr$Expertise)

beta_exp_corrplot<-ggplot(sig_elecs_corr,aes(x=NonFlow_beta,y=Expertise)) + 
  geom_point() +
  geom_smooth(method="lm", se=TRUE, fullrange=FALSE, level=0.95)+
  theme_classic()

beta_exp_corrplot

sig_elecs_corr <- cbind(sig_elecs_dataset,combined_eeg$DFS_Flow)
names(sig_elecs_corr)[names(sig_elecs_corr) == "combined_eeg$DFS_Flow"] <- "DFS"
cor.test(sig_elecs_corr$NonFlow_alpha,sig_elecs_corr$DFS)

beta_exp_corrplot<-ggplot(sig_elecs_corr,aes(x=NonFlow_beta,y=Expertise)) + 
  geom_point() +
  geom_smooth(method="lm", se=TRUE, fullrange=FALSE, level=0.95)+
  theme_classic()

beta_exp_corrplot

ggplot(cor_dataset2,aes(x=diff_beta,y=diff_Flow)) + 
  geom_point() +
  geom_smooth(method="lm", se=TRUE, fullrange=FALSE, level=0.95)+
  theme_classic()

cor.test(cor_dataset2$diff_beta,cor_dataset2$diff_Flow)

sig_elecs_corr_high<- sig_elecs_corr[ sig_elecs_corr$Expertise == "High",]
alpha_high_cor <- cor.test(sig_elecs_corr_high$NonFlow_alpha,sig_elecs_corr_high$NonFlow)
alpha_high_cor

sig_elecs_corr_low<- sig_elecs_corr[ sig_elecs_corr$Expertise == "Low",]
alpha_low_cor <- cor.test(sig_elecs_corr_low$NonFlow_alpha,sig_elecs_corr_low$NonFlow)
alpha_low_cor




