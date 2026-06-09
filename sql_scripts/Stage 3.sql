#Question 1
# Q1: How does property pricing vary across different cities over time?
#Understanding property price trends over time allows us to identify market growth,
#downturns, or stabilization periods. A historical analysis of listing prices can reveal patterns
#related to economic cycles, policy changes, or shifts in demand.

# Using where function to isolate the years and average function to calculate average listing price per city
# Using group by om Year and City we get the desired output

select
	Year,
    City,
    round(avg(Avg_Home_Price),2) as Avg_Listing_Price
from market_trends
where Year between 2019 and 2023
group by
	Year,
    City
order by
	Year,
    city;
    
# Using cte and average function we find avg listing price per year, also grouping them by year gives us a list
# Using windows function and lag function we get the percent change and desired table
with cte as(
select
	Year,
    round(avg(Avg_Home_Price),2) as Avg_Listing_Price
from market_trends
where Year between 2019 and 2023
group by
	Year
)
select
	concat(Year - 1 , '-', Year) as Year_range,
    round((((Avg_Listing_Price) - (lag(Avg_Listing_Price) over ( order by Year))) / lag(Avg_Listing_Price) over ( order by Year))*100,2) as Percent_Change
from cte;

#Question 2
#Q2:How does property pricing vary across different cities over time?
#Understanding how congestion changes over time allows city planners to predict demand
#fluctuations and optimize road usage policies, public transport schedules, and infrastructure
#investments.

#Very similar to the prevous problem using average price and price change, also suing group by to get the yearly numbers
with cte as(
select
	Year,
    City,
    round(avg(Avg_Home_Price),2) as Current_Price
from market_trends
group by
	Year,
    City
order by
	city
)
select
	Year,
    City,
    Current_Price,
    round((Current_Price - lag(Current_Price) over (partition by city order by year))/(lag(Current_Price) over (partition by city order by year))*100,2) as Price_change_percentage
from cte;

# Using union all, max and min function we get the desired output
with cte as(
select
	Year,
    City,
    round(avg(avg_home_price),2) as Current_Price
from market_trends
group by
	Year,
    City
)
(
select
	'Highest Property Values' as 'Property Values',
    Year,
    City
from cte
order by 
	Current_Price desc
limit 1
)
union all
(
select
	'Lowest Property Values' as 'Property Values',
    Year,
    City
from cte
order by 
	Current_Price asc
limit 1
);

update properties_transactions
Set Type = 'Other'
where type is null;

commit;

#Question 3
# How do property prices vary by property type?
#Different property types—such as apartments, townhouses, and single-family homes—have
#varying price trends due to differences in buyer demand, maintenance costs, and availability.
#Understanding these trends helps in pricing and investment decisions

# Using average on listing price and grouping data on type of house give us the output
select
	Type,
    round(avg(Listing_Price),2) as Avg_Listing_Price
from properties_transactions
group by
	Type
order by
	Avg_Listing_Price desc;

#Question 4    
#Which property types are most frequently listed, and how does listing
#volume vary across cities?
#Traffic congestion patterns shift based on work schedules, leisure activities, and city events.
#Understanding how weekday vs. weekend traffic varies helps adjust transport availability,
#allocate traffic police, and optimize road closures or rerouting strategies.

select
	Type,
    City,
    count(Property_ID) as Listings_count
from properties_transactions
group by
	Type,
    City
order by
	Listings_count desc;

#Question 5    
#Q5: How do interest rate changes impact property prices?
#Interest rates directly affect mortgage affordability, influencing buyer behavior and property
#pricing. Understanding how price movements align with interest rate fluctuations can help
#predict market trends.

with cte as(
select
	Interest_Rate,
    round(avg(Avg_Home_Price),2) as Avg_Listing_Price
from market_trends
group by
	Interest_Rate
order by
	Interest_Rate
)
select
	Interest_Rate,
    Avg_Listing_Price,
    round((Avg_Listing_Price - lag(Avg_Listing_Price) over ( order by Interest_Rate))/(lag(Avg_Listing_Price) over ( order by Interest_Rate))*100,2) as Percent_Change
from cte;