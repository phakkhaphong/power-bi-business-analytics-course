# Power BI Business Analytics - Datasets

## 📊 ภาพรวม Datasets

โปรเจ็กต์นี้มีข้อมูลตัวอย่างที่หลากหลายสำหรับการเรียนรู้ Power BI ตั้งแต่ระดับพื้นฐานไปจนถึงขั้นสูง

## 📁 โครงสร้าง Datasets

```
datasets/
├── sample/          # ข้อมูลตัวอย่างสำหรับการเรียนรู้
├── demo/           # ข้อมูลสำหรับ Demo และ Presentation
└── production/     # ข้อมูล Production (จำลอง)
```

## 🎯 Sample Datasets

### 🚗 Automotive Sales Dataset
**ไฟล์**: `sample/SalesData.xlsx`
**ขนาด**: 10,000+ records
**คอลัมน์**:
- InvoiceDate: วันที่ขาย
- ClientID: รหัสลูกค้า
- VehicleKey: รหัสรถ
- ColourID: รหัสสี
- SalePrice: ราคาขาย
- CostPrice: ราคาทุน
- TotalDiscount: ส่วนลดรวม
- DeliveryCharge: ค่าส่ง
- LabourCost: ค่าแรง
- SpareParts: อะไหล่
- Registration_Date: วันที่จดทะเบียน

### 🌍 Countries Dataset
**ไฟล์**: `sample/Countries.csv`
**ขนาด**: 195+ records
**คอลัมน์**:
- CountryID: รหัสประเทศ
- CountryName: ชื่อประเทศ
- CountryFlagURL: URL ธงชาติ
- Continent: ทวีป

### 📅 Date Table
**ไฟล์**: `sample/DateTable.xlsx`
**ขนาด**: 3,000+ records
**คอลัมน์**:
- DateKey: คีย์วันที่
- Year: ปี
- MonthNum: หมายเลขเดือน
- MonthFull: ชื่อเดือนเต็ม
- MonthAbbr: ชื่อเดือนย่อ
- QuarterNum: ไตรมาส
- QuarterFull: ชื่อไตรมาส
- DayOfWeek: วันในสัปดาห์

### 👥 Clients Dataset
**ไฟล์**: `sample/Clients.csv`
**ขนาด**: 500+ records
**คอลัมน์**:
- ClientID: รหัสลูกค้า
- ClientName: ชื่อลูกค้า
- Town: เมือง
- CountryID: รหัสประเทศ
- ClientType: ประเภทลูกค้า
- ClientSize: ขนาดลูกค้า
- IsCreditWorthy: สมควรให้เครดิต
- WebSite: เว็บไซต์

### 🚙 Vehicle Dataset
**ไฟล์**: `sample/Vehicle.xlsx`
**ขนาด**: 200+ records
**คอลัมน์**:
- VehicleKey: คีย์รถ
- Make: ยี่ห้อ
- Marque: รุ่น
- VehicleType: ประเภทรถ
- EngineSize: ขนาดเครื่องยนต์
- FuelType: ประเภทเชื้อเพลิง
- Transmission: เกียร์
- Year: ปีที่ผลิต

### 🎨 Color Dataset
**ไฟล์**: `sample/Color/`
**ขนาด**: 50+ records
**คอลัมน์**:
- ColorID: รหัสสี
- ColorName: ชื่อสี
- ColorCode: รหัสสี (HEX)
- ColorCategory: หมวดหมู่สี

### 🛣️ Mileage Dataset
**ไฟล์**: `sample/Mileage.xlsx`
**ขนาด**: 100+ records
**คอลัมน์**:
- MileageRangeSort: คีย์ระยะทาง
- MileageRange: ช่วงระยะทาง
- MileageCategory: หมวดหมู่ระยะทาง

## 📊 Demo Datasets

### 🏢 Enterprise Sales Demo
**ไฟล์**: `demo/EnterpriseSales.pbix`
**วัตถุประสงค์**: Demo สำหรับ Enterprise Features
**ฟีเจอร์**:
- Row Level Security
- Incremental Refresh
- Advanced DAX
- Custom Visuals

### 📈 Financial Dashboard Demo
**ไฟล์**: `demo/FinancialDashboard.pbix`
**วัตถุประสงค์**: Demo สำหรับ Financial Analytics
**ฟีเจอร์**:
- Financial Calculations
- Time Intelligence
- KPI Visualizations
- Forecasting

### 🛒 Retail Analytics Demo
**ไฟล์**: `demo/RetailAnalytics.pbix`
**วัตถุประสงค์**: Demo สำหรับ Retail Analytics
**ฟีเจอร์**:
- Customer Segmentation
- Product Performance
- Geographic Analysis
- Trend Analysis

## 🏭 Production Datasets (จำลอง)

### 📊 Sales Performance
**ไฟล์**: `production/SalesPerformance.xlsx`
**ขนาด**: 100,000+ records
**วัตถุประสงค์**: ทดสอบ Performance
**ฟีเจอร์**:
- Large dataset handling
- Performance optimization
- Incremental refresh
- DirectQuery

