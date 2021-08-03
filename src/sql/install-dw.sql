-- based on https://github.com/microsoft/sql-server-samples/blob/master/samples/databases/adventure-works/data-warehouse-install-script/instawdbdw.sql


-- not used
/*
CREATE TABLE ${schema}DatabaseLog(
    DatabaseLogID INTEGER IDENTITY (1, 1) NOT NULL,
    PostTime DATETIME NOT NULL, 
    DatabaseUser VARCHAR(100) NOT NULL, 
    Event VARCHAR(100) NOT NULL, 
    Schema VARCHAR(100) NULL, 
    Object VARCHAR(100) NULL, 
    TSQL VARCHAR(32000) NOT NULL, 
    XmlEvent CLOB NOT NULL
)
;

CREATE TABLE ${schema}AdventureWorksDWBuildVersion(
	DBVersion VARCHAR(50) NULL,
	VersionDate DATETIME NULL
)
;

CREATE TABLE ${schema}sysdiagrams(
	name VARCHAR(100) NOT NULL,
	principal_id INTEGER NOT NULL,
	diagram_id INTEGER IDENTITY(1,1) NOT NULL,
	version INTEGER NULL,
	definition VARCHAR(32000) NULL -- BLOB
)
;

*/

CREATE TABLE ${schema}DimAccount(
	AccountKey INTEGER IDENTITY(1,1) NOT NULL,
	ParentAccountKey INTEGER NULL,
	AccountCodeAlternateKey INTEGER NULL,
	ParentAccountCodeAlternateKey INTEGER NULL,
	AccountDescription VARCHAR(50) NULL,
	AccountType VARCHAR(50) NULL,
	Operator VARCHAR(50) NULL,
	CustomMembers VARCHAR(300) NULL,
	ValueType VARCHAR(50) NULL,
	CustomMemberOptions VARCHAR(200) NULL,
    CONSTRAINT PK PRIMARY KEY (AccountKey) 
)
;


CREATE TABLE ${schema}DimCurrency(
	CurrencyKey INTEGER IDENTITY(1,1) NOT NULL,
	CurrencyAlternateKey CHAR(3) NOT NULL,
	CurrencyName VARCHAR(50) NOT NULL,
    CONSTRAINT PK PRIMARY KEY (CurrencyKey),
    CONSTRAINT UK_Alternate UNIQUE (CurrencyAlternateKey) 
)
;

CREATE TABLE ${schema}DimCustomer(
	CustomerKey INTEGER IDENTITY(1,1) NOT NULL,
	GeographyKey INTEGER NULL,
	CustomerAlternateKey VARCHAR(15) NOT NULL,
	Title VARCHAR(8) NULL,
	FirstName VARCHAR(50) NULL,
	MiddleName VARCHAR(50) NULL,
	LastName VARCHAR(50) NULL,
	NameStyle BIT NULL,
	BirthDate DATE NULL,
	MaritalStatus CHAR(1) NULL,
	Suffix VARCHAR(10) NULL,
	Gender VARCHAR(1) NULL,
	EmailAddress VARCHAR(50) NULL,
	YearlyIncome MONEY NULL,
	TotalChildren TINYINT NULL,
	NumberChildrenAtHome TINYINT NULL,
	EnglishEducation VARCHAR(40) NULL,
	SpanishEducation VARCHAR(40) NULL,
	FrenchEducation VARCHAR(40) NULL,
	EnglishOccupation VARCHAR(100) NULL,
	SpanishOccupation VARCHAR(100) NULL,
	FrenchOccupation VARCHAR(100) NULL,
	HouseOwnerFlag CHAR(1) NULL,
	NumberCarsOwned TINYINT NULL,
	AddressLine1 VARCHAR(120) NULL,
	AddressLine2 VARCHAR(120) NULL,
	Phone VARCHAR(20) NULL,
	DateFirstPurchase DATE NULL,
	CommuteDistance VARCHAR(15) NULL,
    CONSTRAINT PK PRIMARY KEY (CustomerKey),
    CONSTRAINT UK_Alternate UNIQUE (CustomerAlternateKey)
)
;

CREATE TABLE ${schema}DimDate(
	DateKey INTEGER NOT NULL,
	FullDateAlternateKey DATE NOT NULL,
	DayNumberOfWeek TINYINT NOT NULL,
	EnglishDayNameOfWeek VARCHAR(10) NOT NULL,
	SpanishDayNameOfWeek VARCHAR(10) NOT NULL,
	FrenchDayNameOfWeek VARCHAR(10) NOT NULL,
	DayNumberOfMonth TINYINT NOT NULL,
	DayNumberOfYear SMALLINT NOT NULL,
	WeekNumberOfYear TINYINT NOT NULL,
	EnglishMonthName VARCHAR(10) NOT NULL,
	SpanishMonthName VARCHAR(10) NOT NULL,
	FrenchMonthName VARCHAR(10) NOT NULL,
	MonthNumberOfYear TINYINT NOT NULL,
	CalendarQuarter TINYINT NOT NULL,
	CalendarYear SMALLINT NOT NULL,
	CalendarSemester TINYINT NOT NULL,
	FiscalQuarter TINYINT NOT NULL,
	FiscalYear SMALLINT NOT NULL,
	FiscalSemester TINYINT NOT NULL,
    CONSTRAINT PK PRIMARY KEY (DateKey),
    CONSTRAINT UK_Alternate UNIQUE (FullDateAlternateKey)
)
;

