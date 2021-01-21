---
title: "coding cheat sheet for data frames"
output: 
  html_document: 
    keep_md: yes
---
***THINGS TO ASK LEDFORD***
1. When we get to the midterm, do you want us to answer things using primarily functions from tidyverse/janitor?
2. Would we get docked off points if we are using R Base Code?
3. Is identifying vector elements and data matrices something we will utilize anymore in the class?

### Getting Set-Up
Make sure your workspace is set up. Check your working directory.

```r
getwd()
```

```
## [1] "/Users/adriannang98/Desktop/BIS15W2021_ang/class_resources"
```

Load your libraries, because we shouldn't rely on using R Base Code (although it's not a bad thing).

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
## ✓ tibble  3.0.4     ✓ dplyr   1.0.2
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.0
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(janitor)
```

```
## 
## Attaching package: 'janitor'
```

```
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

Get your data imported.

```r
ps4_games <- readr::read_csv("data/PS4_GamesSales.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Game = col_character(),
##   Year = col_character(),
##   Genre = col_character(),
##   Publisher = col_character(),
##   `North America` = col_double(),
##   Europe = col_double(),
##   Japan = col_double(),
##   `Rest of World` = col_double(),
##   Global = col_double()
## )
```

```r
xbox_one_games <- readr::read_csv("data/XboxOne_GameSales.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Pos = col_double(),
##   Game = col_character(),
##   Year = col_character(),
##   Genre = col_character(),
##   Publisher = col_character(),
##   `North America` = col_double(),
##   Europe = col_double(),
##   Japan = col_double(),
##   `Rest of World` = col_double(),
##   Global = col_double()
## )
```

```r
video_game_sales <- readr::read_csv("data/Video_Games_Sales_as_at_22_Dec_2016.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Name = col_character(),
##   Platform = col_character(),
##   Year_of_Release = col_character(),
##   Genre = col_character(),
##   Publisher = col_character(),
##   NA_Sales = col_double(),
##   EU_Sales = col_double(),
##   JP_Sales = col_double(),
##   Other_Sales = col_double(),
##   Global_Sales = col_double(),
##   Critic_Score = col_double(),
##   Critic_Count = col_double(),
##   User_Score = col_double(),
##   User_Count = col_double(),
##   Developer = col_character(),
##   Rating = col_character()
## )
```
See that `<-`? We just told R to "get" the .csv containing our data and store it in the **object** called `ps4_games`.

### Dataframes
## Examining Your Data Structure: Dataframes
Summary functions are a great way to get an idea of data structure, content, and dimensions. *(The following data displays sales in the millions).*
`summary()`

```r
summary(ps4_games)
```

```
##      Game               Year              Genre            Publisher        
##  Length:1034        Length:1034        Length:1034        Length:1034       
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##  North America        Europe           Japan         Rest of World    
##  Min.   :0.0000   Min.   :0.0000   Min.   :0.00000   Min.   :0.00000  
##  1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.00000  
##  Median :0.0200   Median :0.0000   Median :0.00000   Median :0.01000  
##  Mean   :0.2046   Mean   :0.2487   Mean   :0.03364   Mean   :0.08901  
##  3rd Qu.:0.1200   3rd Qu.:0.1300   3rd Qu.:0.03000   3rd Qu.:0.05000  
##  Max.   :6.1800   Max.   :9.7100   Max.   :2.17000   Max.   :3.02000  
##      Global       
##  Min.   : 0.0000  
##  1st Qu.: 0.0000  
##  Median : 0.0600  
##  Mean   : 0.5761  
##  3rd Qu.: 0.3575  
##  Max.   :19.3900
```
`glimpse()`

```r
glimpse(ps4_games)
```

```
## Rows: 1,034
## Columns: 9
## $ Game            <chr> "Grand Theft Auto V", "Call of Duty: Black Ops 3", "R…
## $ Year            <chr> "2014", "2015", "2018", "2017", "2017", "2016", "2016…
## $ Genre           <chr> "Action", "Shooter", "Action-Adventure", "Shooter", "…
## $ Publisher       <chr> "Rockstar Games", "Activision", "Rockstar Games", "Ac…
## $ `North America` <dbl> 6.06, 6.18, 5.26, 4.67, 1.27, 1.26, 4.49, 3.64, 3.11,…
## $ Europe          <dbl> 9.71, 6.05, 6.21, 6.21, 8.64, 7.95, 3.93, 3.39, 3.83,…
## $ Japan           <dbl> 0.60, 0.41, 0.21, 0.40, 0.15, 0.12, 0.21, 0.32, 0.19,…
## $ `Rest of World` <dbl> 3.02, 2.44, 2.26, 2.12, 1.73, 1.61, 1.70, 1.41, 1.36,…
## $ Global          <dbl> 19.39, 15.09, 13.94, 13.40, 11.80, 10.94, 10.33, 8.76…
```
`nrow()` gives number of rows.

