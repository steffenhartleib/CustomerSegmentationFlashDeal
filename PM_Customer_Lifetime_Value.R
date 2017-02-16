# //////////////////////////////////////////////////////////////

# _________________CUSTOMER LIFE TIME VALUE______________________

# ////////////////////////////////////////////////////////////////
scipen = 11
library(dplyr)



data = read.csv("data/PopMarketOrders.txt", header = FALSE, stringsAsFactors = FALSE)

data_1 = data[,c('V1','V6','V9')]
# column names
colnames(data_1) = c('email','amount','purchase_date')
# fix date
data_1$purchase_date = as.Date(data_1$purchase_date, '%Y-%m-%d')
# add purchase year colum
data_1$purchase_year = as.numeric(format(data_1$purchase_date,'%Y'))
# max purchase date
max(data_1$purchase_date)
# add recency column
data_1$days_since = as.numeric(difftime(time1 = '2016-01-29',
                                        time2 = data_1$purchase_date,
                                        units ='days'))


customers_2015 = select(data_1, email, amount, purchase_year,days_since)%>%
                 group_by(email)%>%
                 summarize(avg_amount = mean(amount),
                           tl_rev = sum(amount),
                           recency = min(days_since),
                           first_purchase = max(days_since),
                           frequency = n())

summary(customers_2015)
data_1[which(data_1$email == '000todd@gmail.com'),]
customers_2015[which(customers_2015$email == '000todd@gmail.com'),]


# Popmarket Segments

# active high => purchased last year > 1000
# active med =>  purchased last year  100 and 1000
# active low => purchases last year < 100
# inactive high
# inactive medium
# inactive low

# 2015 PopMarket Segments

customers_2015$segment = 'NA'
customers_2015$segment[which(customers_2015$recency > 365*1)] = 'inactive'
customers_2015$segment[which(customers_2015$recency <= 365*1)] = 'active'
table(customers_2015$segment)

customers_2015$segment[which(customers_2015$segment == 'active' & customers_2015$first_purchase < 365)] = 'active new'
customers_2015$segment[which(customers_2015$segment == 'active' & customers_2015$tl_rev < 100) ] = 'active low'
customers_2015$segment[which(customers_2015$segment == 'active' & customers_2015$tl_rev >= 100) ] = 'active med'  ####
customers_2015$segment[which(customers_2015$segment == 'active med' & customers_2015$tl_rev >= 1000) ] = 'active high'

customers_2015$segment[which(customers_2015$segment == 'inactive' & customers_2015$tl_rev < 100)] = 'inactive low'
customers_2015$segment[which(customers_2015$segment == 'inactive' & customers_2015$tl_rev >= 100)] = 'inactive med'
customers_2015$segment[which(customers_2015$segment == 'inactive med' & customers_2015$tl_rev >= 1000)] = 'inactive high'
table(customers_2015$segment)
 

customers_2015$segment  = factor(x = customers_2015$segment, levels = c('active new', 'active high','active med', 'active low',
                                                                        'inactive high', 'inactive med', 'inactive low'))

str(customers_2015)

segments_2015 = select(customers_2015, segment)%>%
                group_by(segment)%>%
                summarize(Customers = n(),
                          PercOfTotal = round(Customers/length(customers_2015$segment),2))
print(segments_2015)


# 2014 Customer Segments i.e. excluding all purchases made up until a year ago (then same analysis as above)

customers_2014 = select(data_1, email, amount, purchase_year,days_since)%>%
        filter(days_since  > 365)%>%  # remove all purchases made mode in the last year 
        group_by(email)%>%
        summarize(avg_amount = mean(amount),
                  tl_rev = sum(amount),
                  recency = min(days_since),
                  first_purchase = max(days_since),
                  frequency = n())

summary(customers_2015)
data_1[which(data_1$email == '000todd@gmail.com'),]
customers_2015[which(customers_2015$email == '000todd@gmail.com'),]

head(customers_2014)

# segment 2014 data
customers_2014$segment = 'NA'
customers_2014$segment[which(customers_2014$recency > 365*2)] = 'inactive'
customers_2014$segment[which(customers_2014$recency <= 365*2)] = 'active'
table(customers_2014$segment)

customers_2014$segment[which(customers_2014$segment == 'active' & customers_2014$first_purchase < 365*2)] = 'active new'
customers_2014$segment[which(customers_2014$segment == 'active' & customers_2014$tl_rev < 100) ] = 'active low'
customers_2014$segment[which(customers_2014$segment == 'active' & customers_2014$tl_rev >= 100) ] = 'active med'  ####
customers_2014$segment[which(customers_2014$segment == 'active med' & customers_2014$tl_rev >= 1000) ] = 'active high'

customers_2014$segment[which(customers_2014$segment == 'inactive' & customers_2014$tl_rev < 100)] = 'inactive low'
customers_2014$segment[which(customers_2014$segment == 'inactive' & customers_2014$tl_rev >= 100)] = 'inactive med'
customers_2014$segment[which(customers_2014$segment == 'inactive med' & customers_2014$tl_rev >= 1000)] = 'inactive high'
table(customers_2014$segment)


customers_2014$segment  = factor(x = customers_2014$segment, levels = c('active new', 'active high','active med', 'active low',
                                                                        'inactive high', 'inactive med', 'inactive low'))

segments_2014 = select(customers_2014, segment)%>%
        group_by(segment)%>%
        summarize(Customers = n(),
                  PercOfTotal = round(Customers/length(customers_2014$segment),2))
print(segments_2014)


# 2013 Customer Segments i.e. excluding all purchases made up until a year ago (then same analysis as above)

