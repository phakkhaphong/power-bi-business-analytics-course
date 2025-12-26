# Module 6: Product & Inventory Analytics (1 ชั่วโมง)

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- วิเคราะห์ Product Performance และ Profitability
- คำนวณ Inventory Turnover และ Stock Analysis
- วิเคราะห์ Category Performance และ Trends
- วิเคราะห์ Seasonal Patterns และ Forecasting
- สร้าง Product Recommendation Engine

## 📚 เนื้อหาบทเรียน (60 นาที)

### 6.1 Product Performance Analysis (15 นาที)

#### 6.1.1 Product Revenue & Profitability
```dax
// Product Revenue Analysis
Product Revenue = 
SUM(FactInternetSales[SalesAmount])

// Product Profitability
Product Profit = 
SUM(FactInternetSales[SalesAmount]) - SUM(FactInternetSales[TotalProductCost])

// Product Profit Margin
Product Profit Margin = 
DIVIDE(
    [Product Profit],
    [Product Revenue]
)

// Top Performing Products
Top Products by Revenue = 
TOPN(10, 
    VALUES(DimProduct[EnglishProductName]),
    [Product Revenue]
)

// Top Products by Profit
Top Products by Profit = 
TOPN(10, 
    VALUES(DimProduct[EnglishProductName]),
    [Product Profit]
)
```

#### 6.1.2 Product Performance Metrics
```dax
// Units Sold
Units Sold = 
SUM(FactInternetSales[OrderQuantity])

// Average Selling Price
Average Selling Price = 
DIVIDE([Product Revenue], [Units Sold])

// Product Sales Velocity
Product Sales Velocity = 
DIVIDE([Units Sold], 
    DATEDIFF(MIN(FactInternetSales[OrderDate]), MAX(FactInternetSales[OrderDate]), DAY)
)

// Product Market Share
Product Market Share = 
DIVIDE([Product Revenue], 
    CALCULATE([Product Revenue], ALL(DimProduct))
)
```

#### 6.1.3 Product Category Analysis
```dax
// Revenue by Product Category
Revenue by Category = 
CALCULATE(
    [Product Revenue],
    VALUES(DimProductCategory[EnglishProductCategoryName])
)

// Profit Margin by Category
Profit Margin by Category = 
CALCULATE(
    [Product Profit Margin],
    VALUES(DimProductCategory[EnglishProductCategoryName])
)

// Category Performance Index
Category Performance Index = 
DIVIDE(
    [Revenue by Category],
    AVERAGEX(
        VALUES(DimProductCategory[EnglishProductCategoryName]),
        [Revenue by Category]
    )
)
```

### 6.2 Inventory Turnover & Stock Analysis (15 นาที)

#### 6.2.1 Inventory Turnover Calculation
```dax
// Cost of Goods Sold
Cost of Goods Sold = 
SUM(FactInternetSales[TotalProductCost])

// Average Inventory (Simulated)
Average Inventory = 
SUM(DimProduct[StandardCost]) * 10 // Assuming 10 units average

// Inventory Turnover Rate
Inventory Turnover Rate = 
DIVIDE([Cost of Goods Sold], [Average Inventory])

// Days in Inventory
Days in Inventory = 
DIVIDE(365, [Inventory Turnover Rate])

// Inventory Turnover by Category
Inventory Turnover by Category = 
CALCULATE(
    [Inventory Turnover Rate],
    VALUES(DimProductCategory[EnglishProductCategoryName])
)
```

#### 6.2.2 Stock Level Analysis
```dax
// Stock Level Classification
Stock Level = 
VAR UnitsSold = [Units Sold]
VAR AvgUnitsSold = AVERAGEX(
    VALUES(DimProduct[ProductKey]),
    [Units Sold]
)
RETURN 
    IF(UnitsSold > AvgUnitsSold * 1.5, "High Stock",
    IF(UnitsSold > AvgUnitsSold * 0.5, "Normal Stock",
    "Low Stock"))

// Stock Out Risk
Stock Out Risk = 
VAR UnitsSold = [Units Sold]
VAR AvgUnitsSold = AVERAGEX(
    VALUES(DimProduct[ProductKey]),
    [Units Sold]
)
RETURN 
    IF(UnitsSold < AvgUnitsSold * 0.3, "High Risk",
    IF(UnitsSold < AvgUnitsSold * 0.6, "Medium Risk",
    "Low Risk"))

// Reorder Point Analysis
Reorder Point Analysis = 
VAR UnitsSold = [Units Sold]
VAR LeadTime = 30 // days
VAR AvgDailySales = UnitsSold / 365
VAR ReorderPoint = AvgDailySales * LeadTime
RETURN 
    IF(ReorderPoint > UnitsSold, "Reorder Needed", "Stock OK")
```

