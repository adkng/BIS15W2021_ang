---
title: "Lab 4 Homework"
author: "Adrianna Ng"
date: "2021-01-24"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

**1. Load the data into a new object called `homerange`.**

```r
homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double()
## )
```

```
## See spec(...) for full column specifications.
```

**2. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.**

Dimensions

```r
dim(homerange)
```

```
## [1] 569  24
```

Column names

```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```

Classes for each variable

```r
glimpse(homerange)
```

```
## Observations: 569
## Variables: 24
## $ taxon                      <chr> "lake fishes", "river fishes", "river fish…
## $ common.name                <chr> "american eel", "blacktail redhorse", "cen…
## $ class                      <chr> "actinopterygii", "actinopterygii", "actin…
## $ order                      <chr> "anguilliformes", "cypriniformes", "cyprin…
## $ family                     <chr> "anguillidae", "catostomidae", "cyprinidae…
## $ genus                      <chr> "anguilla", "moxostoma", "campostoma", "cl…
## $ species                    <chr> "rostrata", "poecilura", "anomalum", "fund…
## $ primarymethod              <chr> "telemetry", "mark-recapture", "mark-recap…
## $ N                          <chr> "16", NA, "20", "26", "17", "5", "2", "2",…
## $ mean.mass.g                <dbl> 887.00, 562.00, 34.00, 4.00, 4.00, 3525.00…
## $ log10.mass                 <dbl> 2.9479236, 2.7497363, 1.5314789, 0.6020600…
## $ alternative.mass.reference <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ mean.hra.m2                <dbl> 282750.00, 282.10, 116.11, 125.50, 87.10, …
## $ log10.hra                  <dbl> 5.4514026, 2.4504031, 2.0648696, 2.0986437…
## $ hra.reference              <chr> "Minns, C. K. 1995. Allometry of home rang…
## $ realm                      <chr> "aquatic", "aquatic", "aquatic", "aquatic"…
## $ thermoregulation           <chr> "ectotherm", "ectotherm", "ectotherm", "ec…
## $ locomotion                 <chr> "swimming", "swimming", "swimming", "swimm…
## $ trophic.guild              <chr> "carnivore", "carnivore", "carnivore", "ca…
## $ dimension                  <chr> "3D", "2D", "2D", "2D", "2D", "2D", "2D", …
## $ preymass                   <dbl> NA, NA, NA, NA, NA, NA, 1.39, NA, NA, NA, …
## $ log10.preymass             <dbl> NA, NA, NA, NA, NA, NA, 0.1430148, NA, NA,…
## $ PPMR                       <dbl> NA, NA, NA, NA, NA, NA, 530, NA, NA, NA, N…
## $ prey.size.reference        <chr> NA, NA, NA, NA, NA, NA, "Brose U, et al. 2…
```

Statistical summary

```r
summary(homerange)
```

```
##     taxon           common.name           class              order          
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     family             genus             species          primarymethod     
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##       N              mean.mass.g        log10.mass     
##  Length:569         Min.   :      0   Min.   :-0.6576  
##  Class :character   1st Qu.:     50   1st Qu.: 1.6990  
##  Mode  :character   Median :    330   Median : 2.5185  
##                     Mean   :  34602   Mean   : 2.5947  
##                     3rd Qu.:   2150   3rd Qu.: 3.3324  
##                     Max.   :4000000   Max.   : 6.6021  
##                                                        
##  alternative.mass.reference  mean.hra.m2          log10.hra     
##  Length:569                 Min.   :0.000e+00   Min.   :-1.523  
##  Class :character           1st Qu.:4.500e+03   1st Qu.: 3.653  
##  Mode  :character           Median :3.934e+04   Median : 4.595  
##                             Mean   :2.146e+07   Mean   : 4.709  
##                             3rd Qu.:1.038e+06   3rd Qu.: 6.016  
##                             Max.   :3.551e+09   Max.   : 9.550  
##                                                                 
##  hra.reference         realm           thermoregulation    locomotion       
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  trophic.guild       dimension            preymass         log10.preymass   
##  Length:569         Length:569         Min.   :     0.67   Min.   :-0.1739  
##  Class :character   Class :character   1st Qu.:    20.02   1st Qu.: 1.3014  
##  Mode  :character   Mode  :character   Median :    53.75   Median : 1.7304  
##                                        Mean   :  3989.88   Mean   : 2.0188  
##                                        3rd Qu.:   363.35   3rd Qu.: 2.5603  
##                                        Max.   :130233.20   Max.   : 5.1147  
##                                        NA's   :502         NA's   :502      
##       PPMR         prey.size.reference
##  Min.   :  0.380   Length:569         
##  1st Qu.:  3.315   Class :character   
##  Median :  7.190   Mode  :character   
##  Mean   : 31.752                      
##  3rd Qu.: 15.966                      
##  Max.   :530.000                      
##  NA's   :502
```

