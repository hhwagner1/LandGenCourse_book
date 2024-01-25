















## 1. Overview of Worked Example {-}

### a) Goals {-} 

This worked example shows how to:

- Check markers and populations (polymorphism, HWE, linkage, null alleles). 
- Assess genetic diversity.
- Aggregate genetic data at the population level.

### b) Data set {-} 

This is the same data set as used in Weeks 1 & 2.

Microsatellite data for 181 individuals of Colombia spotted frogs (Rana luteiventris) from 12 populations. Site-level spatial coordinates and attributes. The data are a subsample of the full data set analyzed in Funk et al. (2005) and Murphy et al. (2010). Please see the separate introduction to the data set. 

- **ralu.loci**: Data frame with populations and genetic data (181 rows x 9 columns). Included in package 'LandGenCourse'. To load it, type: data(ralu.loci)
- **ralu.site**: Spatial points data frame with spatial coordinates and site variables Included in package GeNetIt'. To load it, type: data(ralu.site)

### c) Required R packages {-}

All required packages should have been installed already when you installed 'LandGenCourse'.


```r
#require(adegenet)
require(LandGenCourse)
#require(pegas)       
#require(PopGenReport)
require(dplyr)
require(poppr) 
```

## 2. Basic checking of markers and populations {-}

Before we do landscape genetic analysis, we need to perform a basic population genetic analysis of the genetic data, in order to better understand the nature and quality of the data and to check for underlying assumptions of population genetic models and corresponding methods. 

### a) Re-create genind object {-} 

Adapted from Week 1 tutorial: 

Note: we use the double colon notation 'package::function(argument)' to indicate, for each function, which package it belongs to (see Week 2 video).


```r
data(ralu.loci, package="LandGenCourse")
Frogs <- data.frame(FrogID = paste(substr(ralu.loci$Pop, 1, 3), 
                                   row.names(ralu.loci), sep="."), ralu.loci)
Frogs.genind <- adegenet::df2genind(X=Frogs[,c(4:11)], sep=":", ncode=NULL, 
                          ind.names= Frogs$FrogID, loc.names=NULL, 
                          pop=Frogs$Pop, NA.char="NA", ploidy=2, 
                          type="codom", strata=NULL, hierarchy=NULL)
Frogs.genind
```

```
## /// GENIND OBJECT /////////
## 
##  // 181 individuals; 8 loci; 39 alleles; size: 55.5 Kb
## 
##  // Basic content
##    @tab:  181 x 39 matrix of allele counts
##    @loc.n.all: number of alleles per locus (range: 3-9)
##    @loc.fac: locus factor for the 39 columns of @tab
##    @all.names: list of allele names for each locus
##    @ploidy: ploidy of each individual  (range: 2-2)
##    @type:  codom
##    @call: adegenet::df2genind(X = Frogs[, c(4:11)], sep = ":", ncode = NULL, 
##     ind.names = Frogs$FrogID, loc.names = NULL, pop = Frogs$Pop, 
##     NA.char = "NA", ploidy = 2, type = "codom", strata = NULL, 
##     hierarchy = NULL)
## 
##  // Optional content
##    @pop: population of each individual (group size range: 7-23)
```

### b) Check that markers are polymorphic {-}

The genetic resolution depends on the number of markers and their polymorphism. The table above and the summary function for genind objects together provide this information. Now we run the summary function:


```r
summary(Frogs.genind)
```

```
## Length  Class   Mode 
##      1 genind     S4
```
The output of the summary function shows us the following:

- 8 loci with 3 - 9 alleles (39 in total)
- Expected heterozygosity varies between 0.14 (locus C) and 0.78 (locus E)
- There's a reasonable level of missing values (10.6%) 

### c) Check for deviations from Hardy-Weinberg equilibrium (HWE) {-}

See also: http://dyerlab.github.io/applied_population_genetics/hardy-weinberg-equilibrium.html

