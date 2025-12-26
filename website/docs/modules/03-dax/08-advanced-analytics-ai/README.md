# Module 8: Advanced Analytics & AI (1.5 ชั่วโมง)

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- ใช้ Predictive Analytics ใน Power BI
- บูรณาการ Machine Learning Models
- สร้าง What-if Analysis และ Scenario Planning
- ใช้ Cognitive Services และ AI Features
- สร้าง Advanced Analytics Solutions

## 📚 เนื้อหาบทเรียน (90 นาที)

### 8.1 Predictive Analytics (25 นาที)

#### 8.1.1 Sales Forecasting
```dax
// Linear Trend Forecast
Linear Trend Forecast = 
VAR LastValue = CALCULATE([Total Revenue], LASTDATE(DimDate[FullDateAlternateKey]))
VAR SecondLastValue = CALCULATE([Total Revenue], DATEADD(LASTDATE(DimDate[FullDateAlternateKey]), -1, MONTH))
VAR Trend = LastValue - SecondLastValue
VAR ForecastValue = LastValue + Trend
RETURN ForecastValue

// Exponential Smoothing Forecast
Exponential Smoothing Forecast = 
VAR Alpha = 0.3 // Smoothing factor
VAR LastValue = CALCULATE([Total Revenue], LASTDATE(DimDate[FullDateAlternateKey]))
VAR PreviousForecast = CALCULATE([Total Revenue], DATEADD(LASTDATE(DimDate[FullDateAlternateKey]), -1, MONTH))
VAR ForecastValue = Alpha * LastValue + (1 - Alpha) * PreviousForecast
RETURN ForecastValue

// Seasonal Forecast with Trend
Seasonal Forecast = 
VAR Trend = [Linear Trend Forecast]
VAR SeasonalFactor = CALCULATE(
    [Total Revenue],
    DATEADD(DimDate[FullDateAlternateKey], -12, MONTH)
) / [Total Revenue]
VAR ForecastValue = Trend * SeasonalFactor
RETURN ForecastValue
```

#### 8.1.2 Customer Churn Prediction
```dax
// Churn Probability Model
Churn Probability = 
VAR CustomerKey = SELECTEDVALUE(DimCustomer[CustomerKey])
VAR DaysSinceLastPurchase = [Days Since Last Purchase]
VAR PurchaseFrequency = [Purchase Frequency]
VAR AvgOrderValue = [Average Order Value]
VAR CustomerAge = [Customer Age in Days]
VAR TotalSpent = [Total Customer Revenue]

// Churn Risk Factors
VAR RiskFactor1 = IF(DaysSinceLastPurchase > 90, 0.3, 0)
VAR RiskFactor2 = IF(PurchaseFrequency < 2, 0.2, 0)
VAR RiskFactor3 = IF(AvgOrderValue < 100, 0.1, 0)
VAR RiskFactor4 = IF(CustomerAge < 365, 0.2, 0)
VAR RiskFactor5 = IF(TotalSpent < 500, 0.2, 0)

VAR TotalRisk = RiskFactor1 + RiskFactor2 + RiskFactor3 + RiskFactor4 + RiskFactor5
RETURN MIN(TotalRisk, 1)

// Churn Risk Categories
Churn Risk Category = 
VAR Risk = [Churn Probability]
RETURN 
    IF(Risk > 0.7, "High Risk",
    IF(Risk > 0.4, "Medium Risk",
    IF(Risk > 0.1, "Low Risk", "Very Low Risk")))

// Expected Customer Lifetime Value
Expected CLV = 
VAR CurrentCLV = [Customer Lifetime Value]
VAR ChurnRisk = [Churn Probability]
VAR ExpectedCLV = CurrentCLV * (1 - ChurnRisk)
RETURN ExpectedCLV
```

