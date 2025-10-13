# บทที่ 11: DAX Functions

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- ใช้ DAX Functions หลักได้
- เข้าใจ Aggregation Functions
- ใช้ Time Intelligence Functions
- ใช้ Filter Functions

## 📚 เนื้อหาบทเรียน

### 11.1 Aggregation Functions

#### 11.1.1 Basic Aggregation
- **SUM**: รวมค่า
- **COUNT**: นับจำนวน
- **COUNTROWS**: นับแถว
- **AVERAGE**: ค่าเฉลี่ย
- **MIN/MAX**: ค่าต่ำสุด/สูงสุด

#### 11.1.2 Advanced Aggregation
- **SUMX**: รวมค่าแบบ Iterative
- **COUNTX**: นับแบบ Iterative
- **AVERAGEX**: ค่าเฉลี่ยแบบ Iterative
- **MINX/MAXX**: ค่าต่ำสุด/สูงสุดแบบ Iterative

#### 11.1.3 Statistical Functions
- **STDEV**: ส่วนเบี่ยงเบนมาตรฐาน
- **VAR**: ความแปรปรวน
- **MEDIAN**: ค่ามัธยฐาน
- **PERCENTILE**: เปอร์เซ็นไทล์

### 11.2 Time Intelligence Functions

#### 11.2.1 Date Functions
- **DATE**: สร้างวันที่
- **YEAR**: ดึงปี
- **MONTH**: ดึงเดือน
- **DAY**: ดึงวัน
- **WEEKDAY**: ดึงวันในสัปดาห์

#### 11.2.2 Time Period Functions
- **TOTALYTD**: รวมปีปัจจุบัน
- **TOTALQTD**: รวมไตรมาสปัจจุบัน
- **TOTALMTD**: รวมเดือนปัจจุบัน
- **SAMEPERIODLASTYEAR**: เปรียบเทียบปีที่แล้ว

#### 11.2.3 Advanced Time Intelligence
- **DATESYTD**: วันที่ในปีปัจจุบัน
- **DATESQTD**: วันที่ในไตรมาสปัจจุบัน
- **DATESMTD**: วันที่ในเดือนปัจจุบัน
- **PARALLELPERIOD**: เปรียบเทียบช่วงเวลา

### 11.3 Filter Functions

#### 11.3.1 Basic Filter Functions
- **FILTER**: กรองข้อมูล
- **ALL**: เอาทั้งหมด
- **ALLEXCEPT**: เอาทั้งหมดยกเว้น
- **ALLSELECTED**: เอาที่เลือกไว้

#### 11.3.2 Advanced Filter Functions
- **CALCULATE**: คำนวณตามเงื่อนไข
- **CALCULATETABLE**: ตารางตามเงื่อนไข
- **KEEPFILTERS**: เก็บ Filters
- **REMOVEFILTERS**: ลบ Filters

#### 11.3.3 Context Functions
- **EARLIER**: แถวก่อนหน้า
- **EARLIEST**: แถวแรกสุด
- **SELECTEDVALUE**: ค่าที่เลือก
- **HASONEVALUE**: มีค่าเดียว

### 11.4 Logical Functions

#### 11.4.1 Conditional Functions
- **IF**: เงื่อนไข
- **SWITCH**: หลายเงื่อนไข
- **IFERROR**: จัดการ Error
- **ISERROR**: ตรวจสอบ Error

#### 11.4.2 Comparison Functions
- **AND**: และ
- **OR**: หรือ
- **NOT**: ไม่
- **XOR**: หรือเฉพาะ

#### 11.4.3 Information Functions
- **ISBLANK**: เป็นค่าว่าง
- **ISNUMBER**: เป็นตัวเลข
- **ISTEXT**: เป็นข้อความ
- **ISDATE**: เป็นวันที่

## 🛠️ การปฏิบัติ

### การใช้ Aggregation Functions
1. เปิดไฟล์ `Business_Analytics.pbix`
2. สร้าง Measure "Total Sales": Total Sales = SUM(SalesData[Revenue])
3. สร้าง Measure "Average Sales": Average Sales = AVERAGE(SalesData[Revenue])
4. สร้าง Measure "Count of Sales": Count of Sales = COUNTROWS(SalesData)
5. ใช้ใน Visualization
6. บันทึกไฟล์ `Business_Analytics.pbix`

### การใช้ Time Intelligence Functions
1. สร้าง Measure "Sales YTD": Sales YTD = TOTALYTD([Total Sales], DateTable[Date])
2. สร้าง Measure "Sales vs Last Year": Sales vs Last Year = CALCULATE([Total Sales], SAMEPERIODLASTYEAR(DateTable[Date]))
3. สร้าง Measure "Sales Growth": Sales Growth = DIVIDE([Total Sales] - [Sales vs Last Year], [Sales vs Last Year])
4. ใช้ใน Visualization
5. บันทึกไฟล์ `Business_Analytics.pbix`

