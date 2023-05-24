/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [PortfolioDB].[dbo].[sba_public_data]

  -- 

 select year(DateApproved) Year_approved,
		count(loannumber) Number_of_approval,
		SUM(initialapprovalamount) Approval_amount,
		AVG(initialapprovalamount) Average_loan_size
 from [dbo].[sba_public_data]
 where year(DateApproved) = 2020
 group by year(DateApproved)

 union
 
 select year(DateApproved) Year_approved,
		count(loannumber) Number_of_approval,
		SUM(initialapprovalamount) Approval_amount,
		AVG(initialapprovalamount) Average_loan_size
 from [dbo].[sba_public_data]
 where year(DateApproved) = 2021
group by year(DateApproved)



-- 

 select count(distinct OriginatingLender) Originating_lender,
		count(loannumber) Number_of_approval,
		SUM(initialapprovalamount) Approval_amount,
		AVG(initialapprovalamount) Average_loan_size
 from [dbo].[sba_public_data]
 where year(DateApproved) = 2020
group by year(DateApproved)

union

 select count(distinct OriginatingLender) Originating_lender,
		count(loannumber) Number_of_approval,
		SUM(initialapprovalamount) Approval_amount,
		AVG(initialapprovalamount) Average_loan_size
 from [dbo].[sba_public_data]
 where year(DateApproved) = 2021
group by year(DateApproved)


--

 select top 15
		OriginatingLender Originating_lender,
		count(loannumber) Number_of_approval,
		SUM(initialapprovalamount) Approval_amount,
		AVG(initialapprovalamount) Average_loan_size
 from [dbo].[sba_public_data]
 where year(DateApproved) = 2020
group by OriginatingLender
order by 3 desc

-- 

 select top 15
		OriginatingLender Originating_lender,
		count(loannumber) Number_of_approval,
		SUM(initialapprovalamount) Approval_amount,
		AVG(initialapprovalamount) Average_loan_size
 from [dbo].[sba_public_data]
 where year(DateApproved) = 2021
group by OriginatingLender
order by 3 desc


-- top 20 industries that received the PPP loans in 2021 and 2020

 select Top 20
		d.Sector,
		count(loannumber) Number_of_approval,
		SUM(initialapprovalamount) Approval_amount,
		AVG(initialapprovalamount) Average_loan_size
 from 
		[dbo].[sba_public_data] p 
		inner join sba_nacis_sector_codes_description d
			on LEFT(p.naicscode,2) = d.LookupCodes
 where 
		year(DateApproved) = 2020
group by 
		d.Sector
order by 3 desc


select Top 20
		d.Sector,
		count(loannumber) Number_of_approval,
		SUM(initialapprovalamount) Approval_amount,
		AVG(initialapprovalamount) Average_loan_size
 from 
		[dbo].[sba_public_data] p 
		inner join sba_nacis_sector_codes_description d
			on LEFT(p.naicscode,2) = d.LookupCodes
 where 
		year(DateApproved) = 2021
group by 
		d.Sector
order by 3 desc


-- percentage

-- year 2021

WITH cte as 
(

select Top 20
		d.Sector,
		count(loannumber) Number_of_approval,
		SUM(initialapprovalamount) Approval_amount,
		AVG(initialapprovalamount) Average_loan_size
 from 
		[dbo].[sba_public_data] p 
		inner join sba_nacis_sector_codes_description d
			on LEFT(p.naicscode,2) = d.LookupCodes
 where 
		year(DateApproved) = 2021
group by 
		d.Sector
order by 3 desc

)
select Sector, Number_of_approval, Approval_amount, average_loan_size,
round((Approval_amount/SUM(approval_amount) over() * 100), 2) Percent_by_amount
from cte
order by Approval_amount desc


-- year 2020

WITH cte as 
(

select Top 20
		d.Sector,
		count(loannumber) Number_of_approval,
		SUM(initialapprovalamount) Approval_amount,
		AVG(initialapprovalamount) Average_loan_size
 from 
		[dbo].[sba_public_data] p 
		inner join sba_nacis_sector_codes_description d
			on LEFT(p.naicscode,2) = d.LookupCodes
 where 
		year(DateApproved) = 2020
group by 
		d.Sector
order by 3 desc

)
select Sector, Number_of_approval, Approval_amount, average_loan_size,
round((Approval_amount/SUM(approval_amount) over() * 100), 2) Percent_by_amount
from cte
order by Approval_amount desc

-- How much of the PPP loans of 2021 have been fully forgiven

-- 2020

select
		count(loannumber) Number_of_approval,
		SUM(currentapprovalamount) current_approval_amount,
		AVG(currentapprovalamount) current_average_loan_size,
		SUM(forgivenessamount) amount_forgiven,
		round((SUM(forgivenessamount)/SUM(currentapprovalamount) * 100),2) percent_forgiven

from	
		sba_public_data
where	
		YEAR(dateapproved) = 2020
order by 3 desc

-- 2021


select
		count(loannumber) Number_of_approval,
		SUM(currentapprovalamount) current_approval_amount,
		AVG(currentapprovalamount) current_average_loan_size,
		SUM(forgivenessamount) amount_forgiven,
		round((SUM(forgivenessamount)/SUM(currentapprovalamount) * 100),2) percent_forgiven

from	
		sba_public_data
where	
		YEAR(dateapproved) = 2021
order by 3 desc



-- year, month with highest PPP loans approved

select
	YEAR(dateapproved) year_approved,
	month(dateapproved) month_approved,
	COUNT(loannumber) number_of_approved,
	SUM(initialapprovalamount) total_net_dollars,
	AVG(initialapprovalamount) average_loan_size

from	
	sba_public_data
group by	
	YEAR(dateapproved), 
	month(dateapproved) 
order by 
	4 desc