CREATE TABLE ${schema}DimDepartmentGroup(
	DepartmentGroupKey INTEGER IDENTITY(1,1) NOT NULL,
	ParentDepartmentGroupKey INTEGER NULL,
	DepartmentGroupName VARCHAR(50) NULL,
    CONSTRAINT PK PRIMARY KEY (DepartmentGroupKey)
)
;

CREATE TABLE ${schema}DimEmployee(
	EmployeeKey INTEGER IDENTITY(1,1) NOT NULL,
	ParentEmployeeKey INTEGER NULL,
	EmployeeNationalIDAlternateKey VARCHAR(15) NULL,
	ParentEmployeeNationalIDAlternateKey VARCHAR(15) NULL,
	SalesTerritoryKey INTEGER NULL,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	MiddleName VARCHAR(50) NULL,
	NameStyle BIT NOT NULL,
	Title VARCHAR(50) NULL,
	HireDate DATE NULL,
	BirthDate DATE NULL,
	LoginID VARCHAR(256) NULL,
	EmailAddress VARCHAR(50) NULL,
	Phone VARCHAR(25) NULL,
	MaritalStatus CHAR(1) NULL,
	EmergencyContactName VARCHAR(50) NULL,
	EmergencyContactPhone VARCHAR(25) NULL,
	SalariedFlag BIT NULL,
	Gender CHAR(1) NULL,
	PayFrequency TINYINT NULL,
	BaseRate MONEY NULL,
	VacationHours SMALLINT NULL,
	SickLeaveHours SMALLINT NULL,
	CurrentFlag BIT NOT NULL,
	SalesPersonFlag BIT NOT NULL,
	DepartmentName VARCHAR(50) NULL,
	StartDate DATE NULL,
	EndDate DATE NULL,
	Status VARCHAR(50) NULL,
	--EmployeePhoto VARCHAR(32000) NULL, -- BLOB
    CONSTRAINT PK PRIMARY KEY (EmployeeKey)
)
;

CREATE TABLE ${schema}DimGeography(
	GeographyKey INTEGER IDENTITY(1,1) NOT NULL,
	City VARCHAR(30) NULL,
	StateProvinceCode VARCHAR(3) NULL,
	StateProvinceName VARCHAR(50) NULL,
	CountryRegionCode VARCHAR(3) NULL,
	EnglishCountryRegionName VARCHAR(50) NULL,
	SpanishCountryRegionName VARCHAR(50) NULL,
	FrenchCountryRegionName VARCHAR(50) NULL,
	PostalCode VARCHAR(15) NULL,
	SalesTerritoryKey INTEGER NULL,
	IpAddressLocator VARCHAR(15) NULL,
    CONSTRAINT PK PRIMARY KEY (GeographyKey)
)
;

CREATE TABLE ${schema}DimOrganization(
	OrganizationKey INTEGER IDENTITY(1,1) NOT NULL,
	ParentOrganizationKey INTEGER NULL,
	PercentageOfOwnership VARCHAR(16) NULL,
	OrganizationName VARCHAR(50) NULL,
	CurrencyKey INTEGER NULL,
    CONSTRAINT PK PRIMARY KEY (OrganizationKey)
)
;

CREATE TABLE ${schema}DimProduct(
	ProductKey INTEGER IDENTITY(1,1) NOT NULL,
	ProductAlternateKey VARCHAR(25) NULL,
	ProductSubcategoryKey INTEGER NULL,
	WeightUnitMeasureCode CHAR(3) NULL,
	SizeUnitMeasureCode CHAR(3) NULL,
	EnglishProductName VARCHAR(50) NOT NULL,
	SpanishProductName VARCHAR(50) NOT NULL,
	FrenchProductName VARCHAR(50) NOT NULL,
	StandardCost MONEY NULL,
	FinishedGoodsFlag BIT NOT NULL,
	Color VARCHAR(15) NOT NULL,
	SafetyStockLevel SMALLINT NULL,
	ReorderPoint SMALLINT NULL,
	ListPrice MONEY NULL,
	Size VARCHAR(50) NULL,
	SizeRange VARCHAR(50) NULL,
	Weight FLOAT NULL,
	DaysToManufacture INTEGER NULL,
	ProductLine CHAR(2) NULL,
	DealerPrice MONEY NULL,
	Class CHAR(2) NULL,
	Style CHAR(2) NULL,
	ModelName VARCHAR(50) NULL,
	--LargePhoto VARCHAR(32000) NULL, -- BLOB
	EnglishDescription VARCHAR(400) NULL,
	FrenchDescription VARCHAR(400) NULL,
	ChineseDescription VARCHAR(400) NULL,
	ArabicDescription VARCHAR(400) NULL,
	HebrewDescription VARCHAR(400) NULL,
	ThaiDescription VARCHAR(400) NULL,
	GermanDescription VARCHAR(400) NULL,
	JapaneseDescription VARCHAR(400) NULL,
	TurkishDescription VARCHAR(400) NULL,
	StartDate DATETIME NULL,
	EndDate DATETIME NULL,
	Status VARCHAR(7) NULL,
    CONSTRAINT PK PRIMARY KEY (ProductKey),
    CONSTRAINT UK_Alternate_StartDate UNIQUE (ProductAlternateKey, StartDate)
)
;

