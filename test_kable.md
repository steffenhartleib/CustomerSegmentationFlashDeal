# Testing Kable Display 
Steffen Hartleib  
`r format(Sys.Date())`  




```r
n <- 100
x <- rnorm(n)
y <- 2*x + rnorm(n)
out <- lm(y ~ x)
library(knitr)
kable(summary(out)$coef, digits=2)
```

               Estimate   Std. Error   t value   Pr(>|t|)
------------  ---------  -----------  --------  ---------
(Intercept)       -0.02         0.09     -0.25       0.81
x                  2.03         0.09     22.41       0.00
