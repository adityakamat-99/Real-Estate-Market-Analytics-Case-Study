#Question 1
#Q1: Which Cities Exhibit the Strongest Housing Demand, and What Are the
#Typical Home and Rent Prices in These Areas?
#This analysis identifies cities with the highest housing demand index, reflecting strong
#buyer interest. By examining corresponding average home and rent prices, it offers insights
#into cost trends in high-demand areas. The output helps evaluate how demand aligns with
#affordability and market attractiveness.

select
	City,
    round(max(Housing_Demand_Index),2) as Highest_Demand_Index,
    round(avg(Avg_Home_Price),2) as Avg_Typical_Home_Price,
    round(avg(Avg_Rent_Price),2) as Avg_Typical_Rent_Price
from market_trends
group by
	City
order by
	Highest_Demand_Index desc;

#Question 2
#Q2: What is the distribution of property sizes across different property types?
#Property size is a key factor influencing buyer decisions and real estate valuation. This
#analysis will reveal how property sizes vary by type
select
	Type as Property_Type,
    round(avg(Size_SqFt),2) as Avg_Size_SqFt
from properties_transactions
group by
	Type
order by
	Avg_Size_SqFt desc;