#### 8.1.3 Demand Forecasting
```dax
// Product Demand Forecast
Product Demand Forecast = 
VAR ProductKey = SELECTEDVALUE(DimProduct[ProductKey])
VAR HistoricalDemand = CALCULATE(
    SUM(FactInternetSales[OrderQuantity]),
    DimDate[FullDateAlternateKey] >= DATEADD(TODAY(), -12, MONTH)
)
VAR AvgMonthlyDemand = HistoricalDemand / 12
VAR SeasonalFactor = CALCULATE(
    SUM(FactInternetSales[OrderQuantity]),
    MONTH(DimDate[FullDateAlternateKey]) = MONTH(TODAY())
) / HistoricalDemand
VAR ForecastDemand = AvgMonthlyDemand * SeasonalFactor
RETURN ForecastDemand

// Inventory Planning
Inventory Planning = 
VAR ForecastDemand = [Product Demand Forecast]
VAR LeadTime = 30 // days
VAR SafetyStock = ForecastDemand * 0.2 // 20% safety stock
VAR ReorderPoint = (ForecastDemand / 30) * LeadTime + SafetyStock
RETURN ReorderPoint

// Stock Out Probability
Stock Out Probability = 
VAR CurrentStock = [Current Inventory] // This would come from inventory data
VAR ForecastDemand = [Product Demand Forecast]
VAR StockOutRisk = IF(CurrentStock < ForecastDemand, 1, 0)
RETURN StockOutRisk
```

### 8.2 Machine Learning Integration (25 นาที)

#### 8.2.1 R Integration for ML
```r
# R Script for Customer Segmentation
# K-Means Clustering
library(cluster)

# Prepare data
customer_data <- data.frame(
  total_revenue = dataset$TotalRevenue,
  order_frequency = dataset$OrderFrequency,
  avg_order_value = dataset$AvgOrderValue,
  days_since_last_purchase = dataset$DaysSinceLastPurchase
)

# Perform K-Means clustering
set.seed(123)
kmeans_result <- kmeans(customer_data, centers = 4, nstart = 25)

# Add cluster labels
dataset$CustomerSegment <- kmeans_result$cluster

# Return the dataset with cluster labels
dataset
```

```r
# R Script for Sales Forecasting
# ARIMA Time Series Forecasting
library(forecast)

# Prepare time series data
sales_ts <- ts(dataset$SalesAmount, frequency = 12, start = c(2005, 1))

# Fit ARIMA model
arima_model <- auto.arima(sales_ts)

# Generate forecast
forecast_result <- forecast(arima_model, h = 12)

# Create forecast data frame
forecast_df <- data.frame(
  Date = seq(as.Date("2015-01-01"), by = "month", length.out = 12),
  Forecast = as.numeric(forecast_result$mean),
  Lower = as.numeric(forecast_result$lower[,2]),
  Upper = as.numeric(forecast_result$upper[,2])
)

forecast_df
```

#### 8.2.2 Python Integration for ML
```python
# Python Script for Customer Lifetime Value Prediction
import pandas as pd
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score

# Prepare features
features = ['OrderFrequency', 'AvgOrderValue', 'DaysSinceLastPurchase', 'TotalOrders']
X = dataset[features]
y = dataset['CustomerLifetimeValue']

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train model
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Make predictions
predictions = model.predict(X_test)

# Calculate metrics
mse = mean_squared_error(y_test, predictions)
r2 = r2_score(y_test, predictions)

# Return predictions
result = pd.DataFrame({
    'CustomerKey': X_test.index,
    'ActualCLV': y_test,
    'PredictedCLV': predictions,
    'Accuracy': r2
})

result
```

#### 8.2.3 Azure ML Integration
```dax
// Azure ML Model Integration
// Customer Churn Prediction using Azure ML
Churn Prediction Azure ML = 
VAR CustomerFeatures = {
    [Days Since Last Purchase],
    [Purchase Frequency],
    [Average Order Value],
    [Customer Age in Days],
    [Total Customer Revenue]
}
VAR PredictionResult = AzureML.Predict("CustomerChurnModel", CustomerFeatures)
RETURN PredictionResult[ChurnProbability]

// Product Recommendation using Azure ML
Product Recommendation = 
VAR CustomerProfile = {
    [Customer Age Group],
    [Customer Income Segment],
    [Customer Geographic Region],
    [Customer Purchase History]
}
VAR RecommendationResult = AzureML.Predict("ProductRecommendationModel", CustomerProfile)
RETURN RecommendationResult[RecommendedProduct]
```

### 8.3 What-if Analysis & Scenario Planning (20 นาที)

