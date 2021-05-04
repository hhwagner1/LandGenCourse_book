--- 
title: "Landscape Genetic Data Analysis with R"
author: "Editor: Helene Wagner (University of Toronto)"
date: "2021-05-04"
output:
  bookdown::html_document2:
    includes:
      in_header: header.html
  bookdown::gitbook:
    includes:
      in_header: header.html
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib]
biblio-style: apalike
link-citations: yes
github-repo: hhwagner1/LandGenCourse_book
description: "This is a web-interface to the teaching materials for the lab course 'Landscape Genetic Data Analysis with R' associated with the distributed graduate course 'DGS Landscape Genetics'. The output format is bookdown::gitbook."


---
# (PART\*) Getting Started {-}
# Introduction






This is a web-interface to the teaching materials for the lab course 'Landscape Genetic Data Analysis with R' associated with the distributed graduate course  ['DGS Landscape Genetics'](https://sites.google.com/site/landscapegeneticscourse/ "DGS public website").

All teaching materials are included in the R package `LandGenCourse` available on [Github](https://github.com/hhwagner1/LandGenCourse "github repository") 

## How to use this Book

### 1. Book Structure

This book has weekly chapters that correspond to course modules, with three parts:

#### a) Getting Started 
  - Review of R Skills: check whether you need to build or brush up your R skills before starting the course:
      - Basic R Programming: introduction to R objects and functions. **Prerequisite**.
      - R Graphics: learn to create figures with base R and with `ggplot2`. Optional.
      
#### b) Basic Topics
  - These 8 weekly modules are streamlined to build the necessary R skills and brush up statistics knowledge. Best complete these in sequence.
  - Each module has the following components:
      - Video: introduces the R and stats topics
      - Interactive Tutorial: swirl course to practice R programming
      - Worked Example: worked example by the weekly experts from the ['DGS Landscape Genetics'](https://sites.google.com/site/landscapegeneticscourse/ "DGS public website") course.
      - Bonus Materials: some weeks include bonus vignettes with optional advanced topics.
      
#### c) Advanced Topics
  - These weekly modules build on the skills developed in Basic Topics. You may pick and choose from the Advanced Topics according to your interests.
  - Each weekly modules contains:
      - Worked Example: worked example by the weekly experts from the ['DGS Landscape Genetics'](https://sites.google.com/site/landscapegeneticscourse/ "DGS public website") course.
      - Bonus Materials: some weeks include bonus vignettes with optional advanced topics.

### 2. Find what is relevant for you

#### a) Beginner-level users

#### b) Intermediate-level users

#### c) Advanced-level users

### 3. Course R package `LandGenCourse`

#### a) How to install (or update)

```r
if (!require("devtools")) install.packages("devtools")
```

```
## Loading required package: devtools
```

```
## Loading required package: usethis
```

```r
devtools::install_github("hhwagner1/LandGenCourse")
```

```
## Skipping install of 'LandGenCourse' from a github remote, the SHA1 (158fb26a) has not changed since last install.
##   Use `force = TRUE` to force installation
```

```r
library(LandGenCourse)
```

#### b) How to use the R package `LandGenCourse`

The package installs four Add-ins in RStudio. Each will provide you with some dropdown menu choices.

- **Watch Course Video**: opens a video resource from course "Landscape Genetic Data Analysis with R".
- **Start Tutorial**: installs swirl course "Landscape_Genetics_R_Course" and prints instructions.
- **Choose Worked Example**: opens vignette file (.html, .Rmd, or .R) with a worked example from course "Landscape Genetic Data Analysis with R".
- **Open Cheat Sheet**: opens selected R cheat sheet.

#### c) Video instructions for beginners
This video walks through the process of installing devtools, the course package, and using the RStudio Add-Ins.
<a href="https://www.dropbox.com/s/598kwim7x09m47t/Intro_LandGenCourse_small.mp4?dl=0" target="_blank">Intro_LandGenCourse_small.mp4</a>


## Overview of Topics


## List of Packages by Vignette


<table class="table table-bordered table-striped table-condensed table-responsive table" style="margin-left: auto; margin-right: auto; font-size: 10px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> B </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> G </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 1 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 2 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 2a </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 3 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 4 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 5 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 6 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 7 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 8 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 8a </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 9 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 10 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 11 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 12 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 13 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> 14 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> ade4 </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> adegenet </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> car </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> cowplot </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> data.table </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> deldir </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> dplyr </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> e1071 </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> EcoGenetics </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> effsize </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> fields </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> foreach </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> gdistance </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> GeNetIt </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> ggeffects </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> ggmap </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> ggplot2 </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> gridExtra </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> gstudio </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> here </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> hierfstat </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> igraph </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> knitr </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> landscapemetrics </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> lattice </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> LEA </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> lfmm </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> lme4 </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> mapplots </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> MASS </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> Matrix </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> microbenchmark </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> mmod </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> MuMIn </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> nlme </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> pegas </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> PopGenReport </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> poppr </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> predictmeans </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> profvis </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> purrr </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> pwr </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> QstFstComp </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> qvalue </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> raster </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> RColorBrewer </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> readr </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> rio </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> secr </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> sf </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> sp </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> spatialEco </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> spdep </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> spmoran </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> Sunder </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> tmaptools </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;border-left:1px solid;border-right:1px solid;width: 2; border-right:1px solid;"> vegan </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;"> X </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;border-right:1px solid;">  </td>
   <td style="text-align:left;width: 2; border-right:1px solid;"> X </td>
  </tr>
</tbody>
</table>





