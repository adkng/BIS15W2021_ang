---
title: "tidy_cheatsheet"
output: 
  html_document: 
    keep_md: yes
---

## Load your libraries

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
## ✓ tibble  3.0.6     ✓ dplyr   1.0.4
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(here)
```

```
## here() starts at /Users/adriannang98/Desktop/BIS15W2021_ang
```

```r
library(readr)
```

## What is `Tidy` data?
`Tidy` data in the sense of the tidyverse follows three conventions:   
(1) each variable has its own column  
(2) each observation has its own row  
(3) each value has its own cell 

## `pivot_longer()`

Rules:  
+ `pivot_longer`(cols, names_to, values_to)
+ `cols` - Columns to pivot to longer format
+ `names_to` - Name of the new column; it will contain the column names of gathered columns as values
+ `values_to` - Name of the new column; it will contain the data stored in the values of gathered columns

You'll want to use this when you see "wide data", because column names may actually represent values of a variable (and that goes agianst our handy `Tidy` rules!)


```r
relig_income <- read_csv(here("class_resources", "data", "relig_income.csv"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   religion = col_character(),
##   `<$10k` = col_double(),
##   `$10-20k` = col_double(),
##   `$20-30k` = col_double(),
##   `$30-40k` = col_double(),
##   `$40-50k` = col_double(),
##   `$50-75k` = col_double(),
##   `$75-100k` = col_double(),
##   `$100-150k` = col_double(),
##   `>150k` = col_double(),
##   `Don't know/refused` = col_double()
## )
```

```r
relig_income %>% 
    pivot_longer(-religion,
               names_to = "income_bracket",
               values_to = "num_households")
```

```
## # A tibble: 180 x 3
##    religion income_bracket     num_households
##    <chr>    <chr>                       <dbl>
##  1 Agnostic <$10k                          27
##  2 Agnostic $10-20k                        34
##  3 Agnostic $20-30k                        60
##  4 Agnostic $30-40k                        81
##  5 Agnostic $40-50k                        76
##  6 Agnostic $50-75k                       137
##  7 Agnostic $75-100k                      122
##  8 Agnostic $100-150k                     109
##  9 Agnostic >150k                          84
## 10 Agnostic Don't know/refused             96
## # … with 170 more rows
```

Sometimes, there might even be two observations in a column name... yikes. Use the `names_sep =` command under the `pivot_longer()` function to specify how you want R to split them up.

```r
qpcr_untidy <- read_csv("data/qpcr_untidy.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   gene = col_character(),
##   exp1_rep1 = col_double(),
##   exp1_rep2 = col_double(),
##   exp1_rep3 = col_double(),
##   exp2_rep1 = col_double(),
##   exp2_rep2 = col_double(),
##   exp2_rep3 = col_double(),
##   exp3_rep1 = col_double(),
##   exp3_rep2 = col_double(),
##   exp3_rep3 = col_double()
## )
```

```r
qpcr_untidy %>% 
  pivot_longer(exp1_rep1:exp3_rep3,
    names_to= c("experiment", "replicate"),
    names_sep="_",
    values_to="mRNA_expression")
```

```
## # A tibble: 45 x 4
##    gene  experiment replicate mRNA_expression
##    <chr> <chr>      <chr>               <dbl>
##  1 A     exp1       rep1                 21.7
##  2 A     exp1       rep2                 19.8
##  3 A     exp1       rep3                 20.7
##  4 A     exp2       rep1                 18.3
##  5 A     exp2       rep2                 20.4
##  6 A     exp2       rep3                 17.6
##  7 A     exp3       rep1                 20.6
##  8 A     exp3       rep2                 19.9
##  9 A     exp3       rep3                 19.2
## 10 B     exp1       rep1                 24.3
## # … with 35 more rows
```

You can also use the `separate()` function for means to a similar end. The `unite()` function works the exact same way, only it mushes back whatever you separated (or however you decide you want to mush them together with).

## `pivot_wider()`
The opposite of `pivot_longer()`. You use `pivot_wider()` when you have an observation scattered across multiple rows.
Rules:  
+ `pivot_wider`(names_from, values_from)  
+ `names_from` - Values in the `names_from` column will become new column names  
+ `values_from` - Cell values will be taken from the `values_from` column  


```r
tb_data <- read_csv("data/tb_data.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   country = col_character(),
##   year = col_double(),
##   key = col_character(),
##   value = col_double()
## )
```

```r
tb_data %>% 
  pivot_wider(names_from = "key", #the observations under key will become new columns
              values_from = "value")
```

```
## # A tibble: 6 x 4
##   country      year  cases population
##   <chr>       <dbl>  <dbl>      <dbl>
## 1 Afghanistan  1999    745   19987071
## 2 Afghanistan  2000   2666   20595360
## 3 Brazil       1999  37737  172006362
## 4 Brazil       2000  80488  174504898
## 5 China        1999 212258 1272915272
## 6 China        2000 213766 1280428583
```

**Labs 8.1 and 8.2** have other wonderful examples of data you can pivot with to your heart's content.