**3. Change the class of the variables `taxon` and `order` to factors and display their levels.**
Current class

```r
class(homerange$taxon)
```

```
## [1] "character"
```

```r
class(homerange$order)
```

```
## [1] "character"
```
Class change

```r
homerange$taxon <- as.factor(homerange$taxon)
homerange$order <- as.factor(homerange$order)
```
Class change check

```r
class(homerange$taxon)
```

```
## [1] "factor"
```

```r
class(homerange$order)
```

```
## [1] "factor"
```
Displaying levels (taxon)

```r
levels(homerange$taxon)
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```
Displaying levels (order)

```r
levels(homerange$order)
```

```
##  [1] "accipitriformes"    "afrosoricida"       "anguilliformes"    
##  [4] "anseriformes"       "apterygiformes"     "artiodactyla"      
##  [7] "caprimulgiformes"   "carnivora"          "charadriiformes"   
## [10] "columbidormes"      "columbiformes"      "coraciiformes"     
## [13] "cuculiformes"       "cypriniformes"      "dasyuromorpha"     
## [16] "dasyuromorpia"      "didelphimorphia"    "diprodontia"       
## [19] "diprotodontia"      "erinaceomorpha"     "esociformes"       
## [22] "falconiformes"      "gadiformes"         "galliformes"       
## [25] "gruiformes"         "lagomorpha"         "macroscelidea"     
## [28] "monotrematae"       "passeriformes"      "pelecaniformes"    
## [31] "peramelemorphia"    "perciformes"        "perissodactyla"    
## [34] "piciformes"         "pilosa"             "proboscidea"       
## [37] "psittaciformes"     "rheiformes"         "roden"             
## [40] "rodentia"           "salmoniformes"      "scorpaeniformes"   
## [43] "siluriformes"       "soricomorpha"       "squamata"          
## [46] "strigiformes"       "struthioniformes"   "syngnathiformes"   
## [49] "testudines"         "tetraodontiformes\xa0" "tinamiformes"
```

**4. What taxa are represented in the `homerange` data frame? Make a new data frame `taxa` that is restricted to taxon, common name, class, order, family, genus, species.**

```r
taxa <- select(homerange, "taxon", "common.name", "class", "order", "family", "genus", "species")
taxa <- rename(taxa, "common_name" = common.name)
taxa
```

```
## # A tibble: 569 x 7
##    taxon     common_name       class      order     family    genus    species  
##    <fct>     <chr>             <chr>      <fct>     <chr>     <chr>    <chr>    
##  1 lake fis… american eel      actinopte… anguilli… anguilli… anguilla rostrata 
##  2 river fi… blacktail redhor… actinopte… cyprinif… catostom… moxosto… poecilura
##  3 river fi… central stonerol… actinopte… cyprinif… cyprinid… campost… anomalum 
##  4 river fi… rosyside dace     actinopte… cyprinif… cyprinid… clinost… funduloi…
##  5 river fi… longnose dace     actinopte… cyprinif… cyprinid… rhinich… cataract…
##  6 river fi… muskellunge       actinopte… esocifor… esocidae  esox     masquino…
##  7 marine f… pollack           actinopte… gadiform… gadidae   pollach… pollachi…
##  8 marine f… saithe            actinopte… gadiform… gadidae   pollach… virens   
##  9 marine f… lined surgeonfish actinopte… percifor… acanthur… acanthu… lineatus 
## 10 marine f… orangespine unic… actinopte… percifor… acanthur… naso     lituratus
## # … with 559 more rows
```

