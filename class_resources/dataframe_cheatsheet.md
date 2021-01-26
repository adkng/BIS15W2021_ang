---
title: "coding cheat sheet for data frames"
output: 
  html_document: 
    keep_md: yes
---
# Getting Set-Up
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
## ✓ tibble  3.0.5     ✓ dplyr   1.0.3
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.0
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(dplyr)
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

```r
library(skimr)
library(dataMaid)
```

```
## 
## Attaching package: 'dataMaid'
```

```
## The following object is masked from 'package:dplyr':
## 
##     summarize
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

```r
msleep
```

```
## # A tibble: 83 x 11
##    name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##    <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Chee… Acin… carni Carn… lc                  12.1      NA        NA      11.9
##  2 Owl … Aotus omni  Prim… <NA>                17         1.8      NA       7  
##  3 Moun… Aplo… herbi Rode… nt                  14.4       2.4      NA       9.6
##  4 Grea… Blar… omni  Sori… lc                  14.9       2.3       0.133   9.1
##  5 Cow   Bos   herbi Arti… domesticated         4         0.7       0.667  20  
##  6 Thre… Brad… herbi Pilo… <NA>                14.4       2.2       0.767   9.6
##  7 Nort… Call… carni Carn… vu                   8.7       1.4       0.383  15.3
##  8 Vesp… Calo… <NA>  Rode… <NA>                 7        NA        NA      17  
##  9 Dog   Canis carni Carn… domesticated        10.1       2.9       0.333  13.9
## 10 Roe … Capr… herbi Arti… lc                   3        NA        NA      21  
## # … with 73 more rows, and 2 more variables: brainwt <dbl>, bodywt <dbl>
```
See that `<-`? We just told R to "get" the .csv containing our data and store it in the **object** called `ps4_games`.

# Dataframes
## Examining Your Data Frame
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

```r
video_game_sales <- janitor::clean_names(video_game_sales)
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
xbox_one_games <- rename(xbox_one_games, pos = "Pos", game = "Game", year = "Year", genre = "Genre", publisher = "Publisher", north_america = "North America", europe = "Europe", japan = "Japan", rest_of_world = "Rest of World", global = "Global")
names(xbox_one_games)
```

```
##  [1] "pos"           "game"          "year"          "genre"        
##  [5] "publisher"     "north_america" "europe"        "japan"        
##  [9] "rest_of_world" "global"
```

There are also more specific ways to clean your column names, using `toupper()` or `tolower()`.

If there is ever blank spaces in your column names, you can replace them with a `str_replace()` function. (I didn't load any data here that had this issue.)

# Utilizing Your Data Frame
## Accessing Rows and Columns
We can use `[]` to access rows and columns. The first position applies to rows, and the second applies to columns.

```r
ps4_games[1]
```

```
## # A tibble: 1,034 x 1
##    game                          
##    <chr>                         
##  1 Grand Theft Auto V            
##  2 Call of Duty: Black Ops 3     
##  3 Red Dead Redemption 2         
##  4 Call of Duty: WWII            
##  5 FIFA 18                       
##  6 FIFA 17                       
##  7 Uncharted (PS4)               
##  8 Spider-Man (PS4)              
##  9 Call of Duty: Infinite Warfare
## 10 Fallout 4                     
## # … with 1,024 more rows
```

```r
ps4_games[ ,4]
```

```
## # A tibble: 1,034 x 1
##    publisher                     
##    <chr>                         
##  1 Rockstar Games                
##  2 Activision                    
##  3 Rockstar Games                
##  4 Activision                    
##  5 EA Sports                     
##  6 Electronic Arts               
##  7 Sony Interactive Entertainment
##  8 Sony Interactive Entertainment
##  9 Activision                    
## 10 Bethesda Softworks            
## # … with 1,024 more rows
```
We can select the values in an entire column with  the `$` sign.

```r
n_america_sales <- ps4_games$north_america
mean(n_america_sales)
```

```
## [1] 0.2046132
```
## Creating Rows and Columns
You can use the `rbind()` and `cbind()` functions to bind new data to our frame.

## Subsetting Your Data Frame
One way to subset your data is using the `subset()` function, which pulls out observations that meet specific criteria in a variable.

```r
top_na_sales <- subset(ps4_games, north_america > 2)
top_na_sales
```

```
## # A tibble: 21 x 9
##    game   year  genre  publisher north_america europe japan rest_of_world global
##    <chr>  <chr> <chr>  <chr>             <dbl>  <dbl> <dbl>         <dbl>  <dbl>
##  1 Grand… 2014  Action Rockstar…          6.06   9.71  0.6           3.02  19.4 
##  2 Call … 2015  Shoot… Activisi…          6.18   6.05  0.41          2.44  15.1 
##  3 Red D… 2018  Actio… Rockstar…          5.26   6.21  0.21          2.26  13.9 
##  4 Call … 2017  Shoot… Activisi…          4.67   6.21  0.4           2.12  13.4 
##  5 Uncha… 2016  Action Sony Int…          4.49   3.93  0.21          1.7   10.3 
##  6 Spide… 2018  Actio… Sony Int…          3.64   3.39  0.32          1.41   8.76
##  7 Call … 2016  Shoot… Activisi…          3.11   3.83  0.19          1.36   8.48
##  8 Fallo… 2015  Role-… Bethesda…          2.91   3.97  0.27          1.34   8.48
##  9 Star … 2015  Shoot… Electron…          3.31   3.19  0.23          1.3    8.03
## 10 Call … 2014  Shoot… Activisi…          2.84   3.34  0.14          1.22   7.53
## # … with 11 more rows
```
# Tidyverse and dplyr
## `Select()`
`Select()` helps you pull out columns of interest from a dataframe. The order you add them in determines their appearance on the output.

```r
select(ps4_games, game, publisher, north_america)
```

```
## # A tibble: 1,034 x 3
##    game                           publisher                      north_america
##    <chr>                          <chr>                                  <dbl>
##  1 Grand Theft Auto V             Rockstar Games                          6.06
##  2 Call of Duty: Black Ops 3      Activision                              6.18
##  3 Red Dead Redemption 2          Rockstar Games                          5.26
##  4 Call of Duty: WWII             Activision                              4.67
##  5 FIFA 18                        EA Sports                               1.27
##  6 FIFA 17                        Electronic Arts                         1.26
##  7 Uncharted (PS4)                Sony Interactive Entertainment          4.49
##  8 Spider-Man (PS4)               Sony Interactive Entertainment          3.64
##  9 Call of Duty: Infinite Warfare Activision                              3.11
## 10 Fallout 4                      Bethesda Softworks                      2.91
## # … with 1,024 more rows
```
A range of columns can be selected via `startcol:endcol`.

```r
select(ps4_games, game:genre)
```

```
## # A tibble: 1,034 x 3
##    game                           year  genre           
##    <chr>                          <chr> <chr>           
##  1 Grand Theft Auto V             2014  Action          
##  2 Call of Duty: Black Ops 3      2015  Shooter         
##  3 Red Dead Redemption 2          2018  Action-Adventure
##  4 Call of Duty: WWII             2017  Shooter         
##  5 FIFA 18                        2017  Sports          
##  6 FIFA 17                        2016  Sports          
##  7 Uncharted (PS4)                2016  Action          
##  8 Spider-Man (PS4)               2018  Action-Adventure
##  9 Call of Duty: Infinite Warfare 2016  Shooter         
## 10 Fallout 4                      2015  Role-Playing    
## # … with 1,024 more rows
```
You can ignore columns you don't want to select with the `-` operator.

```r
select(ps4_games, -publisher, -global)
```

```
## # A tibble: 1,034 x 7
##    game                year  genre      north_america europe japan rest_of_world
##    <chr>               <chr> <chr>              <dbl>  <dbl> <dbl>         <dbl>
##  1 Grand Theft Auto V  2014  Action              6.06   9.71  0.6           3.02
##  2 Call of Duty: Blac… 2015  Shooter             6.18   6.05  0.41          2.44
##  3 Red Dead Redemptio… 2018  Action-Ad…          5.26   6.21  0.21          2.26
##  4 Call of Duty: WWII  2017  Shooter             4.67   6.21  0.4           2.12
##  5 FIFA 18             2017  Sports              1.27   8.64  0.15          1.73
##  6 FIFA 17             2016  Sports              1.26   7.95  0.12          1.61
##  7 Uncharted (PS4)     2016  Action              4.49   3.93  0.21          1.7 
##  8 Spider-Man (PS4)    2018  Action-Ad…          3.64   3.39  0.32          1.41
##  9 Call of Duty: Infi… 2016  Shooter             3.11   3.83  0.19          1.36
## 10 Fallout 4           2015  Role-Play…          2.91   3.97  0.27          1.34
## # … with 1,024 more rows
```
### Parsing Data with `Select()` Operators
The `contains()` function returns variables with the keyword you've selected.

```r
names(video_game_sales)
```

```
##  [1] "name"            "platform"        "year_of_release" "genre"          
##  [5] "publisher"       "na_sales"        "eu_sales"        "jp_sales"       
##  [9] "other_sales"     "global_sales"    "critic_score"    "critic_count"   
## [13] "user_score"      "user_count"      "developer"       "rating"
```

```r
select(video_game_sales, contains("sales"))
```

```
## # A tibble: 16,719 x 5
##    na_sales eu_sales jp_sales other_sales global_sales
##       <dbl>    <dbl>    <dbl>       <dbl>        <dbl>
##  1     41.4    29.0      3.77       8.45          82.5
##  2     29.1     3.58     6.81       0.77          40.2
##  3     15.7    12.8      3.79       3.29          35.5
##  4     15.6    10.9      3.28       2.95          32.8
##  5     11.3     8.89    10.2        1             31.4
##  6     23.2     2.26     4.22       0.580         30.3
##  7     11.3     9.14     6.5        2.88          29.8
##  8     14.0     9.18     2.93       2.84          28.9
##  9     14.4     6.94     4.7        2.24          28.3
## 10     26.9     0.63     0.28       0.47          28.3
## # … with 16,709 more rows
```
If columns are sequentially named, then you can use `starts_with()` to narrow in on them.

```r
select(video_game_sales, starts_with("critic"))
```

```
## # A tibble: 16,719 x 2
##    critic_score critic_count
##           <dbl>        <dbl>
##  1           76           51
##  2           NA           NA
##  3           82           73
##  4           80           73
##  5           NA           NA
##  6           NA           NA
##  7           89           65
##  8           58           41
##  9           87           80
## 10           NA           NA
## # … with 16,709 more rows
```
`ends_with()` selects columns that end with a string.

`contains()` selects columns that contain a string.

`matches()` contains columns that match a string.
*The `matches()` function can be used in regex, and is useful when you know if your column has a letter followed by a string.*

`one_of()` selects column names that are from a group of names.

Columns can also be selected (or ignored) based on their class of data.

```r
select_if(video_game_sales, is.character)
```

```
## # A tibble: 16,719 x 7
##    name             platform year_of_release genre    publisher developer rating
##    <chr>            <chr>    <chr>           <chr>    <chr>     <chr>     <chr> 
##  1 Wii Sports       Wii      2006            Sports   Nintendo  Nintendo  E     
##  2 Super Mario Bro… NES      1985            Platform Nintendo  <NA>      <NA>  
##  3 Mario Kart Wii   Wii      2008            Racing   Nintendo  Nintendo  E     
##  4 Wii Sports Reso… Wii      2009            Sports   Nintendo  Nintendo  E     
##  5 Pokemon Red/Pok… GB       1996            Role-Pl… Nintendo  <NA>      <NA>  
##  6 Tetris           GB       1989            Puzzle   Nintendo  <NA>      <NA>  
##  7 New Super Mario… DS       2006            Platform Nintendo  Nintendo  E     
##  8 Wii Play         Wii      2006            Misc     Nintendo  Nintendo  E     
##  9 New Super Mario… Wii      2009            Platform Nintendo  Nintendo  E     
## 10 Duck Hunt        NES      1984            Shooter  Nintendo  <NA>      <NA>  
## # … with 16,709 more rows
```

```r
select_if(video_game_sales, ~!is.character(.))
```

```
## # A tibble: 16,719 x 9
##    na_sales eu_sales jp_sales other_sales global_sales critic_score critic_count
##       <dbl>    <dbl>    <dbl>       <dbl>        <dbl>        <dbl>        <dbl>
##  1     41.4    29.0      3.77       8.45          82.5           76           51
##  2     29.1     3.58     6.81       0.77          40.2           NA           NA
##  3     15.7    12.8      3.79       3.29          35.5           82           73
##  4     15.6    10.9      3.28       2.95          32.8           80           73
##  5     11.3     8.89    10.2        1             31.4           NA           NA
##  6     23.2     2.26     4.22       0.580         30.3           NA           NA
##  7     11.3     9.14     6.5        2.88          29.8           89           65
##  8     14.0     9.18     2.93       2.84          28.9           58           41
##  9     14.4     6.94     4.7        2.24          28.3           87           80
## 10     26.9     0.63     0.28       0.47          28.3           NA           NA
## # … with 16,709 more rows, and 2 more variables: user_score <dbl>,
## #   user_count <dbl>
```

## `Filter()`
`Filter()` allows the extraction of *data* meeting a specific criteria to extract variables.

```r
filter(ps4_games, publisher == "Rockstar Games")
```

```
## # A tibble: 3 x 9
##   game    year  genre  publisher north_america europe japan rest_of_world global
##   <chr>   <chr> <chr>  <chr>             <dbl>  <dbl> <dbl>         <dbl>  <dbl>
## 1 Grand … 2014  Action Rockstar…          6.06   9.71  0.6           3.02   19.4
## 2 Red De… 2018  Actio… Rockstar…          5.26   6.21  0.21          2.26   13.9
## 3 L.A. N… 2017  Adven… Rockstar…          0.18   0.32  0             0.1     0.6
```

```r
filter(ps4_games, north_america > 3.5)
```

```
## # A tibble: 6 x 9
##   game    year  genre publisher  north_america europe japan rest_of_world global
##   <chr>   <chr> <chr> <chr>              <dbl>  <dbl> <dbl>         <dbl>  <dbl>
## 1 Grand … 2014  Acti… Rockstar …          6.06   9.71  0.6           3.02  19.4 
## 2 Call o… 2015  Shoo… Activision          6.18   6.05  0.41          2.44  15.1 
## 3 Red De… 2018  Acti… Rockstar …          5.26   6.21  0.21          2.26  13.9 
## 4 Call o… 2017  Shoo… Activision          4.67   6.21  0.4           2.12  13.4 
## 5 Unchar… 2016  Acti… Sony Inte…          4.49   3.93  0.21          1.7   10.3 
## 6 Spider… 2018  Acti… Sony Inte…          3.64   3.39  0.32          1.41   8.76
```
You can use certain *operators* to specify how you want the data to be filtered.

`!=` excludes.
`>`, `>=` is for greater than/greater than or equal to.
`<`, `<=` is for less than/less than or equal to.

### Filtering Multiple Observations

The `%in%` operator filters for multiple values in the same variable.

```r
filter(ps4_games, year %in% c(2016, 2018))
```

```
## # A tibble: 261 x 9
##    game   year  genre  publisher north_america europe japan rest_of_world global
##    <chr>  <chr> <chr>  <chr>             <dbl>  <dbl> <dbl>         <dbl>  <dbl>
##  1 Red D… 2018  Actio… Rockstar…          5.26   6.21 0.21           2.26  13.9 
##  2 FIFA … 2016  Sports Electron…          1.26   7.95 0.12           1.61  10.9 
##  3 Uncha… 2016  Action Sony Int…          4.49   3.93 0.21           1.7   10.3 
##  4 Spide… 2018  Actio… Sony Int…          3.64   3.39 0.32           1.41   8.76
##  5 Call … 2016  Shoot… Activisi…          3.11   3.83 0.19           1.36   8.48
##  6 Battl… 2016  Shoot… Electron…          2.2    3.65 0.290          1.12   7.26
##  7 God o… 2018  Action Sony Int…          2.83   2.17 0.13           1.02   6.15
##  8 Final… 2016  Role-… Square E…          1.81   1.53 1.05           0.68   5.07
##  9 Monst… 2018  Action Capcom             1.03   1.06 2.17           0.42   4.67
## 10 Overw… 2016  Shoot… Blizzard…          1.84   1.8  0.17           0.73   4.54
## # … with 251 more rows
```
The `between()` functon is for a specific range of values.

```r
filter(ps4_games, between(north_america, 1.5, 2.5))
```

```
## # A tibble: 16 x 9
##    game   year  genre  publisher north_america europe japan rest_of_world global
##    <chr>  <chr> <chr>  <chr>             <dbl>  <dbl> <dbl>         <dbl>  <dbl>
##  1 Battl… 2016  Shoot… Electron…          2.2   3.65  0.290          1.12   7.26
##  2 MineC… 2014  Misc   Sony Com…          1.89  3.13  0.35           0.96   6.33
##  3 Horiz… 2017  Action Sony Int…          2.2   2.43  0.28           0.92   5.82
##  4 Final… 2016  Role-… Square E…          1.81  1.53  1.05           0.68   5.07
##  5 Overw… 2016  Shoot… Blizzard…          1.84  1.8   0.17           0.73   4.54
##  6 Star … 2017  Shoot… Electron…          1.7   1.99  0.12           0.73   4.53
##  7 Call … 2013  Shoot… Activisi…          1.79  1.64  0.05           0.69   4.17
##  8 Desti… 2017  Shoot… Activisi…          1.92  1.44  0.1            0.69   4.14
##  9 Batma… 2015  Action Warner B…          1.65  1.68  0.11           0.66   4.11
## 10 NBA 2… 2016  Sports 2K Sports          2.28  0.59  0.03           0.63   3.52
## 11 Morta… 2015  Fight… Warner B…          1.94  0.94  0              0.61   3.49
## 12 NBA 2… 2017  Sports 2K Sports          2.13  0.570 0.04           0.59   3.34
## 13 Madde… 2015  Sports EA Sports          2.39  0.31  0              0.61   3.3 
## 14 Madde… 2016  Sports EA Sports          2.3   0.37  0              0.6    3.28
## 15 Madde… 2017  Sports EA Sports          1.73  0.42  0              0.47   2.62
## 16 Madde… 2014  Sports EA Sports          1.58  0.25  0              0.41   2.25
```
The `between()` function can also have a specified tolerance.

```r
filter(ps4_games, near(north_america, 2, tol = 0.2))
```

```
## # A tibble: 6 x 9
##   game   year  genre  publisher  north_america europe japan rest_of_world global
##   <chr>  <chr> <chr>  <chr>              <dbl>  <dbl> <dbl>         <dbl>  <dbl>
## 1 MineC… 2014  Misc   Sony Comp…          1.89  3.13   0.35          0.96   6.33
## 2 Final… 2016  Role-… Square En…          1.81  1.53   1.05          0.68   5.07
## 3 Overw… 2016  Shoot… Blizzard …          1.84  1.8    0.17          0.73   4.54
## 4 Desti… 2017  Shoot… Activision          1.92  1.44   0.1           0.69   4.14
## 5 Morta… 2015  Fight… Warner Br…          1.94  0.94   0             0.61   3.49
## 6 NBA 2… 2017  Sports 2K Sports           2.13  0.570  0.04          0.59   3.34
```

### Filtering Multiple Conditions

The rules for filtering on multiple conditions is as follows:

`filter(condition1, condition2)` returns rows where **both** conditions are met. The same is true if you use the operator `&`.

`filter(condition1, !condition2)` returns rows where condition 1 is met, but not condition 2.

`filter(condition1 | condition2)`returns rows where condition 1 and/or condition 2 is met.

`filter(xor(condition1, condition2))` will return all rows where only **one** condition is met, but **not both**.


```r
filter(ps4_games, genre == "Role-Playing", (year != 2018 | north_america >= 3))
```

```
## # A tibble: 117 x 9
##    game   year  genre  publisher north_america europe japan rest_of_world global
##    <chr>  <chr> <chr>  <chr>             <dbl>  <dbl> <dbl>         <dbl>  <dbl>
##  1 Fallo… 2015  Role-… Bethesda…         2.91    3.97  0.27          1.34   8.48
##  2 The W… 2015  Role-… Namco Ba…         1.48    2.82  0.28          0.81   5.39
##  3 Final… 2016  Role-… Square E…         1.81    1.53  1.05          0.68   5.07
##  4 The E… 2016  Role-… Bethesda…         1.24    1.5   0.08          0.54   3.36
##  5 Blood… 2015  Role-… Sony Com…         1.3     1.05  0.28          0.48   3.11
##  6 Diabl… 2014  Role-… Blizzard…         0.83    1.48  0.08          0.44   2.82
##  7 Dark … 2016  Role-… Namco Ba…         1       0.63  0.44          0.34   2.42
##  8 Drago… 2014  Role-… Electron…         1.07    0.8   0.08          0.38   2.34
##  9 Drago… 2017  Role-… Square E…         0.290   0.22  1.43          0.1    2.04
## 10 Kingd… 2017  Role-… Square E…         0.75    0.51  0.23          0.26   1.75
## # … with 107 more rows
```

The fun thing about filters is they can also be used in conjunction with class-related commands. Look!

```r
filter(video_game_sales, !is.na(rating))
```

```
## # A tibble: 9,950 x 16
##    name  platform year_of_release genre publisher na_sales eu_sales jp_sales
##    <chr> <chr>    <chr>           <chr> <chr>        <dbl>    <dbl>    <dbl>
##  1 Wii … Wii      2006            Spor… Nintendo     41.4     29.0      3.77
##  2 Mari… Wii      2008            Raci… Nintendo     15.7     12.8      3.79
##  3 Wii … Wii      2009            Spor… Nintendo     15.6     10.9      3.28
##  4 New … DS       2006            Plat… Nintendo     11.3      9.14     6.5 
##  5 Wii … Wii      2006            Misc  Nintendo     14.0      9.18     2.93
##  6 New … Wii      2009            Plat… Nintendo     14.4      6.94     4.7 
##  7 Mari… DS       2005            Raci… Nintendo      9.71     7.47     4.13
##  8 Wii … Wii      2007            Spor… Nintendo      8.92     8.03     3.6 
##  9 Kine… X360     2010            Misc  Microsof…    15        4.89     0.24
## 10 Wii … Wii      2009            Spor… Nintendo      9.01     8.49     2.53
## # … with 9,940 more rows, and 8 more variables: other_sales <dbl>,
## #   global_sales <dbl>, critic_score <dbl>, critic_count <dbl>,
## #   user_score <dbl>, user_count <dbl>, developer <chr>, rating <chr>
```
This let us get rid of any data that doesn't have an age rating associated.

# Pipes
`%>%` is your savior. Use it to make your code cleaner and helps you type less. It's wonderful. The shortcut for Macs is `CMD + SHFT + M'. 

