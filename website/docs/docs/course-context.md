# Power BI Business Analytics Course - Context Reference

## 📚 ข้อมูลสำคัญจากเอกสารประกอบการอบรม (Version 36)

### 🎯 ภาพรวมหลักสูตร
- **ชื่อหลักสูตร**: Microsoft Power BI Desktop for Business Analytics - Version 36
- **ผู้สอน**: Aj-Phakkapong จาก 9Expert Training
- **เว็บไซต์**: https://www.9experttraining.com/power-bi-desktop-business-analytics-training-course
- **ภาษา**: ไทย (พร้อมเอกสารอ้างอิงภาษาอังกฤษ)

### 📊 ข้อมูลตัวอย่างและกรณีศึกษา

#### ข้อมูลหลักที่ใช้ในหลักสูตร
- **Sales Data**: ข้อมูลยอดขายรถยนต์ (5,000+ records)
- **Countries Data**: ข้อมูลประเทศและทวีป
- **Date Table**: ตารางวันที่สำหรับการวิเคราะห์
- **Color Data**: ข้อมูลสีรถยนต์
- **Vehicle Data**: ข้อมูลยานพาหนะ
- **Client Data**: ข้อมูลลูกค้า

#### กรณีศึกษาหลัก
- **Automotive Sales Analysis**: การวิเคราะห์ยอดขายรถยนต์
- **Geographic Analysis**: การวิเคราะห์ตามภูมิศาสตร์
- **Time Intelligence**: การวิเคราะห์ตามเวลา
- **Customer Segmentation**: การแบ่งกลุ่มลูกค้า

### 💰 DAX Formulas และ Power Query ที่สำคัญ

#### Power Query Calculations
```dax
NetSales = [SalePrice] - ( [TotalDiscount] + [DeliveryCharge] )
GrossMargin = [NetSales] - [CostPrice]
DirectCost = [LabourCost] + [SpareParts]
NetMargin = [GrossMargin] - ( [LabourCost] + [SpareParts] )
SalesCosts = [TotalDiscount] + [DeliveryCharge]
```

#### DAX Measures
```dax
Total Sales = SUM(Sales[NetSales])
Total Costs = SUM(Sales[SalesCosts])
Margin = [Total Sales] - [Total Costs]
%Margin = DIVIDE(([Total Sales]-[Total Costs]),[Total Sales],0)

Client per Country = COUNTROWS(RELATEDTABLE(Clients))
```

#### Advanced DAX Calculations
```dax
VehicleAge = DATEDIFF(Sales[Registration_Date], Sales[InvoiceDate], YEAR)

Vehicle Age Category = 
IF([VehicleAge] <= 5, "Under 5",
IF([VehicleAge] <=10, "6-10",
IF([VehicleAge] <=15, "11-15",
IF([VehicleAge] <=20, "16-20",
IF([VehicleAge] <=25, "21-25",
IF([VehicleAge] <=30, "26-30", "Over 30"))))))

Vehicle Age Category Sort = 
IF( [VehicleAge] <= 5, 1,
IF( [VehicleAge] <=10, 2,
IF( [VehicleAge] <=15, 3,
IF( [VehicleAge] <=20, 4,
IF( [VehicleAge] <=25, 5,
IF( [VehicleAge] <=30, 6, 7))))))
```

#### Vehicle Age Table (DATATABLE)
```dax
VehicleAge =
	DATATABLE(
		"VehicleAgeKey",INTEGER,
		"VehicleAgeCategory",STRING,
		{
			{1,"Under 5"},
			{2,"6-10"},
			{3,"11-15"},
			{4,"16-20"},
			{5,"21-25"},
			{6,"26-30"},
			{7,"Over 30"},
		}
```

### 🎓 เนื้อหาหลักสูตรเดิม (15 บท)

#### บทที่ 1-3: พื้นฐาน
1. **Introduction to Power BI**: แนวคิด BI, Power BI Ecosystem
2. **Power BI Desktop Overview**: Interface, Views, Ribbon
3. **Data Sources and Connections**: การเชื่อมต่อข้อมูล, Import vs DirectQuery

#### บทที่ 4-6: การจัดการข้อมูล
4. **Power Query Editor**: Data Transformation, Applied Steps, M Language
5. **Data Transformation**: Advanced Transformations, Merge/Append Queries
6. **Data Modeling**: Star Schema, Relationships, Fact/Dimension Tables

#### บทที่ 7-9: การสร้างรายงาน
7. **Visualizations**: Charts, Tables, Maps, Cards, KPIs
8. **Advanced Visualizations**: Custom Visuals, Analytics Features
9. **Report Design**: Design Principles, Layout, Interactive Elements

#### บทที่ 10-12: DAX และการคำนวณ
10. **DAX Fundamentals**: Syntax, Context, Calculated Columns vs Measures
11. **DAX Functions**: Aggregation, Time Intelligence, Filter, Logical Functions
12. **Advanced DAX**: Context Transition, Variables, Performance Optimization

#### บทที่ 13-15: การเผยแพร่และแชร์
13. **Power BI Service**: Publishing, Dashboards, Workspace Management
14. **Sharing and Collaboration**: Permissions, Collaboration Features
15. **Best Practices**: Data Model, Report Design, DAX, Security

### 📁 ข้อมูลตัวอย่างที่ใช้

#### ไฟล์ข้อมูลหลัก
- **SalesData.xlsx**: ข้อมูลยอดขายรถยนต์หลัก
- **SalesData2025.xlsx**: ข้อมูลยอดขายรถยนต์ปี 2025
- **Countries.csv**: ข้อมูลประเทศและธงชาติ
- **DateTable.xlsx**: ตารางวันที่
- **Clients.pdf**: ข้อมูลลูกค้า

