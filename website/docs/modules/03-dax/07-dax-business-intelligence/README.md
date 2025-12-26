# Module 7: DAX for Business Intelligence (1.5 ชั่วโมง)

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- ใช้ Advanced DAX Functions สำหรับ Business Intelligence
- สร้าง Time Intelligence และ YOY Analysis
- เข้าใจ Context Transition และ Filter Functions
- เพิ่มประสิทธิภาพ Performance Optimization
- สร้าง Complex Business Calculations

## 📚 เนื้อหาบทเรียน (90 นาที)

### 7.1 Advanced DAX Functions for Business (25 นาที)

#### 7.1.1 Advanced Aggregation Functions
```dax
// SUMX with Complex Logic
Total Revenue with Conditions = 
SUMX(
    FactInternetSales,
    IF(
        FactInternetSales[SalesAmount] > 1000,
        FactInternetSales[SalesAmount] * 1.1, // 10% bonus for high-value orders
        FactInternetSales[SalesAmount]
    )
)

// AVERAGEX with Filters
Average High-Value Order = 
AVERAGEX(
    FILTER(FactInternetSales, FactInternetSales[SalesAmount] > 1000),
    FactInternetSales[SalesAmount]
)

// COUNTX with Multiple Conditions
High-Value Customer Count = 
COUNTX(
    FILTER(
        VALUES(DimCustomer[CustomerKey]),
        CALCULATE(SUM(FactInternetSales[SalesAmount])) > 5000
    ),
    DimCustomer[CustomerKey]
)

// MINX and MAXX for Business Logic
Best Month Performance = 
MAXX(
    VALUES(DimDate[CalendarYearMonth]),
    CALCULATE([Total Revenue])
)

Worst Month Performance = 
MINX(
    VALUES(DimDate[CalendarYearMonth]),
    CALCULATE([Total Revenue])
)
```

#### 7.1.2 Advanced Filter Functions
```dax
// ALLEXCEPT for Dynamic Filtering
Revenue All Except Region = 
CALCULATE(
    [Total Revenue],
    ALLEXCEPT(DimSalesTerritory, DimSalesTerritory[SalesTerritoryGroup])
)

// ALLSELECTED for User Selections
Revenue Based on User Selection = 
CALCULATE(
    [Total Revenue],
    ALLSELECTED(DimSalesTerritory)
)

// KEEPFILTERS for Preserving Context
Revenue with KeepFilters = 
CALCULATE(
    [Total Revenue],
    KEEPFILTERS(DimProductCategory[EnglishProductCategoryName] = "Bikes")
)

// REMOVEFILTERS for Clearing Filters
Revenue Without Date Filters = 
CALCULATE(
    [Total Revenue],
    REMOVEFILTERS(DimDate)
)

// CROSSFILTER for Relationship Control
Revenue with CrossFilter = 
CALCULATE(
    [Total Revenue],
    CROSSFILTER(DimCustomer[CustomerKey], FactInternetSales[CustomerKey], BOTH)
)
```

#### 7.1.3 Advanced Table Functions
```dax
// SUMMARIZE for Custom Grouping
Revenue by Custom Groups = 
SUMMARIZE(
    FactInternetSales,
    DimCustomer[CustomerKey],
    "Total Revenue", SUM(FactInternetSales[SalesAmount]),
    "Order Count", COUNTROWS(FactInternetSales),
    "Avg Order Value", AVERAGE(FactInternetSales[SalesAmount])
)

// ADDCOLUMNS for Adding Calculated Columns
Customer Analysis = 
ADDCOLUMNS(
    VALUES(DimCustomer[CustomerKey]),
    "Total Revenue", [Total Revenue],
    "Order Count", [Order Count],
    "Customer Segment", 
        IF([Total Revenue] > 10000, "High Value",
           IF([Total Revenue] > 5000, "Medium Value", "Low Value"))
)

// UNION for Combining Tables
Combined Sales Data = 
UNION(
    SELECTCOLUMNS(FactInternetSales, "SalesType", "Internet", "Amount", [SalesAmount]),
    SELECTCOLUMNS(FactResellerSales, "SalesType", "Reseller", "Amount", [SalesAmount])
)

// INTERSECT for Finding Common Elements
Common Customers = 
INTERSECT(
    VALUES(FactInternetSales[CustomerKey]),
    VALUES(FactResellerSales[CustomerKey])
)
```

### 7.2 Time Intelligence & YOY Analysis (25 นาที)