CREATE TABLE ${schema}DimProductCategory(
	ProductCategoryKey INTEGER IDENTITY(1,1) NOT NULL,
	ProductCategoryAlternateKey INTEGER NULL,
	EnglishProductCategoryName VARCHAR(50) NOT NULL,
	SpanishProductCategoryName VARCHAR(50) NOT NULL,
	FrenchProductCategoryName VARCHAR(50) NOT NULL,
    CONSTRAINT PK PRIMARY KEY (ProductCategoryKey),
    CONSTRAINT UK_Alternate UNIQUE (ProductCategoryAlternateKey)
)
;

CREATE TABLE ${schema}DimProductSubcategory(
	ProductSubcategoryKey INTEGER IDENTITY(1,1) NOT NULL,
	ProductSubcategoryAlternateKey INTEGER NULL,
	EnglishProductSubcategoryName VARCHAR(50) NOT NULL,
	SpanishProductSubcategoryName VARCHAR(50) NOT NULL,
	FrenchProductSubcategoryName VARCHAR(50) NOT NULL,
	ProductCategoryKey INTEGER NULL,
    CONSTRAINT PK PRIMARY KEY (ProductSubCategoryKey),
    CONSTRAINT UK_Alternate UNIQUE (ProductSubCategoryAlternateKey)
)
;

CREATE TABLE ${schema}DimPromotion(
	PromotionKey INTEGER IDENTITY(1,1) NOT NULL,
	PromotionAlternateKey INTEGER NULL,
	EnglishPromotionName VARCHAR(255) NULL,
	SpanishPromotionName VARCHAR(255) NULL,
	FrenchPromotionName VARCHAR(255) NULL,
	DiscountPct FLOAT NULL,
	EnglishPromotionType VARCHAR(50) NULL,
	SpanishPromotionType VARCHAR(50) NULL,
	FrenchPromotionType VARCHAR(50) NULL,
	EnglishPromotionCategory VARCHAR(50) NULL,
	SpanishPromotionCategory VARCHAR(50) NULL,
	FrenchPromotionCategory VARCHAR(50) NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NULL,
	MinQty INTEGER NULL,
	MaxQty INTEGER NULL,
    CONSTRAINT PK PRIMARY KEY (PromotionKey),
    CONSTRAINT UK_Alternate UNIQUE (PromotionAlternateKey)
)
;

CREATE TABLE ${schema}DimReseller(
	ResellerKey INTEGER IDENTITY(1,1) NOT NULL,
	GeographyKey INTEGER NULL,
	ResellerAlternateKey VARCHAR(15) NULL,
	Phone VARCHAR(25) NULL,
	BusinessType VARCHAR(20) NOT NULL,
	ResellerName VARCHAR(50) NOT NULL,
	NumberEmployees INTEGER NULL,
	OrderFrequency CHAR(1) NULL,
	OrderMonth TINYINT NULL,
	FirstOrderYear INTEGER NULL,
	LastOrderYear INTEGER NULL,
	ProductLine VARCHAR(50) NULL,
	AddressLine1 VARCHAR(60) NULL,
	AddressLine2 VARCHAR(60) NULL,
	AnnualSales MONEY NULL,
	BankName VARCHAR(50) NULL,
	MinPaymentType TINYINT NULL,
	MinPaymentAmount MONEY NULL,
	AnnualRevenue MONEY NULL,
	YearOpened INTEGER NULL,
    CONSTRAINT PK PRIMARY KEY (ResellerKey),
    CONSTRAINT UK_Alternate UNIQUE (ResellerAlternateKey)
)
;

CREATE TABLE ${schema}DimSalesReason(
	SalesReasonKey INTEGER IDENTITY(1,1) NOT NULL,
	SalesReasonAlternateKey INTEGER NOT NULL,
	SalesReasonName VARCHAR(50) NOT NULL,
	SalesReasonReasonType VARCHAR(50) NOT NULL,
    CONSTRAINT PK PRIMARY KEY (SalesReasonKey)
)
;

CREATE TABLE ${schema}DimSalesTerritory(
	SalesTerritoryKey INTEGER IDENTITY(1,1) NOT NULL,
	SalesTerritoryAlternateKey INTEGER NULL,
	SalesTerritoryRegion VARCHAR(50) NOT NULL,
	SalesTerritoryCountry VARCHAR(50) NOT NULL,
	SalesTerritoryGroup VARCHAR(50) NULL,
	-- SalesTerritoryImage VARCHAR(32000) NULL, -- BLOB
    CONSTRAINT PK PRIMARY KEY (SalesTerritoryKey),
    CONSTRAINT UK_Alternate UNIQUE (SalesTerritoryAlternateKey)
)
;

