/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [sector]
      ,[year_approved]
      ,[month_approved]
      ,[originatingLender]
      ,[borrowerstate]
      ,[race]
      ,[gender]
      ,[ethnicity]
      ,[number_of_approved]
      ,[current_approved_amount]
      ,[current_average_loan_size]
      ,[amount_forgiven]
      ,[approved_amount]
      ,[average_loan_size]
  FROM [PortfolioDB].[dbo].[ppp_main]