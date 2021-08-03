DROP VIEW ${schema}vTargetMail
;

DROP VIEW ${schema}vDMPrep
;

DROP TABLE ${schema}FactSurveyResponse
;

DROP TABLE ${schema}FactSalesQuota
;

DROP TABLE ${schema}FactResellerSales
;

DROP TABLE ${schema}FactAdditionalInternationalProductDescription
;

DROP TABLE ${schema}FactCallCenter
;

DROP TABLE ${schema}FactCurrencyRate
;

DROP TABLE ${schema}FactFinance
;

DROP TABLE ${schema}FactInternetSalesReason
;

DROP TABLE ${schema}FactInternetSales
;

DROP TABLE ${schema}FactProductInventory
;


DROP TABLE ${schema}NewFactCurrencyRate
;

DROP TABLE ${schema}ProspectiveBuyer
;

DROP TABLE ${schema}DimAccount
;

DROP TABLE ${schema}DimCustomer
;

DROP TABLE ${schema}DimDate
;

DROP TABLE ${schema}DimDepartmentGroup
;

DROP TABLE ${schema}DimEmployee
;

DROP TABLE ${schema}DimOrganization
;

DROP TABLE ${schema}DimProduct
;

DROP TABLE ${schema}DimProductSubCategory
;

DROP TABLE ${schema}DimProductCategory
;

DROP TABLE ${schema}DimPromotion
;

DROP TABLE ${schema}DimReseller
;

DROP TABLE ${schema}DimSalesReason
;

DROP TABLE ${schema}DimScenario
;

DROP TABLE ${schema}DimGeography
;

DROP TABLE ${schema}DimSalesTerritory
;

DROP TABLE ${schema}DimCurrency
;

-- purge SQL Loader logs

DELETE FROM %SQL_Diag.Message
;

DELETE FROM %SQL_Diag.Result
;