CREATE TABLE ${schema}DimScenario(
	ScenarioKey INTEGER IDENTITY(1,1) NOT NULL,
	ScenarioName VARCHAR(50) NULL,
    CONSTRAINT PK PRIMARY KEY (ScenarioKey)
)
;

CREATE TABLE ${schema}FactAdditionalInternationalProductDescription(
	ProductKey INTEGER NOT NULL,
	CultureName VARCHAR(50) NOT NULL,
	ProductDescription VARCHAR(32000) NOT NULL,
    CONSTRAINT PK PRIMARY KEY (ProductKey, CultureName)
)
;

CREATE TABLE ${schema}FactCallCenter(
	FactCallCenterID INTEGER IDENTITY(1,1) NOT NULL,
	DateKey INTEGER NOT NULL,
	WageType VARCHAR(15) NOT NULL,
	Shift VARCHAR(20) NOT NULL,
	LevelOneOperators SMALLINT NOT NULL,
	LevelTwoOperators SMALLINT NOT NULL,
	TotalOperators SMALLINT NOT NULL,
	Calls INTEGER NOT NULL,
	AutomaticResponses INTEGER NOT NULL,
	Orders INTEGER NOT NULL,
	IssuesRaised SMALLINT NOT NULL,
	AverageTimePerIssue SMALLINT NOT NULL,
	ServiceGrade FLOAT NOT NULL,
	"Date" DATETIME NULL,
    CONSTRAINT PK PRIMARY KEY (FactCallCenterID),
    CONSTRAINT UK_DateKey_Shift UNIQUE (DateKey, Shift)
)
;

CREATE TABLE ${schema}FactCurrencyRate(
	CurrencyKey INTEGER NOT NULL,
	DateKey INTEGER NOT NULL,
	AverageRate FLOAT NOT NULL,
	EndOfDayRate FLOAT NOT NULL,
	"Date" DATETIME NULL,
    CONSTRAINT PK PRIMARY KEY (CurrencyKey, DateKey)
)
;

CREATE TABLE ${schema}FactFinance(
	FinanceKey INTEGER IDENTITY(1,1) NOT NULL,
	DateKey INTEGER NOT NULL,
	OrganizationKey INTEGER NOT NULL,
	DepartmentGroupKey INTEGER NOT NULL,
	ScenarioKey INTEGER NOT NULL,
	AccountKey INTEGER NOT NULL,
	Amount FLOAT NOT NULL,
	"Date" DATETIME NULL
)
;

CREATE TABLE ${schema}FactInternetSales(
	ProductKey INTEGER NOT NULL,
	OrderDateKey INTEGER NOT NULL,
	DueDateKey INTEGER NOT NULL,
	ShipDateKey INTEGER NOT NULL,
	CustomerKey INTEGER NOT NULL,
	PromotionKey INTEGER NOT NULL,
	CurrencyKey INTEGER NOT NULL,
	SalesTerritoryKey INTEGER NOT NULL,
	SalesOrderNumber VARCHAR(20) NOT NULL,
	SalesOrderLineNumber TINYINT NOT NULL,
	RevisionNumber TINYINT NOT NULL,
	OrderQuantity SMALLINT NOT NULL,
	UnitPrice MONEY NOT NULL,
	ExtendedAmount MONEY NOT NULL,
	UnitPriceDiscountPct FLOAT NOT NULL,
	DiscountAmount FLOAT NOT NULL,
	ProductStandardCost MONEY NOT NULL,
	TotalProductCost MONEY NOT NULL,
	SalesAmount MONEY NOT NULL,
	TaxAmt MONEY NOT NULL,
	Freight MONEY NOT NULL,
	CarrierTrackingNumber VARCHAR(25) NULL,
	CustomerPONumber VARCHAR(25) NULL,
	OrderDate DATETIME NULL,
	DueDate DATETIME NULL,
	ShipDate DATETIME NULL,
    CONSTRAINT PK PRIMARY KEY (SalesOrderNumber, SalesOrderLineNumber)
)
;

CREATE TABLE ${schema}FactInternetSalesReason(
	SalesOrderNumber VARCHAR(20) NOT NULL,
	SalesOrderLineNumber TINYINT NOT NULL,
	SalesReasonKey INTEGER NOT NULL,
    CONSTRAINT PK PRIMARY KEY (SalesOrderNumber, SalesOrderLineNumber, SalesReasonKey)
)
;

CREATE TABLE ${schema}FactProductInventory(
	ProductKey INTEGER NOT NULL,
	DateKey INTEGER NOT NULL,
	MovementDate DATE NOT NULL,
	UnitCost MONEY NOT NULL,
	UnitsIn INTEGER NOT NULL,
	UnitsOut INTEGER NOT NULL,
	UnitsBalance INTEGER NOT NULL,
    CONSTRAINT PK PRIMARY KEY (ProductKey, DateKey)
)
;

