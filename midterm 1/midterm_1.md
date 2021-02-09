---
title: "Midterm 1"
author: "Adrianna Ng"
date: "2021-02-09"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 12 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by **12:00p on Thursday, January 28**.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
library(dplyr)
library(janitor)
library(skimr)
```

## Questions
**1. (2 points) Briefly explain how R, RStudio, and GitHub work together to make work flows in data science transparent and repeatable. What is the advantage of using RMarkdown in this context?** 

R is an open source, scripting language. RStudio is a GUI that is used to interact with R and make it easier to see what happens to your data when you create specific codes to analyze it. GitHub is a website for storing and managing files with programming codes in repositories that can be publicly available, so you could potentially run another scientist's code from a published paper and work with that data. This enables transparency because your data needs to be correct before you get called out when others download it, as well as repeatability because it won't take a lot of effort to restructure their steps. RMarkdown allows us to embed code in annotated chunks, show their results, and display any graphs in one file that can be exported into a multitude of different extensions -- it is a form of annotating our data and codes in a way that can be easily understood by others.

**2. (2 points) What are the three types of `data structures` that we have discussed? Why are we using data frames for BIS 15L?**
Vectors, data matrices, and data frames are the three types we have discussed. We are using data frames for BIS15L because it is like a spreadsheet that can store different classes of data and is not limited by the classes of data it can store (unlike a data matrix, which can only have one type).

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

**3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.**

```r
elephants <- readr::read_csv("data/ElephantsMF.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```

```r
elephants
```

```
## # A tibble: 288 x 3
##      Age Height Sex  
##    <dbl>  <dbl> <chr>
##  1   1.4   120  M    
##  2  17.5   227  M    
##  3  12.8   235  M    
##  4  11.2   210  M    
##  5  12.7   220  M    
##  6  12.7   189  M    
##  7  12.2   225  M    
##  8  12.2   204  M    
##  9  28.2   266. M    
## 10  11.7   233  M    
## # … with 278 more rows
```

```r
summary(elephants)
```

```
##       Age            Height           Sex           
##  Min.   : 0.01   Min.   : 75.46   Length:288        
##  1st Qu.: 4.58   1st Qu.:160.75   Class :character  
##  Median : 9.46   Median :200.00   Mode  :character  
##  Mean   :10.97   Mean   :187.68                     
##  3rd Qu.:16.50   3rd Qu.:221.09                     
##  Max.   :32.17   Max.   :304.06
```

```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17, …
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204.00…
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M…
```

**4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.**

```r
elephants <- clean_names(elephants)
names(elephants)
```

```
## [1] "age"    "height" "sex"
```


```r
elephants$sex <- as.factor(elephants$sex)
is.factor(elephants$sex)
```

```
## [1] TRUE
```

```r
summary(elephants)
```

```
##       age            height       sex    
##  Min.   : 0.01   Min.   : 75.46   F:150  
##  1st Qu.: 4.58   1st Qu.:160.75   M:138  
##  Median : 9.46   Median :200.00          
##  Mean   :10.97   Mean   :187.68          
##  3rd Qu.:16.50   3rd Qu.:221.09          
##  Max.   :32.17   Max.   :304.06
```

**5. (2 points) How many male and female elephants are represented in the data?**

```r
elephants %>% 
  count(sex)
```

```
## # A tibble: 2 x 2
##   sex       n
## * <fct> <int>
## 1 F       150
## 2 M       138
```
There are 150 females in this elephant data set, while 138 males in this elephant data set.

**6. (2 points) What is the average age all elephants in the data?**

```r
elephants %>% 
  summarise(average_age = mean(age),
            total = n())
```

```
## # A tibble: 1 x 2
##   average_age total
##         <dbl> <int>
## 1        11.0   288
```

**7. (2 points) How does the average age and height of elephants compare by sex?**

```r
elephants %>% 
  group_by(sex) %>% 
  summarise(avg_age = mean(age),
            avg_height = mean(height),
            total = n())
```

```
## # A tibble: 2 x 4
##   sex   avg_age avg_height total
## * <fct>   <dbl>      <dbl> <int>
## 1 F       12.8        190.   150
## 2 M        8.95       185.   138
```
Female elephants are older and just a bit taller than male elephants.

**8. (2 points) How does the average height of elephants compare by sex for individuals over 25 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.**

```r
elephants %>% 
  group_by(sex) %>%
  filter(age > 25) %>% 
  summarise(min_height = min(height),
            max_height = max(height),
            mean_height = mean(height),
            total = n())
```

```
## # A tibble: 2 x 5
##   sex   min_height max_height mean_height total
##   <fct>      <dbl>      <dbl>       <dbl> <int>
## 1 F           206.       278.        233.    25
## 2 M           237.       304.        273.     8
```
For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

**9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.**

```r
vertebrates <- readr::read_csv("data/IvindoData_DryadVersion.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## ℹ Use `spec()` for the full column specifications.
```

```r
vertebrates
```

```
## # A tibble: 24 x 26
##    TransectID Distance HuntCat NumHouseholds LandUse Veg_Rich Veg_Stems
##         <dbl>    <dbl> <chr>           <dbl> <chr>      <dbl>     <dbl>
##  1          1     7.14 Modera…            54 Park        16.7      31.2
##  2          2    17.3  None               54 Park        15.8      37.4
##  3          2    18.3  None               29 Park        16.9      32.3
##  4          3    20.8  None               29 Logging     12.4      29.4
##  5          4    16.0  None               29 Park        17.1      36  
##  6          5    17.5  None               29 Park        16.5      29.2
##  7          6    24.1  None               29 Park        14.8      31.2
##  8          7    19.8  None               54 Logging     13.2      32.6
##  9          8     5.78 High               25 Neither     12.6      23.7
## 10          9     5.13 High               73 Logging     16        27.1
## # … with 14 more rows, and 19 more variables: Veg_liana <dbl>, Veg_DBH <dbl>,
## #   Veg_Canopy <dbl>, Veg_Understory <dbl>, RA_Apes <dbl>, RA_Birds <dbl>,
## #   RA_Elephant <dbl>, RA_Monkeys <dbl>, RA_Rodent <dbl>, RA_Ungulate <dbl>,
## #   Rich_AllSpecies <dbl>, Evenness_AllSpecies <dbl>,
## #   Diversity_AllSpecies <dbl>, Rich_BirdSpecies <dbl>,
## #   Evenness_BirdSpecies <dbl>, Diversity_BirdSpecies <dbl>,
## #   Rich_MammalSpecies <dbl>, Evenness_MammalSpecies <dbl>,
## #   Diversity_MammalSpecies <dbl>
```

```r
vertebrates$HuntCat <- as.factor(vertebrates$HuntCat)
vertebrates$LandUse <- as.factor(vertebrates$LandUse)
is.factor(vertebrates$HuntCat)
```

```
## [1] TRUE
```

```r
is.factor(vertebrates$LandUse)
```

```
## [1] TRUE
```


```r
vertebrates <- clean_names(vertebrates)
```


```r
names(vertebrates)
```

```
##  [1] "transect_id"              "distance"                
##  [3] "hunt_cat"                 "num_households"          
##  [5] "land_use"                 "veg_rich"                
##  [7] "veg_stems"                "veg_liana"               
##  [9] "veg_dbh"                  "veg_canopy"              
## [11] "veg_understory"           "ra_apes"                 
## [13] "ra_birds"                 "ra_elephant"             
## [15] "ra_monkeys"               "ra_rodent"               
## [17] "ra_ungulate"              "rich_all_species"        
## [19] "evenness_all_species"     "diversity_all_species"   
## [21] "rich_bird_species"        "evenness_bird_species"   
## [23] "diversity_bird_species"   "rich_mammal_species"     
## [25] "evenness_mammal_species"  "diversity_mammal_species"
```

```r
summary(vertebrates)
```

```
##   transect_id       distance          hunt_cat num_households     land_use 
##  Min.   : 1.00   Min.   : 2.700   High    :7   Min.   :13.00   Logging:13  
##  1st Qu.: 5.75   1st Qu.: 5.668   Moderate:8   1st Qu.:24.75   Neither: 4  
##  Median :14.50   Median : 9.720   None    :9   Median :29.00   Park   : 7  
##  Mean   :13.50   Mean   :11.879                Mean   :37.88               
##  3rd Qu.:20.25   3rd Qu.:17.683                3rd Qu.:54.00               
##  Max.   :27.00   Max.   :26.760                Max.   :73.00               
##     veg_rich       veg_stems       veg_liana         veg_dbh     
##  Min.   :10.88   Min.   :23.44   Min.   : 4.750   Min.   :28.45  
##  1st Qu.:13.10   1st Qu.:28.69   1st Qu.: 9.033   1st Qu.:40.65  
##  Median :14.94   Median :32.45   Median :11.940   Median :43.90  
##  Mean   :14.83   Mean   :32.80   Mean   :11.040   Mean   :46.09  
##  3rd Qu.:16.54   3rd Qu.:37.08   3rd Qu.:13.250   3rd Qu.:50.58  
##  Max.   :18.75   Max.   :47.56   Max.   :16.380   Max.   :76.48  
##    veg_canopy    veg_understory     ra_apes          ra_birds    
##  Min.   :2.500   Min.   :2.380   Min.   : 0.000   Min.   :31.56  
##  1st Qu.:3.250   1st Qu.:2.875   1st Qu.: 0.000   1st Qu.:52.51  
##  Median :3.430   Median :3.000   Median : 0.485   Median :57.90  
##  Mean   :3.469   Mean   :3.020   Mean   : 2.045   Mean   :58.64  
##  3rd Qu.:3.750   3rd Qu.:3.167   3rd Qu.: 3.815   3rd Qu.:68.17  
##  Max.   :4.000   Max.   :3.880   Max.   :12.930   Max.   :85.03  
##   ra_elephant       ra_monkeys      ra_rodent      ra_ungulate    
##  Min.   :0.0000   Min.   : 5.84   Min.   :1.060   Min.   : 0.000  
##  1st Qu.:0.0000   1st Qu.:22.70   1st Qu.:2.047   1st Qu.: 1.232  
##  Median :0.3600   Median :31.74   Median :3.230   Median : 2.545  
##  Mean   :0.5450   Mean   :31.30   Mean   :3.278   Mean   : 4.166  
##  3rd Qu.:0.8925   3rd Qu.:39.88   3rd Qu.:4.093   3rd Qu.: 5.157  
##  Max.   :2.3000   Max.   :54.12   Max.   :6.310   Max.   :13.860  
##  rich_all_species evenness_all_species diversity_all_species rich_bird_species
##  Min.   :15.00    Min.   :0.6680       Min.   :1.966         Min.   : 8.00    
##  1st Qu.:19.00    1st Qu.:0.7542       1st Qu.:2.248         1st Qu.:10.00    
##  Median :20.00    Median :0.7760       Median :2.317         Median :11.00    
##  Mean   :20.21    Mean   :0.7699       Mean   :2.310         Mean   :10.33    
##  3rd Qu.:22.00    3rd Qu.:0.8083       3rd Qu.:2.429         3rd Qu.:11.00    
##  Max.   :24.00    Max.   :0.8330       Max.   :2.566         Max.   :13.00    
##  evenness_bird_species diversity_bird_species rich_mammal_species
##  Min.   :0.5590        Min.   :1.162          Min.   : 6.000     
##  1st Qu.:0.6825        1st Qu.:1.603          1st Qu.: 9.000     
##  Median :0.7220        Median :1.680          Median :10.000     
##  Mean   :0.7137        Mean   :1.661          Mean   : 9.875     
##  3rd Qu.:0.7722        3rd Qu.:1.784          3rd Qu.:11.000     
##  Max.   :0.8240        Max.   :2.008          Max.   :12.000     
##  evenness_mammal_species diversity_mammal_species
##  Min.   :0.6190          Min.   :1.378           
##  1st Qu.:0.7073          1st Qu.:1.567           
##  Median :0.7390          Median :1.699           
##  Mean   :0.7477          Mean   :1.698           
##  3rd Qu.:0.7847          3rd Qu.:1.815           
##  Max.   :0.8610          Max.   :2.065
```

**10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?**

```r
vertebrates %>% 
  filter(hunt_cat != "None") %>% 
  group_by(hunt_cat) %>% 
  summarise(avg_bird = mean(diversity_bird_species),
            avg_mammal = mean(diversity_mammal_species),
            total = n(), .groups = "keep")
```

```
## # A tibble: 2 x 4
## # Groups:   hunt_cat [2]
##   hunt_cat avg_bird avg_mammal total
##   <fct>       <dbl>      <dbl> <int>
## 1 High         1.66       1.74     7
## 2 Moderate     1.62       1.68     8
```

**11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 5km from a village to sites that are greater than 20km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.**  

```r
vertebrates %>%
  group_by(distance) %>% 
  filter(distance < 5 | distance > 20) %>% 
  summarise(across(c(ra_apes, ra_birds, ra_elephant, ra_monkeys, ra_rodent, ra_ungulate))) %>% 
  arrange(desc(distance))
```

```
## # A tibble: 6 x 7
##   distance ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##      <dbl>   <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1    26.8     4.91     31.6       0          54.1       1.29        8.12
## 2    24.1     3.78     42.7       1.11       46.2       3.1         3.1 
## 3    20.8    12.9      59.3       0.56       19.8       3.66        3.71
## 4     3.83    0        57.8       0          37.8       3.19        1.04
## 5     2.92    0.24     68.2       0          25.6       4.05        1.88
## 6     2.7     0        85.0       0.290       9.09      3.74        1.86
```

_My only suggestion here (which was not explicit in the question) is that I would probably makes this comparison with the means of these indices._

**12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`**

What happens to average species richness when land use falls under logging versus park?

```r
vertebrates %>% 
  group_by(land_use) %>% 
  filter(land_use != "Neither") %>% 
  summarise(avg_rich_all = mean(rich_all_species),
            avg_rich_bird = mean(rich_bird_species),
            avg_rich_mammals = mean(rich_mammal_species))
```

```
## # A tibble: 2 x 4
##   land_use avg_rich_all avg_rich_bird avg_rich_mammals
##   <fct>           <dbl>         <dbl>            <dbl>
## 1 Logging          19.6          10.2             9.38
## 2 Park             21.9          10.4            11.4
```

_Great job Adrianna!_