### การใช้ Filter Functions
1. สร้าง Measure "Sales All Countries": Sales All Countries = CALCULATE([Total Sales], ALL(Countries))
2. สร้าง Measure "Sales Selected Country": Sales Selected Country = CALCULATE([Total Sales], SELECTEDVALUE(Countries[CountryName]))
3. สร้าง Measure "Sales Top 5": Sales Top 5 = TOPN(5, VALUES(Countries[CountryName]), [Total Sales])
4. ใช้ใน Visualization
5. บันทึกไฟล์ `Business_Analytics.pbix`

## 📊 ข้อมูลตัวอย่าง

สำหรับบทนี้ เราใช้ข้อมูลจากไฟล์ `Business_Analytics.pbix` ที่มีอยู่แล้ว:
- **SalesData**: ข้อมูลยอดขายหลัก
- **All Sales by Country**: ข้อมูลยอดขายจากทุกประเทศ
- **Countries**: ข้อมูลประเทศและทวีป
- **DateTable**: ตารางวันที่
- **Calculated Columns และ Measures ที่สร้างไว้แล้ว**

## 🎯 แบบฝึกหัด

### แบบฝึกหัดที่ 1: Aggregation Functions
1. เปิดไฟล์ `Business_Analytics.pbix`
2. สร้าง Measure "Total Sales" ด้วย SUM: Total Sales = SUM(SalesData[Revenue])
3. สร้าง Measure "Average Sales" ด้วย AVERAGE: Average Sales = AVERAGE(SalesData[Revenue])
4. สร้าง Measure "Count of Sales" ด้วย COUNT: Count of Sales = COUNTROWS(SalesData)
5. ใช้ใน Visualization
6. บันทึกไฟล์ `Business_Analytics.pbix`

### แบบฝึกหัดที่ 2: Time Intelligence Functions
1. สร้าง Measure "Sales YTD" ด้วย TOTALYTD: Sales YTD = TOTALYTD([Total Sales], DateTable[Date])
2. สร้าง Measure "Sales vs Last Year" ด้วย SAMEPERIODLASTYEAR: Sales vs Last Year = CALCULATE([Total Sales], SAMEPERIODLASTYEAR(DateTable[Date]))
3. สร้าง Measure "Sales Growth" ด้วย DIVIDE: Sales Growth = DIVIDE([Total Sales] - [Sales vs Last Year], [Sales vs Last Year])
4. ใช้ใน Visualization
5. บันทึกไฟล์ `Business_Analytics.pbix`

### แบบฝึกหัดที่ 3: Filter Functions
1. สร้าง Measure "Sales All Countries" ด้วย ALL: Sales All Countries = CALCULATE([Total Sales], ALL(Countries))
2. สร้าง Measure "Sales Selected Country" ด้วย SELECTEDVALUE: Sales Selected Country = CALCULATE([Total Sales], SELECTEDVALUE(Countries[CountryName]))
3. สร้าง Measure "Sales Top 5" ด้วย TOPN: Sales Top 5 = TOPN(5, VALUES(Countries[CountryName]), [Total Sales])
4. ใช้ใน Visualization
5. บันทึกไฟล์ `Business_Analytics.pbix`

### แบบฝึกหัดที่ 4: Logical Functions
1. สร้าง Measure "Sales Category" ด้วย IF: Sales Category = IF([Total Sales] > 1000000, "High", "Low")
2. สร้าง Measure "Sales Status" ด้วย SWITCH: Sales Status = SWITCH(TRUE(), [Total Sales] > 1000000, "High", [Total Sales] > 500000, "Medium", "Low")
3. สร้าง Measure "Sales Valid" ด้วย IFERROR: Sales Valid = IFERROR([Total Sales], 0)
4. ใช้ใน Visualization
5. บันทึกไฟล์ `Business_Analytics.pbix`

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- Aggregation Functions
- Time Intelligence Functions
- Filter Functions
- Logical Functions

### สิ่งที่จะเรียนต่อไป:
- Advanced DAX
- การใช้ DAX ใน Visualizations
- Performance Optimization

## 🔗 ลิงก์ที่เป็นประโยชน์

- [DAX Function Reference](https://docs.microsoft.com/en-us/dax/dax-function-reference)
- [Time Intelligence Functions](https://docs.microsoft.com/en-us/dax/time-intelligence-functions-dax)
- [Filter Functions](https://docs.microsoft.com/en-us/dax/filter-functions-dax)

## 📞 คำถามที่พบบ่อย

**Q: DAX Functions มีกี่ประเภท?**
A: มีหลายประเภท เช่น Aggregation, Time Intelligence, Filter, Logical

**Q: Time Intelligence Functions ใช้ทำอะไร?**
A: ใช้สำหรับการวิเคราะห์ข้อมูลตามเวลา

**Q: Filter Functions ใช้ทำอะไร?**
A: ใช้สำหรับการกรองข้อมูลในการคำนวณ

---

**หมายเหตุ**: DAX Functions เป็นเครื่องมือสำคัญสำหรับการสร้างการคำนวณที่ซับซ้อน