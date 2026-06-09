-- Question 1
-- How can we evaluate the completeness and reliability of the real estate
-- dataset to ensure sufficient data availability while identifying potential anomalies
-- or collection issues?

-- This questio basically makes sure that all rows of property transaction are imported
-- and no rows were skipped during imports due to blanks in the .csv filr
select
	'properties_transactions' as Table_Name,
    count(*) as Total_Records
from properties_transactions;

-- Question 2
--  How comprehensive is the transaction data, and does missing field
-- percentage impact market analysis depth?

-- Using the fact that count specifically ignores null values we were able to find the
-- missing values percentage for all the critical columns.

select
	'Type' as Column_Name,
    round(((count(*)-count(type))/count(*))*100,2) as Missing_Values_Percentage
from properties_transactions
union all
select
	'City' as Column_Name,
    round(((count(*)-count(City))/count(*))*100,2) as Missing_Values_Percentage
from properties_transactions
union all
select
	'Size_SqFt' as Column_Name,
    round(((count(*)-count(Size_SqFt))/count(*))*100,2) as Missing_Values_Percentage
from properties_transactions
union all
select
	'Bedrooms' as Column_Name,
    round(((count(*)-count(Bedrooms))/count(*))*100,2) as Missing_Values_Percentage
from properties_transactions
union all
select
	'Bathrooms' as Column_Name,
    round(((count(*)-count(Bathrooms))/count(*))*100,2) as Missing_Values_Percentage
from properties_transactions
union all
select
	'Year_Built' as Column_Name,
    round(((count(*)-count(Year_Built))/count(*))*100,2) as Missing_Values_Percentage
from properties_transactions
union all
select
	'Listing_Price' as Column_Name,
    round(((count(*)-count(Listing_Price))/count(*))*100,2) as Missing_Values_Percentage
from properties_transactions
union all
select
	'Rental_Price' as Column_Name,
    round(((count(*)-count(Rental_Price))/count(*))*100,2) as Missing_Values_Percentage
from properties_transactions
union all
select
	'Neighborhood' as Column_Name,
    round(((count(*)-count(Neighborhood))/count(*))*100,2) as Missing_Values_Percentage
from properties_transactions
union all
select
	'Status' as Column_Name,
    round(((count(*)-count(Status))/count(*))*100,2) as Missing_Values_Percentage
from properties_transactions
order by
	Missing_Values_Percentage desc;
    
-- Question 3
-- How can we detect duplicate property transactions, extreme pricing values,
-- and unrealistic sizes of property to ensure data accuracy?

-- Using group by and Having functions we were able to find out the duplicates
-- present in the table

with duplicate_groups as (
	select
		Property_ID,
        Type,
        Listing_Price,
        Rental_Price,
        Neighborhood,
        Status
	from properties_transactions
    group by
		Property_ID,
        Type,
        Listing_Price,
        Rental_Price,
        Neighborhood,
        Status
	having count(*) >1
)
select
	count(*) as Duplicate_records
from duplicate_groups;


-- Now checking for extreme high pricings

select
	Property_ID,
    Listing_Price as Sale_Price,
    City as Region,
    Neighborhood
from properties_transactions
where
	Status = "Sold"
order by
	Listing_Price desc
limit 10;

-- Now checking for unrealistic pricings
select
	avg(Size_SqFt)
from properties_transactions;
select
	max(Size_SqFt),
    min(Size_SqFt),
    avg(Size_SqFt)
from properties_transactions;

select
	Property_ID,
    Type,
    Size_SqFt,
    City as Region,
    Neighborhood
from properties_transactions
order by
	Size_SqFt desc;