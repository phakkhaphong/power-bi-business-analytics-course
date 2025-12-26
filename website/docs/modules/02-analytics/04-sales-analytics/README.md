# Module 4: Sales Analytics Dashboard (1.5 ชั่วโมง)

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- สร้าง Sales Performance Dashboard ที่ครบถ้วน
- วิเคราะห์ Revenue และ Profit Tracking
- ทำ Territory และ Regional Analysis
- สร้าง Advanced Visualizations สำหรับ Sales Data
- ใช้ Time Intelligence สำหรับ Sales Analysis

## 📚 เนื้อหาบทเรียน (90 นาที)

### 4.1 Sales Performance Analysis (30 นาที)

#### 4.1.1 Key Sales Metrics
```dax
// Revenue Metrics
Total Revenue = SUM(FactInternetSales[SalesAmount])
Total Orders = COUNTROWS(FactInternetSales)
Average Order Value = DIVIDE([Total Revenue], [Total Orders])

// Profit Metrics
Total Cost = SUM(FactInternetSales[TotalProductCost])
Gross Profit = [Total Revenue] - [Total Cost]
Gross Profit Margin = DIVIDE([Gross Profit], [Total Revenue])

// Performance Metrics
Sales Growth = 
VAR CurrentPeriod = [Total Revenue]
VAR PreviousPeriod = CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(DimDate[FullDateAlternateKey]))
RETURN DIVIDE(CurrentPeriod - PreviousPeriod, PreviousPeriod)
```

#### 4.1.2 Sales Trends Analysis
```dax
// Monthly Sales Trend
Monthly Sales = 
CALCULATE(
    [Total Revenue],
    DATESMTD(DimDate[FullDateAlternateKey])
)

// Quarter over Quarter Growth
QoQ Growth = 
VAR CurrentQuarter = [Total Revenue]
VAR PreviousQuarter = CALCULATE([Total Revenue], DATEADD(DimDate[FullDateAlternateKey], -3, QUARTER))
RETURN DIVIDE(CurrentQuarter - PreviousQuarter, PreviousQuarter)
```

#### 4.1.3 Sales Target Analysis
```dax
// Sales vs Target
Sales vs Target = DIVIDE([Total Revenue], [Sales Target])

// Target Achievement
Target Achievement = 
IF([Sales vs Target] >= 1, "Achieved", "Not Achieved")

// Variance from Target
Variance from Target = [Total Revenue] - [Sales Target]
```

### 4.2 Revenue & Profit Tracking (20 นาที)

#### 4.2.1 Revenue Analysis
```dax
// Revenue by Product Category
Revenue by Category = 
CALCULATE(
    [Total Revenue],
    VALUES(DimProductCategory[EnglishProductCategoryName])
)

// Revenue by Territory
Revenue by Territory = 
CALCULATE(
    [Total Revenue],
    VALUES(DimSalesTerritory[SalesTerritoryRegion])
)

// Top Customers by Revenue
Top Customer Revenue = 
CALCULATE(
    [Total Revenue],
    TOPN(10, DimCustomer, [Total Revenue])
)
```

#### 4.2.2 Profit Analysis
```dax
// Profit by Product
Profit by Product = 
CALCULATE(
    [Gross Profit],
    VALUES(DimProduct[EnglishProductName])
)

// Most Profitable Products
Most Profitable Products = 
CALCULATE(
    [Gross Profit],
    TOPN(10, DimProduct, [Gross Profit])
)

// Profit Margin by Category
Profit Margin by Category = 
DIVIDE(
    CALCULATE([Gross Profit], VALUES(DimProductCategory[EnglishProductCategoryName])),
    CALCULATE([Total Revenue], VALUES(DimProductCategory[EnglishProductCategoryName]))
)
```

### 4.3 Territory & Regional Analysis (20 นาที)

#### 4.3.1 Geographic Performance
```dax
// Sales by Country
Sales by Country = 
CALCULATE(
    [Total Revenue],
    VALUES(DimSalesTerritory[SalesTerritoryCountry])
)

// Sales by Region
Sales by Region = 
CALCULATE(
    [Total Revenue],
    VALUES(DimSalesTerritory[SalesTerritoryRegion])
)

// Regional Growth Rate
Regional Growth = 
VAR CurrentPeriod = [Sales by Region]
VAR PreviousPeriod = CALCULATE([Sales by Region], SAMEPERIODLASTYEAR(DimDate[FullDateAlternateKey]))
RETURN DIVIDE(CurrentPeriod - PreviousPeriod, PreviousPeriod)
```

#### 4.3.2 Market Share Analysis
```dax
// Market Share by Territory
Market Share = 
DIVIDE(
    [Sales by Country],
    CALCULATE([Total Revenue], ALL(DimSalesTerritory))
)

// Territory Performance Index
Territory Performance Index = 
DIVIDE(
    [Sales by Country],
    AVERAGEX(
        VALUES(DimSalesTerritory[SalesTerritoryCountry]),
        [Sales by Country]
    )
)
```

