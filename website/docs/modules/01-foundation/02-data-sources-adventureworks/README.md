# Module 2: AdventureWorks OLTP & Power Query Transformation (1 ชั่วโมง)

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- เข้าใจ AdventureWorks OLTP Database Structure
- ใช้ Power Query สร้าง Dimensional Model
- Transform OLTP Data เป็น Star Schema
- สร้าง Date Dimension และ Business Logic
- Optimize Power Query Performance

## 📚 เนื้อหาบทเรียน (60 นาที)

### 2.1 AdventureWorks OLTP Overview (15 นาที)

#### 2.1.1 OLTP vs OLAP
```
OLTP (Online Transaction Processing)
├── Normalized Structure
├── Transactional Data
├── Many Small Tables
├── Fast Writes
└── Current Data

OLAP (Online Analytical Processing)
├── Denormalized Structure
├── Analytical Data
├── Few Large Tables
├── Fast Reads
└── Historical Data
```

#### 2.1.2 AdventureWorks OLTP Structure
```sql
-- Key OLTP Tables
Sales.SalesOrderHeader      -- 31,465 orders
Sales.SalesOrderDetail      -- 121,317 line items
Sales.Customer              -- 19,820 customers
Production.Product          -- 504 products
Person.Person               -- 19,972 people
Sales.SalesTerritory        -- 10 territories
```

#### 2.1.3 Business Context
- **Company**: AdventureWorks Cycles - Bicycle Manufacturer
- **Business Model**: B2B และ B2C Sales
- **Products**: Bicycles, Components, Accessories, Clothing
- **Time Period**: 2005-2014 (10 years of transactional data)
- **Total Revenue**: $109M+ across all sales

### 2.2 Power Query Transformation Strategy (20 นาที)

#### 2.2.1 Transformation Approach
```
OLTP Tables → Power Query → Star Schema
├── SalesOrderHeader + SalesOrderDetail → FactSales
├── Customer + Person + Address → DimCustomer
├── Product + ProductCategory → DimProduct
├── SalesPerson → DimSalesPerson
├── SalesTerritory → DimTerritory
└── Custom Date Table → DimDate
```

#### 2.2.2 Fact Table Creation
```m
// Create FactSales Table
let
    Source = Sql.Database("localhost", "AdventureWorks2019"),
    SalesOrderHeader = Source{[Schema="Sales",Item="SalesOrderHeader"]}[Data],
    SalesOrderDetail = Source{[Schema="Sales",Item="SalesOrderDetail"]}[Data],
    
    // Join Sales tables
    JoinedTables = Table.NestedJoin(
        SalesOrderHeader, 
        {"SalesOrderID"}, 
        SalesOrderDetail, 
        {"SalesOrderID"}, 
        "Details", 
        JoinKind.Inner
    ),
    
    // Expand details
    ExpandedDetails = Table.ExpandTableColumn(
        JoinedTables, 
        "Details", 
        {
            "ProductID", 
            "OrderQty", 
            "UnitPrice", 
            "UnitPriceDiscount", 
            "LineTotal"
        }
    ),
    
    // Add calculated columns
    AddCalculations = Table.AddColumn(
        ExpandedDetails, 
        "NetAmount", 
        each [LineTotal] * (1 - [UnitPriceDiscount])
    ),
    AddCalculations2 = Table.AddColumn(
        AddCalculations, 
        "DiscountAmount", 
        each [LineTotal] * [UnitPriceDiscount]
    ),
    AddCalculations3 = Table.AddColumn(
        AddCalculations2, 
        "GrossProfit", 
        each [NetAmount] - [OrderQty] * [UnitPrice]
    ),
    
    // Select final columns
    SelectColumns = Table.SelectColumns(
        AddCalculations3,
        {
            "SalesOrderID",
            "SalesOrderDetailID", 
            "CustomerID",
            "SalesPersonID",
            "TerritoryID",
            "ProductID",
            "OrderDate",
            "ShipDate",
            "OrderQty",
            "UnitPrice",
            "LineTotal",
            "NetAmount",
            "DiscountAmount",
            "GrossProfit"
        }
    ),
    
    // Clean data
    CleanData = Table.SelectRows(
        SelectColumns, 
        each [OrderDate] <> null and [NetAmount] > 0
    )
in
    CleanData
```

