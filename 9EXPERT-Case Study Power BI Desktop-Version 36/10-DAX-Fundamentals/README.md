# บทที่ 10: DAX Fundamentals

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- เข้าใจแนวคิดพื้นฐานของ DAX
- เขียน DAX Formulas พื้นฐานได้
- เข้าใจ Context และ Filter Context
- สร้าง Calculated Columns และ Measures

## 📚 เนื้อหาบทเรียน

### 10.1 DAX คืออะไร?

#### 10.1.1 คำนิยาม
- **DAX**: Data Analysis Expressions
- **วัตถุประสงค์**: ภาษาโปรแกรมสำหรับการคำนวณใน Power BI
- **ความสามารถ**: สร้าง Calculated Columns, Measures, และ Calculated Tables

#### 10.1.2 DAX vs Excel Formulas
- **ความคล้ายคลึง**: Syntax คล้าย Excel
- **ความแตกต่าง**: ทำงานกับตารางและ Relationships
- **Context**: เข้าใจ Context ของข้อมูล
- **Performance**: ประสิทธิภาพสูงกว่า

### 10.2 DAX Syntax

#### 10.2.1 Basic Syntax
- **Operators**: +, -, *, /, =
- **Functions**: SUM, COUNT, AVERAGE
- **References**: Table[Column]
- **Constants**: Numbers, Text, Dates

#### 10.2.2 Function Structure
- **Function Name**: ชื่อฟังก์ชัน
- **Arguments**: อาร์กิวเมนต์
- **Parentheses**: วงเล็บ
- **Commas**: จุลภาค

#### 10.2.3 Examples
```
Total Sales = SUM(SalesData[Revenue])
Average Sales = AVERAGE(SalesData[Revenue])
Count of Products = COUNTROWS(SalesData)
```

### 10.3 Context in DAX

#### 10.3.1 Row Context
- **คำนิยาม**: Context ของแถวในตาราง
- **การใช้งาน**: ใน Calculated Columns
- **ตัวอย่าง**: การคำนวณในแต่ละแถว

#### 10.3.2 Filter Context
- **คำนิยาม**: Context ของการกรองข้อมูล
- **การใช้งาน**: ใน Measures และ Visualizations
- **ตัวอย่าง**: การคำนวณตามการกรอง

#### 10.3.3 Context Transition
- **คำนิยาม**: การเปลี่ยนจาก Row Context เป็น Filter Context
- **การใช้งาน**: ใน Calculated Columns
- **ตัวอย่าง**: การใช้ EARLIER function

### 10.4 Calculated Columns vs Measures

#### 10.4.1 Calculated Columns
- **คำนิยาม**: คอลัมน์ที่คำนวณในตาราง
- **การใช้งาน**: ใช้ใน Filters และ Slicers
- **Performance**: ใช้พื้นที่เก็บข้อมูล
- **ตัวอย่าง**: Year, Month, Sales Category

#### 10.4.2 Measures
- **คำนิยาม**: การคำนวณแบบ Dynamic
- **การใช้งาน**: ใช้ใน Visualizations
- **Performance**: คำนวณตาม Context
- **ตัวอย่าง**: Total Sales, Average Sales, Growth Rate

#### 10.4.3 When to Use What
- **Calculated Columns**: เมื่อต้องการใช้ใน Filters
- **Measures**: เมื่อต้องการใช้ใน Visualizations
- **Performance**: Measures ประสิทธิภาพดีกว่า

## 🛠️ การปฏิบัติ

### การสร้าง Calculated Column
1. เปิดไฟล์ `Business_Analytics.pbix`
2. ไปที่ Data View
3. เลือกตาราง "SalesData"
4. คลิก "New Column"
5. เขียน DAX Formula: Year = YEAR(SalesData[Date])
6. ตรวจสอบผลลัพธ์
7. บันทึกไฟล์ `Business_Analytics.pbix`

### การสร้าง Measure
1. ไปที่ Model View
2. คลิก "New Measure"
3. เขียน DAX Formula: Total Sales = SUM(SalesData[Revenue])
4. ตรวจสอบผลลัพธ์
5. ใช้ใน Visualization
6. บันทึกไฟล์ `Business_Analytics.pbix`

