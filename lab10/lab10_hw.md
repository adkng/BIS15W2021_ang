---
title: "Lab 10 Homework"
author: "Adrianna Ng"
date: "2021-02-15"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
library(skimr)
```


```r
options(scipen=999)
```

## Desert Ecology
For this assignment, we are going to use a modified data set on [desert ecology](http://esapubs.org/archive/ecol/E090/118/). The data are from: S. K. Morgan Ernest, Thomas J. Valone, and James H. Brown. 2009. Long-term monitoring and experimental manipulation of a Chihuahuan Desert ecosystem near Portal, Arizona, USA. Ecology 90:1708.

```r
deserts <- read_csv(here("lab10", "data", "surveys_complete.csv"))
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   record_id = col_double(),
##   month = col_double(),
##   day = col_double(),
##   year = col_double(),
##   plot_id = col_double(),
##   species_id = col_character(),
##   sex = col_character(),
##   hindfoot_length = col_double(),
##   weight = col_double(),
##   genus = col_character(),
##   species = col_character(),
##   taxa = col_character(),
##   plot_type = col_character()
## )
```

1. Use the function(s) of your choice to get an idea of its structure, including how NA's are treated. Are the data tidy?  

```r
skim(deserts)
```


Table: Data summary

|                         |        |
|:------------------------|:-------|
|Name                     |deserts |
|Number of rows           |34786   |
|Number of columns        |13      |
|_______________________  |        |
|Column type frequency:   |        |
|character                |6       |
|numeric                  |7       |
|________________________ |        |
|Group variables          |None    |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|species_id    |         0|          1.00|   2|   2|     0|       48|          0|
|sex           |      1748|          0.95|   1|   1|     0|        2|          0|
|genus         |         0|          1.00|   6|  16|     0|       26|          0|
|species       |         0|          1.00|   3|  15|     0|       40|          0|
|taxa          |         0|          1.00|   4|   7|     0|        4|          0|
|plot_type     |         0|          1.00|   7|  25|     0|        5|          0|


**Variable type: numeric**

|skim_variable   | n_missing| complete_rate|     mean|       sd|   p0|     p25|     p50|      p75|  p100|hist  |
|:---------------|---------:|-------------:|--------:|--------:|----:|-------:|-------:|--------:|-----:|:-----|
|record_id       |         0|          1.00| 17804.20| 10229.68|    1| 8964.25| 17761.5| 26654.75| 35548|▇▇▇▇▇ |
|month           |         0|          1.00|     6.47|     3.40|    1|    4.00|     6.0|    10.00|    12|▇▆▆▅▇ |
|day             |         0|          1.00|    16.10|     8.25|    1|    9.00|    16.0|    23.00|    31|▆▇▇▇▆ |
|year            |         0|          1.00|  1990.50|     7.47| 1977| 1984.00|  1990.0|  1997.00|  2002|▇▆▇▇▇ |
|plot_id         |         0|          1.00|    11.34|     6.79|    1|    5.00|    11.0|    17.00|    24|▇▆▇▆▅ |
|hindfoot_length |      3348|          0.90|    29.29|     9.56|    2|   21.00|    32.0|    36.00|    70|▁▇▇▁▁ |
|weight          |      2503|          0.93|    42.67|    36.63|    4|   20.00|    37.0|    48.00|   280|▇▁▁▁▁ |

```r
summary(deserts)
```

```
##    record_id         month             day            year         plot_id     
##  Min.   :    1   Min.   : 1.000   Min.   : 1.0   Min.   :1977   Min.   : 1.00  
##  1st Qu.: 8964   1st Qu.: 4.000   1st Qu.: 9.0   1st Qu.:1984   1st Qu.: 5.00  
##  Median :17762   Median : 6.000   Median :16.0   Median :1990   Median :11.00  
##  Mean   :17804   Mean   : 6.474   Mean   :16.1   Mean   :1990   Mean   :11.34  
##  3rd Qu.:26655   3rd Qu.:10.000   3rd Qu.:23.0   3rd Qu.:1997   3rd Qu.:17.00  
##  Max.   :35548   Max.   :12.000   Max.   :31.0   Max.   :2002   Max.   :24.00  
##                                                                                
##   species_id            sex            hindfoot_length     weight      
##  Length:34786       Length:34786       Min.   : 2.00   Min.   :  4.00  
##  Class :character   Class :character   1st Qu.:21.00   1st Qu.: 20.00  
##  Mode  :character   Mode  :character   Median :32.00   Median : 37.00  
##                                        Mean   :29.29   Mean   : 42.67  
##                                        3rd Qu.:36.00   3rd Qu.: 48.00  
##                                        Max.   :70.00   Max.   :280.00  
##                                        NA's   :3348    NA's   :2503    
##     genus             species              taxa            plot_type        
##  Length:34786       Length:34786       Length:34786       Length:34786      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
## 
```

```r
glimpse(deserts)
```

```
## Rows: 34,786
## Columns: 13
## $ record_id       <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, ...
## $ month           <dbl> 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, ...
## $ day             <dbl> 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,...
## $ year            <dbl> 1977, 1977, 1977, 1977, 1977, 1977, 1977, 1977, 197...
## $ plot_id         <dbl> 2, 3, 2, 7, 3, 1, 2, 1, 1, 6, 5, 7, 3, 8, 6, 4, 3, ...
## $ species_id      <chr> "NL", "NL", "DM", "DM", "DM", "PF", "PE", "DM", "DM...
## $ sex             <chr> "M", "M", "F", "M", "M", "M", "F", "M", "F", "F", "...
## $ hindfoot_length <dbl> 32, 33, 37, 36, 35, 14, NA, 37, 34, 20, 53, 38, 35,...
## $ weight          <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
## $ genus           <chr> "Neotoma", "Neotoma", "Dipodomys", "Dipodomys", "Di...
## $ species         <chr> "albigula", "albigula", "merriami", "merriami", "me...
## $ taxa            <chr> "Rodent", "Rodent", "Rodent", "Rodent", "Rodent", "...
## $ plot_type       <chr> "Control", "Long-term Krat Exclosure", "Control", "...
```

```r
miss_var_summary(deserts)
```

```
## # A tibble: 13 x 3
##    variable        n_miss pct_miss
##    <chr>            <int>    <dbl>
##  1 hindfoot_length   3348     9.62
##  2 weight            2503     7.20
##  3 sex               1748     5.03
##  4 record_id            0     0   
##  5 month                0     0   
##  6 day                  0     0   
##  7 year                 0     0   
##  8 plot_id              0     0   
##  9 species_id           0     0   
## 10 genus                0     0   
## 11 species              0     0   
## 12 taxa                 0     0   
## 13 plot_type            0     0
```

2. How many genera and species are represented in the data? What are the total number of observations? Which species is most/ least frequently sampled in the study?

```r
deserts %>% 
  summarise(n_genera = n_distinct(genus),
            n_species = n_distinct(species),
            n_observations = n())