#### 2.2.3 Dimension Tables Creation
```m
// Create DimCustomer
let
    Source = Sql.Database("localhost", "AdventureWorks2019"),
    Customer = Source{[Schema="Sales",Item="Customer"]}[Data],
    Person = Source{[Schema="Person",Item="Person"]}[Data],
    Address = Source{[Schema="Person",Item="Address"]}[Data],
    StateProvince = Source{[Schema="Person",Item="StateProvince"]}[Data],
    CountryRegion = Source{[Schema="Person",Item="CountryRegion"]}[Data],
    
    // Join customer tables
    CustomerPerson = Table.NestedJoin(
        Customer, 
        {"PersonID"}, 
        Person, 
        {"BusinessEntityID"}, 
        "Person", 
        JoinKind.LeftOuter
    ),
    ExpandedPerson = Table.ExpandTableColumn(
        CustomerPerson, 
        "Person", 
        {"FirstName", "LastName", "EmailPromotion"}
    ),
    
    // Add full name
    AddFullName = Table.AddColumn(
        ExpandedPerson, 
        "FullName", 
        each [FirstName] & " " & [LastName]
    ),
    
    // Join address information
    CustomerAddress = Table.NestedJoin(
        AddFullName, 
        {"CustomerID"}, 
        Address, 
        {"AddressID"}, 
        "Address", 
        JoinKind.LeftOuter
    ),
    ExpandedAddress = Table.ExpandTableColumn(
        CustomerAddress, 
        "Address", 
        {"AddressLine1", "City", "StateProvinceID"}
    ),
    
    // Join state/province
    AddressStateProvince = Table.NestedJoin(
        ExpandedAddress, 
        {"StateProvinceID"}, 
        StateProvince, 
        {"StateProvinceID"}, 
        "StateProvince", 
        JoinKind.LeftOuter
    ),
    ExpandedStateProvince = Table.ExpandTableColumn(
        AddressStateProvince, 
        "StateProvince", 
        {"Name", "CountryRegionCode"}
    ),
    
    // Join country/region
    StateProvinceCountry = Table.NestedJoin(
        ExpandedStateProvince, 
        {"CountryRegionCode"}, 
        CountryRegion, 
        {"CountryRegionCode"}, 
        "CountryRegion", 
        JoinKind.LeftOuter
    ),
    ExpandedCountryRegion = Table.ExpandTableColumn(
        StateProvinceCountry, 
        "CountryRegion", 
        {"Name"}
    ),
    
    // Add customer segments
    AddCustomerSegment = Table.AddColumn(
        ExpandedCountryRegion,
        "CustomerSegment",
        each if [CustomerID] <= 1000 then "Early Adopter"
             else if [CustomerID] <= 5000 then "Growth"
             else if [CustomerID] <= 15000 then "Mature"
             else "Late Adopter"
    ),
    
    // Final column selection
    SelectColumns = Table.SelectColumns(
        AddCustomerSegment,
        {
            "CustomerID",
            "FullName",
            "EmailPromotion",
            "AddressLine1",
            "City",
            "StateProvinceName",
            "CountryRegionName",
            "CustomerSegment"
        }
    )
in
    SelectColumns
```

### 2.3 Date Dimension Creation (15 นาที)

