






This file contains the same code as the file "myScript.R", but in the format of a simple R Notebook.

## Generate data


```r
x <- rnorm(100)
```

## Calculate mean


```r
mean(x)
```

```
## [1] -0.05095916
```

## Histogram


```r
hist(x)
```

<img src="08-Week08_files/figure-html/unnamed-chunk-54-1.png" width="672" />

## Normal probability plot


```r
qqnorm(x)
```

<img src="08-Week08_files/figure-html/unnamed-chunk-55-1.png" width="672" />