```

```
## # A tibble: 1 x 3
##   n_genera n_species n_observations
##      <int>     <int>          <int>
## 1       26        40          34786
```

```r
deserts %>% 
  group_by(genus, species) %>% 
  summarise(n_observations = n(), .groups = "keep") %>% 
  arrange(desc(n_observations))
```

```
## # A tibble: 48 x 3
## # Groups:   genus, species [48]
##    genus           species      n_observations
##    <chr>           <chr>                 <int>
##  1 Dipodomys       merriami              10596
##  2 Chaetodipus     penicillatus           3123
##  3 Dipodomys       ordii                  3027
##  4 Chaetodipus     baileyi                2891
##  5 Reithrodontomys megalotis              2609
##  6 Dipodomys       spectabilis            2504
##  7 Onychomys       torridus               2249
##  8 Perognathus     flavus                 1597
##  9 Peromyscus      eremicus               1299
## 10 Neotoma         albigula               1252
## # ... with 38 more rows
```
Dipodomys merriami was most frequently sampled. There are quite a few species that were sampled least: Cnemidophorus tigris, Cnemidophorus uniparens, Crotalus scutalatus, Crotalus viridis, Sceloporus clarki, Spermophilus tereticaudus all had 1 observation only.

3. What is the proportion of taxa included in this study? Show a table and plot that reflects this count.

```r
deserts %>% 
  count(taxa)
```

```
## # A tibble: 4 x 2
##   taxa        n
## * <chr>   <int>
## 1 Bird      450
## 2 Rabbit     75
## 3 Reptile    14
## 4 Rodent  34247
```

```r
deserts %>%
  ggplot(aes(x = taxa)) +
  geom_bar() +
  scale_y_log10() +
  labs(title = "Observations by Taxon in Desert Observations",
       x = "Taxonomic Group",
       y = "Count (Log10)") +
  theme(plot.title = element_text(size = rel(0.95), hjust = 0.5))
```

![](lab10_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->


4. For the taxa included in the study, use the fill option to show the proportion of individuals sampled by `plot_type.`

```r
deserts %>%
  ggplot(aes(x = taxa, fill = plot_type)) +
  geom_bar(position = "dodge") +
  scale_y_log10() +
  labs(title = "Observations by Taxon in Desert Observations",
       x = "Taxonomic Group",
       y = "Count (Log10)") +
  theme(plot.title = element_text(size = rel(0.95), hjust = 0.5))
```

![](lab10_hw_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

5. What is the range of weight for each species included in the study? Remove any observations of weight that are NA so they do not show up in the plot.

```r
deserts %>% 
  filter(weight != "NA") %>% 
  ggplot(aes(x = reorder(species, weight), y = weight)) +
  geom_boxplot() +
  coord_flip() +
  labs(title = "Range of Weight by Species",
       x = "Species",
       y = "Weight") +
  theme(plot.title = element_text(size = rel(0.95), hjust = 0.5))
