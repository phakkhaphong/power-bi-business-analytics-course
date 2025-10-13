# บทที่ 10: DAX Fundamentals

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- เข้าใจ DAX Syntax และ Structure
- เข้าใจ Context และ Filter Context
- สร้าง Calculated Columns และ Measures
- ใช้ Basic DAX Functions
- เข้าใจ Evaluation Context และ Context Transition

## 📚 เนื้อหาบทเรียน

### 10.1 DAX Introduction

#### 10.1.1 What is DAX?
- **Data Analysis Expressions**: ภาษาโปรแกรมสำหรับการวิเคราะห์ข้อมูล
- **Formula Language**: ภาษาเขียนสูตรสำหรับ Power BI
- **Functional Language**: ภาษาแบบ Functional Programming
- **Context-aware**: เข้าใจ Context ของข้อมูล

#### 10.1.2 DAX vs Excel Formulas
```dax
// Excel Formula
=SUM(A1:A10)

// DAX Formula
Total Sales = SUM(Sales[Amount])
```

#### 10.1.3 DAX Syntax Rules
- **Case Sensitive**: ตัวพิมพ์ใหญ่-เล็กสำคัญ
- **Table[Column]**: อ้างอิงคอลัมน์
- **Function(Argument)**: โครงสร้างฟังก์ชัน
- **Measure Name = Expression**: โครงสร้าง Measure

### 10.2 Context in DAX

#### 10.2.1 Row Context
- **คำนิยาม**: Context ของแถวในตาราง
- **การใช้งาน**: ใน Calculated Columns
- **ตัวอย่าง**: การคำนวณในแต่ละแถว

```dax
// Calculated Column - Row Context
Profit = Sales[Revenue] - Sales[Cost]
```

#### 10.2.2 Filter Context
- **คำนิยาม**: Context ของการกรองข้อมูล
- **การใช้งาน**: ใน Measures และ Visualizations
- **ตัวอย่าง**: การคำนวณตามการกรอง

```dax
// Measure - Filter Context
Total Sales = SUM(Sales[Revenue])
```

#### 10.2.3 Context Transition
- **คำนิยาม**: การเปลี่ยนจาก Row Context เป็น Filter Context
- **การใช้งาน**: ใน Calculated Columns
- **ตัวอย่าง**: การใช้ EARLIER function

```dax
// Context Transition
Running Total = 
CALCULATE(
    SUM(Sales[Amount]),
    FILTER(
        ALL(Sales[Date]),
        Sales[Date] <= EARLIER(Sales[Date])
    )
)
```

### 10.3 Calculated Columns vs Measures

#### 10.3.1 Calculated Columns
```dax
// Calculated Column - Row Context
Year = YEAR(Sales[Date])
Month = MONTH(Sales[Date])
Profit = Sales[Revenue] - Sales[Cost]
```

**ลักษณะ**:
- คำนวณใน Data Model
- ใช้พื้นที่เก็บข้อมูล
- ใช้ใน Filters และ Slicers
- Row Context

#### 10.3.2 Measures
```dax
// Measures - Filter Context
Total Sales = SUM(Sales[Revenue])
Average Sales = AVERAGE(Sales[Revenue])
Count of Sales = COUNTROWS(Sales)
```

**ลักษณะ**:
- คำนวณแบบ Dynamic
- ไม่ใช้พื้นที่เก็บข้อมูล
- ใช้ใน Visualizations
- Filter Context

### 10.4 Basic DAX Functions

#### 10.4.1 Aggregation Functions
```dax
// Basic Aggregation
Total Sales = SUM(Sales[Revenue])
Average Sales = AVERAGE(Sales[Revenue])
Count of Sales = COUNTROWS(Sales)
Max Sales = MAX(Sales[Revenue])
Min Sales = MIN(Sales[Revenue])
```

#### 10.4.2 Mathematical Functions
```dax
// Mathematical Functions
Sales Growth = DIVIDE([Total Sales] - [Previous Sales], [Previous Sales])
Sales Percentage = DIVIDE([Total Sales], CALCULATE([Total Sales], ALL()))
Rounded Sales = ROUND([Total Sales], 2)
```

#### 10.4.3 Text Functions
```dax
// Text Functions
Full Name = CONCATENATE(Customer[FirstName], " ", Customer[LastName])
Upper Name = UPPER(Customer[Name])
Text Length = LEN(Customer[Name])
```

#### 10.4.4 Date Functions
```dax
// Date Functions
Current Year = YEAR(TODAY())
Current Month = MONTH(TODAY())
Days Since = DATEDIFF(Sales[Date], TODAY(), DAY)
```

### 10.5 Logical Functions

#### 10.5.1 IF Function
```dax
// Simple IF
Sales Category = 
IF([Total Sales] > 1000000, "High", "Low")

// Nested IF
Sales Category = 
IF([Total Sales] > 1000000, "High",
    IF([Total Sales] > 500000, "Medium", "Low"))
```

