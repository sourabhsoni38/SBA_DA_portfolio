/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [NAICS_Industry_Description]
      ,[LookupCodes]
      ,[Sector]
  FROM [PortfolioDB].[dbo].[sba_nacis_sector_codes_description]
  order by Lookupcodes



INSERT INTO [dbo].[sba_nacis_sector_codes_description]
values
('Sector 31 – 33 – Manufacturing',32,'Manufacturing'),
('Sector 31 – 33 – Manufacturing',33,'Manufacturing'),
('Sector 44 - 45 – Retail Trade',45,'Retail Trade'),
('Sector 48 - 49 – Transportation and Warehousing',49,'Transportation and Warehousing')


update [dbo].[sba_nacis_sector_codes_description]
set Sector = 'Manufacturing'
Where lookupcodes = 31