#### ข้อมูลสีรถยนต์
- **CarColor_01.txt**: ข้อมูลสีรถยนต์ 1
- **CarColor_02.txt**: ข้อมูลสีรถยนต์ 2

#### ข้อมูลประเทศและทวีป
- **List of Countries by Continent.txt**: รายชื่อประเทศตามทวีป

#### ข้อมูลยอดขายแยกตามประเทศ
- **CA Sales.csv**: ข้อมูลยอดขายแคนาดา
- **FR Sales.csv**: ข้อมูลยอดขายฝรั่งเศส
- **GermanySales.csv**: ข้อมูลยอดขายเยอรมนี
- **MX Sales.csv**: ข้อมูลยอดขายเม็กซิโก

### 🛠️ ข้อกำหนดระบบ

#### ระบบปฏิบัติการ
- Windows 10 (เวอร์ชัน 1903 หรือใหม่กว่า)
- Windows 11 (แนะนำ)
- Windows Server 2019 หรือใหม่กว่า

#### ฮาร์ดแวร์
- RAM: อย่างน้อย 4GB (แนะนำ 8GB ขึ้นไป)
- Storage: อย่างน้อย 2GB ว่างสำหรับการติดตั้ง
- Processor: Intel Core i3 หรือ AMD equivalent ขึ้นไป
- Display: ความละเอียด 1366x768 ขึ้นไป (แนะนำ 1920x1080)

#### ซอฟต์แวร์
- Microsoft Power BI Desktop (ฟรี)
- Microsoft Excel 2016 หรือใหม่กว่า (แนะนำ)
- PDF Reader
- Web Browser (สำหรับ Power BI Service)

### 🔗 ลิงก์และทรัพยากรเพิ่มเติม

#### 9Expert Training Resources
- **เว็บไซต์หลัก**: https://www.9experttraining.com/
- **Power BI Course**: https://www.9experttraining.com/power-bi-desktop-business-analytics-training-course

#### Microsoft Resources
- **Power BI Documentation**: https://docs.microsoft.com/en-us/power-bi/
- **Power BI Community**: https://community.powerbi.com/
- **DAX Reference**: https://docs.microsoft.com/en-us/dax/

#### Power Query Resources
- **Power Query แบบ Fuzzy Matching**: https://www.youtube.com/watch?v=ObqBcPdhnaI
- **Refresh Power BI ด้วย Power BI Gateway**: https://youtu.be/K6PmRgol86c

### 📊 โครงสร้างข้อมูลและ Data Model

#### Star Schema Design
- **Fact Table**: Sales (ตารางหลัก)
- **Dimension Tables**: 
  - Client (ลูกค้า)
  - Date (วันที่)
  - Color (สีรถ)
  - Vehicle (ยานพาหนะ)
  - Mileage (ระยะทาง)
  - Vehicle Age (อายุรถ)

#### Relationships
- Sales.InvoiceDate → Date.DateKey
- Sales.ClientID → Client.ClientID
- Sales.ColourID → Color.ColorID
- Sales.VehicleKey → Vehicle.VehicleKey
- Sales.MileageRangeSort → Mileage.MileageRangeSort
- Sales.VehicleAgeKey → Vehicle Age.VehicleAgeKey

### 🎯 กลุ่มเป้าหมายหลักสูตร

#### ผู้เรียนที่เหมาะสม
- ผู้เริ่มต้นที่ต้องการเรียนรู้ Power BI
- Business Analyst ที่ต้องการพัฒนาทักษะ
- ผู้ที่ต้องการสร้างรายงานและ Dashboard
- ผู้ที่ต้องการเข้าใจ Business Intelligence

#### ข้อกำหนดเบื้องต้น
- ความรู้พื้นฐานในการใช้งานคอมพิวเตอร์
- ความรู้พื้นฐานใน Microsoft Excel จะเป็นประโยชน์
- ไม่จำเป็นต้องมีประสบการณ์ Power BI มาก่อน

### 📚 วิธีการเรียน

#### สำหรับผู้เรียน
1. อ่านเนื้อหาในแต่ละบทตามลำดับ
2. ทำตามตัวอย่างในไฟล์ README.md ของแต่ละบท
3. ฝึกทำแบบฝึกหัดในโฟลเดอร์ exercises/
4. ตรวจสอบคำตอบในโฟลเดอร์ solutions/

#### สำหรับผู้สอน
1. อ่าน CONTRIBUTING.md สำหรับคำแนะนำ
2. ใช้ไฟล์ PowerPoint ในโฟลเดอร์ resources/
3. ปรับแต่งเนื้อหาตามความเหมาะสม

### 🔄 การอัพเดทและพัฒนา

#### เวอร์ชันปัจจุบัน
- **Version**: 36
- **อัพเดทล่าสุด**: 2024
- **สถานะ**: กำลังพัฒนาสู่ Version 2.0

#### แผนการพัฒนา
- เพิ่มเนื้อหาเข้มข้นขึ้น
- ปรับโครงสร้างตาม Best Practices
- เพิ่ม Advanced Exercises และ Case Studies
- บูรณาการ Power Platform

---

## 📝 หมายเหตุ

เอกสารนี้เก็บข้อมูลสำคัญจากเอกสารประกอบการอบรม PDF เพื่อใช้เป็น context reference สำหรับการพัฒนาหลักสูตรต่อไป โดยไม่เก็บไฟล์ PDF ต้นฉบับเพื่อลดขนาดของ repository

ข้อมูลนี้จะถูกใช้ในการสร้างเนื้อหา modules ใหม่และปรับปรุงหลักสูตรให้เข้มข้นขึ้นตามแผนการพัฒนา Version 2.0