**5. The variable `taxon` identifies the large, common name groups of the species represented in `homerange`. Make a table the shows the counts for each of these `taxon`.**

```r
table(homerange$taxon)
```

```
## 
##         birds   lake fishes       lizards       mammals marine fishes 
##           140             9            11           238            90 
##  river fishes        snakes     tortoises       turtles 
##            14            41            12            14
```


**6. The species in `homerange` are also classified into trophic guilds. How many species are represented in each trophic guild.**  

```r
table(homerange$trophic.guild)
```

```
## 
## carnivore herbivore 
##       342       227
```


**7. Make two new data frames, one which is restricted to carnivores and another that is restricted to herbivores.**  

```r
carnivore <- filter(homerange, trophic.guild == "carnivore")
carnivore
```

```
## # A tibble: 342 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 lake… american e… acti… angu… angui… angu… rostra… telemetry     16   
##  2 rive… blacktail … acti… cypr… catos… moxo… poecil… mark-recaptu… <NA> 
##  3 rive… central st… acti… cypr… cypri… camp… anomal… mark-recaptu… 20   
##  4 rive… rosyside d… acti… cypr… cypri… clin… fundul… mark-recaptu… 26   
##  5 rive… longnose d… acti… cypr… cypri… rhin… catara… mark-recaptu… 17   
##  6 rive… muskellunge acti… esoc… esoci… esox  masqui… telemetry     5    
##  7 mari… pollack     acti… gadi… gadid… poll… pollac… telemetry     2    
##  8 mari… saithe      acti… gadi… gadid… poll… virens  telemetry     2    
##  9 mari… giant trev… acti… perc… caran… cara… ignobi… telemetry     4    
## 10 lake… rock bass   acti… perc… centr… ambl… rupest… mark-recaptu… 16   
## # … with 332 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```


```r
herbivore <- filter(homerange, trophic.guild == "herbivore")
herbivore
```

```
## # A tibble: 227 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 mari… lined surg… acti… perc… acant… acan… lineat… direct obser… <NA> 
##  2 mari… orangespin… acti… perc… acant… naso  litura… telemetry     8    
##  3 mari… bluespine … acti… perc… acant… naso  unicor… telemetry     7    
##  4 mari… redlip ble… acti… perc… blenn… ophi… atlant… direct obser… 20   
##  5 mari… bermuda ch… acti… perc… kypho… kyph… sectat… telemetry     11   
##  6 mari… cherubfish  acti… perc… pomac… cent… argi    direct obser… <NA> 
##  7 mari… damselfish  acti… perc… pomac… chro… chromis direct obser… <NA> 
##  8 mari… twinspot d… acti… perc… pomac… chry… biocel… direct obser… 18   
##  9 mari… wards dams… acti… perc… pomac… poma… wardi   direct obser… <NA> 
## 10 mari… australian… acti… perc… pomac… steg… apical… direct obser… <NA> 
## # … with 217 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```


**8. Do herbivores or carnivores have, on average, a larger `mean.hra.m2`? Remove any NAs from the data.**

```r
names(carnivore)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```

```r
carnivore_mean <- carnivore[ , 13]
carnivore_mean
```

```
## # A tibble: 342 x 1
##    mean.hra.m2
##          <dbl>
##  1    282750  
##  2       282. 
##  3       116. 
##  4       126. 
##  5        87.1
##  6     39344. 
##  7      9056. 
##  8     44516. 
##  9     52773  
## 10     10407. 
## # … with 332 more rows
```

```r
colMeans(carnivore_mean, na.rm = TRUE)
```

```
## mean.hra.m2 
##    13039918
```

```r
herbivore_mean <- herbivore[ , 13]
colMeans(herbivore_mean, na.rm = TRUE)
```

```
## mean.hra.m2 
##    34137012
```
Herbivores have a larger mean.hra.m2.