CREATE TABLE ${schema}FactResellerSales(
	ProductKey INTEGER NOT NULL,
	OrderDateKey INTEGER NOT NULL,
	DueDateKey INTEGER NOT NULL,
	ShipDateKey INTEGER NOT NULL,
	ResellerKey INTEGER NOT NULL,
	EmployeeKey INTEGER NOT NULL,
	PromotionKey INTEGER NOT NULL,
	CurrencyKey INTEGER NOT NULL,
	SalesTerritoryKey INTEGER NOT NULL,
	SalesOrderNumber VARCHAR(20) NOT NULL,
	SalesOrderLineNumber TINYINT NOT NULL,
	RevisionNumber TINYINT NULL,
	OrderQuantity SMALLINT NULL,
	UnitPrice MONEY NULL,
	ExtendedAmount MONEY NULL,
	UnitPriceDiscountPct FLOAT NULL,
	DiscountAmount FLOAT NULL,
	ProductStandardCost MONEY NULL,
	TotalProductCost MONEY NULL,
	SalesAmount MONEY NULL,
	TaxAmt MONEY NULL,
	Freight MONEY NULL,
	CarrierTrackingNumber VARCHAR(25) NULL,
	CustomerPONumber VARCHAR(25) NULL,
	OrderDate DATETIME NULL,
	DueDate DATETIME NULL,
	ShipDate DATETIME NULL,
    CONSTRAINT PK PRIMARY KEY (SalesOrderNumber, SalesOrderLineNumber)
)
;

CREATE TABLE ${schema}FactSalesQuota(
	SalesQuotaKey INTEGER IDENTITY(1,1) NOT NULL,
	EmployeeKey INTEGER NOT NULL,
	DateKey INTEGER NOT NULL,
	CalendarYear SMALLINT NOT NULL,
	CalendarQuarter TINYINT NOT NULL,
	SalesAmountQuota MONEY NOT NULL,
	"Date" DATETIME NULL,
    CONSTRAINT PK PRIMARY KEY (SalesQuotaKey)
)
;

CREATE TABLE ${schema}FactSurveyResponse(
	SurveyResponseKey INTEGER IDENTITY(1,1) NOT NULL,
	DateKey INTEGER NOT NULL,
	CustomerKey INTEGER NOT NULL,
	ProductCategoryKey INTEGER NOT NULL,
	EnglishProductCategoryName VARCHAR(50) NOT NULL,
	ProductSubcategoryKey INTEGER NOT NULL,
	EnglishProductSubcategoryName VARCHAR(50) NOT NULL,
	"Date" DATETIME NULL,
    CONSTRAINT PK PRIMARY KEY (SurveyResponseKey)
)
;

CREATE TABLE ${schema}NewFactCurrencyRate(
	AverageRate REAL NULL,
	CurrencyID VARCHAR(3) NULL,
	CurrencyDate DATE NULL,
	EndOfDayRate REAL NULL,
	CurrencyKey INTEGER NULL,
	DateKey INTEGER NULL
)
;

CREATE TABLE ${schema}ProspectiveBuyer(
	ProspectiveBuyerKey INTEGER IDENTITY(1,1) NOT NULL,
	ProspectAlternateKey VARCHAR(15) NULL,
	FirstName VARCHAR(50) NULL,
	MiddleName VARCHAR(50) NULL,
	LastName VARCHAR(50) NULL,
	BirthDate DATETIME NULL,
	MaritalStatus CHAR(1) NULL,
	Gender VARCHAR(1) NULL,
	EmailAddress VARCHAR(50) NULL,
	YearlyIncome MONEY NULL,
	TotalChildren TINYINT NULL,
	NumberChildrenAtHome TINYINT NULL,
	Education VARCHAR(40) NULL,
	Occupation VARCHAR(100) NULL,
	HouseOwnerFlag CHAR(1) NULL,
	NumberCarsOwned TINYINT NULL,
	AddressLine1 VARCHAR(120) NULL,
	AddressLine2 VARCHAR(120) NULL,
	City VARCHAR(30) NULL,
	StateProvinceCode VARCHAR(3) NULL,
	PostalCode VARCHAR(15) NULL,
	Phone VARCHAR(20) NULL,
	Salutation VARCHAR(8) NULL,
	Unknown INTEGER NULL,
    CONSTRAINT PK PRIMARY KEY (ProspectiveBuyerKey)
)
;



-- foreign keys


ALTER TABLE ${schema}DimAccount ADD 
    CONSTRAINT FK_DimAccount_DimAccount FOREIGN KEY 
    (
        ParentAccountKey
    ) REFERENCES ${schema}DimAccount (AccountKey) NOCHECK
;

ALTER TABLE ${schema}DimCustomer ADD
	CONSTRAINT FK_DimCustomer_DimGeography FOREIGN KEY
	(
		GeographyKey
	)
	REFERENCES ${schema}DimGeography (GeographyKey) NOCHECK
;

ALTER TABLE ${schema}DimDepartmentGroup ADD 
    CONSTRAINT FK_DimDepartmentGroup_DimDepartmentGroup FOREIGN KEY 
    (
        ParentDepartmentGroupKey
    ) REFERENCES ${schema}DimDepartmentGroup (DepartmentGroupKey) NOCHECK