#### 2.3.1 Date Dimension M Code
```m
// Create Date Dimension
let
    StartDate = #date(2005, 1, 1),
    EndDate = #date(2014, 12, 31),
    NumberOfDays = Duration.Days(EndDate - StartDate),
    DateList = List.Dates(StartDate, NumberOfDays + 1, #duration(1, 0, 0, 0)),
    TableFromList = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}),
    
    // Add date components
    AddYear = Table.AddColumn(TableFromList, "Year", each Date.Year([Date])),
    AddMonth = Table.AddColumn(AddYear, "Month", each Date.Month([Date])),
    AddDay = Table.AddColumn(AddMonth, "Day", each Date.Day([Date])),
    AddQuarter = Table.AddColumn(AddDay, "Quarter", each Date.QuarterOfYear([Date])),
    AddWeekday = Table.AddColumn(AddQuarter, "Weekday", each Date.DayOfWeek([Date])),
    
    // Add text representations
    AddMonthName = Table.AddColumn(AddWeekday, "MonthName", each Date.MonthName([Date])),
    AddQuarterName = Table.AddColumn(AddMonthName, "QuarterName", each "Q" & Text.From(Date.QuarterOfYear([Date]))),
    AddYearMonth = Table.AddColumn(AddQuarterName, "YearMonth", each Date.Year([Date]) * 100 + Date.Month([Date])),
    AddYearQuarter = Table.AddColumn(AddYearMonth, "YearQuarter", each Date.Year([Date]) * 10 + Date.QuarterOfYear([Date])),
    
    // Add business logic
    AddFiscalYear = Table.AddColumn(AddYearQuarter, "FiscalYear", each if Date.Month([Date]) >= 7 then Date.Year([Date]) + 1 else Date.Year([Date])),
    AddFiscalQuarter = Table.AddColumn(AddFiscalYear, "FiscalQuarter", each if Date.Month([Date]) >= 7 then Date.QuarterOfYear([Date]) - 2 else Date.QuarterOfYear([Date]) + 2),
    AddIsWeekend = Table.AddColumn(AddFiscalQuarter, "IsWeekend", each Date.DayOfWeek([Date]) >= 6),
    AddIsHoliday = Table.AddColumn(AddIsWeekend, "IsHoliday", each false), // Can be expanded with holiday logic
    
    // Add sorting columns
    AddMonthSort = Table.AddColumn(AddIsHoliday, "MonthSort", each Date.Month([Date])),
    AddQuarterSort = Table.AddColumn(AddMonthSort, "QuarterSort", each Date.QuarterOfYear([Date])),
    
    // Set data types
    SetDataTypes = Table.TransformColumnTypes(AddQuarterSort, {
        {"Date", type date},
        {"Year", Int64.Type},
        {"Month", Int64.Type},
        {"Day", Int64.Type},
        {"Quarter", Int64.Type},
        {"Weekday", Int64.Type},
        {"MonthName", type text},
        {"QuarterName", type text},
        {"YearMonth", Int64.Type},
        {"YearQuarter", Int64.Type},
        {"FiscalYear", Int64.Type},
        {"FiscalQuarter", Int64.Type},
        {"IsWeekend", type logical},
        {"IsHoliday", type logical},
        {"MonthSort", Int64.Type},
        {"QuarterSort", Int64.Type}
    })
in
    SetDataTypes
```

#### 2.3.2 Date Dimension Features
- **Calendar Hierarchy**: Year → Quarter → Month → Day
- **Fiscal Year**: July to June fiscal year
- **Business Logic**: Weekend, Holiday flags
- **Sorting Columns**: For proper ordering in visuals
- **Text Representations**: Month names, quarter names

### 2.4 Product Dimension Enhancement (10 นาที)

#### 2.4.1 Product Dimension M Code
```m
// Create Enhanced DimProduct
let
    Source = Sql.Database("localhost", "AdventureWorks2019"),
    Product = Source{[Schema="Production",Item="Product"]}[Data],
    ProductCategory = Source{[Schema="Production",Item="ProductCategory"]}[Data],
    ProductSubcategory = Source{[Schema="Production",Item="ProductSubcategory"]}[Data],
    ProductModel = Source{[Schema="Production",Item="ProductModel"]}[Data],
    
    // Join product tables
    ProductSubcategoryJoin = Table.NestedJoin(
        Product, 
        {"ProductSubcategoryID"}, 
        ProductSubcategory, 
        {"ProductSubcategoryID"}, 
        "Subcategory", 
        JoinKind.LeftOuter
    ),
    ExpandedSubcategory = Table.ExpandTableColumn(
        ProductSubcategoryJoin, 
        "Subcategory", 
        {"Name", "ProductCategoryID"}
    ),
    
    ProductCategoryJoin = Table.NestedJoin(
        ExpandedSubcategory, 
        {"ProductCategoryID"}, 
        ProductCategory, 
        {"ProductCategoryID"}, 
        "Category", 
        JoinKind.LeftOuter
    ),
    ExpandedCategory = Table.ExpandTableColumn(
        ProductCategoryJoin, 
        "Category", 
        {"Name"}
    ),
    
    ProductModelJoin = Table.NestedJoin(
        ExpandedCategory, 
        {"ProductModelID"}, 
        ProductModel, 
        {"ProductModelID"}, 
        "Model", 
        JoinKind.LeftOuter
    ),
    ExpandedModel = Table.ExpandTableColumn(
        ProductModelJoin, 
        "Model", 
        {"Name"}
    ),
    
    // Add calculated columns
    AddProfitMargin = Table.AddColumn(
        ExpandedModel, 
        "ProfitMargin", 
        each if [ListPrice] <> 0 then ([ListPrice] - [StandardCost]) / [ListPrice] else 0
    ),
    AddProfitAmount = Table.AddColumn(
        AddProfitMargin, 
        "ProfitAmount", 
        each [ListPrice] - [StandardCost]
    ),
    AddProductSegment = Table.AddColumn(
        AddProfitAmount,
        "ProductSegment",
        each if [ListPrice] >= 1000 then "Premium"
             else if [ListPrice] >= 500 then "Standard"
             else "Basic"
    ),
    AddProductStatus = Table.AddColumn(
        AddProductSegment,
        "ProductStatus",
        each if [DiscontinuedDate] <> null then "Discontinued"
             else if [SellStartDate] > DateTime.LocalNow() then "Future"
             else "Active"
    )
in
    AddProductStatus
```