```r
names(video_game_sales)
```

```
##  [1] "name"            "platform"        "year_of_release" "genre"          
##  [5] "publisher"       "na_sales"        "eu_sales"        "jp_sales"       
##  [9] "other_sales"     "global_sales"    "critic_score"    "critic_count"   
## [13] "user_score"      "user_count"      "developer"       "rating"
```

```r
video_game_sales %>%
  select(name, genre, critic_score, critic_count) %>% 
  filter(critic_score >= 80, genre == "Role-Playing") %>% 
  arrange(critic_score)
```

```
## # A tibble: 233 x 4
##    name                                     genre      critic_score critic_count
##    <chr>                                    <chr>             <dbl>        <dbl>
##  1 Fable III                                Role-Play…           80           88
##  2 Star Ocean: Till The End of Time         Role-Play…           80           55
##  3 Dragon Quest IV: Chapters of the Chosen  Role-Play…           80           44
##  4 Dark Cloud                               Role-Play…           80           27
##  5 Final Fantasy: Crystal Chronicles        Role-Play…           80           55
##  6 Star Ocean: The Second Story             Role-Play…           80           13
##  7 Pokemon Conquest                         Role-Play…           80           40
##  8 Kingdoms of Amalur: Reckoning            Role-Play…           80           71
##  9 Final Fantasy Anthology                  Role-Play…           80           14
## 10 Final Fantasy Tactics A2: Grimoire of t… Role-Play…           80           47
## # … with 223 more rows
```
See that `arrange()` function we used? That sorted our search for role-playing games that critics scored at least 80 to show us the games in ascending order. We can also do descending order by using `arrange(desc())`.