```

![](lab10_hw_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

6. Add another layer to your answer from #5 using `geom_point` to get an idea of how many measurements were taken for each species.

```r
deserts %>% 
  filter(weight != "NA") %>% 
  ggplot(aes(x = reorder(species, weight), y = weight)) +
  geom_boxplot() +
  geom_point(size = 0.5) +
  coord_flip() +
  labs(title = "Range of Weight by Species",
       x = "Species",
       y = "Weight") +
  theme(plot.title = element_text(size = rel(0.95), hjust = 0.5))
```

![](lab10_hw_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

7. [Dipodomys merriami](https://en.wikipedia.org/wiki/Merriam's_kangaroo_rat) is the most frequently sampled animal in the study. How have the number of observations of this species changed over the years included in the study?

```r
deserts %>% 
  filter(species == "merriami") %>% 
  group_by(year) %>% 
  summarise(n_observations = n()) %>% 
  ggplot(aes(x = year, y = n_observations)) +
  geom_col() +
  geom_smooth(method = "lm") +
  labs(title = "*Dipodomys merriami* Observations by Year",
       x = "Year",
       y = NULL) +
  theme(plot.title = element_text(size = rel(0.95), hjust = 0.5))
```

```
## `geom_smooth()` using formula 'y ~ x'
```

![](lab10_hw_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

8. What is the relationship between `weight` and `hindfoot` length? Consider whether or not over plotting is an issue.

```r
deserts %>%
  filter(weight != "NA", hindfoot_length != "NA") %>% 
  ggplot(aes(x = weight, y = hindfoot_length)) +
  geom_point(na.rm = T) +
  geom_smooth(method = "lm")
```

```
## `geom_smooth()` using formula 'y ~ x'
```

![](lab10_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->
Yikes! The plot is very messy and hard to read... it looks like overplotting to me. Gross! *Overplotting means you have too many labels/points that impede on visualization. We have so many dots that they overlap with each other and makes it hard to see the dots!* 


```r
deserts %>%
  filter(weight != "NA", hindfoot_length != "NA") %>% 
  ggplot(aes(x = weight, y = hindfoot_length)) +
  geom_jitter(na.rm = T, size = 0.25, alpha = 0.3) +
  geom_smooth(method = "lm")
```

```
## `geom_smooth()` using formula 'y ~ x'
```

![](lab10_hw_files/figure-html/unnamed-chunk-17-1.png)<!-- -->
This makes it a little better, because we are now offsetting where each point is so they don't directly overlap. However, there are still some spots that are pretty bad...

9. Which two species have, on average, the highest weight? Once you have identified them, make a new column that is a ratio of `weight` to `hindfoot_length`. Make a plot that shows the range of this new ratio and fill by sex.

```r
deserts %>% 
  filter(weight != "NA") %>% 
  group_by(genus, species) %>% 
  summarise(mean_weight = mean(weight), .groups = "keep") %>% 
  arrange(desc(mean_weight))
```

```
## # A tibble: 25 x 3
## # Groups:   genus, species [25]
##    genus        species      mean_weight
##    <chr>        <chr>              <dbl>
##  1 Neotoma      albigula           159. 
##  2 Dipodomys    spectabilis        120. 
##  3 Spermophilus spilosoma           93.5
##  4 Sigmodon     hispidus            73.1
##  5 Sigmodon     fulviventer         58.9
##  6 Sigmodon     ochrognathus        55.4
##  7 Dipodomys    ordii               48.9
##  8 Dipodomys    merriami            43.2
##  9 Chaetodipus  baileyi             31.7
## 10 Onychomys    leucogaster         31.6
## # ... with 15 more rows
```
It looks like Neotoma albigula and Dipodomys spectabilis have the highest average weights.


```r
deserts %>%
  filter(sex != "NA", weight != "NA", hindfoot_length != "NA") %>% 
  filter(species == "albigula" | species == "spectabilis") %>% 
  mutate(weight_to_hindfoot = weight/hindfoot_length) %>% 
  ggplot(aes(x = species, y = weight_to_hindfoot, fill = sex)) +
  geom_boxplot() +
  labs(title = "Ratio of Weight to Hindfoot Length in N. albigula & D. spectabilis",
       x = "species",
       y = "Weight to Hindfoot Ratio") +
  theme(plot.title = element_text(size = rel(0.95), hjust = 0.5))
```

![](lab10_hw_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

10. Make one plot of your choice! Make sure to include at least two of the aesthetics options you have learned.

```r
deserts %>% 
  filter(weight != "NA") %>% 
  ggplot(aes(x = species, fill = plot_type)) +
  geom_bar(position = "dodge") +
  theme(axis.text.x = element_text(angle = 50, hjust = 0.95)) +
  scale_y_log10() +
  labs(title = "Obsevations by Plot Type in the Taxon 'Rodent'",
       x = "Species",
       y = "Number of Observations") +
  theme(plot.title = element_text(size = rel(0.95), hjust = 0.5))
```

![](lab10_hw_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
