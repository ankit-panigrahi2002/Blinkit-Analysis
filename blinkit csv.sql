--BLINKIT ANALYSIS



create table blinkit(
	Item_FatContent varchar(50),
	Item_Identifier varchar(50),
	Item_Type varchar(50),
	Outlet_Establishment_Year int,
	Outlet_Identifier varchar(50),
	Outlet_Location_Type varchar(50),
	Outlet_Size varchar(50),
	Outlet_Type varchar(50),
	Item_Visibility double precision,
	Item_Weight double precision,
	Total_Sales double precision,
	Rating double precision
);
ALTER TABLE blinkit RENAME COLUMN Item_FatContent TO item_fatcontent;
ALTER TABLE blinkit RENAME COLUMN Item_Identifier TO item_identifier;
ALTER TABLE blinkit RENAME COLUMN Item_Type TO item_type;
ALTER TABLE blinkit RENAME COLUMN Outlet_Establishment_Year TO outlet_establishment_year;
ALTER TABLE blinkit RENAME COLUMN Outlet_Identifier TO outlet_identifier;
ALTER TABLE blinkit RENAME COLUMN Outlet_Location_Type TO outlet_location_type;
ALTER TABLE blinkit RENAME COLUMN Outlet_Size TO outlet_size;   
ALTER TABLE blinkit RENAME COLUMN Outlet_Type TO outlet_type;  
ALTER TABLE blinkit RENAME COLUMN Item_Visibility TO item_visibility;
ALTER TABLE blinkit RENAME COLUMN Item_Weight TO item_weight;
ALTER TABLE blinkit RENAME COLUMN Total_Sales TO total_sales;
ALTER TABLE blinkit RENAME COLUMN Rating TO rating;





update blinkit
set item_fatcontent= case when item_fatcontent in ('LF','low fat') then 'Low Fat' 
						  when item_fatcontent ='reg' then 'Regular' 
						  else item_fatcontent
						 end





-- Total sales
select cast(sum(total_sales)/1000000 as decimal(10,2)) as Total_sales from blinkit;

--Avgerage sales
select cast(avg(total_sales) as decimal(10,2)) as Avg_sales from blinkit;
 
--Number of items
select   count(item_type) as number_of_items from blinkit ;

--Average Rating
select cast(avg(rating) as decimal(10,2)) as Average_Rating from blinkit;


--Total sales by fat content
select item_fatcontent,cast(sum(total_sales) as decimal(10,2)) as Total_sales from blinkit group by item_fatcontent order by total_sales desc;



--Total sales by item type
select item_type,cast(sum(total_sales) as decimal(10,2)) as Total_sales from blinkit group by item_type order by total_sales desc;


--fat content by Outlet for Total sales;

SELECT 
    outlet_location_type,
    SUM(total_sales) FILTER (WHERE item_fatcontent = 'Low Fat')  AS low_fat,
    SUM(total_sales) FILTER (WHERE item_fatcontent = 'Regular') AS regular
FROM blinkit
GROUP BY outlet_location_type
ORDER BY outlet_location_type;



--total sales by outlet establishment
select outlet_establishment_year,
		cast(sum(total_sales) as decimal(10,2)) as total_sales,
		cast(avg(total_sales) as decimal(10,2)) as avgearge_sales,
		count(item_type) as number_of_items,
		cast(avg(rating) as decimal(10,2)) as avgerage_rating from blinkit 
group by outlet_establishment_year order by outlet_establishment_year ;


--percentage of sales by outlet size


select outlet_size,
sum(total_sales) as total_sales,
cast(sum(total_sales)*100 / (select sum(total_sales) from blinkit) as decimal(10,2)) as percentage_ofsales from blinkit 
group by outlet_size order by percentage_ofsales desc;


--sales by outlet location
select outlet_location_type ,sum(total_sales) from blinkit group by outlet_location_type;

--all metrics by outlet type
SELECT Outlet_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;

select * from blinkit;