```r
video_game_sales %>%
  select(name, genre, critic_score, critic_count) %>% 
  filter(critic_score >= 80, genre == "Platform") %>% 
  arrange(desc(critic_score))
```

```
## # A tibble: 100 x 4
##    name                               genre    critic_score critic_count
##    <chr>                              <chr>           <dbl>        <dbl>
##  1 Super Mario Galaxy                 Platform           97           73
##  2 Super Mario Galaxy 2               Platform           97           87
##  3 LittleBigPlanet                    Platform           95           85
##  4 Super Mario 3D World               Platform           93           83
##  5 Castlevania: Symphony of the Night Platform           93           12
##  6 Super Mario Sunshine               Platform           92           61
##  7 Rayman Legends                     Platform           92           35
##  8 Rayman Origins                     Platform           92           13
##  9 Crash Bandicoot 3: Warped          Platform           91           12
## 10 Spyro: Year of the Dragon          Platform           91           15
## # … with 90 more rows
```
Super Mario Galaxy was indeed, one of the best platforming games ever.

## `Mutate()`
There are two types of these functions: `mutate()` and `mutate_all()`.

`Mutate()` allows us to make a new column from existing columns in the data frame.

```r
names(video_game_sales)
```

```
##  [1] "name"            "platform"        "year_of_release" "genre"          
##  [5] "publisher"       "na_sales"        "eu_sales"        "jp_sales"       
##  [9] "other_sales"     "global_sales"    "critic_score"    "critic_count"   
## [13] "user_score"      "user_count"      "developer"       "rating"
```