### การทดสอบ Context
1. สร้าง Measure: Sales by Country = SUM(SalesData[Revenue])
2. ใช้ใน Column Chart
3. เพิ่ม Filter สำหรับ Year
4. ตรวจสอบการเปลี่ยนแปลง
5. เข้าใจ Context
6. บันทึกไฟล์ `Business_Analytics.pbix`

## 📊 ข้อมูลตัวอย่าง

สำหรับบทนี้ เราใช้ข้อมูลจากไฟล์ `Business_Analytics.pbix` ที่มีอยู่แล้ว:
- **SalesData**: ข้อมูลยอดขายหลัก
- **All Sales by Country**: ข้อมูลยอดขายจากทุกประเทศ
- **Countries**: ข้อมูลประเทศและทวีป
- **DateTable**: ตารางวันที่
- **Visualizations ที่สร้างไว้แล้ว**: Column Chart, Line Chart, Pie Chart

## 🎯 แบบฝึกหัด

### แบบฝึกหัดที่ 1: สร้าง Calculated Columns
1. เปิดไฟล์ `Business_Analytics.pbix`
2. สร้างคอลัมน์ "Year" ในตาราง SalesData: Year = YEAR(SalesData[Date])
3. สร้างคอลัมน์ "Month" ในตาราง SalesData: Month = MONTH(SalesData[Date])
4. สร้างคอลัมน์ "Sales Category" ในตาราง SalesData: Sales Category = IF(SalesData[Revenue] > 10000, "High", "Low")
5. ตรวจสอบผลลัพธ์
6. บันทึกไฟล์ `Business_Analytics.pbix`

### แบบฝึกหัดที่ 2: สร้าง Measures
1. สร้าง Measure "Total Sales": Total Sales = SUM(SalesData[Revenue])
2. สร้าง Measure "Average Sales": Average Sales = AVERAGE(SalesData[Revenue])
3. สร้าง Measure "Count of Sales": Count of Sales = COUNTROWS(SalesData)
4. ใช้ใน Visualization
5. บันทึกไฟล์ `Business_Analytics.pbix`

### แบบฝึกหัดที่ 3: ทดสอบ Context
1. สร้าง Measure "Sales by Country": Sales by Country = SUM(SalesData[Revenue])
2. ใช้ใน Column Chart
3. เพิ่ม Filter สำหรับ Year
4. ตรวจสอบการเปลี่ยนแปลง
5. เข้าใจ Context
6. บันทึกไฟล์ `Business_Analytics.pbix`

### แบบฝึกหัดที่ 4: DAX Formulas พื้นฐาน
1. สร้าง Measure "Sales Growth": Sales Growth = DIVIDE([Total Sales], [Total Sales], 0)
2. สร้าง Measure "Sales Percentage": Sales Percentage = DIVIDE([Total Sales], CALCULATE([Total Sales], ALL()), 0)
3. สร้าง Measure "Top 5 Countries": Top 5 Countries = TOPN(5, VALUES(Countries[CountryName]), [Total Sales])
4. ใช้ใน Visualizations
5. บันทึกไฟล์ `Business_Analytics.pbix`

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- แนวคิดพื้นฐานของ DAX
- DAX Syntax และ Function Structure
- Context ใน DAX
- Calculated Columns vs Measures

### สิ่งที่จะเรียนต่อไป:
- DAX Functions
- Advanced DAX
- การใช้ DAX ใน Visualizations

## 🔗 ลิงก์ที่เป็นประโยชน์

- [DAX Reference](https://docs.microsoft.com/en-us/dax/)
- [DAX Fundamentals](https://docs.microsoft.com/en-us/learn/powerplatform/power-bi-dax/)
- [DAX Syntax](https://docs.microsoft.com/en-us/dax/dax-syntax-reference)

## 📞 คำถามที่พบบ่อย

**Q: DAX ยากไหม?**
A: เริ่มต้นไม่ยาก มีพื้นฐาน Excel จะช่วยได้

**Q: Calculated Columns และ Measures ต่างกันอย่างไร?**
A: Calculated Columns ใช้ใน Filters, Measures ใช้ใน Visualizations

**Q: Context คืออะไร?**
A: Context คือบริบทของการคำนวณใน DAX

---

**หมายเหตุ**: DAX เป็นพื้นฐานสำคัญสำหรับการสร้างการคำนวณที่ซับซ้อนใน Power BI