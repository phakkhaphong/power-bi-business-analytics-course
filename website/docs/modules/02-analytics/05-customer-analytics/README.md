# Module 5: Customer Analytics & Segmentation (1.5 ชั่วโมง)

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- คำนวณ Customer Lifetime Value (CLV)
- ทำ RFM Analysis (Recency, Frequency, Monetary)
- สร้าง Customer Segmentation
- วิเคราะห์ Customer Churn
- สร้าง Customer Journey Analytics

## 📚 เนื้อหาบทเรียน (90 นาที)

### 5.1 Customer Lifetime Value (CLV) (20 นาที)

#### 5.1.1 CLV Fundamentals
```dax
// Basic Customer Lifetime Value
Customer Lifetime Value = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR TotalRevenue = CALCULATE(
    SUM(FactInternetSales[SalesAmount]),
    FactInternetSales[CustomerKey] = CustomerKey
)
VAR TotalOrders = CALCULATE(
    COUNTROWS(FactInternetSales),
    FactInternetSales[CustomerKey] = CustomerKey
)
VAR AvgOrderValue = DIVIDE(TotalRevenue, TotalOrders)
VAR AvgOrdersPerYear = DIVIDE(TotalOrders, 5) // 5 years of data
VAR CustomerLifespan = 3 // years
RETURN AvgOrderValue * AvgOrdersPerYear * CustomerLifespan
```

#### 5.1.2 Advanced CLV Calculation
```dax
// Advanced CLV with Cohort Analysis
Customer Lifetime Value Advanced = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR FirstPurchaseDate = CALCULATE(
    MIN(FactInternetSales[OrderDate]),
    FactInternetSales[CustomerKey] = CustomerKey
)
VAR LastPurchaseDate = CALCULATE(
    MAX(FactInternetSales[OrderDate]),
    FactInternetSales[CustomerKey] = CustomerKey
)
VAR CustomerAge = DATEDIFF(FirstPurchaseDate, LastPurchaseDate, DAY) / 365
VAR TotalRevenue = CALCULATE(
    SUM(FactInternetSales[SalesAmount]),
    FactInternetSales[CustomerKey] = CustomerKey
)
VAR AnnualRevenue = DIVIDE(TotalRevenue, CustomerAge)
VAR CustomerLifespan = 3
RETURN AnnualRevenue * CustomerLifespan
```

#### 5.1.3 CLV by Customer Segment
```dax
// CLV by Geographic Region
CLV by Region = 
SUMX(
    VALUES(DimSalesTerritory[SalesTerritoryRegion]),
    [Customer Lifetime Value]
)

// CLV by Product Category
CLV by Category = 
SUMX(
    VALUES(DimProductCategory[EnglishProductCategoryName]),
    [Customer Lifetime Value]
)

// CLV by Customer Demographics
CLV by Demographics = 
SUMX(
    VALUES(DimCustomer[EnglishOccupation]),
    [Customer Lifetime Value]
)
```

### 5.2 RFM Analysis (Recency, Frequency, Monetary) (25 นาที)

#### 5.2.1 RFM Score Calculation
```dax
// Recency Score (Days since last purchase)
Recency Score = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR LastPurchaseDate = CALCULATE(
    MAX(FactInternetSales[OrderDate]),
    FactInternetSales[CustomerKey] = CustomerKey
)
VAR DaysSinceLastPurchase = DATEDIFF(LastPurchaseDate, TODAY(), DAY)
RETURN 
    IF(DaysSinceLastPurchase <= 30, 5,
    IF(DaysSinceLastPurchase <= 90, 4,
    IF(DaysSinceLastPurchase <= 180, 3,
    IF(DaysSinceLastPurchase <= 365, 2, 1))))
```

```dax
// Frequency Score (Number of purchases)
Frequency Score = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR PurchaseCount = CALCULATE(
    COUNTROWS(FactInternetSales),
    FactInternetSales[CustomerKey] = CustomerKey
)
RETURN 
    IF(PurchaseCount >= 20, 5,
    IF(PurchaseCount >= 10, 4,
    IF(PurchaseCount >= 5, 3,
    IF(PurchaseCount >= 2, 2, 1))))
```

```dax
// Monetary Score (Total spending)
Monetary Score = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR TotalSpent = CALCULATE(
    SUM(FactInternetSales[SalesAmount]),
    FactInternetSales[CustomerKey] = CustomerKey
)
RETURN 
    IF(TotalSpent >= 10000, 5,
    IF(TotalSpent >= 5000, 4,
    IF(TotalSpent >= 2000, 3,
    IF(TotalSpent >= 1000, 2, 1))))
```

#### 5.2.2 RFM Segment Classification
```dax
// RFM Segment Classification
RFM Segment = 
VAR RecencyScore = [Recency Score]
VAR FrequencyScore = [Frequency Score]
VAR MonetaryScore = [Monetary Score]
VAR RFMString = RecencyScore & FrequencyScore & MonetaryScore
RETURN 
    SWITCH(
        RFMString,
        "555", "Champions",
        "554", "Loyal Customers",
        "544", "Potential Loyalists",
        "555", "New Customers",
        "444", "Promising",
        "333", "Need Attention",
        "222", "About to Sleep",
        "111", "At Risk",
        "Lost Customers"
    )
```