```r
video_game_sales %>%
  mutate(percent_na_sales = na_sales/global_sales) %>% 
  select(name, na_sales, global_sales, percent_na_sales)
```

```
## # A tibble: 16,719 x 4
##    name                      na_sales global_sales percent_na_sales
##    <chr>                        <dbl>        <dbl>            <dbl>
##  1 Wii Sports                    41.4         82.5            0.501
##  2 Super Mario Bros.             29.1         40.2            0.723
##  3 Mario Kart Wii                15.7         35.5            0.441
##  4 Wii Sports Resort             15.6         32.8            0.476
##  5 Pokemon Red/Pokemon Blue      11.3         31.4            0.359
##  6 Tetris                        23.2         30.3            0.767
##  7 New Super Mario Bros.         11.3         29.8            0.379
##  8 Wii Play                      14.0         28.9            0.483
##  9 New Super Mario Bros. Wii     14.4         28.3            0.510
## 10 Duck Hunt                     26.9         28.3            0.951
## # … with 16,709 more rows
```
If we wanted to make all the data lower-cased, we should change them with the `mutate_all()` function.

```r
video_game_sales %>%
  mutate_all(tolower)
```

```
## # A tibble: 16,719 x 16
##    name  platform year_of_release genre publisher na_sales eu_sales jp_sales
##    <chr> <chr>    <chr>           <chr> <chr>     <chr>    <chr>    <chr>   
##  1 wii … wii      2006            spor… nintendo  41.36    28.96    3.77    
##  2 supe… nes      1985            plat… nintendo  29.08    3.58     6.81    
##  3 mari… wii      2008            raci… nintendo  15.68    12.76    3.79    
##  4 wii … wii      2009            spor… nintendo  15.61    10.93    3.28    
##  5 poke… gb       1996            role… nintendo  11.27    8.89     10.22   
##  6 tetr… gb       1989            puzz… nintendo  23.2     2.26     4.22    
##  7 new … ds       2006            plat… nintendo  11.28    9.14     6.5     
##  8 wii … wii      2006            misc  nintendo  13.96    9.18     2.93    
##  9 new … wii      2009            plat… nintendo  14.44    6.94     4.7     
## 10 duck… nes      1984            shoo… nintendo  26.93    0.63     0.28    
## # … with 16,709 more rows, and 8 more variables: other_sales <chr>,
## #   global_sales <chr>, critic_score <chr>, critic_count <chr>,
## #   user_score <chr>, user_count <chr>, developer <chr>, rating <chr>
```
## `If_else()`
The `if_else()` function is really great for finding and replacing data to make it more uniform. This works best if the data you have uses weird numbers or symbols for `NA` data. The person who made these data sets took care of it already, but you can do the following for data with funky data:

` dataframe %>% 
    select(variable1, variable2, variable3) %>% 
    mutate(new_variable3 = ifelse(variable3 == -999.00, NA, variable3))`

Here, we told R to look at our dataframe and replace any data in variable3 that has a `999.00` value with `NA`. This function also lets R know to leave that data alone if it already has `NA`.

## `Tabyl()`
The `tabyl()` function is the `janitor` package's version of `table()`.

```r
tabyl(ps4_games, genre)
```

```
##             genre   n     percent
##            Action 258 0.249516441
##  Action-Adventure  40 0.038684720
##         Adventure  97 0.093810445
##          Fighting  35 0.033849130
##              Misc 123 0.118955513
##               MMO   8 0.007736944
##             Music  19 0.018375242
##             Party   2 0.001934236
##          Platform  46 0.044487427
##            Puzzle  16 0.015473888
##            Racing  48 0.046421663
##      Role-Playing 123 0.118955513
##           Shooter  89 0.086073501
##        Simulation  23 0.022243714
##            Sports  71 0.068665377
##          Strategy  28 0.027079304
##      Visual Novel   8 0.007736944
```

## `Summarise()` and Friends
The `summarise()` function produces a summary of statistics for a given variable in a data frame.


```r
names(video_game_sales)
```

```
##  [1] "name"            "platform"        "year_of_release" "genre"          
##  [5] "publisher"       "na_sales"        "eu_sales"        "jp_sales"       
##  [9] "other_sales"     "global_sales"    "critic_score"    "critic_count"   
## [13] "user_score"      "user_count"      "developer"       "rating"
```