;

ALTER TABLE ${schema}DimEmployee ADD 
    CONSTRAINT FK_DimEmployee_DimSalesTerritory FOREIGN KEY 
    (
        SalesTerritoryKey
    ) REFERENCES ${schema}DimSalesTerritory (SalesTerritoryKey) NOCHECK,
	CONSTRAINT FK_DimEmployee_DimEmployee FOREIGN KEY 
    (
        ParentEmployeeKey
    ) REFERENCES ${schema}DimEmployee (EmployeeKey) NOCHECK
;

ALTER TABLE ${schema}DimGeography ADD
    CONSTRAINT FK_DimGeography_DimSalesTerritory  FOREIGN KEY 
    (
        SalesTerritoryKey
    ) REFERENCES ${schema}DimSalesTerritory (SalesTerritoryKey) NOCHECK
;    

ALTER TABLE ${schema}DimOrganization ADD 
    CONSTRAINT FK_DimOrganization_DimCurrency FOREIGN KEY 
    (
        CurrencyKey
    ) REFERENCES ${schema}DimCurrency (CurrencyKey) NOCHECK,
    CONSTRAINT FK_DimOrganization_DimOrganization FOREIGN KEY 
    (
        ParentOrganizationKey
    ) REFERENCES ${schema}DimOrganization (OrganizationKey) NOCHECK
;

ALTER TABLE ${schema}DimProduct ADD 
    CONSTRAINT FK_DimProduct_DimProductSubcategory FOREIGN KEY 
    (
        ProductSubcategoryKey
    ) REFERENCES ${schema}DimProductSubcategory (ProductSubcategoryKey) NOCHECK
;

ALTER TABLE ${schema}DimProductSubcategory ADD 
    CONSTRAINT FK_DimProductSubcategory_DimProductCategory FOREIGN KEY 
    (
        ProductCategoryKey
    ) REFERENCES ${schema}DimProductCategory (ProductCategoryKey) NOCHECK
;

ALTER TABLE ${schema}DimReseller ADD
	CONSTRAINT FK_DimReseller_DimGeography FOREIGN KEY
	(
		GeographyKey
	) REFERENCES ${schema}DimGeography (GeographyKey) NOCHECK
;

ALTER TABLE ${schema}FactCallCenter ADD 
    CONSTRAINT FK_FactCallCenter_DimDate FOREIGN KEY 
    (
        DateKey
    ) REFERENCES ${schema}DimDate (DateKey) NOCHECK
;

ALTER TABLE ${schema}FactCurrencyRate ADD 
    CONSTRAINT FK_FactCurrencyRate_DimDate FOREIGN KEY 
    (
       DateKey
    ) REFERENCES ${schema}DimDate (DateKey) NOCHECK,
	CONSTRAINT FK_FactCurrencyRate_DimCurrency FOREIGN KEY 
    (
       CurrencyKey
    ) REFERENCES ${schema}DimCurrency (CurrencyKey) NOCHECK
;

ALTER TABLE ${schema}FactFinance ADD 
    CONSTRAINT FK_FactFinance_DimScenario FOREIGN KEY 
    (
        ScenarioKey
    ) REFERENCES ${schema}DimScenario (ScenarioKey) NOCHECK,
    CONSTRAINT FK_FactFinance_DimOrganization FOREIGN KEY 
    (
        OrganizationKey
    ) REFERENCES ${schema}DimOrganization (OrganizationKey) NOCHECK,
    CONSTRAINT FK_FactFinance_DimDepartmentGroup FOREIGN KEY 
    (
        DepartmentGroupKey
    ) REFERENCES ${schema}DimDepartmentGroup (DepartmentGroupKey) NOCHECK,
	CONSTRAINT FK_FactFinance_DimDate FOREIGN KEY 
    (
        DateKey
    ) REFERENCES ${schema}DimDate (DateKey) NOCHECK,
	CONSTRAINT FK_FactFinance_DimAccount FOREIGN KEY 
    (
        AccountKey
    ) REFERENCES ${schema}DimAccount (AccountKey) NOCHECK	
;

ALTER TABLE ${schema}FactInternetSales ADD 
    CONSTRAINT FK_FactInternetSales_DimCurrency FOREIGN KEY 
    (
        CurrencyKey
    ) REFERENCES ${schema}DimCurrency (CurrencyKey) NOCHECK,
	 CONSTRAINT FK_FactInternetSales_DimCustomer FOREIGN KEY 
    (
        CustomerKey
    ) REFERENCES ${schema}DimCustomer (CustomerKey) NOCHECK,
	 CONSTRAINT FK_FactInternetSales_DimDate FOREIGN KEY 
    (
        OrderDateKey
    ) REFERENCES ${schema}DimDate (DateKey) NOCHECK,
	 CONSTRAINT FK_FactInternetSales_DimDate1 FOREIGN KEY 
    (
        DueDateKey
    ) REFERENCES ${schema}DimDate (DateKey) NOCHECK,
	 CONSTRAINT FK_FactInternetSales_DimDate2 FOREIGN KEY 
    (
        ShipDateKey
    ) REFERENCES ${schema}DimDate (DateKey) NOCHECK,
	 CONSTRAINT FK_FactInternetSales_DimProduct FOREIGN KEY 
    (
        ProductKey
    ) REFERENCES ${schema}DimProduct (ProductKey) NOCHECK,
	CONSTRAINT FK_FactInternetSales_DimPromotion FOREIGN KEY 
    (
        PromotionKey
    ) REFERENCES ${schema}DimPromotion (PromotionKey) NOCHECK,
	CONSTRAINT FK_FactInternetSales_DimSalesTerritory FOREIGN KEY 
    (
        SalesTerritoryKey
    ) REFERENCES ${schema}DimSalesTerritory (SalesTerritoryKey) NOCHECK
