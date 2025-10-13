# บทที่ 12: Advanced DAX

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- เข้าใจ Advanced DAX Concepts
- ใช้ Advanced DAX Functions
- เข้าใจ Performance Optimization
- สร้าง Complex DAX Formulas

## 📚 เนื้อหาบทเรียน

### 12.1 Advanced DAX Concepts

#### 12.1.1 Context Transition
- **คำนิยาม**: การเปลี่ยนจาก Row Context เป็น Filter Context
- **การใช้งาน**: ใน Calculated Columns
- **ตัวอย่าง**: การใช้ EARLIER function
- **Performance**: ผลกระทบต่อประสิทธิภาพ

#### 12.1.2 Evaluation Context
- **Filter Context**: Context ของการกรอง
- **Row Context**: Context ของแถว
- **Query Context**: Context ของ Query
- **Calculation Context**: Context ของการคำนวณ

#### 12.1.3 Variable Functions
- **VAR**: ประกาศตัวแปร
- **RETURN**: คืนค่า
- **ตัวอย่าง**: การใช้ Variables
- **Performance**: ประสิทธิภาพที่ดีขึ้น

### 12.2 Advanced Functions

#### 12.2.1 Iterator Functions
- **SUMX**: รวมค่าแบบ Iterative
- **COUNTX**: นับแบบ Iterative
- **AVERAGEX**: ค่าเฉลี่ยแบบ Iterative
- **MAXX/MINX**: ค่าสูงสุด/ต่ำสุดแบบ Iterative

#### 12.2.2 Table Functions
- **FILTER**: กรองตาราง
- **ADDCOLUMNS**: เพิ่มคอลัมน์
- **SUMMARIZE**: สรุปตาราง
- **GROUPBY**: จัดกลุ่มตาราง

#### 12.2.3 Advanced Filter Functions
- **CALCULATE**: คำนวณตามเงื่อนไข
- **CALCULATETABLE**: ตารางตามเงื่อนไข
- **KEEPFILTERS**: เก็บ Filters
- **REMOVEFILTERS**: ลบ Filters

#### 12.2.4 Advanced Time Intelligence
- **DATESBETWEEN**: วันที่ระหว่าง
- **DATESINPERIOD**: วันที่ในช่วง
- **PREVIOUSYEAR**: ปีที่แล้ว
- **NEXTYEAR**: ปีหน้า

### 12.3 Performance Optimization

#### 12.3.1 Best Practices
- **Use Measures**: ใช้ Measures แทน Calculated Columns
- **Avoid Complex Calculations**: หลีกเลี่ยงการคำนวณที่ซับซ้อน
- **Optimize Data Model**: ปรับปรุง Data Model
- **Use Variables**: ใช้ Variables

#### 12.3.2 Performance Monitoring
- **Performance Analyzer**: เครื่องมือวิเคราะห์ประสิทธิภาพ
- **DAX Studio**: เครื่องมือ Debug DAX
- **Query Plans**: แผนการ Query
- **Execution Time**: เวลาการทำงาน

#### 12.3.3 Optimization Techniques
- **Reduce Columns**: ลดจำนวนคอลัมน์
- **Optimize Relationships**: ปรับปรุง Relationships
- **Use Aggregations**: ใช้ Aggregations
- **Cache Results**: เก็บผลลัพธ์ใน Cache

### 12.4 Advanced Patterns

#### 12.4.1 Running Totals
- **Cumulative Sum**: ผลรวมสะสม
- **Moving Averages**: ค่าเฉลี่ยเคลื่อนที่
- **Period Comparisons**: เปรียบเทียบช่วงเวลา
- **Growth Calculations**: การคำนวณการเติบโต

#### 12.4.2 Ranking and Percentiles
- **RANK**: การจัดอันดับ
- **PERCENTILE**: เปอร์เซ็นไทล์
- **QUARTILE**: ควอร์ไทล์
- **TOP/BOTTOM N**: อันดับต้น/ท้าย

#### 12.4.3 Advanced Analytics
- **Correlation**: ความสัมพันธ์
- **Regression**: การถดถอย
- **Forecasting**: การพยากรณ์
- **Statistical Analysis**: การวิเคราะห์ทางสถิติ

## 🛠️ การปฏิบัติ

### การใช้ Advanced Functions
1. เปิดไฟล์ `Business_Analytics.pbix`
2. สร้าง Measure ด้วย SUMX: Sales by Category = SUMX(Countries, [Total Sales])
3. สร้าง Measure ด้วย CALCULATE: Sales Growth = CALCULATE([Total Sales], ALL(Countries))
4. สร้าง Measure ด้วย Variables: Sales Analysis = VAR TotalSales = [Total Sales] VAR AvgSales = [Average Sales] RETURN TotalSales - AvgSales
5. ใช้ใน Visualization
6. บันทึกไฟล์ `Business_Analytics.pbix`

