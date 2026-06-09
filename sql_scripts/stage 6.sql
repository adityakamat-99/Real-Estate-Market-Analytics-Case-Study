select*
from agents;
select*
from market_trends;
select*
from properties_transactions;

#Question 3
#Q3: Which cities have seen the most volatility in investor activity over time?
#Investors often enter and exit markets rapidly based on economic conditions. Understanding
#where investor activity fluctuates the most can help assess risks of price volatility

select
	City,
    round(avg(Investor_Activity_Score),2) as Avg_Investor_Activity,
    row_number() over(order by  avg(Investor_Activity_Score) desc) as Investor_Rank
from market_trends
group by
	city;
    
#Question 2
#Q2: Which income brackets experience the most significant affordability challenges over time?
#As home prices rise, affordability for different income brackets changes, impacting
#homeownership accessibility. Some income groups may struggle to keep up with price
#growth, while others benefit from higher purchasing power

select
	Income_Bracket,
    round(avg(Affordability_Price_to_Income_Ratio),2) as Price_To_Income_Ratio,
    case
		when (avg(Affordability_Price_to_Income_Ratio)) > 6 then 'Severely Unaffordable'
        when (avg(Affordability_Price_to_Income_Ratio)) between 5.75 and 6 then 'Moderately Unaffordable'
        else 'Unaffordable'
	end as Affordability_Stress
from market_trends
group by
	Income_Bracket
order by
	Price_To_Income_Ratio desc;
    
