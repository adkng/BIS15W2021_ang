---
title: "coding cheat sheet for data matrices"
output: 
  html_document: 
    keep_md: yes
---
### Getting Set-Up
Make sure your workspace is set up. Check your working directory.

```r
getwd()
```

```
## [1] "/Users/adriannang98/Desktop/BIS15W2021_ang/class_resources"
```

# Data Matrices
## What Are They?
Data matrices are a series of stacked vectors, similar to a data table. For example, we can make a data matrix of box office earnings for Harry Potter movies (in millions!). Notice that these are separate vectors for earnings in dollars (US versus INTL).  

First, we have to create our separate vectors in our environment.

```r
Philosophers_Stone <- c(317.5, 657.1)
Chamber_of_Secrets <- c(261.9, 616.9)
Prisoner_of_Azkaban <- c(249.5, 547.1)
Goblet_of_Fire <- c(290.0, 606.8)
Order_of_the_Phoenix <- c(292.0, 647.8)
Half_Blood_Prince <- c(301.9, 632.4)
Deathly_Hallows_1 <- c(295.9, 664.3)
Deathly_Hallows_2 <- c(381.0, 960.5)
```

Now, we can "stack" all these vectors into an object called `box office`.

```r
box_office <- c(Philosophers_Stone, Chamber_of_Secrets, Prisoner_of_Azkaban, Goblet_of_Fire, Order_of_the_Phoenix, Half_Blood_Prince, Deathly_Hallows_1, Deathly_Hallows_2)
```

## Making a Matrix
Create `harry_potter_matrix` using the `matrix()` command. We need to tell R how to organize the `box_office` vector using the `nrow` and `byrow` commands.

## Setting Up a Matrix
Using the matrix command, we want it to be arranged by row. We know we will have 8 rows, because there are 8 movies. Note that we there is no command to arrange it by column.

```r
harry_potter_matrix <- matrix(box_office, nrow = 8, byrow = T)
harry_potter_matrix
```

```
##       [,1]  [,2]
## [1,] 317.5 657.1
## [2,] 261.9 616.9
## [3,] 249.5 547.1
## [4,] 290.0 606.8
## [5,] 292.0 647.8
## [6,] 301.9 632.4
## [7,] 295.9 664.3
## [8,] 381.0 960.5
```
The brackets are calling specific points in our vector. [1, _] is our first value in the first row. [_,1] is our first value in the first column.

## Naming the Matrix
We should really name the rows and columns, so we know what we are looking at if we decide to take a break. You can use vectors to name them!

```r
region <- c("US", "non-US")
region
```

```
## [1] "US"     "non-US"
```

```r
titles <- c("Philosophers_Stone", "Chamber_of_Secrets", "Prisoner_of_Azkaban", "Goblet_of_Fire", "Order_of_the_Phoenix", "Half_Blood_Prince", "Deathly_Hallows_1", "Deathly_Hallows_2")
titles
```

```
## [1] "Philosophers_Stone"   "Chamber_of_Secrets"   "Prisoner_of_Azkaban" 
## [4] "Goblet_of_Fire"       "Order_of_the_Phoenix" "Half_Blood_Prince"   
## [7] "Deathly_Hallows_1"    "Deathly_Hallows_2"
```
Name the columns using `colnames()` with the vector region.

```r
colnames(harry_potter_matrix) <- region
```
Name the rows using `rownames()` with the vector titles.

```r
rownames(harry_potter_matrix) <- titles
```
Now, print the matrix!

```r
harry_potter_matrix
```

```
##                         US non-US
## Philosophers_Stone   317.5  657.1
## Chamber_of_Secrets   261.9  616.9
## Prisoner_of_Azkaban  249.5  547.1
## Goblet_of_Fire       290.0  606.8
## Order_of_the_Phoenix 292.0  647.8
## Half_Blood_Prince    301.9  632.4
## Deathly_Hallows_1    295.9  664.3
## Deathly_Hallows_2    381.0  960.5
```
So pretty.

## Using a Data Matrix
You can use your data matrix to perform many different analyses.
For example, how much did each movie make globally?

```r
global <- rowSums(harry_potter_matrix)
global
```

```
##   Philosophers_Stone   Chamber_of_Secrets  Prisoner_of_Azkaban 
##                974.6                878.8                796.6 
##       Goblet_of_Fire Order_of_the_Phoenix    Half_Blood_Prince 
##                896.8                939.8                934.3 
##    Deathly_Hallows_1    Deathly_Hallows_2 
##                960.2               1341.5
```
We used the `rowSums()` function because we wanted to add the US and non-US earnings together to get the global earnings.
Cool, what were the total earnings for all movies in the US and non-US?

```r
total_earnings <- colSums(harry_potter_matrix)
total_earnings
```

```
##     US non-US 
## 2389.7 5332.9
```
We used the `colSums()` function because we wanted to add all the US earnings together, and all the non-US earnings together.

Now that we have the global total and total earnings, we can add it to the existing matrix!
We can add a new column or row to reflect this calculation. 

`cbind()` adds columns.

```r
all_harry_potter_matrix <- cbind(harry_potter_matrix, global)
all_harry_potter_matrix
```

```
##                         US non-US global
## Philosophers_Stone   317.5  657.1  974.6
## Chamber_of_Secrets   261.9  616.9  878.8
## Prisoner_of_Azkaban  249.5  547.1  796.6
## Goblet_of_Fire       290.0  606.8  896.8
## Order_of_the_Phoenix 292.0  647.8  939.8
## Half_Blood_Prince    301.9  632.4  934.3
## Deathly_Hallows_1    295.9  664.3  960.2
## Deathly_Hallows_2    381.0  960.5 1341.5
```
'rbind()' adds rows.

```r
all_harry_potter_matrix_2 <- rbind(all_harry_potter_matrix, total_earnings)
```

```
## Warning in rbind(all_harry_potter_matrix, total_earnings): number of columns of
## result is not a multiple of vector length (arg 2)
```

```r
all_harry_potter_matrix_2
```

```
##                          US non-US global
## Philosophers_Stone    317.5  657.1  974.6
## Chamber_of_Secrets    261.9  616.9  878.8
## Prisoner_of_Azkaban   249.5  547.1  796.6
## Goblet_of_Fire        290.0  606.8  896.8
## Order_of_the_Phoenix  292.0  647.8  939.8
## Half_Blood_Prince     301.9  632.4  934.3
## Deathly_Hallows_1     295.9  664.3  960.2
## Deathly_Hallows_2     381.0  960.5 1341.5
## total_earnings       2389.7 5332.9 2389.7
```

## Selecting Elements in a Data Matrix

The same methods of selecting elements in a vector apply to data matrices. We use `[]`. The following selects the value in the first column, second row.

```r
harry_potter_matrix[2,1]
```

```
## [1] 261.9
```

Adding a colon `:` selects the specified elements in a column.  

```r
harry_potter_matrix[1:4]
```

```
## [1] 317.5 261.9 249.5 290.0
```

We can also select values in an entire row or column. This can be useful for calculations. Here we calculate the mean of the entire second column. 

```r
non_us_earnings <- all_harry_potter_matrix[ ,2]
mean(non_us_earnings)
```

```
## [1] 666.6125
```