#### 7.2.1 Basic Time Intelligence Functions
```dax
// Year-to-Date Sales
YTD Sales = 
TOTALYTD([Total Revenue], DimDate[FullDateAlternateKey])

// Quarter-to-Date Sales
QTD Sales = 
TOTALQTD([Total Revenue], DimDate[FullDateAlternateKey])

// Month-to-Date Sales
MTD Sales = 
TOTALMTD([Total Revenue], DimDate[FullDateAlternateKey])

// Previous Year Sales
PY Sales = 
CALCULATE(
    [Total Revenue],
    SAMEPERIODLASTYEAR(DimDate[FullDateAlternateKey])
)

// Previous Month Sales
PM Sales = 
CALCULATE(
    [Total Revenue],
    DATEADD(DimDate[FullDateAlternateKey], -1, MONTH)
)
```

#### 7.2.2 Advanced Time Intelligence
```dax
// Year-over-Year Growth
YoY Growth = 
VAR CurrentYear = [Total Revenue]
VAR PreviousYear = [PY Sales]
RETURN DIVIDE(CurrentYear - PreviousYear, PreviousYear)

// Year-over-Year Growth %
YoY Growth % = 
VAR CurrentYear = [Total Revenue]
VAR PreviousYear = [PY Sales]
RETURN DIVIDE(CurrentYear - PreviousYear, PreviousYear, 0)

// Moving Average (12 months)
12 Month Moving Average = 
AVERAGEX(
    DATESINPERIOD(DimDate[FullDateAlternateKey], 
        LASTDATE(DimDate[FullDateAlternateKey]), 
        -12, MONTH),
    [Total Revenue]
)

// Rolling 12 Month Total
Rolling 12 Month Total = 
SUMX(
    DATESINPERIOD(DimDate[FullDateAlternateKey], 
        LASTDATE(DimDate[FullDateAlternateKey]), 
        -12, MONTH),
    [Total Revenue]
)

// Quarter-over-Quarter Growth
QoQ Growth = 
VAR CurrentQuarter = [Total Revenue]
VAR PreviousQuarter = CALCULATE(
    [Total Revenue],
    DATEADD(DimDate[FullDateAlternateKey], -1, QUARTER)
)
RETURN DIVIDE(CurrentQuarter - PreviousQuarter, PreviousQuarter)
```

#### 7.2.3 Complex Time Intelligence Patterns
```dax
// Same Period Last Year with Custom Date Range
SPLY Custom Range = 
CALCULATE(
    [Total Revenue],
    SAMEPERIODLASTYEAR(DimDate[FullDateAlternateKey]),
    DimDate[FullDateAlternateKey] >= DATE(2020, 1, 1),
    DimDate[FullDateAlternateKey] <= DATE(2020, 12, 31)
)

// Parallel Period (Same month last year)
Parallel Period Sales = 
CALCULATE(
    [Total Revenue],
    PARALLELPERIOD(DimDate[FullDateAlternateKey], -1, YEAR)
)

// First and Last Date Calculations
First Sale Date = 
CALCULATE(
    MIN(FactInternetSales[OrderDate]),
    ALL(DimDate)
)

Last Sale Date = 
CALCULATE(
    MAX(FactInternetSales[OrderDate]),
    ALL(DimDate)
)

// Days in Current Period
Days in Current Period = 
DATEDIFF(
    STARTOFMONTH(LASTDATE(DimDate[FullDateAlternateKey])),
    ENDOFMONTH(LASTDATE(DimDate[FullDateAlternateKey])),
    DAY
)
```

### 7.3 Context Transition & Filter Functions (25 นาที)

#### 7.3.1 Context Transition Deep Dive
```dax
// Context Transition in Calculated Columns
Customer Total Revenue = 
CALCULATE(
    SUM(FactInternetSales[SalesAmount])
    // This creates a filter context for each customer
)

// EARLIER Function for Row Context
Running Total = 
SUMX(
    FILTER(
        ALL(FactInternetSales[OrderDate]),
        FactInternetSales[OrderDate] <= EARLIER(FactInternetSales[OrderDate])
    ),
    FactInternetSales[SalesAmount]
)

// EARLIER with Multiple Levels
Customer Running Total = 
SUMX(
    FILTER(
        ALL(FactInternetSales),
        FactInternetSales[CustomerKey] = EARLIER(FactInternetSales[CustomerKey]) &&
        FactInternetSales[OrderDate] <= EARLIER(FactInternetSales[OrderDate])
    ),
    FactInternetSales[SalesAmount]
)
```

