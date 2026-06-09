# Question 1
#Q1: Which years saw the highest number of new property developments?
#New property developments indicate market growth and expansion. Understanding how
#construction trends have changed over time can reveal supply shortages or surpluses.
select
	Year,
    sum(New_Construction_Count) as  New_Properties_Built
from market_trends
group by
	Year;


with cte as(
select
	Year,
    sum(New_Construction_Count) as  New_Properties_Built
from market_trends
group by
	Year
)
(
select
	'Highest New_Property' as Categoty,
    Year
from cte
order by New_Properties_Built desc
limit 1
)
union all
(
select
	'Lowest New_Property' as Categoty,
    Year
from cte
order by New_Properties_Built asc
limit 1
);
# Question 2
#Q2: Which cities have experienced the most new construction over the past years?
#Different cities experience varying levels of new housing development due to economic
#conditions, land availability, and demand.
#Steps to follow:
#Identify cities with the highest number of newly built properties.
#Highlight which cities have seen the most development activity overall in terms of new construction.
#Determine if new construction is concentrated in specific metropolitan regions
select
	City,
    sum(New_Construction_Count) as New_Properties_Built
from market_trends
group by
	City
order by
	New_Properties_Built desc;
    
#Question 3
#Q3: How does new construction impact average home prices?
#More housing supply can help stabilize prices, but in high-demand areas, prices may continue
#rising. Understanding this relationship is crucial for market predictions.
#Steps to follow:
#Compare average home price trends before and after major construction spikes.
#Identify if higher supply leads to price stabilization or if demand remains strong.
#Observe whether periods of intense construction activity align with years of elevated housing prices.

select
	Year,
    sum(New_Construction_Count) as New_Properties_Built,
    round(avg(Avg_Home_Price),2) as Avg_Home_Price
from market_trends
group by
	Year;

# Question 4
#Q4: Which cities have seen the highest changes in investor activity?
#Affordability is a key concern in real estate, affecting homeownership rates and market dynamics.

select*
from market_trends;
select*
from properties_transactions;


select
	City,
    round(avg(Investor_Activity_Score),2) as Investor_Activity_Change
from market_trends
group by
	city;