For a very large population (no drift) with random mating and non-overlapping generations (plus a few more assumptions about the mating system), and in the absence of mutation, migration (gene flow) and selection, we can predict offspring genotype frequencies from allele frequencies of the parent generation (Hardy-Weinberg equilibrium). 
In general, we don't expect all of these assumptions to be met (e.g., if we want to study gene flow or selection, we kind of expect that these processes are present). Note: plants often show higher levels of departure from HWE than animals. 

Here are p-values for two alternative tests of deviation from HWE for each locus. Columns:

- **chi^2**: value of the classical chi-squared test statistic
- **df**: degrees of freedom of the chi-squared test
- **Pr(chi^2 >)**: p-value of the chi-squared test ('>' indicates that the alternative is 'greater', which is always the case for a chi-squared test)
- **Pr.exact**: p-value from an exact test based on Monte Carlo permutation of alleles (for diploids only). The default is B = 1000 permutations (set B = 0 to skip this test). 
Here we use the function 'round' with argument 'digits = 3' to round all values to 3 decimals. 


```r
round(pegas::hw.test(Frogs.genind, B = 1000), digits = 3)
```

```
##     chi^2 df Pr(chi^2 >) Pr.exact
## A  40.462  3       0.000    0.000
## B  17.135  6       0.009    0.034
## C 136.522  6       0.000    0.000
## D  83.338  6       0.000    0.000
## E 226.803 36       0.000    0.000
## F   0.024  3       0.999    1.000
## G  12.349  6       0.055    0.007
## H  76.813 28       0.000    0.000
```

Both tests suggest that all loci except for locus "F" are out of HWE globally (across all 181 individuals). Next, we check for HWE of each locus in each population.