#### 7.3.2 Advanced Filter Context Manipulation
```dax
// Filter Context with Multiple Tables
Revenue with Complex Filters = 
CALCULATE(
    [Total Revenue],
    DimProductCategory[EnglishProductCategoryName] = "Bikes",
    DimSalesTerritory[SalesTerritoryRegion] = "North America",
    DimCustomer[YearlyIncome] >= 50000
)

// Dynamic Filter Context
Dynamic Revenue Filter = 
VAR SelectedCategory = SELECTEDVALUE(DimProductCategory[EnglishProductCategoryName])
VAR SelectedRegion = SELECTEDVALUE(DimSalesTerritory[SalesTerritoryRegion])
RETURN
CALCULATE(
    [Total Revenue],
    IF(SelectedCategory <> BLANK(), DimProductCategory[EnglishProductCategoryName] = SelectedCategory),
    IF(SelectedRegion <> BLANK(), DimSalesTerritory[SalesTerritoryRegion] = SelectedRegion)
)

// Filter Context with OR Logic
Revenue with OR Logic = 
CALCULATE(
    [Total Revenue],
    OR(
        DimProductCategory[EnglishProductCategoryName] = "Bikes",
        DimProductCategory[EnglishProductCategoryName] = "Components"
    )
)
```

#### 7.3.3 Iterator Functions with Complex Logic
```dax
// RANKX for Ranking
Revenue Rank = 
RANKX(
    ALL(DimCustomer[CustomerKey]),
    [Total Revenue],
    ,
    DESC
)

// TOPN with Dynamic N
Top N Customers = 
VAR N = 10
RETURN
SUMX(
    TOPN(N, 
        ALL(DimCustomer[CustomerKey]),
        [Total Revenue]
    ),
    [Total Revenue]
)

// GENERATE for Cartesian Products
Customer Product Matrix = 
GENERATE(
    VALUES(DimCustomer[CustomerKey]),
    VALUES(DimProduct[ProductKey])
)

// ADDCOLUMNS with Complex Calculations
Customer Product Analysis = 
ADDCOLUMNS(
    GENERATE(
        VALUES(DimCustomer[CustomerKey]),
        VALUES(DimProduct[ProductKey])
    ),
    "Revenue", 
    CALCULATE(
        SUM(FactInternetSales[SalesAmount]),
        TREATAS(VALUES(DimCustomer[CustomerKey]), FactInternetSales[CustomerKey]),
        TREATAS(VALUES(DimProduct[ProductKey]), FactInternetSales[ProductKey])
    )
)
```

### 7.4 Performance Optimization (15 นาที)

#### 7.4.1 DAX Performance Best Practices
```dax
// Use Variables for Complex Calculations
Optimized Revenue Calculation = 
VAR TotalSales = SUM(FactInternetSales[SalesAmount])
VAR TotalCost = SUM(FactInternetSales[TotalProductCost])
VAR Profit = TotalSales - TotalCost
VAR Margin = DIVIDE(Profit, TotalSales)
RETURN Margin

// Avoid Nested CALCULATE
// Bad Practice
Bad Practice = 
CALCULATE(
    CALCULATE([Total Revenue], DimDate[CalendarYear] = 2020),
    DimProductCategory[EnglishProductCategoryName] = "Bikes"
)

// Good Practice
Good Practice = 
CALCULATE(
    [Total Revenue],
    DimDate[CalendarYear] = 2020,
    DimProductCategory[EnglishProductCategoryName] = "Bikes"
)

// Use DIVIDE instead of Division
Safe Division = 
DIVIDE([Total Revenue], [Total Orders], 0)

// Use IF instead of Nested IF when possible
Simple IF Logic = 
IF([Total Revenue] > 10000, "High", "Low")

// Complex IF Logic (use SWITCH instead)
Complex IF Logic = 
SWITCH(
    TRUE(),
    [Total Revenue] > 10000, "High",
    [Total Revenue] > 5000, "Medium",
    [Total Revenue] > 1000, "Low",
    "Very Low"
)
```