```r
ps4_games %>% 
  filter(genre == "Role-Playing") %>%
  summarise(mean_tot_sales = mean(global),
            mean_na_sales = mean(north_america),
            mean_jp_sales = mean(japan),
            total_games = n(), .groups= 'keep') # n() provides the count of that variable
```

```
## # A tibble: 1 x 4
##   mean_tot_sales mean_na_sales mean_jp_sales total_games
##            <dbl>         <dbl>         <dbl>       <int>
## 1          0.511         0.180        0.0766         123
```

`.groups= 'keep'` is an additional piece of code you can append to the end of your `summarise()` to prevent a particular warning from appearing when running it.

**Beware of your spelling!** I found out that you **need** to spell this function right to get the proper formatting to your coding. Take a look at the difference.

`SummariZe()` is apart of the dataMaid package.

```r
msleep %>% 
  group_by(vore) %>% 
  summarize(min_bodywt = min(bodywt),
            max_bodywt = max(bodywt),
            mean_bodywt = mean(bodywt),
            total = n())
```

```
## $name
## $name$variableType
## Variable type: character
## $name$countMissing
## Number of missing obs.: 0 (0 %)
## $name$uniqueValues
## Number of unique values: 83
## $name$centralValue
## Mode: "African elephant"
## 
## $genus
## $genus$variableType
## Variable type: character
## $genus$countMissing
## Number of missing obs.: 0 (0 %)
## $genus$uniqueValues
## Number of unique values: 77
## $genus$centralValue
## Mode: "Panthera"
## 
## $vore
## $vore$variableType
## Variable type: character
## $vore$countMissing
## Number of missing obs.: 7 (8.43 %)
## $vore$uniqueValues
## Number of unique values: 4
## $vore$centralValue
## Mode: "herbi"
## 
## $order
## $order$variableType
## Variable type: character
## $order$countMissing
## Number of missing obs.: 0 (0 %)
## $order$uniqueValues
## Number of unique values: 19
## $order$centralValue
## Mode: "Rodentia"
## 
## $conservation
## $conservation$variableType
## Variable type: character
## $conservation$countMissing
## Number of missing obs.: 29 (34.94 %)
## $conservation$uniqueValues
## Number of unique values: 6
## $conservation$centralValue
## Mode: "lc"
## 
## $sleep_total
## $sleep_total$variableType
## Variable type: numeric
## $sleep_total$countMissing
## Number of missing obs.: 0 (0 %)
## $sleep_total$uniqueValues
## Number of unique values: 65
## $sleep_total$centralValue
## Median: 10.1
## $sleep_total$quartiles
## 1st and 3rd quartiles: 7.85; 13.75
## $sleep_total$minMax
## Min. and max.: 1.9; 19.9
## 
## $sleep_rem
## $sleep_rem$variableType
## Variable type: numeric
## $sleep_rem$countMissing
## Number of missing obs.: 22 (26.51 %)
## $sleep_rem$uniqueValues
## Number of unique values: 32
## $sleep_rem$centralValue
## Median: 1.5
## $sleep_rem$quartiles
## 1st and 3rd quartiles: 0.9; 2.4
## $sleep_rem$minMax
## Min. and max.: 0.1; 6.6
## 
## $sleep_cycle
## $sleep_cycle$variableType
## Variable type: numeric
## $sleep_cycle$countMissing
## Number of missing obs.: 51 (61.45 %)
## $sleep_cycle$uniqueValues
## Number of unique values: 22
## $sleep_cycle$centralValue
## Median: 0.33
## $sleep_cycle$quartiles
## 1st and 3rd quartiles: 0.18; 0.58
## $sleep_cycle$minMax
## Min. and max.: 0.12; 1.5
## 
## $awake
## $awake$variableType
## Variable type: numeric
## $awake$countMissing
## Number of missing obs.: 0 (0 %)
## $awake$uniqueValues
## Number of unique values: 65
## $awake$centralValue
## Median: 13.9
## $awake$quartiles
## 1st and 3rd quartiles: 10.25; 16.15
## $awake$minMax
## Min. and max.: 4.1; 22.1
## 
## $brainwt
## $brainwt$variableType
## Variable type: numeric
## $brainwt$countMissing
## Number of missing obs.: 27 (32.53 %)
## $brainwt$uniqueValues
## Number of unique values: 53
## $brainwt$centralValue
## Median: 0.01
## $brainwt$quartiles
## 1st and 3rd quartiles: 0; 0.13
## $brainwt$minMax
## Min. and max.: 0; 5.71
## 
## $bodywt
## $bodywt$variableType
## Variable type: numeric
## $bodywt$countMissing
## Number of missing obs.: 0 (0 %)
## $bodywt$uniqueValues
## Number of unique values: 82
## $bodywt$centralValue
## Median: 1.67
## $bodywt$quartiles
## 1st and 3rd quartiles: 0.17; 41.75
## $bodywt$minMax
## Min. and max.: 0; 6654
```