## 🛠️ การปฏิบัติ (30 นาที)

### Lab 1: OLTP to Star Schema Transformation (15 นาที)
1. **Connect to AdventureWorks OLTP**
   - เชื่อมต่อกับ AdventureWorks OLTP
   - สำรวจ OLTP Structure
   - เข้าใจ Table Relationships

2. **Create Fact Table**
   - สร้าง FactSales จาก SalesOrderHeader + SalesOrderDetail
   - เพิ่ม Calculated Columns
   - Clean และ Validate Data

### Lab 2: Dimension Tables Creation (15 นาที)
1. **Create Dimension Tables**
   - สร้าง DimCustomer
   - สร้าง DimProduct
   - สร้าง DimDate

2. **Build Star Schema**
   - สร้าง Relationships
   - ทดสอบ Data Model
   - Validate Calculations

## 📊 ข้อมูลตัวอย่าง

### AdventureWorks OLTP Business Scenarios
- **Sales Transaction Analysis**: การวิเคราะห์ธุรกรรมการขาย
- **Customer Behavior**: พฤติกรรมลูกค้า
- **Product Performance**: ประสิทธิภาพผลิตภัณฑ์
- **Territory Analysis**: การวิเคราะห์พื้นที่ขาย

### Transformation Results
- **FactSales**: 121,317 records
- **DimCustomer**: 19,820 customers
- **DimProduct**: 504 products
- **DimDate**: 3,652 days
- **Star Schema**: 5 tables with proper relationships

## 🎯 แบบฝึกหัด

### Exercise 1: OLTP to Star Schema
**สถานการณ์**: Transform AdventureWorks OLTP เป็น Star Schema

**งาน**:
1. สร้าง FactSales Table
2. สร้าง Dimension Tables
3. สร้าง Date Dimension
4. สร้าง Star Schema Relationships

### Exercise 2: Business Logic Implementation
**สถานการณ์**: เพิ่ม Business Logic ใน Data Model

**งาน**:
1. สร้าง Customer Segments
2. สร้าง Product Categories
3. เพิ่ม Calculated Columns
4. ทดสอบ Data Model

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- AdventureWorks OLTP Structure
- Power Query Transformation Strategy
- Star Schema Creation
- Date Dimension และ Business Logic

### สิ่งที่จะเรียนต่อไป:
- Power Query และ Data Transformation
- Sales Analytics Dashboard
- Customer Analytics และ Segmentation

## 🔗 ลิงก์ที่เป็นประโยชน์

- [AdventureWorks OLTP](https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure)
- [Power Query M Formula Language](https://docs.microsoft.com/en-us/powerquery-m/)
- [Star Schema Design](https://en.wikipedia.org/wiki/Star_schema)
- [Data Transformation Best Practices](https://docs.microsoft.com/en-us/power-query/best-practices)

## 📞 คำถามที่พบบ่อย

**Q: OLTP แตกต่างจาก OLAP อย่างไร?**
A: OLTP เป็น Transactional Database, OLAP เป็น Analytical Database

**Q: ทำไมต้องสร้าง Star Schema?**
A: Star Schema เหมาะสำหรับการวิเคราะห์ข้อมูลและสร้าง Reports

**Q: Date Dimension สำคัญอย่างไร?**
A: ช่วยในการวิเคราะห์ตามเวลาและสร้าง Time Intelligence

---

**หมายเหตุ**: การ Transform OLTP เป็น Star Schema เป็นพื้นฐานสำคัญของ Business Intelligence