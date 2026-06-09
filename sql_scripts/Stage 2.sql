-- Stage 2
-- Question 1
-- How can we handle missing values in transaction price and property size?

-- Using averages, median and windows function we found the value which needs to be
-- inserted in the null values. Sadly we cant fix any values for houses where the house-type
-- was missing.

select*
from properties_transactions
where 
	Size_SqFt is null;

select*
from properties_transactions
where 
	Listing_Price is null;
    
select*
from properties_transactions
where 
	Rental_Price is null;

-- Updating the null values in size_sqft
update properties_transactions as pt
join(
select
	Type,
    City,
    avg(Size_SqFt)as Mean_Size
from properties_transactions
where 
	Size_SqFt is not null
group by
	Type,
    City
) as avg_table
	on pt.type = avg_table.type
    and pt.city = avg_table.city
set pt.Size_SqFt = avg_table.Mean_Size
where pt.Size_SqFt is null;

-- Updating the null values in listing price

select*
from properties_transactions
where 
	Listing_Price is null;


update properties_transactions as pt
join(
select
	Type,
    City,
    avg(Listing_Price) as Median_Price
from(
	 select
		Type,
		City,
        Listing_Price,
        row_number() over (partition by type,city order by Listing_Price) as rn,
        count(Listing_Price) over(partition by type, city) as total_count
	 from properties_transactions
     where Listing_Price is not null
     ) as ranked
where rn in (floor((total_count + 1) / 2), ceil((total_count + 1) / 2))
group by
	Type, 
	City
) as median_table
	on pt.type = median_table.type
    and pt.city = median_table.city
set pt.Listing_Price = median_table.Median_Price
where pt.Listing_Price is null;

select*
from properties_transactions
where 
	-- type is null and
    Size_SqFt is null or
    Listing_Price is null; 
    
    
select*
from properties_transactions
where 
	Listing_Price < 0 or Listing_Price = 0 or
    Rental_Price < 0 or Rental_Price = 0;
    
select
	city,
    max(Listing_Price) as Cap_List_price,
    max(Rental_Price) as Cap_Rent_price
from properties_transactions
group by
	city;
    
select
	city,
    Listing_Price,
    percent_rank() over (partition by city order by Listing_Price asc) as percent_ranks
from properties_transactions;