#### 8.3.1 What-if Parameters
```dax
// Price Sensitivity Analysis
Price Sensitivity Analysis = 
VAR BasePrice = [Current Average Price]
VAR PriceChange = [Price Change %] / 100
VAR NewPrice = BasePrice * (1 + PriceChange)
VAR PriceElasticity = -1.5 // Price elasticity coefficient
VAR QuantityChange = PriceChange * PriceElasticity
VAR NewQuantity = [Current Quantity] * (1 + QuantityChange)
VAR NewRevenue = NewPrice * NewQuantity
RETURN NewRevenue

// Marketing Spend Impact
Marketing Spend Impact = 
VAR BaseRevenue = [Total Revenue]
VAR MarketingSpend = [Marketing Spend]
VAR MarketingROI = 3.5 // Marketing ROI multiplier
VAR RevenueImpact = MarketingSpend * MarketingROI
VAR NewRevenue = BaseRevenue + RevenueImpact
RETURN NewRevenue

// Seasonal Demand Adjustment
Seasonal Demand Adjustment = 
VAR BaseDemand = [Product Demand Forecast]
VAR SeasonalMultiplier = [Seasonal Multiplier]
VAR AdjustedDemand = BaseDemand * SeasonalMultiplier
RETURN AdjustedDemand
```

#### 8.3.2 Scenario Analysis
```dax
// Best Case Scenario
Best Case Revenue = 
VAR BaseRevenue = [Total Revenue]
VAR GrowthRate = [Best Case Growth %] / 100
VAR BestCaseRevenue = BaseRevenue * (1 + GrowthRate)
RETURN BestCaseRevenue

// Worst Case Scenario
Worst Case Revenue = 
VAR BaseRevenue = [Total Revenue]
VAR DeclineRate = [Worst Case Decline %] / 100
VAR WorstCaseRevenue = BaseRevenue * (1 - DeclineRate)
RETURN WorstCaseRevenue

// Most Likely Scenario
Most Likely Revenue = 
VAR BaseRevenue = [Total Revenue]
VAR GrowthRate = [Most Likely Growth %] / 100
VAR MostLikelyRevenue = BaseRevenue * (1 + GrowthRate)
RETURN MostLikelyRevenue

// Scenario Comparison
Scenario Comparison = 
VAR BestCase = [Best Case Revenue]
VAR WorstCase = [Worst Case Revenue]
VAR MostLikely = [Most Likely Revenue]
VAR ExpectedValue = (BestCase * 0.2) + (WorstCase * 0.2) + (MostLikely * 0.6)
RETURN ExpectedValue
```

### 8.4 Cognitive Services & AI Features (20 นาที)

#### 8.4.1 Text Analytics
```dax
// Sentiment Analysis
Customer Sentiment = 
VAR CustomerFeedback = [Customer Feedback Text]
VAR SentimentScore = CognitiveServices.SentimentAnalysis(CustomerFeedback)
RETURN SentimentScore[Sentiment]

// Key Phrase Extraction
Key Phrases = 
VAR CustomerFeedback = [Customer Feedback Text]
VAR KeyPhrases = CognitiveServices.KeyPhraseExtraction(CustomerFeedback)
RETURN KeyPhrases[KeyPhrases]

// Language Detection
Language Detection = 
VAR CustomerFeedback = [Customer Feedback Text]
VAR Language = CognitiveServices.LanguageDetection(CustomerFeedback)
RETURN Language[Language]
```

#### 8.4.2 Image Analytics
```dax
// Product Image Analysis
Product Image Analysis = 
VAR ProductImage = [Product Image URL]
VAR ImageAnalysis = CognitiveServices.ComputerVision(ProductImage)
RETURN ImageAnalysis[Description]

// Brand Detection
Brand Detection = 
VAR ProductImage = [Product Image URL]
VAR BrandAnalysis = CognitiveServices.ComputerVision(ProductImage)
RETURN BrandAnalysis[Brands]

// Object Detection
Object Detection = 
VAR ProductImage = [Product Image URL]
VAR ObjectAnalysis = CognitiveServices.ComputerVision(ProductImage)
RETURN ObjectAnalysis[Objects]
```