**9. Make a new dataframe `deer` that is limited to the mean mass, log10 mass, family, genus, and species of deer in the database. The family for deer is cervidae. Arrange the data in descending order by log10 mass. Which is the largest deer? What is its common name?**

```r
deer_frame <- filter(homerange, family == "cervidae")
deer_frame
```

```
## # A tibble: 12 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 mamm… moose       mamm… arti… cervi… alces alces   telemetry*    <NA> 
##  2 mamm… chital      mamm… arti… cervi… axis  axis    telemetry*    <NA> 
##  3 mamm… roe deer    mamm… arti… cervi… capr… capreo… telemetry*    <NA> 
##  4 mamm… red deer    mamm… arti… cervi… cerv… elaphus telemetry*    <NA> 
##  5 mamm… sika deer   mamm… arti… cervi… cerv… nippon  telemetry*    <NA> 
##  6 mamm… fallow deer mamm… arti… cervi… dama  dama    telemetry*    <NA> 
##  7 mamm… Reeves's m… mamm… arti… cervi… munt… reevesi telemetry*    <NA> 
##  8 mamm… mule deer   mamm… arti… cervi… odoc… hemion… telemetry*    <NA> 
##  9 mamm… white-tail… mamm… arti… cervi… odoc… virgin… telemetry*    <NA> 
## 10 mamm… pampas deer mamm… arti… cervi… ozot… bezoar… telemetry*    <NA> 
## 11 mamm… pudu        mamm… arti… cervi… pudu  puda    telemetry*    <NA> 
## 12 mamm… reindeer    mamm… arti… cervi… rang… tarand… telemetry*    <NA> 
## # … with 15 more variables: mean.mass.g <dbl>, log10.mass <dbl>,
## #   alternative.mass.reference <chr>, mean.hra.m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic.guild <chr>, dimension <chr>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```

```r
deer_frame <- select(deer_frame, "family", "genus", "species", "mean.mass.g", "log10.mass")
deer_frame
```

```
## # A tibble: 12 x 5
##    family   genus      species     mean.mass.g log10.mass
##    <chr>    <chr>      <chr>             <dbl>      <dbl>
##  1 cervidae alces      alces           307227.       5.49
##  2 cervidae axis       axis             62823.       4.80
##  3 cervidae capreolus  capreolus        24050.       4.38
##  4 cervidae cervus     elaphus         234758.       5.37
##  5 cervidae cervus     nippon           29450.       4.47
##  6 cervidae dama       dama             71450.       4.85
##  7 cervidae muntiacus  reevesi          13500.       4.13
##  8 cervidae odocoileus hemionus         53864.       4.73
##  9 cervidae odocoileus virginianus      87884.       4.94
## 10 cervidae ozotoceros bezoarticus      35000.       4.54
## 11 cervidae pudu       puda              7500.       3.88
## 12 cervidae rangifer   tarandus        102059.       5.01
```

```r
arrange(deer_frame, desc(log10.mass))
```

```
## # A tibble: 12 x 5
##    family   genus      species     mean.mass.g log10.mass
##    <chr>    <chr>      <chr>             <dbl>      <dbl>
##  1 cervidae alces      alces           307227.       5.49
##  2 cervidae cervus     elaphus         234758.       5.37
##  3 cervidae rangifer   tarandus        102059.       5.01
##  4 cervidae odocoileus virginianus      87884.       4.94
##  5 cervidae dama       dama             71450.       4.85
##  6 cervidae axis       axis             62823.       4.80
##  7 cervidae odocoileus hemionus         53864.       4.73
##  8 cervidae ozotoceros bezoarticus      35000.       4.54
##  9 cervidae cervus     nippon           29450.       4.47
## 10 cervidae capreolus  capreolus        24050.       4.38
## 11 cervidae muntiacus  reevesi          13500.       4.13
## 12 cervidae pudu       puda              7500.       3.88
```
When sorting the data in descending order via the `arrange()` function, the deer Alces alces comes up as the largest. This is commonly known as the moose.