### 6.3 Category Analysis & Trends (15 นาที)

#### 6.3.1 Category Performance Analysis
```dax
// Category Growth Rate
Category Growth Rate = 
VAR CurrentPeriod = [Revenue by Category]
VAR PreviousPeriod = CALCULATE(
    [Revenue by Category],
    SAMEPERIODLASTYEAR(DimDate[FullDateAlternateKey])
)
RETURN DIVIDE(CurrentPeriod - PreviousPeriod, PreviousPeriod)

// Category Market Share
Category Market Share = 
DIVIDE(
    [Revenue by Category],
    CALCULATE([Revenue by Category], ALL(DimProductCategory))
)

// Category Profitability Index
Category Profitability Index = 
DIVIDE(
    CALCULATE([Product Profit], VALUES(DimProductCategory[EnglishProductCategoryName])),
    CALCULATE([Product Revenue], VALUES(DimProductCategory[EnglishProductCategoryName]))
)
```

#### 6.3.2 Product Trend Analysis
```dax
// Monthly Product Sales Trend
Monthly Product Sales = 
CALCULATE(
    [Product Revenue],
    DATESMTD(DimDate[FullDateAlternateKey])
)

// Quarter over Quarter Growth
Product QoQ Growth = 
VAR CurrentQuarter = [Product Revenue]
VAR PreviousQuarter = CALCULATE(
    [Product Revenue],
    DATEADD(DimDate[FullDateAlternateKey], -3, QUARTER)
)
RETURN DIVIDE(CurrentQuarter - PreviousQuarter, PreviousQuarter)

// Year over Year Growth
Product YoY Growth = 
VAR CurrentYear = [Product Revenue]
VAR PreviousYear = CALCULATE(
    [Product Revenue],
    SAMEPERIODLASTYEAR(DimDate[FullDateAlternateKey])
)
RETURN DIVIDE(CurrentYear - PreviousYear, PreviousYear)
```

### 6.4 Seasonal Patterns & Forecasting (15 นาที)

#### 6.4.1 Seasonal Analysis
```dax
// Seasonal Sales Pattern
Seasonal Sales Pattern = 
VAR MonthNumber = MONTH(DimDate[FullDateAlternateKey])
VAR MonthlySales = CALCULATE([Product Revenue])
VAR AvgMonthlySales = AVERAGEX(
    VALUES(DimDate[MonthNumberOfYear]),
    CALCULATE([Product Revenue])
)
RETURN DIVIDE(MonthlySales, AvgMonthlySales)

// Peak Season Analysis
Peak Season = 
VAR SeasonalIndex = [Seasonal Sales Pattern]
RETURN 
    IF(SeasonalIndex > 1.2, "Peak Season",
    IF(SeasonalIndex < 0.8, "Low Season",
    "Normal Season"))

// Seasonal Product Performance
Seasonal Product Performance = 
SUMX(
    VALUES(DimProduct[ProductKey]),
    [Seasonal Sales Pattern] * [Product Revenue]
)
```

#### 6.4.2 Forecasting & Prediction
```dax
// Simple Moving Average Forecast
Moving Average Forecast = 
VAR Periods = 3
VAR HistoricalData = 
    CALCULATETABLE(
        VALUES(DimDate[FullDateAlternateKey]),
        DimDate[FullDateAlternateKey] <= MAX(DimDate[FullDateAlternateKey])
    )
VAR RecentSales = 
    AVERAGEX(
        TOPN(Periods, HistoricalData, DimDate[FullDateAlternateKey]),
        CALCULATE([Product Revenue])
    )
RETURN RecentSales

// Trend-based Forecast
Trend Forecast = 
VAR LastMonthSales = CALCULATE(
    [Product Revenue],
    DATEADD(DimDate[FullDateAlternateKey], -1, MONTH)
)
VAR TwoMonthsAgoSales = CALCULATE(
    [Product Revenue],
    DATEADD(DimDate[FullDateAlternateKey], -2, MONTH)
)
VAR Trend = LastMonthSales - TwoMonthsAgoSales
VAR Forecast = LastMonthSales + Trend
RETURN Forecast

// Seasonal Forecast
Seasonal Forecast = 
VAR BaseForecast = [Trend Forecast]
VAR SeasonalFactor = [Seasonal Sales Pattern]
RETURN BaseForecast * SeasonalFactor
```

