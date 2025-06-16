use PortfolioProject_MarketingAnalytics;
--data cleaning, combine customer and geography into one
 SELECT [CustomerID]
      ,[CustomerName]
      ,[Email]
      ,[Gender]
      ,[Age]
      ,g.Country
	  ,g.City
  FROM customers c
  left join geography g
  on c.GeographyID = g.GeographyID


--data cleaning for customer review table
 SELECT [ReviewID]
      ,[ReviewDate]
      ,[CustomerID]
      ,[ProductID]
      ,[Rating]
      ,REPLACE(ReviewText,'  ',' ') as ReviewText
  FROM [PortfolioProject_MarketingAnalytics].[dbo].[customer_reviews];

  --data cleaning for engagement table, also check if duplicate records, replace null with average duration--unfinished
 Select  EngagementID,
         EngagementDate,
         ContentID,
		 CampaignID,
		 upper(REPLACE(ContentType,'socialmedia','social media')) as ContentType,
		 ProductID,
		 left(ViewsClicksCombined,CHARINDEX('-',ViewsClicksCombined)-1) as Views,
		 right(ViewsClicksCombined, LEN(ViewsClicksCombined)-CHARINDEX('-',ViewsClicksCombined)) as CLicks,
		 Likes
		 from engagement_data;

--data cleaning for customer_journey, first check if duplicates records~ and replace null with average
 With DuplicateRecords as(
  SELECT  [JourneyID]
      ,[VisitDate]
      ,[CustomerID]
      ,[ProductID]
      ,[Stage]
      ,[Action]
	  ,Duration
	  ,round(AVG(Duration) over(partition by VisitDate),0)as Avg_Duration  ---average duration for each visitdate
      ,ROW_NUMBER()over(partition by JourneyID,VisitDate,CustomerID,ProductID,Stage,Action 
	  order by JourneyID) as row_num
  FROM [customer_journey]
  )
  SELECT  [JourneyID]
      ,[VisitDate]
      ,[CustomerID]
      ,[ProductID]
      ,[Stage]
      ,[Action]
      ,Coalesce(Duration, Avg_Duration) as Duration
  FROM DuplicateRecords
  where row_num= 1;
  
  -----product table 
  SELECT [ProductID]
      ,[ProductName]
      ,[Category]
      ,[Price]
	  ,Case 
	    When Price < 50 then 'Low'
		When Price between 50 and 200 then 'Medium'
		Else 'High'
		End as PriceCategory
  FROM [PortfolioProject_MarketingAnalytics].[dbo].[products]


  ----data aggreagtion for customer_journey (but not needed for now)
 select JourneyID, 
      VisitDate, 
      CustomerID, 
	  ProductID,
	  Stage,
	  case when action = 'View' then 1 else 0 End as viewing,
	  case when action = 'Click' then 1 else 0 End as click,
	  case when action = 'Drop-off' then 1 else 0 End as drop_off,
	  case when action = 'Purchase' then 1 else 0 End as Buy,
	  Duration
from customer_journey;


--average customer order value--219.43
select AVG(price) as average_order_value
from 
(select j.CustomerID, j.ProductID, p.Price
from customer_journey j
left join products p
on j.ProductID = p.ProductID
where j.Action = 'Purchase') t;


--average rating 3.68
select AVG(cast(Rating as float)) as average_rating from customer_reviews;

---engagement by contenttype ,v_click_like 3%
  with cte1 as (
         select ContentType, 
		 sum(cast(left(ViewsClicksCombined,CHARINDEX('-',ViewsClicksCombined)-1) as int)) as Views,
		 sum(cast(right(ViewsClicksCombined, LEN(ViewsClicksCombined)-CHARINDEX('-',ViewsClicksCombined)) as int))as Clicks,
		 sum(cast(Likes as int)) as Likes 
		 from engagement_data
		 group by ContentType
		 )
  select *,
         concat(round(100*CAST(Likes as float)/(Views+Clicks),2),'%')as v_l_rate
		 from cte1;


--view&click_buy conversion rate--6.25%

with cte4 as
(select sum(viewing) as view_num, 
	   sum(click) as click_num,
	   sum(buy) as buy_num from new_customer_journey
)
select cast(buy_num as float)/(click_num + view_num) as conersion_rate from cte4;

  --customer journey--conversion rate, view, click, purchase
--engagement ---
---average order value, order-value by product



---average rating by product
  with producct_rating as 
  (select productID,
         AVG(cast(Rating as float)) as average_rating 
		 from customer_reviews
		 group by productID
		 ),

 ---average buy-count by product
 product_buy_count as
 (select ProductID,
 count(*) as buy_count
 from customer_journey
 where action = 'Purchase'
 group by ProductID
)
 select  top 10 c.productID,
 c.buy_count,
 r.average_rating
 from product_buy_count c
 inner join producct_rating r
 on c.buy_count =r.ProductID
 order by c.buy_count desc;




 
  --contentType engagement level
  with cte1 as (
         select ContentType, 
		 sum(cast(left(ViewsClicksCombined,CHARINDEX('-',ViewsClicksCombined)-1) as int)) as Views,
		 sum(cast(right(ViewsClicksCombined, LEN(ViewsClicksCombined)-CHARINDEX('-',ViewsClicksCombined)) as int))as Clicks,
		 sum(cast(Likes as int)) as Likes 
		 from engagement_data
		 group by ContentType
		 )
  select *,
         concat(round(100*CAST(Likes as float)/(Views+Clicks),2),'%')as v_l_rate
		 from cte1;

		 ---campaign interaction level
  with cte3 as (
         select CampaignID, 
		 sum(cast(left(ViewsClicksCombined,CHARINDEX('-',ViewsClicksCombined)-1) as int)) as Views,
		 sum(cast(right(ViewsClicksCombined, LEN(ViewsClicksCombined)-CHARINDEX('-',ViewsClicksCombined)) as int))as Clicks,
		 sum(cast(Likes as int)) as Likes 
		 from engagement_data
		 group by CampaignID
		 )
  select *,
         concat(round(100*CAST(Likes as float)/(Views+Clicks),2),'%')as v_l_rate
		 from cte3
		 order by v_l_rate desc;