### 💰 Financial Data
**ไฟล์**: `production/FinancialData.xlsx`
**ขนาด**: 50,000+ records
**วัตถุประสงค์**: ทดสอบ Financial Analytics
**ฟีเจอร์**:
- Complex calculations
- Multiple currencies
- Regulatory reporting
- Audit trails

## 🔧 Data Preparation Scripts

### 📥 Data Generation
```powershell
# สร้างข้อมูลตัวอย่าง
.\scripts\generate-sample-data.ps1 -Records 10000 -OutputPath "datasets\sample\"

# สร้างข้อมูล Production
.\scripts\generate-production-data.ps1 -Records 100000 -OutputPath "datasets\production\"
```

### 🔄 Data Refresh
```powershell
# รีเฟรชข้อมูลตัวอย่าง
.\scripts\refresh-sample-data.ps1

# รีเฟรชข้อมูล Production
.\scripts\refresh-production-data.ps1
```

## 📋 Data Quality Guidelines

### ✅ Data Standards
- **Consistency**: ใช้รูปแบบข้อมูลที่สอดคล้อง
- **Completeness**: ข้อมูลครบถ้วน
- **Accuracy**: ข้อมูลถูกต้อง
- **Timeliness**: ข้อมูลเป็นปัจจุบัน

### 🔍 Data Validation
```powershell
# ตรวจสอบคุณภาพข้อมูล
.\scripts\validate-data.ps1 -DatasetPath "datasets\sample\"

# รายงานคุณภาพข้อมูล
.\scripts\data-quality-report.ps1
```

## 🚀 Quick Start

### 1. Download Datasets
```bash
# Clone repository
git clone https://github.com/your-username/power-bi-business-analytics.git

# หรือดาวน์โหลด ZIP
wget https://github.com/your-username/power-bi-business-analytics/archive/main.zip
```

### 2. Setup Data Environment
```powershell
# รัน setup script
.\scripts\setup-environment.ps1

# หรือ setup manual
# 1. ตรวจสอบไฟล์ข้อมูล
# 2. ตั้งค่า permissions
# 3. ทดสอบการเชื่อมต่อ
```

### 3. Start Learning
```powershell
# เปิด Power BI Desktop
Start-Process "C:\Program Files\Microsoft Power BI Desktop\PBIDesktop.exe"

# เปิดข้อมูลตัวอย่าง
Get-ChildItem "datasets\sample\" -Filter "*.xlsx"
```

## 📊 Data Relationships

### 🔗 Entity Relationship Diagram
```
Sales (Fact Table)
├── ClientID → Client.ClientID
├── VehicleKey → Vehicle.VehicleKey
├── ColourID → Color.ColorID
├── InvoiceDate → Date.DateKey
└── MileageRangeSort → Mileage.MileageRangeSort

Client (Dimension)
├── CountryID → Countries.CountryID
└── Geography Hierarchy

Vehicle (Dimension)
├── Make, Marque, VehicleType
└── Vehicle Age Calculation

Date (Dimension)
├── Calendar Hierarchy
└── Time Intelligence
```

## 🎯 Use Cases

### 📈 Business Scenarios
1. **Sales Analysis**: วิเคราะห์ยอดขาย
2. **Customer Analytics**: วิเคราะห์ลูกค้า
3. **Product Performance**: ประสิทธิภาพผลิตภัณฑ์
4. **Financial Reporting**: รายงานการเงิน
5. **Geographic Analysis**: วิเคราะห์ภูมิศาสตร์

### 🔧 Technical Scenarios
1. **Data Modeling**: การสร้าง Data Model
2. **DAX Development**: การพัฒนา DAX
3. **Performance Testing**: ทดสอบประสิทธิภาพ
4. **Security Implementation**: การรักษาความปลอดภัย
5. **Integration Testing**: ทดสอบการรวมระบบ

## 📚 Learning Path by Dataset

### 🟢 Beginner
- Countries Dataset
- Basic Sales Data
- Simple Date Table

### 🟡 Intermediate
- Complete Sales Dataset
- Client Dataset
- Vehicle Dataset

### 🟠 Advanced
- Production Datasets
- Complex Relationships
- Performance Testing

### 🔴 Expert
- Large Datasets
- Real-time Data
- Enterprise Features

## 🛡️ Data Privacy & Security

### 🔒 Privacy Considerations
- ข้อมูลเป็นข้อมูลจำลอง
- ไม่มีข้อมูลส่วนบุคคลจริง
- ใช้สำหรับการเรียนรู้เท่านั้น

### 🛡️ Security Best Practices
- ตั้งค่า Row Level Security
- ใช้ Data Classification
- Implement Access Control
- Monitor Data Usage

## 📞 Support

### 🆘 Getting Help
- **GitHub Issues**: สำหรับปัญหาเกี่ยวกับข้อมูล
- **Documentation**: คู่มือการใช้งาน
- **Community**: ชุมชนผู้ใช้

### 📧 Contact
- **Email**: support@9experttraining.com
- **GitHub**: [Power BI Business Analytics](https://github.com/your-username/power-bi-business-analytics)

---

**หมายเหตุ**: ข้อมูลเหล่านี้จัดทำขึ้นเพื่อการเรียนการสอนเท่านั้น กรุณาไม่ใช้ข้อมูลจริงในสภาพแวดล้อมการผลิต
