---
title: "Statistical Inference Project - Inferential Data Analysis"
author: "William Matthews"
date: "January 19, 2018"
output: pdf_document
keep_md: yes
---
### Load packages
```{r} 
library(ggplot2)
```
# Summary:
We will study the The effect of vitamin c on tooth growth in Guinea Pigs using two supplements (orange juice and ascorbic acid (vc)) administered at three different dosage levels (0.5, 1, 2).

# Exploratory data analysis of the ToothGrowth dataset
### Load the ToothGrowth dataset
```{r}
data("ToothGrowth")
```
### View dimensions of the dataset
```{r}
dim(ToothGrowth)
```
### View variable names in the datasets
```{r}
names(ToothGrowth)
```
### View structure of the dataset.
```{r}
str(ToothGrowth)
```
### Since there are only three unique values in the dose variable convert from numeric to factor
```{r}
ToothGrowth$dose <- as.factor(ToothGrowth$dose)
```
### View structure of data
```{r}
str(ToothGrowth)
```
### View summary of the dataset
```{r}
summary(ToothGrowth)
```
### Create a boxplot graph to show the tooth lenght by supplement
```{r}
ggplot(aes(x = supp, y = len), data = ToothGrowth) + geom_boxplot(aes(fill = supp)) + 
  xlab("Supplement Type") + ylab("Tooth Length")
```
### Calculate the mean tooth growth by dosage level.
```{r}
meanDosage <- split(ToothGrowth$len, ToothGrowth$dose)
sapply(meanDosage, mean)
```
### Create a boxplot graph to show the tooth length by dosage level
```{r}
ggplot(aes(x = dose, y = len), data = ToothGrowth) + geom_boxplot(aes(fill = dose)) + 
  xlab("Dosage Level (mg)") + ylab("Tooth Length")
```
### Create a boxplot graph to compare the supplements at each dosage level
```{r}
ggplot(aes(x = supp, y = len), data = ToothGrowth) + geom_boxplot(aes(fill = supp)) + 
  facet_wrap(~dose) + xlab("Dosage Level (mg)") + ylab("Tooth Length")
```
# Analysis & Hypothesis testing
OJ appears to be more effective for tooth growth at lower dosage levels. At 2mg both supplements are relatively equal. 

The graphs seem to indicate there is an increase in tooth growth with the increase in supplement dose and supplement type. Let the null hypothesis be that supp type does not affect tooth growth. 

### Use t-test to test for differences in tooth growth due to supplement type. 
```{r}
t.test(len ~ supp, data = ToothGrowth)
```
With a p-value at 0.06 and the confidence interval containing 0 we cannot reject the null hypothesis that supp type has no affect on tooth growth.

### Use t-test to test for differences in tooth growth due to dosage level. 
### First create three groups to compare the dosage levels 
```{r}
dose_a <- subset(ToothGrowth, dose %in% c(0.5,1.0))
dose_b <- subset(ToothGrowth, dose %in% c(0.5,2.0))
dose_c <- subset(ToothGrowth, dose %in% c(1.0,2.0))
```
### Now test each level
```{r}
t.test(len ~ dose, data = dose_a)
t.test(len ~ dose, data = dose_b)
t.test(len ~ dose, data = dose_c)
```

For each of these tests the p-value was less than 0.05 and the confidence interval does not contain 0. Therefore, we can reject the null hypothesis that changes in dosage levels do not affect tooth growth.

# Conclusion:
We cannot reject the null hypothesis that supplement type does not affect tooth growth. 
We can rejet the null hypothesis that dosage levels do not affect tooth growth. 

### Assumptions:
1. The samples are independent and the variances are assumed to be different. 
2. The sample represents the true population. 