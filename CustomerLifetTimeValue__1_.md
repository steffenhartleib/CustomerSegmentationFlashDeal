# Customer Segmentation and Life Time Value for Flash Deal Site 
Steffen Hartleib  
`r format(Sys.Date())`  

### The Data Set

##### Online purchase data from 2010 to 2016
##### 553087 observations (line items), 19 variables

### Questions
##### 1. Which customer segments are driving revenue? 
##### 2. What is the  average life time value of a customer?

***

### Let's look at year over year revenue and customer trends


```
## [1] TRUE
```

![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-1-1.png)<!-- -->![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-1-2.png)<!-- -->![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-1-3.png)<!-- -->![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-1-4.png)<!-- -->![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-1-5.png)<!-- -->


##### In 2016 the number of customers increased significantly. But Total Revenue rose only slightly. Because, on average, customer placed fewer orders and spent less per order. This is pattern is typical for customer acquistion campaigns driven by discounts. The challenge will be to convert these new customers from bargain shoppers to valuable long term customers.
##### Let's segement the customers to see what's behind these trends.
&nbsp;


***

### Simple Customer Segmentation by Recency, Frequency and Monetary Value (RFM) 
##### We need to calculate three variables per customer:
##### 1. Recency: Number of days since the last purchase
##### 2. Frequency:  Number of orders placed, life to date
##### 3. LTD Revenue: Product Revenue net of discounts life to date
&nbsp;

#### Here are the summary statistics of each variable: 





```
##         Recency LTD.Revenue No.of.Purchases
## Minimum       0           1               1
## Average   1,042         224               3
## Median    1,115          70               1
## Max       2,292     222,182           2,863
```

##### Look at LTD Revenue! The mean is over three times the median. And one customer spent over $200k. Clearly a few high rolers are pulling up the the average. (A bit like Bill Gates sitting down at your neighborhood bar...)
&nbsp;

***

### Let's define our customer segements as follows. I'm using round numbers since this is a managerial analysis.
 
Segment        | Recency                | LTD Revenue  
-------------  | ---------------------  | -------------  
 Active New    | 1st purchase last year | 
 Active Low    | purchase last year     | < $100
 Active Med    | purchase last year     | >= $100 & < $1000
 Activ High    | purchase last year     | > $1000
 Inactive Low  | no purchase last year  | < $100
 Inactive Med  | no purchase last year  | >= $100 & < $1000
 Inactive High | no purchase last year  | > $1000

&nbsp;

***
   
### Summary of the segments:  



Segments         Customers   Perc of Cust   Rev. LTD   Rev 2016   Perc Tl Rev 2016
--------------  ----------  -------------  ---------  ---------  -----------------
active new           18621           0.18    1410602    1410602               0.48
active high           1719           0.02    5432010     950284               0.32
active med            4420           0.04    1813677     576158               0.20
active low             538           0.01      38624      16103               0.01
inactive high         2008           0.02    4770592          0               0.00
inactive med         29617           0.28    7817822          0               0.00
inactive low         48892           0.46    2371343          0               0.00

##### How neat, a perfect 80/20: In 2016 80% of revenue came from exactly 20% of customers (New Active +  Active High). 52% of revenue came from just 6% of customers (Active High + Active Medium). And 32% of revenue came from the top 2% of customers (Active High).  This site has some seriously loyal high rollers. Great!



&nbsp;

***

### Here is how the customer segments changed over time:



![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-6-1.png)<!-- -->

##### Active New customers more than doubled last year. Active High/Med/Low segments stayed almost flat. So customer acquisition efforts are paying off and customer retention is working. The challenge will be to retain these new active customers, and to convert them to higher priced offers.
&nbsp;


### Here is how revenue per segment stacks up, over time:




![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-8-1.png)<!-- -->

##### New Active customers drove the increase in revenue. 


 


# &nbsp;

***

## What's the value of the current data base? 
##### This isn't the same as Customer Life Time Value (CLV). CLV tells us how much a customer spends on average in her lifetime. That's very usefull to determine how much can we spend to acquire a new customer. Here we're asking how much more revenue can we expect from the customers in the data base. 




***

###  Let's make a Transition Matrix
##### It shows the probabilities of customers changing segments between 2015 and 2016, e.g. how many "Active High" customers in 2015 were also Active High customers in 2016? etc. (the answer is 67%, not bad!)


                 active new   active high   active med   active low   inactive high   inactive med   inactive low
--------------  -----------  ------------  -----------  -----------  --------------  -------------  -------------
active new                0          0.02         0.16         0.04            0.00           0.24           0.54
active high               0          0.67         0.00         0.00            0.33           0.00           0.00
active med                0          0.06         0.34         0.00            0.00           0.60           0.00
active low                0          0.00         0.19         0.06            0.00           0.00           0.75
inactive high             0          0.09         0.00         0.00            0.91           0.00           0.00
inactive med              0          0.00         0.04         0.00            0.00           0.95           0.00
inactive low              0          0.00         0.01         0.01            0.00           0.00           0.98
***
&nbsp;

### Let's quickly visualize where last year's New Active customers ended up: 

![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-13-1.png)<!-- -->

#### 22% of New Active customers are still Active the next year. Most of them are in the Active Medium segment. Curious to see what next year will look like...
&nbsp;

***

### How do we forecast the size of each segment over the next 5 years?

##### Let's assume customers will continue to transition from segment to segment in the same proportions as the did from 2015 to 2016. That way we can mulitply this year's segments by the transition matrix to predict next year's segments. Then we'll multiply next year's (forecasted) segments by the same transition matrix to the get the following year. And so on.
&nbsp;



```
##                2016  2017  2018  2019  2020  2021
## active new    18621     0     0     0     0     0
## active high    1719  1970  1911  1797  1713  1671
## active med     4420  6258  4362  3680  3464  3395
## active low      538  1266   660   621   612   605
## inactive high  2008  2395  2829  3205  3510  3759
## inactive med  29617 35257 37249 38004 38312 38475
## inactive low  48892 58373 58155 57487 56803 56126
```

***

### Now we can forecast revenue per segment for the next 5 years
#####(assuming that, on average, revenue per segment stays the same)


&nbsp;

***

![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-16-1.png)<!-- -->

***

![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-17-1.png)<!-- -->

***





![](CustomerLifetTimeValue__1__files/figure-html/unnamed-chunk-20-1.png)<!-- -->

#### Total net present value of the data base in 2020 is:

                    2020      
------------------  ----------
Net Present Value   6,593,739 

### And let's add the Customer Life Time Value

       Customer Life Time Value   Total Net Present Value of Data Base 
-----  -------------------------  -------------------------------------
2021   62.31                      6,593,739                            