#### 10.5.2 SWITCH Function
```dax
// SWITCH Function
Sales Category = 
SWITCH(
    TRUE(),
    [Total Sales] > 1000000, "High",
    [Total Sales] > 500000, "Medium",
    "Low"
)
```

#### 10.5.3 AND, OR, NOT Functions
```dax
// Logical Functions
High Value Sales = 
AND([Total Sales] > 1000000, [Profit Margin] > 0.2)

Either High Sales or High Margin = 
OR([Total Sales] > 1000000, [Profit Margin] > 0.2)

Not Low Sales = 
NOT([Total Sales] < 100000)
```

### 10.6 Filter Functions

#### 10.6.1 CALCULATE Function
```dax
// CALCULATE - Most Important DAX Function
Sales Last Year = 
CALCULATE([Total Sales], SAMEPERIODLASTYEAR(Date[Date]))

Sales in France = 
CALCULATE([Total Sales], Customer[Country] = "France")
```

#### 10.6.2 FILTER Function
```dax
// FILTER Function
High Value Sales = 
SUMX(
    FILTER(Sales, Sales[Revenue] > 10000),
    Sales[Revenue]
)
```

#### 10.6.3 ALL Function
```dax
// ALL Function
Sales All Time = 
CALCULATE([Total Sales], ALL(Date))

Sales Percentage = 
DIVIDE([Total Sales], CALCULATE([Total Sales], ALL()))
```

## 🛠️ การปฏิบัติ

### Lab 1: Basic DAX
1. **Create Calculated Columns**
   - Year, Month, Quarter
   - Profit calculations
   - Text concatenations

2. **Create Basic Measures**
   - Total, Average, Count
   - Percentage calculations
   - Growth calculations

### Lab 2: Context Understanding
1. **Row Context**
   - Calculated columns
   - Context transition
   - EARLIER function

2. **Filter Context**
   - Measures in visualizations
   - Filter interactions
   - Cross-filtering

### Lab 3: Filter Functions
1. **CALCULATE Function**
   - Basic CALCULATE
   - Multiple filters
   - Context modification

2. **Advanced Filtering**
   - ALL function
   - FILTER function
   - Complex filters

## 📊 ข้อมูลตัวอย่าง

### DAX Examples
- **Sales Calculations**: การคำนวณยอดขาย
- **Time Intelligence**: การวิเคราะห์เวลา
- **Customer Analytics**: การวิเคราะห์ลูกค้า
- **Product Performance**: ประสิทธิภาพผลิตภัณฑ์

### Context Scenarios
- **Row Context**: การคำนวณในแต่ละแถว
- **Filter Context**: การคำนวณตามการกรอง
- **Context Transition**: การเปลี่ยน Context

## 🎯 แบบฝึกหัด

### Exercise 1: Basic DAX Mastery
**สถานการณ์**: ต้องสร้างการคำนวณพื้นฐาน

**งาน**:
1. สร้าง Calculated Columns
2. สร้าง Basic Measures
3. ใช้ Logical Functions
4. ทดสอบ Context

### Exercise 2: Context Deep Dive
**สถานการณ์**: ต้องเข้าใจ Context อย่างลึกซึ้ง

**งาน**:
1. วิเคราะห์ Row Context
2. วิเคราะห์ Filter Context
3. ใช้ Context Transition
4. แก้ไขปัญหา Context

### Exercise 3: Filter Functions
**สถานการณ์**: ต้องใช้ Filter Functions

**งาน**:
1. ใช้ CALCULATE Function
2. ใช้ FILTER Function
3. ใช้ ALL Function
4. สร้าง Complex Filters

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- DAX Syntax และ Structure
- Context และ Filter Context
- Calculated Columns vs Measures
- Basic DAX Functions
- Filter Functions

### สิ่งที่จะเรียนต่อไป:
- Advanced DAX Functions
- Performance และ Optimization
- Time Intelligence

## 🔗 ลิงก์ที่เป็นประโยชน์

- [DAX Reference](https://docs.microsoft.com/en-us/dax/)
- [DAX Fundamentals](https://docs.microsoft.com/en-us/learn/powerplatform/power-bi-dax/)
- [DAX Syntax](https://docs.microsoft.com/en-us/dax/dax-syntax-reference)
- [Context in DAX](https://docs.microsoft.com/en-us/dax/context-in-dax)

## 📞 คำถามที่พบบ่อย

**Q: DAX ยากไหม?**
A: เริ่มต้นไม่ยาก แต่ต้องฝึกฝนเพื่อเชี่ยวชาญ

**Q: Calculated Columns vs Measures ต่างกันอย่างไร?**
A: Calculated Columns ใช้ Row Context, Measures ใช้ Filter Context

**Q: CALCULATE ใช้ทำอะไร?**
A: เป็นฟังก์ชันที่สำคัญที่สุดใน DAX ใช้สำหรับการแก้ไข Context

---

**หมายเหตุ**: DAX Fundamentals เป็นพื้นฐานสำคัญสำหรับการเขียน DAX ขั้นสูง
