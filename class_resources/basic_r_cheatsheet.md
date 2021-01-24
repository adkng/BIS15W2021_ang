---
title: "basic r cheatsheet"
output: 
  html_document: 
    keep_md: yes
---

### Base R
We probably aren't going to come back to it now that we use things like the tidyverse, but it's still good to know. However, there are still important concepts!

## Basic Arithmetic
We have data... cool! Remember the following if you want to do basic arithmetic in R...

1. R follows PEMDAS, so format your math accordingly.

2. `+` is for addition, `-` is for subtraction.

3. `*` is for multiplication, `/` is for divison.

4. `**` is for exponents.

5. You can take the `mean()` or `median()` of your data, as long as it is in an object!

## Operators
1. < > denote less than or greater than.

2. <= >= denote less than or equal to; greater than or equal to.

3. == denotes equal to.

4. != denotes not equal to.

### Types of Data
## Classes
These are the main five `classes` of data in R.

```r
my_numeric <- 42
my_integer <- 2L
my_character <- "universe"
my_logical <- FALSE
my_complex <- 2+4i
```

If you don't know the type of class your data falls under, just use the `class()` function. It will return the class type.
You can use the `is()` function to clarify what type of class type your data is -- this returns a `TRUE` or `FALSE`.

```r
is.integer(my_character)
```

```
## [1] FALSE
```

```r
is.integer(my_integer)
```

```
## [1] TRUE
```

The `as()` function is good for specifying your data from one class to another.

```r
my_integer <- as.integer(my_numeric)
```

## Vectors
Vectors are a way of organizing data in R, using the `c` command ("concatenate").

```r
my_data <- c(10, 20, 30, 40, 50, NA, 60, 70, 80, 90, 100)
```
`my_data` is a numeric vector.

```r
my_days <- c("Monday", "Tuesday", "Wednesday")
```
`my_days` is a character vector as denoted by the "strings".

# Identifying Vector Elements
Use `[]` to pull elements out of a vector, as long as we specify their position.

```r
my_days[1]
```

```
## [1] "Monday"
```


## Missing Data
When you are missing data, R designates it as the NA. There are two ways to find out if and where NAs are in your data.
The `is.na` function is useful in telling you where exactly the NA occurs.

```r
is.na(my_data)
```

```
##  [1] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
```

The `anyNA` function is useful for a simple `TRUE` or `FALSE` about whether NAs exist in your data.

```r
anyNA(my_data)
```

```
## [1] TRUE
```

When working with NAs, you may find the need to take them out. Use `na.rm = T` to take them out.

```r
mean(my_data)
```

```
## [1] NA
```
Watch this.

```r
mean(my_data, na.rm =T)
```

```
## [1] 55
```
All good!

## Writing Data to File
We can save things like dataframes to work with later. If we want to write it to a .csv, use:

```r
write.csv(my_data, "my_data.csv", row.names = FALSE)
```
The `row.names = FALSE` functions to prevent row numbers from printing out.