#### 8.4.3 Anomaly Detection
```dax
// Sales Anomaly Detection
Sales Anomaly Detection = 
VAR SalesData = [Total Revenue]
VAR AnomalyScore = CognitiveServices.AnomalyDetection(SalesData)
RETURN AnomalyScore[IsAnomaly]

// Customer Behavior Anomaly
Customer Behavior Anomaly = 
VAR CustomerBehavior = {
    [Purchase Frequency],
    [Average Order Value],
    [Days Since Last Purchase]
}
VAR AnomalyScore = CognitiveServices.AnomalyDetection(CustomerBehavior)
RETURN AnomalyScore[IsAnomaly]

// Inventory Anomaly Detection
Inventory Anomaly Detection = 
VAR InventoryData = [Inventory Level]
VAR AnomalyScore = CognitiveServices.AnomalyDetection(InventoryData)
RETURN AnomalyScore[IsAnomaly]
```

## 🛠️ การปฏิบัติ (45 นาที)

### Lab 1: Predictive Analytics (20 นาที)
1. **Sales Forecasting**
   - สร้าง Linear Trend Forecast
   - สร้าง Exponential Smoothing Forecast
   - สร้าง Seasonal Forecast

2. **Customer Churn Prediction**
   - สร้าง Churn Probability Model
   - สร้าง Churn Risk Categories
   - สร้าง Expected CLV

### Lab 2: Machine Learning & AI (25 นาที)
1. **R/Python Integration**
   - สร้าง Customer Segmentation Model
   - สร้าง Sales Forecasting Model
   - สร้าง Customer Lifetime Value Prediction

2. **Cognitive Services**
   - ใช้ Text Analytics
   - ใช้ Image Analytics
   - ใช้ Anomaly Detection

## 📊 ข้อมูลตัวอย่าง

### Advanced Analytics Scenarios
- **Sales Forecasting**: การพยากรณ์ยอดขาย
- **Customer Churn Prediction**: การทำนายลูกค้าที่จะออกไป
- **Demand Forecasting**: การพยากรณ์ความต้องการ
- **Anomaly Detection**: การตรวจจับความผิดปกติ

### AI & ML Use Cases
- **Customer Segmentation**: การแบ่งกลุ่มลูกค้า
- **Product Recommendation**: การแนะนำผลิตภัณฑ์
- **Sentiment Analysis**: การวิเคราะห์ความรู้สึก
- **Image Recognition**: การจดจำภาพ

## 🎯 แบบฝึกหัด

### Exercise 1: Predictive Analytics Dashboard
**สถานการณ์**: สร้าง Predictive Analytics Dashboard

**งาน**:
1. สร้าง Sales Forecasting Models
2. สร้าง Customer Churn Prediction
3. สร้าง Demand Forecasting
4. สร้าง What-if Analysis

### Exercise 2: AI-Powered Analytics
**สถานการณ์**: บูรณาการ AI และ ML

**งาน**:
1. ใช้ R/Python for ML
2. ใช้ Azure ML Models
3. ใช้ Cognitive Services
4. สร้าง AI-Powered Insights

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- Predictive Analytics และ Forecasting
- Machine Learning Integration
- What-if Analysis และ Scenario Planning
- Cognitive Services และ AI Features

### สิ่งที่จะเรียนต่อไป:
- Power BI Service และ Collaboration
- Enterprise Deployment และ Governance
- Best Practices และ Maintenance

## 🔗 ลิงก์ที่เป็นประโยชน์

- [Power BI AI Features](https://docs.microsoft.com/en-us/power-bi/transform-model/desktop-r-visuals)
- [Azure Cognitive Services](https://docs.microsoft.com/en-us/azure/cognitive-services/)
- [R Integration in Power BI](https://docs.microsoft.com/en-us/power-bi/transform-model/desktop-r-visuals)
- [Python Integration in Power BI](https://docs.microsoft.com/en-us/power-bi/transform-model/desktop-python-scripts)

## 📞 คำถามที่พบบ่อย

**Q: AI ใน Power BI ใช้ทำอะไร?**
A: ใช้สำหรับ Predictive Analytics, Machine Learning, และ Cognitive Services

**Q: R และ Python ใช้ทำอะไร?**
A: ใช้สำหรับสร้าง Machine Learning Models และ Advanced Analytics

**Q: Cognitive Services คืออะไร?**
A: AI Services ของ Microsoft สำหรับ Text, Image, และ Speech Analytics

---

**หมายเหตุ**: Advanced Analytics และ AI เป็นอนาคตของ Business Intelligence