#### 7.4.2 Memory and Query Optimization
```dax
// Use SUMMARIZE instead of GROUPBY for simple aggregations
Simple Aggregation = 
SUMMARIZE(
    FactInternetSales,
    DimProductCategory[EnglishProductCategoryName],
    "Total Revenue", SUM(FactInternetSales[SalesAmount])
)

// Use SELECTCOLUMNS for column selection
Column Selection = 
SELECTCOLUMNS(
    FactInternetSales,
    "Order Date", FactInternetSales[OrderDate],
    "Sales Amount", FactInternetSales[SalesAmount],
    "Customer", RELATED(DimCustomer[FirstName] & " " & DimCustomer[LastName])
)

// Use TREATAS for virtual relationships
Virtual Relationship = 
CALCULATE(
    [Total Revenue],
    TREATAS(VALUES(DimProduct[ProductKey]), FactInternetSales[ProductKey])
)

// Use VALUES instead of ALL when possible
Values vs All = 
// Use VALUES when you want to keep current filter context
CALCULATE([Total Revenue], VALUES(DimProductCategory[EnglishProductCategoryName]))

// Use ALL when you want to remove filter context
CALCULATE([Total Revenue], ALL(DimProductCategory[EnglishProductCategoryName]))
```

## 🛠️ การปฏิบัติ (45 นาที)

### Lab 1: Advanced DAX Functions (20 นาที)
1. **Advanced Aggregation**
   - สร้าง Complex SUMX Calculations
   - ใช้ AVERAGEX with Filters
   - สร้าง COUNTX with Multiple Conditions

2. **Advanced Filter Functions**
   - ใช้ ALLEXCEPT และ ALLSELECTED
   - สร้าง KEEPFILTERS และ REMOVEFILTERS
   - ใช้ CROSSFILTER for Relationships

### Lab 2: Time Intelligence & Performance (25 นาที)
1. **Time Intelligence**
   - สร้าง YTD, QTD, MTD Calculations
   - สร้าง YoY และ QoQ Growth
   - สร้าง Moving Averages

2. **Performance Optimization**
   - ใช้ Variables for Complex Calculations
   - Optimize Filter Context
   - ใช้ Best Practices

## 📊 ข้อมูลตัวอย่าง

### AdventureWorksDW Business Scenarios
- **Sales Performance**: การวิเคราะห์ประสิทธิภาพยอดขาย
- **Customer Analytics**: การวิเคราะห์ลูกค้า
- **Product Performance**: ประสิทธิภาพผลิตภัณฑ์
- **Time Intelligence**: การวิเคราะห์ตามเวลา

### Advanced DAX Patterns
- **Context Transition**: การเปลี่ยน Context
- **Filter Manipulation**: การจัดการ Filter
- **Time Intelligence**: การวิเคราะห์เวลา
- **Performance Optimization**: การเพิ่มประสิทธิภาพ

## 🎯 แบบฝึกหัด

### Exercise 1: Advanced DAX Mastery
**สถานการณ์**: สร้าง Complex Business Calculations

**งาน**:
1. สร้าง Advanced Aggregation Functions
2. ใช้ Advanced Filter Functions
3. สร้าง Complex Business Logic
4. Optimize Performance

### Exercise 2: Time Intelligence Dashboard
**สถานการณ์**: สร้าง Time Intelligence Dashboard

**งาน**:
1. สร้าง YTD, QTD, MTD Calculations
2. สร้าง YoY และ QoQ Growth
3. สร้าง Moving Averages
4. สร้าง Time-based Insights

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- Advanced DAX Functions สำหรับ Business Intelligence
- Time Intelligence และ YOY Analysis
- Context Transition และ Filter Functions
- Performance Optimization

### สิ่งที่จะเรียนต่อไป:
- Advanced Analytics และ AI
- Power BI Service และ Collaboration
- Enterprise Deployment และ Governance

## 🔗 ลิงก์ที่เป็นประโยชน์

- [DAX Reference](https://docs.microsoft.com/en-us/dax/)
- [DAX Best Practices](https://docs.microsoft.com/en-us/dax/dax-best-practices)
- [Time Intelligence in DAX](https://docs.microsoft.com/en-us/dax/time-intelligence-functions-dax)
- [DAX Performance Optimization](https://docs.microsoft.com/en-us/power-bi/guidance/whitepaper-powerbi-performance)

## 📞 คำถามที่พบบ่อย

**Q: DAX ยากไหม?**
A: เริ่มต้นไม่ยาก แต่ต้องฝึกฝนเพื่อเชี่ยวชาญ Advanced Functions

**Q: Context Transition คืออะไร?**
A: การเปลี่ยนจาก Row Context เป็น Filter Context ใน Calculated Columns

**Q: Performance Optimization สำคัญไหม?**
A: สำคัญมากสำหรับข้อมูลขนาดใหญ่และ Complex Calculations

---

**หมายเหตุ**: DAX เป็นหัวใจสำคัญของ Power BI สำหรับการสร้าง Business Intelligence Solutions