;

ALTER TABLE ${schema}FactInternetSalesReason ADD 
    CONSTRAINT FK_FactInternetSalesReason_FactInternetSales FOREIGN KEY 
    (
        SalesOrderNumber, SalesOrderLineNumber
    ) REFERENCES ${schema}FactInternetSales (SalesOrderNumber, SalesOrderLineNumber),
	CONSTRAINT FK_FactInternetSalesReason_DimSalesReason FOREIGN KEY
	(
		SalesReasonKey
	) REFERENCES ${schema}DimSalesReason (SalesReasonKey) NOCHECK
;

ALTER TABLE ${schema}FactProductInventory ADD 
    CONSTRAINT FK_FactProductInventory_DimDate FOREIGN KEY 
    (
        DateKey
    ) REFERENCES ${schema}DimDate (DateKey) NOCHECK,
	CONSTRAINT FK_FactProductInventory_DimProduct FOREIGN KEY
	(
		ProductKey
	) REFERENCES ${schema}DimProduct (ProductKey) NOCHECK
;



ALTER TABLE ${schema}FactResellerSales ADD 
    CONSTRAINT FK_FactResellerSales_DimCurrency FOREIGN KEY(CurrencyKey)
			REFERENCES ${schema}DimCurrency (CurrencyKey) NOCHECK,
	CONSTRAINT FK_FactResellerSales_DimDate FOREIGN KEY(OrderDateKey)
			REFERENCES ${schema}DimDate (DateKey) NOCHECK,
	CONSTRAINT FK_FactResellerSales_DimDate1 FOREIGN KEY(DueDateKey)
			REFERENCES ${schema}DimDate (DateKey) NOCHECK,
	CONSTRAINT FK_FactResellerSales_DimDate2 FOREIGN KEY(ShipDateKey)
			REFERENCES ${schema}DimDate (DateKey) NOCHECK,
	CONSTRAINT FK_FactResellerSales_DimEmployee FOREIGN KEY(EmployeeKey)
			REFERENCES ${schema}DimEmployee (EmployeeKey) NOCHECK,
	CONSTRAINT FK_FactResellerSales_DimProduct FOREIGN KEY(ProductKey)
			REFERENCES ${schema}DimProduct (ProductKey) NOCHECK,
	CONSTRAINT FK_FactResellerSales_DimPromotion FOREIGN KEY(PromotionKey)
			REFERENCES ${schema}DimPromotion (PromotionKey) NOCHECK,
	CONSTRAINT FK_FactResellerSales_DimReseller FOREIGN KEY(ResellerKey)
			REFERENCES ${schema}DimReseller (ResellerKey) NOCHECK,
	CONSTRAINT FK_FactResellerSales_DimSalesTerritory FOREIGN KEY(SalesTerritoryKey)
			REFERENCES ${schema}DimSalesTerritory (SalesTerritoryKey) NOCHECK
;

ALTER TABLE ${schema}FactSalesQuota ADD 
    CONSTRAINT FK_FactSalesQuota_DimEmployee FOREIGN KEY(EmployeeKey)
			REFERENCES ${schema}DimEmployee (EmployeeKey) NOCHECK,
    CONSTRAINT FK_FactSalesQuota_DimDate FOREIGN KEY(DateKey)
			REFERENCES ${schema}DimDate (DateKey) NOCHECK
;

ALTER TABLE ${schema}FactSurveyResponse  ADD 
    CONSTRAINT FK_FactSurveyResponse_DateKey FOREIGN KEY(DateKey)
			REFERENCES ${schema}DimDate (DateKey) NOCHECK,
	CONSTRAINT FK_FactSurveyResponse_CustomerKey FOREIGN KEY(CustomerKey)
			REFERENCES ${schema}DimCustomer (CustomerKey) NOCHECK
;



--- views