## 🛠️ การปฏิบัติ (30 นาที)

### Lab 1: Product Performance Dashboard (15 นาที)
1. **Product Revenue Analysis**
   - สร้าง Product Revenue Dashboard
   - วิเคราะห์ Top Performing Products
   - สร้าง Product Profitability Analysis

2. **Category Performance**
   - วิเคราะห์ Category Performance
   - สร้าง Category Comparison
   - สร้าง Market Share Analysis

### Lab 2: Inventory & Seasonal Analysis (15 นาที)
1. **Inventory Turnover Analysis**
   - คำนวณ Inventory Turnover Rate
   - สร้าง Stock Level Analysis
   - สร้าง Reorder Point Analysis

2. **Seasonal Pattern Analysis**
   - วิเคราะห์ Seasonal Patterns
   - สร้าง Forecasting Models
   - สร้าง Seasonal Recommendations

## 📊 ข้อมูลตัวอย่าง

### AdventureWorksDW Product Data
- **Product Categories**: Bikes, Components, Accessories, Clothing
- **Total Products**: 606 products
- **Product Subcategories**: 37 subcategories
- **Price Range**: $2.29 - $3,573.98
- **Cost Range**: $0.86 - $2,142.95

### Product Analytics Scenarios
- **Product Performance**: ประสิทธิภาพผลิตภัณฑ์
- **Inventory Management**: การจัดการสินค้าคงคลัง
- **Category Analysis**: การวิเคราะห์หมวดหมู่
- **Seasonal Planning**: การวางแผนตามฤดูกาล

## 🎯 แบบฝึกหัด

### Exercise 1: Product Performance Analysis
**สถานการณ์**: วิเคราะห์ประสิทธิภาพผลิตภัณฑ์

**งาน**:
1. สร้าง Product Performance Dashboard
2. วิเคราะห์ Top/Bottom Performers
3. สร้าง Category Analysis
4. สร้าง Recommendations

### Exercise 2: Inventory & Seasonal Planning
**สถานการณ์**: วางแผนสินค้าคงคลังและฤดูกาล

**งาน**:
1. วิเคราะห์ Inventory Turnover
2. สร้าง Seasonal Pattern Analysis
3. สร้าง Forecasting Models
4. สร้าง Inventory Planning Strategy

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- Product Performance และ Profitability Analysis
- Inventory Turnover และ Stock Analysis
- Category Analysis และ Trend Analysis
- Seasonal Patterns และ Forecasting

### สิ่งที่จะเรียนต่อไป:
- DAX for Business Intelligence
- Advanced Analytics และ AI
- Power BI Service และ Collaboration

## 🔗 ลิงก์ที่เป็นประโยชน์

- [Product Analytics with Power BI](https://docs.microsoft.com/en-us/power-bi/guidance/whitepaper-powerbi-implementation-planning)
- [Inventory Management](https://en.wikipedia.org/wiki/Inventory_management)
- [Seasonal Analysis](https://docs.microsoft.com/en-us/power-bi/visuals/power-bi-visualization-best-practices)
- [Forecasting in Power BI](https://docs.microsoft.com/en-us/power-bi/visuals/power-bi-visualization-forecasting)

## 📞 คำถามที่พบบ่อย

**Q: Inventory Turnover Rate คืออะไร?**
A: อัตราการหมุนเวียนสินค้าคงคลัง วัดจาก Cost of Goods Sold หารด้วย Average Inventory

**Q: Seasonal Analysis สำคัญอย่างไร?**
A: ช่วยวางแผนการผลิตและการตลาดตามฤดูกาล เพื่อเพิ่มประสิทธิภาพ

**Q: Product Performance วัดจากอะไร?**
A: วัดจาก Revenue, Profit, Units Sold, Market Share, และ Customer Satisfaction

---

**หมายเหตุ**: Product Analytics ช่วยในการตัดสินใจเกี่ยวกับผลิตภัณฑ์และการจัดการสินค้าคงคลัง

