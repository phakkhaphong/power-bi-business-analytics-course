# AdventureWorks OLTP Focus - การเปลี่ยนแปลงหลักสูตร

## 🎯 ภาพรวมการเปลี่ยนแปลง

หลักสูตรได้ถูกปรับปรุงให้เน้น **AdventureWorks OLTP** แทน AdventureWorksDW และเพิ่ม **Power Query Transformation** เพื่อสร้าง Dimensional Model

## 📊 การเปลี่ยนแปลงหลัก

### ✅ **เปลี่ยนจาก AdventureWorksDW เป็น AdventureWorks OLTP**

#### **เหตุผล**
- **OLTP เป็นต้นทางที่แท้จริง**: AdventureWorks OLTP เป็น transactional database ที่มีข้อมูลธุรกิจจริง
- **การเรียนรู้ที่สมบูรณ์**: ผู้เรียนจะได้เรียนรู้การ transform ข้อมูลจาก OLTP เป็น Analytical Model
- **ทักษะที่สำคัญ**: การใช้ Power Query สร้าง Dimensional Model เป็นทักษะที่จำเป็น

#### **AdventureWorks OLTP Structure**
```
AdventureWorks OLTP (Normalized)
├── Sales Schema
│   ├── SalesOrderHeader (31,465 orders)
│   ├── SalesOrderDetail (121,317 line items)
│   ├── Customer (19,820 customers)
│   └── SalesTerritory (10 territories)
├── Production Schema
│   ├── Product (504 products)
│   ├── ProductCategory (4 categories)
│   ├── ProductSubcategory (37 subcategories)
│   └── ProductModel (128 models)
├── Person Schema
│   ├── Person (19,972 people)
│   ├── Address (19,614 addresses)
│   └── StateProvince (181 states)
└── HumanResources Schema
    ├── Employee (290 employees)
    └── Department (16 departments)
```

### ✅ **เพิ่ม Power Query Transformation Steps**

#### **Module 2: AdventureWorks OLTP & Power Query Transformation**
- **OLTP to Star Schema**: Transform normalized data เป็น analytical model
- **Fact Table Creation**: สร้าง FactSales จาก SalesOrderHeader + SalesOrderDetail
- **Dimension Tables**: สร้าง DimCustomer, DimProduct, DimDate
- **Business Logic**: เพิ่ม calculated columns และ business rules

#### **Module 3: Advanced Power Query & Data Transformation**
- **Data Quality**: ตรวจสอบและแก้ไขปัญหาคุณภาพข้อมูล
- **Error Handling**: จัดการข้อผิดพลาดและ edge cases
- **Performance Optimization**: เพิ่มประสิทธิภาพ Power Query
- **Custom Functions**: สร้าง reusable functions

## 🔧 Power Query Transformation Examples

### **FactSales Table Creation**
```m
// Create FactSales from OLTP Tables
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
    )
in
    AddCalculations3
```

### **DimCustomer Creation**
```m
// Create DimCustomer from OLTP Tables
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
    )
in
    ExpandedAddress
```

### **Date Dimension Creation**
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
    AddYearQuarter = Table.AddColumn(AddYearMonth, "YearQuarter", each Date.Year([Date]) * 10 + Date.QuarterOfYear([Date]))
in
    AddYearQuarter
```

## 📊 Star Schema Result

### **Fact Table: FactSales**
- **SalesOrderID**: Order identifier
- **ProductID**: Product identifier
- **CustomerID**: Customer identifier
- **SalesPersonID**: Sales person identifier
- **TerritoryID**: Territory identifier
- **OrderDate**: Order date
- **OrderQty**: Quantity ordered
- **UnitPrice**: Unit price
- **LineTotal**: Line total
- **NetAmount**: Net amount after discount
- **DiscountAmount**: Discount amount
- **GrossProfit**: Gross profit

### **Dimension Tables**
- **DimCustomer**: Customer dimension (19,820 customers)
- **DimProduct**: Product dimension (504 products)
- **DimSalesPerson**: Sales person dimension
- **DimTerritory**: Territory dimension (10 territories)
- **DimDate**: Date dimension (3,652 days)

## 🎯 ประโยชน์ของการเปลี่ยนแปลง

### ✅ **การเรียนรู้ที่สมบูรณ์**
- เข้าใจ OLTP vs OLAP
- เรียนรู้การ transform ข้อมูล
- สร้าง Dimensional Model จากต้นทาง

### ✅ **ทักษะที่สำคัญ**
- Power Query Mastery
- Data Transformation
- Business Logic Implementation
- Performance Optimization

### ✅ **กรณีศึกษาจริง**
- ข้อมูลธุรกิจจริง 10 ปี
- Business scenarios ที่หลากหลาย
- Real-world challenges และ solutions

## 🛠️ Setup Instructions

### **1. Download AdventureWorks OLTP**
```powershell
# Download AdventureWorks OLTP
.\scripts\download-adventureworks.ps1

# This will create:
# - AdventureWorks2019.bak
# - restore-adventureworks.sql
# - connection-strings.json
# - power-bi-connection-guide.md
```

### **2. Restore Database**
```sql
-- Restore AdventureWorks OLTP
sqlcmd -S "(localdb)\MSSQLLocalDB" -i restore-adventureworks.sql
```

### **3. Connect from Power BI**
- Server: `(localdb)\MSSQLLocalDB`
- Database: `AdventureWorks2019`
- Authentication: Windows

### **4. Transform Data**
- ใช้ Power Query สร้าง Star Schema
- สร้าง FactSales และ Dimension Tables
- เพิ่ม Business Logic และ Calculated Columns

## 📚 เอกสารประกอบ

### **Connection Guide**
- `datasets/adventureworks/power-bi-connection-guide.md`
- รวม Power Query transformation examples
- Business logic implementation
- Performance optimization tips

### **Sample Queries**
- Sales analysis queries
- Customer analysis queries
- Product performance queries
- Time intelligence queries

## 🎉 สรุป

การเปลี่ยนแปลงหลักสูตรให้เน้น AdventureWorks OLTP และ Power Query Transformation:

### ✅ **ข้อดี**
- **การเรียนรู้ที่สมบูรณ์**: จาก OLTP ถึง Analytical Model
- **ทักษะที่สำคัญ**: Power Query และ Data Transformation
- **กรณีศึกษาจริง**: ข้อมูลธุรกิจจริง 10 ปี
- **Best Practices**: การใช้ Power Query สร้าง Dimensional Model

### ✅ **ผลลัพธ์**
- ผู้เรียนเข้าใจ OLTP vs OLAP
- เชี่ยวชาญ Power Query และ M Language
- สามารถสร้าง Dimensional Model ได้
- มีทักษะ Data Transformation ที่จำเป็น

**หลักสูตรตอนนี้เน้นการใช้งานเชิงธุรกิจจริง โดยใช้ AdventureWorks OLTP และ Power Query สร้าง Dimensional Model สำหรับการวิเคราะห์ที่ครอบคลุมและมีประสิทธิภาพ! 🚀**

