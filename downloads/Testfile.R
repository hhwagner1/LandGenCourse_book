




Some code from Week 7 Worked Example for profiling.


``` r
library(LandGenCourse)
library(nlme)
library(dplyr)
library(spatialreg)
library(ggplot2)
library(tmap)
```

### a) Import data


``` r
data(Dianthus)
```


``` r
Dianthus.df <- data.frame(A=Dianthus$A, IBD=Dianthus$Eu_pj, 
                          IBR=Dianthus$Sheint_pj,
                          PatchSize=log(Dianthus$Ha),
                          System=Dianthus$System,
                          Longitude=Dianthus$Longitude,
                          Latitude=Dianthus$Latitude,
                          st_coordinates(Dianthus))

# Define 'System' for ungrazed patches
Dianthus.df$System=as.character(Dianthus$System)
Dianthus.df$System[is.na(Dianthus.df$System)] <- "Ungrazed"
Dianthus.df$System <- factor(Dianthus.df$System, 
                             levels=c("Ungrazed", "East", "South", "West"))

# Remove patches with missing values for A
Dianthus.df <- Dianthus.df[!is.na(Dianthus.df$A),]
dim(Dianthus.df)
```

```
## [1] 59  9
```


### b) Fit regression models

Here we fit three multiple regression models to explain variation in allelic richness:

- **mod.lm.IBD**: IBD model of connectivity 'Eu_pj'.
- **mod.lm.IBR**: IBR model shepherding connectivity 'Sheint_pj'.
- **mod.lm.PatchSize**: log patch size and IBR model.


``` r
mod.lm.IBD <- lm(A ~ IBD, data = Dianthus.df)
summary(mod.lm.IBD)
```

```
## 
## Call:
## lm(formula = A ~ IBD, data = Dianthus.df)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.68545 -0.10220  0.03883  0.16178  0.36100 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 4.070960   0.064061  63.549   <2e-16 ***
## IBD         0.008454   0.047460   0.178    0.859    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.2324 on 57 degrees of freedom
## Multiple R-squared:  0.0005563,	Adjusted R-squared:  -0.01698 
## F-statistic: 0.03173 on 1 and 57 DF,  p-value: 0.8593
```

This model does not fit the data at all!


``` r
mod.lm.IBR <- lm(A ~ IBR, data = Dianthus.df)
summary(mod.lm.IBR)
```

```
## 
## Call:
## lm(formula = A ~ IBR, data = Dianthus.df)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.66844 -0.11251  0.03418  0.12219  0.41760 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.92306    0.05499  71.348  < 2e-16 ***
## IBR          0.25515    0.07672   3.326  0.00155 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.2128 on 57 degrees of freedom
## Multiple R-squared:  0.1625,	Adjusted R-squared:  0.1478 
## F-statistic: 11.06 on 1 and 57 DF,  p-value: 0.001547
```