#### 5.2.3 RFM Analysis Dashboard
```dax
// RFM Segment Counts
Champions Count = 
CALCULATE(
    COUNTROWS(DimCustomer),
    [RFM Segment] = "Champions"
)

Loyal Customers Count = 
CALCULATE(
    COUNTROWS(DimCustomer),
    [RFM Segment] = "Loyal Customers"
)

At Risk Count = 
CALCULATE(
    COUNTROWS(DimCustomer),
    [RFM Segment] = "At Risk"
)

// RFM Revenue by Segment
Revenue by RFM Segment = 
SUMX(
    VALUES(DimCustomer[CustomerKey]),
    IF([RFM Segment] = SELECTEDVALUE(DimCustomer[RFM Segment]), 
       [Customer Lifetime Value], 0)
)
```

### 5.3 Customer Segmentation (25 นาที)

#### 5.3.1 Behavioral Segmentation
```dax
// Customer Purchase Behavior
Purchase Frequency = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR PurchaseCount = CALCULATE(
    COUNTROWS(FactInternetSales),
    FactInternetSales[CustomerKey] = CustomerKey
)
VAR CustomerAge = CALCULATE(
    DATEDIFF(MIN(FactInternetSales[OrderDate]), MAX(FactInternetSales[OrderDate]), DAY),
    FactInternetSales[CustomerKey] = CustomerKey
)
RETURN DIVIDE(PurchaseCount, CustomerAge / 365)

// Customer Spending Behavior
Average Order Value = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR TotalRevenue = CALCULATE(
    SUM(FactInternetSales[SalesAmount]),
    FactInternetSales[CustomerKey] = CustomerKey
)
VAR TotalOrders = CALCULATE(
    COUNTROWS(FactInternetSales),
    FactInternetSales[CustomerKey] = CustomerKey
)
RETURN DIVIDE(TotalRevenue, TotalOrders)
```

#### 5.3.2 Demographic Segmentation
```dax
// Age Group Classification
Age Group = 
VAR BirthYear = YEAR(DimCustomer[BirthDate])
VAR CurrentYear = YEAR(TODAY())
VAR Age = CurrentYear - BirthYear
RETURN 
    IF(Age < 25, "18-24",
    IF(Age < 35, "25-34",
    IF(Age < 45, "35-44",
    IF(Age < 55, "45-54",
    IF(Age < 65, "55-64", "65+")))))

// Income Segment
Income Segment = 
VAR YearlyIncome = DimCustomer[YearlyIncome]
RETURN 
    IF(YearlyIncome < 30000, "Low Income",
    IF(YearlyIncome < 60000, "Medium Income",
    IF(YearlyIncome < 100000, "High Income", "Very High Income")))

// Geographic Segment
Geographic Segment = 
DimSalesTerritory[SalesTerritoryRegion]
```

#### 5.3.3 Product Preference Segmentation
```dax
// Favorite Product Category
Favorite Category = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR CategorySpending = 
    ADDCOLUMNS(
        VALUES(DimProductCategory[EnglishProductCategoryName]),
        "CategoryRevenue", 
        CALCULATE(
            SUM(FactInternetSales[SalesAmount]),
            FactInternetSales[CustomerKey] = CustomerKey,
            RELATED(DimProduct[ProductCategoryKey]) = DimProductCategory[ProductCategoryKey]
        )
    )
VAR TopCategory = TOPN(1, CategorySpending, [CategoryRevenue])
RETURN SELECTEDVALUE(TopCategory[EnglishProductCategoryName])

// Brand Loyalty
Brand Loyalty = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR UniqueBrands = CALCULATE(
    DISTINCTCOUNT(DimProduct[ProductSubcategoryKey]),
    FactInternetSales[CustomerKey] = CustomerKey
)
RETURN 
    IF(UniqueBrands = 1, "Brand Loyal",
    IF(UniqueBrands <= 3, "Brand Favorable",
    "Brand Switcher"))
```

### 5.4 Customer Churn Analysis (20 นาที)

#### 5.4.1 Churn Definition & Calculation
```dax
// Customer Churn Rate
Customer Churn Rate = 
VAR TotalCustomers = COUNTROWS(DimCustomer)
VAR ChurnedCustomers = 
    CALCULATE(
        COUNTROWS(DimCustomer),
        [Days Since Last Purchase] > 365
    )
RETURN DIVIDE(ChurnedCustomers, TotalCustomers)

// Days Since Last Purchase
Days Since Last Purchase = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR LastPurchaseDate = CALCULATE(
    MAX(FactInternetSales[OrderDate]),
    FactInternetSales[CustomerKey] = CustomerKey
)
RETURN DATEDIFF(LastPurchaseDate, TODAY(), DAY)

// Churn Probability
Churn Probability = 
VAR DaysSinceLastPurchase = [Days Since Last Purchase]
VAR PurchaseFrequency = [Purchase Frequency]
VAR AvgOrderValue = [Average Order Value]
RETURN 
    IF(DaysSinceLastPurchase > 365, 1,
    IF(DaysSinceLastPurchase > 180 AND PurchaseFrequency < 2, 0.8,
    IF(DaysSinceLastPurchase > 90 AND PurchaseFrequency < 1, 0.6,
    IF(DaysSinceLastPurchase > 30 AND AvgOrderValue < 100, 0.4, 0.1))))
```