`SummariSe()` is apart of the dplyr package.

```r
msleep %>% 
  group_by(vore) %>% 
  summarise(min_bodywt = min(bodywt),
            max_bodywt = max(bodywt),
            mean_bodywt = mean(bodywt),
            total = n())
```

```
## # A tibble: 5 x 5
##   vore    min_bodywt max_bodywt mean_bodywt total
## * <chr>        <dbl>      <dbl>       <dbl> <int>
## 1 carni        0.028      800        90.8      19
## 2 herbi        0.022     6654       367.       32
## 3 insecti      0.01        60        12.9       5
## 4 omni         0.005       86.2      12.7      20
## 5 <NA>         0.021        3.6       0.858     7
```
**Your spelling matters.**

### `N_distinct()`
`n_disinct()` is useful sub-command for the `summarise()` for cleanly presenting the number of distinct observations.

```r
ps4_games %>% 
  summarise(n_genres = n_distinct(genre))
```

```
## # A tibble: 1 x 1
##   n_genres
##      <int>
## 1       17
```

### `Group_by()`
This is very helpful for further narrowing in on a specific summary of data.

```r
msleep %>% 
  group_by(vore) %>% 
  summarise(min_bodywt = min(bodywt),
            max_bodywt = max(bodywt),
            mean_bodywt = mean(bodywt),
            total = n())
```

```
## # A tibble: 5 x 5
##   vore    min_bodywt max_bodywt mean_bodywt total
## * <chr>        <dbl>      <dbl>       <dbl> <int>
## 1 carni        0.028      800        90.8      19
## 2 herbi        0.022     6654       367.       32
## 3 insecti      0.01        60        12.9       5
## 4 omni         0.005       86.2      12.7      20
## 5 <NA>         0.021        3.6       0.858     7
```

## Counts
The `count()` function helps you determine how many observations you have in a column.

```r
video_game_sales %>% 
  count(publisher, genre, sort = T) # sort = T sorts column in descending order.
```