### การใช้ Performance Analyzer
1. เปิด Performance Analyzer
2. เริ่ม Recording
3. ใช้ Visualizations ที่มีอยู่
4. ตรวจสอบ Performance
5. ปรับปรุง DAX ถ้าจำเป็น
6. บันทึกไฟล์ `Business_Analytics.pbix`

### การสร้าง Advanced Patterns
1. สร้าง Running Total: Running Total = CALCULATE([Total Sales], FILTER(ALL(DateTable), DateTable[Date] <= MAX(DateTable[Date])))
2. สร้าง Moving Average: Moving Average = AVERAGEX(DATESINPERIOD(DateTable[Date], MAX(DateTable[Date]), -12, MONTH), [Total Sales])
3. สร้าง Ranking: Ranking = RANKX(ALL(Countries), [Total Sales])
4. ใช้ใน Visualization
5. บันทึกไฟล์ `Business_Analytics.pbix`

## 📊 ข้อมูลตัวอย่าง

สำหรับบทนี้ เราใช้ข้อมูลจากไฟล์ `Business_Analytics.pbix` ที่มีอยู่แล้ว:
- **SalesData**: ข้อมูลยอดขายหลัก
- **All Sales by Country**: ข้อมูลยอดขายจากทุกประเทศ
- **Countries**: ข้อมูลประเทศและทวีป
- **DateTable**: ตารางวันที่
- **Measures ที่สร้างไว้แล้ว**: Total Sales, Average Sales, Sales YTD

## 🎯 แบบฝึกหัด

### แบบฝึกหัดที่ 1: Advanced Functions
1. เปิดไฟล์ `Business_Analytics.pbix`
2. สร้าง Measure "Sales by Category" ด้วย SUMX: Sales by Category = SUMX(Countries, [Total Sales])
3. สร้าง Measure "Sales Growth" ด้วย CALCULATE: Sales Growth = CALCULATE([Total Sales], ALL(Countries))
4. สร้าง Measure "Sales Trend" ด้วย Variables: Sales Trend = VAR TotalSales = [Total Sales] VAR AvgSales = [Average Sales] RETURN TotalSales - AvgSales
5. ใช้ใน Visualization
6. บันทึกไฟล์ `Business_Analytics.pbix`

### แบบฝึกหัดที่ 2: Performance Optimization
1. เปิด Performance Analyzer
2. เริ่ม Recording
3. ใช้ Visualizations ที่มีอยู่
4. ตรวจสอบ Performance
5. ปรับปรุง DAX ถ้าจำเป็น
6. บันทึกไฟล์ `Business_Analytics.pbix`

### แบบฝึกหัดที่ 3: Advanced Patterns
1. สร้าง Running Total: Running Total = CALCULATE([Total Sales], FILTER(ALL(DateTable), DateTable[Date] <= MAX(DateTable[Date])))
2. สร้าง Moving Average: Moving Average = AVERAGEX(DATESINPERIOD(DateTable[Date], MAX(DateTable[Date]), -12, MONTH), [Total Sales])
3. สร้าง Ranking: Ranking = RANKX(ALL(Countries), [Total Sales])
4. ใช้ใน Visualization
5. บันทึกไฟล์ `Business_Analytics.pbix`

### แบบฝึกหัดที่ 4: Complex DAX
1. สร้าง Measure "Sales Analysis": Sales Analysis = VAR TotalSales = [Total Sales] VAR AvgSales = [Average Sales] VAR Growth = DIVIDE(TotalSales - AvgSales, AvgSales) RETURN Growth
2. ใช้ Advanced Functions
3. ใช้ Variables
4. ใช้ใน Visualization
5. บันทึกไฟล์ `Business_Analytics.pbix`

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- Advanced DAX Concepts
- Advanced Functions
- Performance Optimization
- Advanced Patterns

### สิ่งที่จะเรียนต่อไป:
- Power BI Service
- การเผยแพร่รายงาน
- การแชร์และทำงานร่วมกัน

## 🔗 ลิงก์ที่เป็นประโยชน์

- [Advanced DAX](https://docs.microsoft.com/en-us/dax/)
- [DAX Performance](https://docs.microsoft.com/en-us/power-bi/guidance/dax-avoid-overuse/)
- [DAX Patterns](https://www.daxpatterns.com/)

## 📞 คำถามที่พบบ่อย

**Q: Advanced DAX ยากไหม?**
A: ต้องฝึกฝนและเข้าใจ Context

**Q: Performance Optimization สำคัญไหม?**
A: สำคัญมากสำหรับ Report ที่มีข้อมูลเยอะ

**Q: DAX Patterns คืออะไร?**
A: รูปแบบการเขียน DAX ที่ใช้บ่อย

---

**หมายเหตุ**: Advanced DAX ช่วยให้สร้างการคำนวณที่ซับซ้อนและมีประสิทธิภาพ