```r
nrow(ps4_games)
```

```
## [1] 1034
```
`ncol()` gives number of columns.

```r
ncol(ps4_games)
```

```
## [1] 9
```
`dim()` gives the dimensions.

```r
dim(ps4_games)
```

```
## [1] 1034    9
```
`names()` gives the column names.

```r
names(ps4_games)
```

```
## [1] "Game"          "Year"          "Genre"         "Publisher"    
## [5] "North America" "Europe"        "Japan"         "Rest of World"
## [9] "Global"
```
`head()` gives the first `n` rows of data.

```r
head(ps4_games, n = 10)
```

```
## # A tibble: 10 x 9
##    Game  Year  Genre Publisher `North America` Europe Japan `Rest of World`
##    <chr> <chr> <chr> <chr>               <dbl>  <dbl> <dbl>           <dbl>
##  1 Gran… 2014  Acti… Rockstar…            6.06   9.71  0.6             3.02
##  2 Call… 2015  Shoo… Activisi…            6.18   6.05  0.41            2.44
##  3 Red … 2018  Acti… Rockstar…            5.26   6.21  0.21            2.26
##  4 Call… 2017  Shoo… Activisi…            4.67   6.21  0.4             2.12
##  5 FIFA… 2017  Spor… EA Sports            1.27   8.64  0.15            1.73
##  6 FIFA… 2016  Spor… Electron…            1.26   7.95  0.12            1.61
##  7 Unch… 2016  Acti… Sony Int…            4.49   3.93  0.21            1.7 
##  8 Spid… 2018  Acti… Sony Int…            3.64   3.39  0.32            1.41
##  9 Call… 2016  Shoo… Activisi…            3.11   3.83  0.19            1.36
## 10 Fall… 2015  Role… Bethesda…            2.91   3.97  0.27            1.34
## # … with 1 more variable: Global <dbl>
```
`tail()` gives the last `n` rows of data.

```r
tail(ps4_games, n = 10)
```

```
## # A tibble: 10 x 9
##    Game  Year  Genre Publisher `North America` Europe Japan `Rest of World`
##    <chr> <chr> <chr> <chr>               <dbl>  <dbl> <dbl>           <dbl>
##  1 Biom… 2018  Acti… THQ Nord…               0      0     0               0
##  2 Biom… 2019  Acti… THQ Nord…               0      0     0               0
##  3 de B… 2017  Plat… THQ Nord…               0      0     0               0
##  4 Chao… 2017  Adve… Daedalic…               0      0     0               0
##  5 Code… 2018  Acti… Bandai N…               0      0     0               0
##  6 Fall… N/A   Role… <NA>                    0      0     0               0
##  7 Radi… 2017  Raci… Tammeka …               0      0     0               0
##  8 The … N/A   Acti… <NA>                    0      0     0               0
##  9 Proj… N/A   Acti… <NA>                    0      0     0               0
## 10 Batt… N/A   Acti… <NA>                    0      0     0               0
## # … with 1 more variable: Global <dbl>
```
`view()` is good for viewing data in a more aesthetic tab.

```r
view(ps4_games)
```
`table()` produces fast counts of a number of observations in a variable.

```r
table(ps4_games$Genre)
```

```
## 
##           Action Action-Adventure        Adventure         Fighting 
##              258               40               97               35 
##             Misc              MMO            Music            Party 
##              123                8               19                2 
##         Platform           Puzzle           Racing     Role-Playing 
##               46               16               48              123 
##          Shooter       Simulation           Sports         Strategy 
##               89               23               71               28 
##     Visual Novel 
##                8
```


## Cleaning Your Data: Dataframes
If your data has... less than ideal column names, clean them up in two ways:
**Using the Janitor library**

```r
ps4_games <- janitor::clean_names(ps4_games)
names(ps4_games)
```

```
## [1] "game"          "year"          "genre"         "publisher"    
## [5] "north_america" "europe"        "japan"         "rest_of_world"
## [9] "global"
```

**Using the `rename()` function**

```r
names(xbox_one_games)
```

```
##  [1] "Pos"           "Game"          "Year"          "Genre"        
##  [5] "Publisher"     "North America" "Europe"        "Japan"        
##  [9] "Rest of World" "Global"
```

```r
xbox_one_games <- rename(xbox_one_games, pos = "Pos", game = "Game", year = "Year", genre = "Genre", publisher = "Publisher", north_america = "North America", japan = "Japan", rest_of_world = "Rest of World", global = "Global")
names(xbox_one_games)
```

```
##  [1] "pos"           "game"          "year"          "genre"        
##  [5] "publisher"     "north_america" "Europe"        "japan"        
##  [9] "rest_of_world" "global"
```