CREATE VIEW ${schema}vDMPrep
AS
    SELECT
        pc.EnglishProductCategoryName
        ,Coalesce(p.ModelName, p.EnglishProductName) AS Model
        ,c.CustomerKey
        ,s.SalesTerritoryGroup AS Region
        ,CASE
            WHEN Month(GetDate()) < Month(c.BirthDate)
                THEN DateDiff(yy,c.BirthDate,GetDate()) - 1
            WHEN Month(GetDate()) = Month(c.BirthDate)
            AND Day(GetDate()) < Day(c.BirthDate)
                THEN DateDiff(yy,c.BirthDate,GetDate()) - 1
            ELSE DateDiff(yy,c.BirthDate,GetDate())
        END AS Age
        ,CASE
            WHEN c.YearlyIncome < 40000 THEN 'Low'
            WHEN c.YearlyIncome > 60000 THEN 'High'
            ELSE 'Moderate'
        END AS IncomeGroup
        ,d.CalendarYear
        ,d.FiscalYear
        ,d.MonthNumberOfYear AS Month
        ,f.SalesOrderNumber AS OrderNumber
        ,f.SalesOrderLineNumber AS LineNumber
        ,f.OrderQuantity AS Quantity
        ,f.ExtendedAmount AS Amount  
    FROM
        ${schema}FactInternetSales f
    INNER JOIN ${schema}DimDate d
        ON f.OrderDateKey = d.DateKey
    INNER JOIN ${schema}DimProduct p
        ON f.ProductKey = p.ProductKey
    INNER JOIN ${schema}DimProductSubcategory psc
        ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
    INNER JOIN ${schema}DimProductCategory pc
        ON psc.ProductCategoryKey = pc.ProductCategoryKey
    INNER JOIN ${schema}DimCustomer c
        ON f.CustomerKey = c.CustomerKey
    INNER JOIN ${schema}DimGeography g
        ON c.GeographyKey = g.GeographyKey
    INNER JOIN ${schema}DimSalesTerritory s
        ON g.SalesTerritoryKey = s.SalesTerritoryKey 
;

CREATE VIEW ${schema}vTargetMail 
AS
    SELECT
        c.CustomerKey, 
        c.GeographyKey, 
        c.CustomerAlternateKey, 
        c.Title, 
        c.FirstName, 
        c.MiddleName, 
        c.LastName, 
        c.NameStyle, 
        c.BirthDate, 
        c.MaritalStatus, 
        c.Suffix, 
        c.Gender, 
        c.EmailAddress, 
        c.YearlyIncome, 
        c.TotalChildren, 
        c.NumberChildrenAtHome, 
        c.EnglishEducation, 
        c.SpanishEducation, 
        c.FrenchEducation, 
        c.EnglishOccupation, 
        c.SpanishOccupation, 
        c.FrenchOccupation, 
        c.HouseOwnerFlag, 
        c.NumberCarsOwned, 
        c.AddressLine1, 
        c.AddressLine2, 
        c.Phone, 
        c.DateFirstPurchase, 
        c.CommuteDistance, 
        x.Region, 
        x.Age, 
        CASE x.Bikes 
            WHEN 0 THEN 0 
            ELSE 1 
        END AS BikeBuyer
    FROM
        ${schema}DimCustomer c INNER JOIN (
            SELECT
                CustomerKey
                ,Region
                ,Age
                ,Sum(
                    CASE EnglishProductCategoryName 
                        WHEN 'Bikes' THEN 1 
                        ELSE 0 
                    END) AS Bikes
            FROM
                ${schema}vDMPrep 
            GROUP BY
                CustomerKey
                ,Region
                ,Age
            ) AS x
        ON c.CustomerKey = x.CustomerKey
;



/*
-- vTimeSeries view supports the creation of time series data mining models.
--      - Replaces earlier bike models with successor models.
--      - Abbreviates model names to improve readability in mining model viewer
--      - Concatenates model and region so that table only has one input.
--      - Creates a date field indexed to monthly reporting date for use in prediction.
CREATE VIEW ${schema}vTimeSeries 
AS
    SELECT 
        CASE Model 
            WHEN 'Mountain-100' THEN 'M200' 
            WHEN 'Road-150' THEN 'R250' 
            WHEN 'Road-650' THEN 'R750' 
            WHEN 'Touring-1000' THEN 'T1000' 
            ELSE Left(Model, 1) + Right(Model, 3) 
        END + ' ' + Region AS ModelRegion 
        ,(Convert(Integer, CalendarYear) * 100) + Convert(Integer, Month) AS TimeIndex 
        ,Sum(Quantity) AS Quantity 
        ,Sum(Amount) AS Amount
		,CalendarYear
		,Month
		,${schema}udfBuildISO8601Date (CalendarYear, Month, 25)
		as ReportingDate
    FROM 
        ${schema}vDMPrep 
    WHERE 
        Model IN ('Mountain-100', 'Mountain-200', 'Road-150', 'Road-250', 
            'Road-650', 'Road-750', 'Touring-1000') 
    GROUP BY 
        CASE Model 
            WHEN 'Mountain-100' THEN 'M200' 
            WHEN 'Road-150' THEN 'R250' 
            WHEN 'Road-650' THEN 'R750' 
            WHEN 'Touring-1000' THEN 'T1000' 
            ELSE Left(Model,1) + Right(Model,3) 
        END + ' ' + Region 
        ,(Convert(Integer, CalendarYear) * 100) + Convert(Integer, Month)
		,CalendarYear
		,Month
		,${schema}udfBuildISO8601Date (CalendarYear, Month, 25)
;

*/