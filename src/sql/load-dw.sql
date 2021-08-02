LOAD DATA FROM FILE '${data_dir}DimAccount.csv'
	INTO AdventureWorks.DimAccount
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimCurrency.csv'
	INTO AdventureWorks.DimCurrency
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimCustomer.csv'
	INTO AdventureWorks.DimCustomer
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimDate.csv'
	INTO AdventureWorks.DimDate
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimDepartmentGroup.csv'
	INTO AdventureWorks.DimDepartmentGroup
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimEmployee.csv'
	INTO AdventureWorks.DimEmployee
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimGeography.csv'
	INTO AdventureWorks.DimGeography
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimOrganization.csv'
	INTO AdventureWorks.DimOrganization
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimProduct.csv'
	INTO AdventureWorks.DimProduct
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimProductCategory.csv'
	INTO AdventureWorks.DimProductCategory
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimProductSubCategory.csv'
	INTO AdventureWorks.DimProductSubCategory
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimPromotion.csv'
	INTO AdventureWorks.DimPromotion
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimReseller.csv'
	INTO AdventureWorks.DimReseller
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimSalesReason.csv'
	INTO AdventureWorks.DimSalesReason
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimSalesTerritory.csv'
	INTO AdventureWorks.DimSalesTerritory
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}DimScenario.csv'
	INTO AdventureWorks.DimScenario
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}FactAdditionalInternationalProductDescription.csv'
	INTO AdventureWorks.FactAdditionalInternationalProductDescription
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}FactCallCenter.csv'
	INTO AdventureWorks.FactCallCenter
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}FactCurrencyRate.csv'
	INTO AdventureWorks.FactCurrencyRate
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}FactFinance.csv'
	INTO AdventureWorks.FactFinance
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}FactInternetSales.csv'
	INTO AdventureWorks.FactInternetSales
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}FactInternetSalesReason.csv'
	INTO AdventureWorks.FactInternetSalesReason
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}FactProductInventory.csv'
	INTO AdventureWorks.FactProductInventory
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}FactResellerSales.csv'
	INTO AdventureWorks.FactResellerSales
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}FactSalesQuota.csv'
	INTO AdventureWorks.FactSalesQuota
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}FactSurveyResponse.csv'
	INTO AdventureWorks.FactSurveyResponse
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}NewFactCurrencyRate.csv'
	INTO AdventureWorks.NewFactCurrencyRate
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}ProspectiveBuyer.csv'
	INTO AdventureWorks.ProspectiveBuyer
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