Notes on the code: The curly brackets '{ }' below are used to keep the output from multiple lines together in the html file. Function 'seppop' splits the genind object by population. We use 'sapply' to apply the function 'hw.test' from package 'pegas' to each population (see this week's video and tutorial). We set 'B=0' to specify that we don't need any permutations right now. The function 't' takes the transpose of the resulting matrix, which means it flips rows and columns. This works on a matrix, not a data frame, hence we use 'data.matrix' to temporarily interpret the data frame as a matrix. 


```r
# Chi-squared test: p-value
HWE.test <- data.frame(sapply(seppop(Frogs.genind), 
                              function(ls) pegas::hw.test(ls, B=0)[,3]))
HWE.test.chisq <- t(data.matrix(HWE.test))
{cat("Chi-squared test (p-values):", "\n")
round(HWE.test.chisq,3)}
```

```
## Chi-squared test (p-values):
```

```
##                A     B     C     D     E     F     G     H
## Airplane   0.092 0.359 1.000 0.427 0.680 1.000 0.178 0.051
## Bachelor   1.000 0.557 0.576 0.686 0.716 1.000 0.414 0.609
## BarkingFox 0.890 0.136 0.005 0.533 0.739 0.890 0.708 0.157
## Bob        0.764 0.864 0.362 0.764 0.033 1.000 0.860 0.287
## Cache      1.000 0.325 0.046 0.659 0.753 1.000 0.709 0.402
## Egg        1.000 0.812 1.000 1.000 0.156 1.000 0.477 0.470
## Frog       1.000 0.719 0.070 0.722 0.587 1.000 0.564 0.172
## GentianL   0.809 0.059 1.000 0.028 0.560 0.717 0.474 0.108
## ParagonL   1.000 0.054 0.885 0.709 0.868 1.000 0.291 0.000
## Pothole    1.000 1.000 1.000 0.488 0.248 1.000 0.296 0.850
## ShipIsland 0.807 0.497 1.000 0.521 0.006 1.000 0.498 0.403
## Skyhigh    0.915 0.493 0.063 0.001 0.155 1.000 0.126 0.078
```

Let's repeat this with a Monte Carlo permutation test with B = 1000 replicates:


```r
# Monte Carlo: p-value
HWE.test <- data.frame(sapply(seppop(Frogs.genind), 
                              function(ls) pegas::hw.test(ls, B=1000)[,4]))
HWE.test.MC <- t(data.matrix(HWE.test))
{cat("MC permuation test (p-values):", "\n")
round(HWE.test.MC,3)}
```

```
## MC permuation test (p-values):
```

```
##                A     B     C     D     E F     G     H
## Airplane   0.013 1.000 1.000 0.412 0.618 1 0.251 0.010
## Bachelor   1.000 0.433 1.000 1.000 0.844 1 0.499 0.591
## BarkingFox 1.000 0.223 0.083 1.000 0.757 1 1.000 0.158
## Bob        1.000 1.000 1.000 1.000 0.017 1 1.000 0.277
## Cache      1.000 0.409 0.148 1.000 1.000 1 1.000 0.642
## Egg        1.000 1.000 1.000 1.000 0.073 1 0.544 0.463
## Frog       1.000 1.000 0.073 1.000 0.460 1 1.000 0.170
## GentianL   1.000 0.064 1.000 0.058 0.664 1 0.646 0.145
## ParagonL   1.000 0.161 1.000 1.000 1.000 1 0.333 0.070
## Pothole    1.000 1.000 1.000 1.000 0.529 1 0.508 1.000
## ShipIsland 1.000 0.611 1.000 0.696 0.136 1 0.540 0.447
## Skyhigh    1.000 0.362 0.157 0.103 0.115 1 0.071 0.032
```

To summarize, let's calculate, for each locus, the proportion of populations where it was out of HWE. Here we'll use the conservative cut-off of alpha = 0.05 for each test. There are various ways of modifying this, including a simple Bonferroni correction, where we divide alpha by the number of tests, which you can activate here by removing the # in front of the line.

We write the results into a data frame 'Prop.loci.out.of.HWE' and use '=' to specify the name for each column. 


```r
alpha=0.05 # /96
Prop.loci.out.of.HWE <- data.frame(Chisq=apply(HWE.test.chisq<alpha, 2, mean), 
           MC=apply(HWE.test.MC<alpha, 2, mean))
Prop.loci.out.of.HWE             # Type this line again to see results table
```

```
##        Chisq         MC
## A 0.00000000 0.08333333
## B 0.00000000 0.00000000
## C 0.16666667 0.00000000
## D 0.16666667 0.00000000
## E 0.16666667 0.08333333
## F 0.00000000 0.00000000
## G 0.00000000 0.00000000
## H 0.08333333 0.16666667
```

And similarly, for each population, the proportion of loci that were out of HWE:


```r
Prop.pops.out.of.HWE <- data.frame(Chisq=apply(HWE.test.chisq<alpha, 1, mean), 
           MC=apply(HWE.test.MC<alpha, 1, mean))
Prop.pops.out.of.HWE             
```

```
##            Chisq    MC
## Airplane   0.000 0.250
## Bachelor   0.000 0.000
## BarkingFox 0.125 0.000
## Bob        0.125 0.125
## Cache      0.125 0.000
## Egg        0.000 0.000
## Frog       0.000 0.000
## GentianL   0.125 0.000
## ParagonL   0.125 0.000
## Pothole    0.000 0.000
## ShipIsland 0.125 0.000
## Skyhigh    0.125 0.125
```
The results suggest that:

- While most loci are out of HWE globally, this is largely explained by subdivision (variation in allele frequencies among local populations indicating limited gene flow). 
- No locus is consistently out of HWE across populations (loci probably not affected by selection).
- No population is consistently out of HWE across loci (probably no recent major bottlenecks/ founder effects).

Let's repeat this with 'false discovery rate' correction for the number of tests. Here we use the function 'p.adjust' with the argument 'method="fdr"' to adjust the p-values from the previous tests. This returns a vector of length 96 (the number of p-values used), which we convert back into a matrix of 12 rows (pops) by 8 columns (loci). Then we procede as above.


```r
Chisq.fdr <- matrix(p.adjust(HWE.test.chisq,method="fdr"), 
                    nrow=nrow(HWE.test.chisq))
MC.fdr <- matrix(p.adjust(HWE.test.MC, method="fdr"), 
                    nrow=nrow(HWE.test.MC))

Prop.pops.out.of.HWE <- data.frame(Chisq=apply(HWE.test.chisq<alpha, 1, mean), 
           MC=apply(HWE.test.MC<alpha, 1, mean),
           Chisq.fdr=apply(Chisq.fdr<alpha, 1, mean),
           MC.fdr=apply(MC.fdr<alpha, 1, mean))
Prop.pops.out.of.HWE             
```

```
##            Chisq    MC Chisq.fdr MC.fdr
## Airplane   0.000 0.250     0.000      0
## Bachelor   0.000 0.000     0.000      0
## BarkingFox 0.125 0.000     0.000      0
## Bob        0.125 0.125     0.000      0
## Cache      0.125 0.000     0.000      0
## Egg        0.000 0.000     0.000      0
## Frog       0.000 0.000     0.000      0
## GentianL   0.125 0.000     0.000      0
## ParagonL   0.125 0.000     0.125      0
## Pothole    0.000 0.000     0.000      0
## ShipIsland 0.125 0.000     0.000      0
## Skyhigh    0.125 0.125     0.125      0
```

After using false discovery rate correction for the 8 * 12 = 96 tests performed, very few combinations of locus and population were out of HWE based on the chi-squared test, and none with the MC test. 

Note: exact results are likely to differ somewhat between runs due to the permutation tests.


### d) Check for linkage disequilibrium (LD) {-}
See also: https://grunwaldlab.github.io/Population_Genetics_in_R/Linkage_disequilibrium.html

For microsatellite markers, we typically don't know where on the genome they are located. The closer together two markers are on a chromosome, the more likely they are inherited together, which means that they don't really provide independent information. Testing for linkage disequilibrium assesses this, for each pair of loci, by checking whether alleles of two loci are statistically associated.

This step is especially important when developing a new set of markers. You may want to drop (the less informative) one marker of any pair of linked loci. 

Here, we start with performing an overall test of linkage disequilibrium (the null hypothesis is that there is no linkage among the set of markers). Two indices are calculated and tested: an index of association (Ia; Brown et al. 1980) and a measure of correlation (rbarD; Agapow and Burt 2001), which is less biased (see URL above). The number of permutations is specified by 'sample = 199'.

Overall, there is statistically significant association among the markers (p-value: prD = 0.005; also left figure). Recall that the power of a statistical test increases with sample size, and here we have n = 181, hence even a small effect may be statistically significant. Hence we look at effect size, i.e., the actual strength of the pairwise associations (right figure). 


```r
poppr::ia(Frogs.genind, sample=199)
```

```
##         Ia       p.Ia      rbarD       p.rD 
## 0.33744318 0.00500000 0.05366542 0.00500000
```

```r
LD.pair <- poppr::pair.ia(Frogs.genind)
```

```r
LD.pair
```

```
##          Ia   rbarD
## A:B  0.0485  0.0492
## A:C -0.0314 -0.0335
## A:D  0.1886  0.1966
## A:E  0.0560  0.0569
## A:F -0.0272 -0.0452
## A:G  0.0931  0.0935
## A:H  0.0294  0.0304
## B:C -0.0329 -0.0375
## B:D  0.0903  0.0911
## B:E  0.0910  0.0910
## B:F -0.0013 -0.0025
## B:G  0.0451  0.0452
## B:H  0.0621  0.0623
## C:D -0.0859 -0.1049
## C:E  0.0247  0.0284
## C:F -0.0311 -0.0397
## C:G -0.0107 -0.0118
## C:H  0.0012  0.0015
## D:E  0.0455  0.0458
## D:F  0.0094  0.0199
## D:G  0.0069  0.0070
## D:H  0.0461  0.0462
## E:F  0.0013  0.0025
## E:G  0.0453  0.0454
## E:H  0.2153  0.2159
## F:G  0.0167  0.0299
## F:H  0.0296  0.0606
## G:H  0.0942  0.0953
```

<img src="08-Week08_files/figure-html/unnamed-chunk-135-1.png" width="672" /><img src="08-Week08_files/figure-html/unnamed-chunk-135-2.png" width="672" />

The strongest correlation is around 0.2, for markers E and H. 

Effect size: If rbarD can be interpreted similarly to a linear correlation coefficient r, that would mean that less than 5% of the variation in one marker is shared with the other marker (recall from stats: the amount of variance explained in regression, Rsquared, is the square of the linear correlation coefficient). This is probably not large enough to worry about.  

### e) Check for null alleles {-}

See also Dakin and Avise (2004): http://www.nature.com/articles/6800545

One potential drawback for microsatellites as molecular markers is the presence of null alleles that fail to amplify, thus they couldn't be detected in the PCR assays.

The function 'null.all' takes a genind object and returns a list with two components ('homozygotes' and 'null.allele.freq'), and each of these is again a list. See '?null.all' for details and choice of method.

List 'homozygotes':
  
- **homozygotes$observed**: observed number of homozygotes for each allele at each locus
- **homozygotes$bootstrap**: distribution of the expected number of homozygotes
- **homozygotes$probability.obs**: probability of observing the number of homozygotes

Note: we are turning off warnings here (currently the code throws a warning for each sample, though results don't seem to be affected).


```r
# Null alleles: depends on method! See help file.
Null.alleles <- PopGenReport::null.all(Frogs.genind)
Null.alleles$homozygotes$probability.obs
```

```
##   Allele-1 Allele-2 Allele-3 Allele-4 Allele-5 Allele-6 Allele-7 Allele-8
## A    0.123    0.000    0.034       NA       NA       NA       NA       NA
## B    0.149    0.045    0.094    0.006       NA       NA       NA       NA
## C    0.172    0.000    0.000    0.002       NA       NA       NA       NA
## D    0.000    0.000    0.198    0.003       NA       NA       NA       NA
## E    0.046    0.015    0.042    0.275    0.069    0.040    0.742    0.541
## F    0.420    0.001    0.020       NA       NA       NA       NA       NA
## G    0.071    0.071    0.019    0.003       NA       NA       NA       NA
## H    0.431    0.079    0.007    0.028    0.238    0.293    0.010    0.002
##   Allele-9
## A       NA
## B       NA
## C       NA
## D       NA
## E        0
## F       NA
## G       NA
## H       NA
```

List 'null.allele.freq': 
  
- **null.allele.freq$summary1**: null allele frequency estimates based upon the forumulas of Chakraborty et al. (1994)
- **null.allele.freq$summary2**: null allele frequency estimates based upon the forumulas of Brookfield (1996)

From the help file: "Brookfield (1996) provides a brief discussion on which estimator should be used. In summary, it was recommended that Chakraborty et al. (1994)'s method (e.g. summary1) be used if there are individuals with no bands at a locus seen, but they are discounted as possible artefacts. If all individuals have one or more bands at a locus then Brookfield (1996)'s method (e.g. summary2) should be used." In this case, we have many individuals with missing values for both alleles, hence better use summary1.

Each summary table contains a summary with observed, median, 2.5th percentile and 97.5the percentile. The percentiles form a 95% confidence interval. From the help file: "If the 95% confidence interval includes zero, it indicates that the frequency of null alleles at a locus does not significantly differ from zero."


```r
{cat(" summary1 (Chakraborty et al. 1994):", "\n")
round(Null.alleles$null.allele.freq$summary1,2)} 
```

```
##  summary1 (Chakraborty et al. 1994):
```

```
##                       A    B    C    D    E     F    G    H
## Observed frequency 0.24 0.08 0.23 0.25 0.06  0.00 0.11 0.04
## Median frequency   0.24 0.08 0.23 0.25 0.06  0.00 0.11 0.04
## 2.5th percentile   0.07 0.01 0.04 0.17 0.02 -0.01 0.01 0.00
## 97.5th percentile  0.44 0.16 0.48 0.33 0.11  0.00 0.22 0.10
```


```r
{cat("summary2 (Brookfield et al. 1996):", "\n")
round(Null.alleles$null.allele.freq$summary2,2)}   
```

```
## summary2 (Brookfield et al. 1996):
```

```
##                       A    B    C    D    E F    G    H
## Observed frequency 0.06 0.05 0.05 0.17 0.05 0 0.07 0.04
## Median frequency   0.06 0.05 0.05 0.17 0.05 0 0.07 0.03
## 2.5th percentile   0.02 0.01 0.01 0.12 0.02 0 0.01 0.00
## 97.5th percentile  0.10 0.10 0.11 0.23 0.09 0 0.13 0.08
```

For this example, both methods suggest that there may be null alleles in most loci. However, the estimates of the frequency of null alleles differ a lot between the two methods. 

A different approach for estimating null alleles at microsatellite loci, based on the Estimation-Maximization algorithm, is implemented in `FreeNA` (outside of the R environment). `FreeNA` will directly provide Fst values and some other measurements using the corrected allele frequencies: https://www1.montpellier.inra.fr/CBGP/software/FreeNA/

Relevant papers for the Estimation-Maximization algorithm:

- Kalinowski et al. (2006), Conservation Genetics 7:991–995, doi: 10.1007/s10592-006-9134-9.
- Chapuis and Estoup (2007), Mol. Biol. Evol. 24:621–631, doi: 10.1093/molbev/msl191.


### f) Overall interpretation {-}

- **Spatial genetic structure**: The Columbia spotted frog data used in this lab come from a study area with a great deal of genetic structure.  If we use a population assignment test (see Week 9), each basin is a separate unit with significant substructure within basins. Testing for significant genetic distance, most pairs of ponds have a genetic distance that is significantly different from zero. 
- **HWE**: Therefore, we expect global estimates (i.e., the whole dataset) of He to be out of HWE due to population substructure (HWE assumes panmictic populations). We would also expect data to be out of HWE when analyzing data by basin due to population substructure. We could, then, test HWE and linkage disequilibrium at the pond level (as shown here). However, some ponds have low sample sizes (which refleect a low number of individuals: based on repeated surveys of sites, most if not nearly all animals were captured). 
- **Linkage**: These low samples sizes can result in deviations from HWE and in linkage disequilibrium as an artifact of sample size and/or breeding structure (if one male is responsible for all breeding, his genes would appear “linked” in offspring genotypes, even though they are not physically linked in the genome).  In addition, each pond may not represent a “population”, but only a portion of a population. 

So, what do we do? We can look for patterns.  Are there loci that are consistently out of HWE across samples sites while other loci are not out of HWE suggesting that there are null alleles or other data quality control issues?  With the full data set, this was not the case. Are there loci that are consistently linked across different ponds (while others are not), suggesting that they are linked?  With the full dataset, this was not the case.  

- **Null alleles**: Missing data can imply null (non-amplifying) alleles. In this case, while there are loci that have higher “drop-out” rates than others, this is more likely due to some loci being more difficult to call (the authors were very strict in removing any questionable data; equivocal calls resulting in no data). In addition, some of the samples used in this study were toe clips which with low yields of DNA, resulting in incomplete genotypes. While presence of null alleles is a possibility, genetic structure, breeding patterns at low population size and aggressive quality control of genotypes can all explain the results. Finally, with all of the structure in these data, there are examples (at the basin level and pond level) of unique alleles that are fixed or nearly fixed. When the data are assessed globally, this will result in a similar pattern to the presence of null alleles and will result in positive null allele tests.