```
## # A tibble: 1,847 x 3
##    publisher                              genre       n
##    <chr>                                  <chr>   <int>
##  1 Electronic Arts                        Sports    560
##  2 Activision                             Action    311
##  3 Konami Digital Entertainment           Sports    281
##  4 Namco Bandai Games                     Action    251
##  5 Ubisoft                                Action    198
##  6 THQ                                    Action    194
##  7 Electronic Arts                        Action    183
##  8 Warner Bros. Interactive Entertainment Action    169
##  9 Activision                             Shooter   162
## 10 Capcom                                 Action    159
## # … with 1,837 more rows
```
EA really loves their sports games.

You can even use the `tabyl()` function to get a count.

```r
video_game_sales %>% 
  filter(publisher == "Square Enix") %>% 
  tabyl(platform, genre)
```

```
##  platform Action Adventure Fighting Misc Puzzle Role-Playing Shooter Simulation
##       3DS      1         0        0    3      1            9       0          0
##        DS      4         1        0    2      3           26       2          4
##       GBA      0         1        0    0      0            1       0          0
##        PC      9         2        0    0      0            5       3          0
##       PS2      0         0        0    0      0           23       1          0
##       PS3     11         0        0    0      0           14       4          0
##       PS4     10         2        0    0      0            9       0          0
##       PSP      0         0        3    1      0           15       1          0
##       PSV      2         1        0    0      0            6       0          0
##       Wii      2         1        0    0      0            5       0          0
##      WiiU      0         0        0    0      0            2       1          0
##      X360      7         1        0    0      0           13       4          0
##      XOne      6         2        0    0      0            3       0          0
##  Strategy
##         0
##         3
##         0
##         2
##         2
##         0
##         0
##         0
##         0
##         1
##         0
##         1
##         0
```
Make your counts pretty with `adorn()` functions.

```r
video_game_sales %>% 
  filter(publisher == "Square Enix") %>% 
  tabyl(platform, genre) %>%
  adorn_ns()
```

```
##  platform  Action Adventure Fighting  Misc Puzzle Role-Playing Shooter
##       3DS  1  (1)     0 (0)    0 (0) 3 (3)  1 (1)       9  (9)   0 (0)
##        DS  4  (4)     1 (1)    0 (0) 2 (2)  3 (3)      26 (26)   2 (2)
##       GBA  0  (0)     1 (1)    0 (0) 0 (0)  0 (0)       1  (1)   0 (0)
##        PC  9  (9)     2 (2)    0 (0) 0 (0)  0 (0)       5  (5)   3 (3)
##       PS2  0  (0)     0 (0)    0 (0) 0 (0)  0 (0)      23 (23)   1 (1)
##       PS3 11 (11)     0 (0)    0 (0) 0 (0)  0 (0)      14 (14)   4 (4)
##       PS4 10 (10)     2 (2)    0 (0) 0 (0)  0 (0)       9  (9)   0 (0)
##       PSP  0  (0)     0 (0)    3 (3) 1 (1)  0 (0)      15 (15)   1 (1)
##       PSV  2  (2)     1 (1)    0 (0) 0 (0)  0 (0)       6  (6)   0 (0)
##       Wii  2  (2)     1 (1)    0 (0) 0 (0)  0 (0)       5  (5)   0 (0)
##      WiiU  0  (0)     0 (0)    0 (0) 0 (0)  0 (0)       2  (2)   1 (1)
##      X360  7  (7)     1 (1)    0 (0) 0 (0)  0 (0)      13 (13)   4 (4)
##      XOne  6  (6)     2 (2)    0 (0) 0 (0)  0 (0)       3  (3)   0 (0)
##  Simulation Strategy
##       0 (0)    0 (0)
##       4 (4)    3 (3)
##       0 (0)    0 (0)
##       0 (0)    2 (2)
##       0 (0)    2 (2)
##       0 (0)    0 (0)
##       0 (0)    0 (0)
##       0 (0)    0 (0)
##       0 (0)    0 (0)
##       0 (0)    1 (1)
##       0 (0)    0 (0)
##       0 (0)    1 (1)
##       0 (0)    0 (0)
```

## `Across()`
What if you wanted to use `filter()` and  `select()` across multiple variables? Use `across()`!

```r
video_game_sales %>% 
  summarise(across(c(platform, genre, year_of_release), n_distinct))
```

```
## # A tibble: 1 x 3
##   platform genre year_of_release
##      <int> <int>           <int>
## 1       31    13              40
```

Try it across a continuous variable!

```r
video_game_sales %>% 
  summarise(across(contains("critic"), mean, na.rm = T))
```

```
## # A tibble: 1 x 2
##   critic_score critic_count
##          <dbl>        <dbl>
## 1         69.0         26.4
```
Looks like most games get about 26 critics to give a score, but only score a 68-69. Uh oh..

We can also combine it with `group_by()`.

```r
video_game_sales %>% 
  group_by(publisher) %>% 
  summarise(across(contains("critic"), mean, na.rm = T)) %>%
  arrange(desc(critic_score))
```

```
## # A tibble: 582 x 3
##    publisher              critic_score critic_count
##    <chr>                         <dbl>        <dbl>
##  1 Valve                          95           54  
##  2 Valve Software                 93           57.7
##  3 Blue Byte                      91           12  
##  4 2D Boy                         90           26  
##  5 Graphsim Entertainment         90            7  
##  6 Number None                    90           11  
##  7 Psygnosis                      89.8         10.8
##  8 Square                         89           15  
##  9 Devolver Digital               88           31  
## 10 Havas Interactive              88           34  
## # … with 572 more rows
```
Everybody loves Valve!

### End ###
