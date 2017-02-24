# Testing Kable Display 
Steffen Hartleib  
`r format(Sys.Date())`  




```r
options(knitr.table.format = 'markdown')
n <- 100
x <- rnorm(n)
y <- 2*x + rnorm(n)
out <- lm(y ~ x)
library(knitr)
kable(summary(out)$coef, digits=2)
```



|            | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:-----------|--------:|----------:|-------:|------------------:|
|(Intercept) |    -0.17|       0.09|   -1.77|               0.08|
|x           |     1.84|       0.09|   19.47|               0.00|