**10. As measured by the data, which snake species has the smallest homerange? Show all of your work, please. Look this species up online and tell me about it!** **Snake is found in taxon column**

```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```

```r
snakes <- select(homerange, "taxon", "family", "genus", "species", "common.name", "mean.hra.m2")
snakes
```

```
## # A tibble: 569 x 6
##    taxon       family      genus     species    common.name          mean.hra.m2
##    <fct>       <chr>       <chr>     <chr>      <chr>                      <dbl>
##  1 lake fishes anguillidae anguilla  rostrata   american eel            282750  
##  2 river fish… catostomid… moxostoma poecilura  blacktail redhorse         282. 
##  3 river fish… cyprinidae  camposto… anomalum   central stoneroller        116. 
##  4 river fish… cyprinidae  clinosto… funduloid… rosyside dace              126. 
##  5 river fish… cyprinidae  rhinicht… cataractae longnose dace               87.1
##  6 river fish… esocidae    esox      masquinon… muskellunge              39344. 
##  7 marine fis… gadidae     pollachi… pollachius pollack                   9056. 
##  8 marine fis… gadidae     pollachi… virens     saithe                   44516. 
##  9 marine fis… acanthurid… acanthur… lineatus   lined surgeonfish           11.1
## 10 marine fis… acanthurid… naso      lituratus  orangespine unicorn…     32093. 
## # … with 559 more rows
```

```r
snakes <- filter(snakes, taxon == "snakes")
snakes
```

```
## # A tibble: 41 x 6
##    taxon  family    genus     species             common.name        mean.hra.m2
##    <fct>  <chr>     <chr>     <chr>               <chr>                    <dbl>
##  1 snakes colubrid… carphopis vermis              western worm snake         700
##  2 snakes colubrid… carphopis viridis             eastern worm snake         253
##  3 snakes colubrid… coluber   constrictor         racer                   151000
##  4 snakes colubrid… coluber   constrictor flaviv… yellow bellied ra…      114500
##  5 snakes colubrid… diadophis punctatus           ringneck snake            6476
##  6 snakes colubrid… drymarch… couperi             eastern indigo sn…     1853000
##  7 snakes colubrid… elaphe    guttata emoryi      great plains rats…      150600
##  8 snakes colubrid… elaphe    obsoleta            western ratsnake         46000
##  9 snakes colubrid… heterodon platirhinos         hognose snake           516375
## 10 snakes colubrid… hierophis viridiflavus        European whipsnake      110900
## # … with 31 more rows
```

```r
arrange(snakes, mean.hra.m2)
```

```
## # A tibble: 41 x 6
##    taxon  family     genus       species      common.name          mean.hra.m2
##    <fct>  <chr>      <chr>       <chr>        <chr>                      <dbl>
##  1 snakes viperidae  bitis       schneideri   namaqua dwarf adder         200 
##  2 snakes colubridae carphopis   viridis      eastern worm snake          253 
##  3 snakes colubridae thamnophis  butleri      butlers garter snake        600 
##  4 snakes colubridae carphopis   vermis       western worm snake          700 
##  5 snakes viperidae  vipera      latastei     snubnosed viper            2400 
##  6 snakes viperidae  gloydius    shedaoensis  chinese pit viper          2614.
##  7 snakes colubridae diadophis   punctatus    ringneck snake             6476 
##  8 snakes viperidae  agkistrodon piscivorous  cottonmouth               10655 
##  9 snakes colubridae oocatochus  rufodorsatus redbacked ratsnake        15400 
## 10 snakes colubridae pituophis   catenifer    gopher snake              17400 
## # … with 31 more rows
```
It looks like the namaqua dwarf adder, or Bitis schneideri, has the smallest mean homerange (m2) at 200 m2. According to the African Snake Bite Institute, this is the smallest adder in the world at only 20cm! It is found in a small sliver of coastal dunes in Namaqualand and southern Namibia, which explains their small homerange. It is under the "Vulnerable" conservation because of habitat destruction and illegal capture in the pet trade. Their bite is mildly cytotoxic and causes pain/swelling. Antivenom won't work in treating it.

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