### 4.4 Advanced Visualizations (20 นาที)

#### 4.4.1 Sales Dashboard Components
- **KPI Cards**: Revenue, Orders, AOV, Profit Margin
- **Line Charts**: Sales Trends over Time
- **Bar Charts**: Sales by Product Category
- **Map Visuals**: Geographic Sales Distribution
- **Matrix Tables**: Detailed Sales Breakdown

#### 4.4.2 Interactive Features
- **Slicers**: Date, Product Category, Territory
- **Cross-filtering**: Drill-down capabilities
- **Bookmarks**: Save different views
- **Drill-through**: Navigate to detailed reports

#### 4.4.3 Conditional Formatting
```dax
// Color Coding for Performance
Performance Color = 
SWITCH(
    TRUE(),
    [Sales vs Target] >= 1.2, "Green",
    [Sales vs Target] >= 1.0, "Yellow", 
    "Red"
)
```

## 🛠️ การปฏิบัติ (45 นาที)

### Lab 1: Create Sales Performance Dashboard (25 นาที)
1. **Build Core Metrics**
   - สร้าง Revenue และ Profit Measures
   - สร้าง Growth Calculations
   - สร้าง Target Comparisons

2. **Create Visualizations**
   - KPI Cards สำหรับ Key Metrics
   - Line Chart สำหรับ Sales Trends
   - Bar Chart สำหรับ Category Analysis
   - Map สำหรับ Geographic Analysis

### Lab 2: Advanced Sales Analytics (20 นาที)
1. **Time Intelligence**
   - Year-over-Year Analysis
   - Month-over-Month Trends
   - Quarterly Comparisons

2. **Interactive Features**
   - สร้าง Slicers
   - ตั้งค่า Cross-filtering
   - สร้าง Bookmarks

## 📊 ข้อมูลตัวอย่าง

### AdventureWorksDW Sales Data
- **FactInternetSales**: 60,398 records
- **FactResellerSales**: 608,040 records
- **Time Period**: 2005-2014
- **Geographic Coverage**: Global
- **Product Categories**: Bikes, Components, Accessories, Clothing

### Key Business Scenarios
- **Sales Performance Tracking**: การติดตามประสิทธิภาพยอดขาย
- **Territory Management**: การจัดการพื้นที่ขาย
- **Product Performance**: ประสิทธิภาพผลิตภัณฑ์
- **Seasonal Analysis**: การวิเคราะห์ตามฤดูกาล

## 🎯 แบบฝึกหัด

### Exercise 1: Sales Performance Dashboard
**สถานการณ์**: สร้าง Dashboard สำหรับ Sales Manager

**งาน**:
1. สร้าง Sales Performance Dashboard
2. เพิ่ม Revenue และ Profit Tracking
3. สร้าง Territory Analysis
4. ใช้ Advanced Visualizations

### Exercise 2: Sales Analytics Deep Dive
**สถานการณ์**: วิเคราะห์ Sales Performance แบบลึกซึ้ง

**งาน**:
1. วิเคราะห์ Sales Trends
2. เปรียบเทียบกับ Target
3. วิเคราะห์ Geographic Performance
4. สร้าง Insights และ Recommendations

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- Sales Performance Analysis และ Metrics
- Revenue และ Profit Tracking
- Territory และ Regional Analysis
- Advanced Visualizations สำหรับ Sales Data

### สิ่งที่จะเรียนต่อไป:
- Customer Analytics และ Segmentation
- Product และ Inventory Analytics
- DAX for Business Intelligence

## 🔗 ลิงก์ที่เป็นประโยชน์

- [Sales Analytics with Power BI](https://docs.microsoft.com/en-us/power-bi/guidance/whitepaper-powerbi-implementation-planning)
- [Time Intelligence in DAX](https://docs.microsoft.com/en-us/dax/time-intelligence-functions-dax)
- [Geographic Visualizations](https://docs.microsoft.com/en-us/power-bi/visuals/power-bi-map-tips-and-tricks)
- [AdventureWorks Sales Analysis](https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure)

## 📞 คำถามที่พบบ่อย

**Q: ควรติดตาม Sales Metrics อะไรบ้าง?**
A: Revenue, Orders, AOV, Profit Margin, Growth Rate, Target Achievement

**Q: Time Intelligence ใช้ทำอะไร?**
A: วิเคราะห์แนวโน้ม, เปรียบเทียบช่วงเวลา, คาดการณ์ผลประกอบการ

**Q: Geographic Analysis สำคัญอย่างไร?**
A: ช่วยระบุตลาดที่มีศักยภาพ, วางแผนการขยายตลาด, จัดสรรทรัพยากร

---

**หมายเหตุ**: Sales Analytics เป็นหัวใจสำคัญของ Business Intelligence สำหรับองค์กรทุกขนาด

