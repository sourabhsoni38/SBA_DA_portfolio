/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [NAICS_Codes],
       [NAICS_Industry_Description],
	   SUBSTRING([NAICS_Industry_Description], 8, 2) LookupCodes
  FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''

  select [NAICS_Codes],
	     [NAICS_Industry_Description]
  from sba_industry_standards
  where [NAICS_Codes] = '';

SELECT
	 [NAICS_Industry_Description],
		CASE 
			WHEN ([NAICS_Industry_Description] like '%–%') THEN SUBSTRING([NAICS_Industry_Description], 8, 2)
			ELSE '' 
		END AS LookupCodes
FROM [PortfolioDB].[dbo].[sba_industry_standards]
where [NAICS_Codes] = '';

                                    -- OR-- 

SELECT
	 [NAICS_Industry_Description],
	 IIF([NAICS_Industry_Description] LIKE '%–%', SUBSTRING([NAICS_Industry_Description],8,2), '') LookupCodes
FROM [PortfolioDB].[dbo].[sba_industry_standards]
where [NAICS_Codes] = '';


-- eliminating empty rows --

select *
from (
	
		SELECT
			 [NAICS_Industry_Description],
			 IIF([NAICS_Industry_Description] LIKE '%–%', SUBSTRING([NAICS_Industry_Description],8,2), '') LookupCodes
		FROM [PortfolioDB].[dbo].[sba_industry_standards]
		where [NAICS_Codes] = ''
) main 
where 
	LookupCodes != ''


select *
from (
	
		SELECT
			 [NAICS_Industry_Description],
			 IIF([NAICS_Industry_Description] LIKE '%–%', SUBSTRING([NAICS_Industry_Description],8,2), '') LookupCodes,
			 IIF([NAICS_Industry_Description] LIKE '%–%', LTRIM(SUBSTRING([NAICS_Industry_Description], CHARINDEX('–', [NAICS_Industry_Description]) + 1, LEN([NAICS_Industry_Description]) )), '') Sector
		FROM [PortfolioDB].[dbo].[sba_industry_standards]
		where [NAICS_Codes] = ''
) main
where 
	LookupCodes != ''


-- Creting new Table --

select *
into sba_nacis_sector_codes_description
from (
	
		SELECT
			 [NAICS_Industry_Description],
			 IIF([NAICS_Industry_Description] LIKE '%–%', SUBSTRING([NAICS_Industry_Description],8,2), '') LookupCodes,
			 IIF([NAICS_Industry_Description] LIKE '%–%', LTRIM(SUBSTRING([NAICS_Industry_Description], CHARINDEX('–', [NAICS_Industry_Description]) + 1, LEN([NAICS_Industry_Description]) )), '') Sector
		FROM [PortfolioDB].[dbo].[sba_industry_standards]
		where [NAICS_Codes] = ''
) main
where 
	LookupCodes != ''

  





 