customers_2013 = select(data_1, email, amount, purchase_year,days_since)%>%
        filter(days_since  > 365*2)%>%  # remove all purchases made mode in the last 2 years
        group_by(email)%>%
        summarize(avg_amount = mean(amount),
                  tl_rev = sum(amount),
                  recency = min(days_since),
                  first_purchase = max(days_since),
                  frequency = n())

summary(customers_2013)
data_1[which(data_1$email == '000todd@gmail.com'),]
customers_2013[which(customers_2015$email == '000todd@gmail.com'),]

head(customers_2013)


# segment 2013 data
customers_2013$segment = 'NA'
customers_2013$segment[which(customers_2013$recency > 365*3)] = 'inactive'
customers_2013$segment[which(customers_2013$recency <= 365*3)] = 'active'
table(customers_2013$segment)

customers_2013$segment[which(customers_2013$segment == 'active' & customers_2013$first_purchase < 365*3)] = 'active new'
customers_2013$segment[which(customers_2013$segment == 'active' & customers_2013$tl_rev < 100) ] = 'active low'
customers_2013$segment[which(customers_2013$segment == 'active' & customers_2013$tl_rev >= 100) ] = 'active med'  ####
customers_2013$segment[which(customers_2013$segment == 'active med' & customers_2013$tl_rev >= 1000) ] = 'active high'

customers_2013$segment[which(customers_2013$segment == 'inactive' & customers_2013$tl_rev < 100)] = 'inactive low'
customers_2013$segment[which(customers_2013$segment == 'inactive' & customers_2013$tl_rev >= 100)] = 'inactive med'
customers_2013$segment[which(customers_2013$segment == 'inactive med' & customers_2013$tl_rev >= 1000)] = 'inactive high'
table(customers_2013$segment)


customers_2013$segment  = factor(x = customers_2013$segment, levels = c('active new', 'active high','active med', 'active low',
                                                                        'inactive high', 'inactive med', 'inactive low'))

segments_2013 = select(customers_2013, segment)%>%
        group_by(segment)%>%
        summarize(Customers = n(),
                  PercOfTotal = round(Customers/length(customers_2013$segment),2))
print(segments_2013)
print(segments_2014)
print(segments_2015)


# make table to compare segments per year
segments_all = cbind(segments_2013,segments_2014,segments_2015)
segments_all
segments_all[,4] = NULL
segments_all[,6] = NULL
colnames(segments_all) = c('Segment', 'Cust_2013', 'Perc_2013', 'Cust_2014', 'Perc_2014', 'Cust_2015', 'Perc_2015')
segments_all

# plot
library(reshape2)
segments_all
seg_all_val = select(segments_all,Segment, Cust_2013, Cust_2014, Cust_2015)
colnames(seg_all_val) = c('Segment', '2013','2014','2015')
segments_all_long = melt(seg_all_val, value.name  = 'Customers')
segments_all_long



# total customers per segement per year
segments_tl = colSums(segments_all[,2:7])
#segments_tl = rbind(segments_all, segments_tl)
print(segments_tl)
str(segments_all)


# ----------COMPUTE TRANSITION MATRIX------------------------

new_data = merge(x = customers_2014, y = customers_2015, by = 'email', all.x = TRUE)


transition = table(new_data$segment.x, new_data$segment.y)
print(transition)
transition = transition / rowSums(transition)
print(transition)


# initialize a matrix with the number of customers in each segment today and after 10 periods

segments = matrix(nrow = 7, ncol = 6)
segments[,1] = table(customers_2015$segment)
colnames(segments) = 2015:2020
rownames(segments) = levels(customers_2015$segment)
dim(segments)
transition
segments[,1]
segments

# compute for every period

for (i in 2:11) {
        segments[,i] =  segments[,i-1] %*% transition
}

segments[,2] = segments[,1] %*% transition
segments[,1]%*% transition

print(round(segments))

# ________________COMPUTE REVENUE_________________

# get average revenue per customer in each segement in 2015

# revenue per customer for PURCHASES in 2015
rev_2015 = filter(data_1, days_since <= 365)%>%
        select(email,amount)%>%
        group_by(email)%>%
        summarize(rev_2015 = sum(amount))%>%
        arrange(desc(rev_2015))

 # join with table of all customers (not everyone in every segment purchased in 2015)
actual = merge(customers_2015,rev_2015, all.x = TRUE, by = 'email')
actual$rev_2015[is.na(actual$rev_2015)] = 0
str(actual)
head(customers_2015)

# average rev per customer in each segment
rev_2015_segment = select(actual, rev_2015, segment)%>%
                   group_by(segment)%>%
                   summarize(avg_rev = mean(rev_2015))

print(rev_2015_segment)

yearly_revenue = rev_2015_segment$avg_rev

revenue_per_segment = yearly_revenue * segments
revenue_per_segment

#Compute yearly revenue

yearly_revenue = colSums(revenue_per_segment)
print(round(yearly_revenue))
barplot(yearly_revenue)

#Compute cumulative revenue
cumulative_revenue = cumsum(yearly_revenue)
print(round(cumulative_revenue))
barplot(cumulative_revenue)

#create discount factor
discount_rate = .1
discount = 1 / (1 + discount_rate) ^ ((1:6)-1)
discount

# compute yearly discounted revenue

disc_yearly_revenue = discount * yearly_revenue
print(round(disc_yearly_revenue))
barplot(disc_yearly_revenue)
lines(yearly_revenue)

# compute discounted cumulative revenue

disc_cumulative_revenue = cumsum(disc_yearly_revenue)
print(round(disc_cumulative_revenue))
barplot(disc_cumulative_revenue)

# what is the data base worth?

print(disc_cumulative_revenue[6] - disc_cumulative_revenue[1])

# Customer Life Time value

(disc_cumulative_revenue[6] - disc_cumulative_revenue[1])/dim(customers_2015)[1]