#### 5.4.2 Churn Prevention Strategies
```dax
// High Value At-Risk Customers
High Value At Risk = 
CALCULATE(
    COUNTROWS(DimCustomer),
    [Churn Probability] > 0.5,
    [Customer Lifetime Value] > 5000
)

// Retention Campaign Targets
Retention Campaign Targets = 
CALCULATE(
    COUNTROWS(DimCustomer),
    [RFM Segment] IN ("About to Sleep", "At Risk"),
    [Customer Lifetime Value] > 2000
)

// Win-back Campaign Targets
Win-back Campaign Targets = 
CALCULATE(
    COUNTROWS(DimCustomer),
    [Days Since Last Purchase] > 365,
    [Customer Lifetime Value] > 1000
)
```

## 🛠️ การปฏิบัติ (45 นาที)

### Lab 1: Customer Lifetime Value Analysis (20 นาที)
1. **Calculate CLV**
   - สร้าง Basic CLV Calculation
   - สร้าง Advanced CLV with Cohort Analysis
   - วิเคราะห์ CLV by Segments

2. **CLV Dashboard**
   - สร้าง CLV Distribution Chart
   - สร้าง CLV by Region Map
   - สร้าง CLV Trend Analysis

### Lab 2: RFM Analysis & Segmentation (25 นาที)
1. **RFM Calculation**
   - สร้าง Recency, Frequency, Monetary Scores
   - สร้าง RFM Segment Classification
   - สร้าง RFM Analysis Dashboard

2. **Customer Segmentation**
   - สร้าง Behavioral Segments
   - สร้าง Demographic Segments
   - สร้าง Product Preference Segments

## 📊 ข้อมูลตัวอย่าง

### AdventureWorksDW Customer Data
- **Total Customers**: 18,484
- **Customer Demographics**: Age, Income, Occupation, Education
- **Geographic Distribution**: 6 continents, multiple countries
- **Purchase History**: 10 years of transaction data

### Customer Analytics Scenarios
- **CLV Analysis**: การวิเคราะห์มูลค่าลูกค้าตลอดชีพ
- **RFM Segmentation**: การแบ่งกลุ่มลูกค้าตาม RFM
- **Churn Prediction**: การทำนายลูกค้าที่จะออกไป
- **Retention Strategies**: กลยุทธ์การรักษาลูกค้า

## 🎯 แบบฝึกหัด

### Exercise 1: Customer Lifetime Value Dashboard
**สถานการณ์**: สร้าง Customer Lifetime Value Dashboard

**งาน**:
1. คำนวณ Customer Lifetime Value
2. สร้าง CLV Distribution Analysis
3. วิเคราะห์ CLV by Segments
4. สร้าง Retention Recommendations

### Exercise 2: RFM Analysis & Churn Prediction
**สถานการณ์**: วิเคราะห์ลูกค้าและทำนาย Churn

**งาน**:
1. สร้าง RFM Analysis
2. แบ่งกลุ่มลูกค้าตาม RFM
3. คำนวณ Churn Probability
4. สร้าง Retention Campaign Strategy

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- Customer Lifetime Value (CLV) Calculation
- RFM Analysis (Recency, Frequency, Monetary)
- Customer Segmentation Techniques
- Customer Churn Analysis และ Prevention

### สิ่งที่จะเรียนต่อไป:
- Product และ Inventory Analytics
- DAX for Business Intelligence
- Advanced Analytics และ AI

## 🔗 ลิงก์ที่เป็นประโยชน์

- [Customer Analytics with Power BI](https://docs.microsoft.com/en-us/power-bi/guidance/whitepaper-powerbi-implementation-planning)
- [RFM Analysis](https://en.wikipedia.org/wiki/RFM_(market_research))
- [Customer Lifetime Value](https://en.wikipedia.org/wiki/Customer_lifetime_value)
- [Churn Analysis](https://docs.microsoft.com/en-us/azure/machine-learning/studio-module-reference/churn-prediction)

## 📞 คำถามที่พบบ่อย

**Q: RFM Analysis ใช้ทำอะไร?**
A: ใช้แบ่งกลุ่มลูกค้าตามพฤติกรรมการซื้อ เพื่อวางแผนการตลาด

**Q: Customer Lifetime Value คำนวณอย่างไร?**
A: คำนวณจากรายได้เฉลี่ยต่อปี × อายุลูกค้า × อัตราการรักษาลูกค้า

**Q: Churn Analysis สำคัญอย่างไร?**
A: ช่วยระบุลูกค้าที่มีแนวโน้มจะออกไป เพื่อวางแผนการรักษาลูกค้า

---

**หมายเหตุ**: Customer Analytics เป็นหัวใจสำคัญของการทำ Business Intelligence ที่เน้นลูกค้า

