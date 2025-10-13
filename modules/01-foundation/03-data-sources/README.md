# บทที่ 3: Data Sources & Connections

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- เชื่อมต่อกับ Data Sources หลากหลายประเภทได้
- เข้าใจ Import vs DirectQuery vs Live Connection
- ตั้งค่า Data Gateway และ On-premises Connections
- จัดการ Data Refresh และ Scheduling
- เข้าใจ Privacy Levels และ Security Implications

## 📚 เนื้อหาบทเรียน

### 3.1 Data Source Categories

#### 3.1.1 File Sources
- **Excel Files**: .xlsx, .xls, .csv, .txt
- **Power BI Files**: .pbix, .pbit
- **JSON Files**: API responses, configuration files
- **XML Files**: Data interchange, configuration
- **PDF Files**: Tabular data extraction
- **Folder Sources**: Multiple files in folder

#### 3.1.2 Database Sources
- **SQL Server**: On-premises และ Azure
- **Oracle**: Enterprise databases
- **MySQL**: Open source databases
- **PostgreSQL**: Advanced open source
- **Access**: Desktop databases
- **SQLite**: Lightweight databases

#### 3.1.3 Cloud Services
- **Azure Services**: SQL Database, Data Lake, Synapse
- **AWS Services**: RDS, Redshift, S3
- **Google Cloud**: BigQuery, Cloud SQL
- **Salesforce**: CRM data
- **Dynamics 365**: ERP data
- **SharePoint**: Document libraries

#### 3.1.4 Online Services
- **Google Analytics**: Web analytics
- **Facebook**: Social media data
- **Twitter**: Social media insights
- **GitHub**: Repository data
- **Jira**: Project management
- **Zendesk**: Customer support

### 3.2 Connection Modes

#### 3.2.1 Import Mode
- **คำนิยาม**: นำข้อมูลมาบันทึกใน Power BI
- **ข้อดี**:
  - Performance ดีที่สุด
  - ใช้งานได้ทุกฟีเจอร์
  - ทำงาน Offline ได้
  - รองรับ Complex Calculations
- **ข้อเสีย**:
  - ใช้พื้นที่เก็บข้อมูล
  - ข้อมูลอาจไม่เป็นปัจจุบัน
  - จำกัดขนาดข้อมูล
  - ต้องจัดการ Refresh

#### 3.2.2 DirectQuery Mode
- **คำนิยาม**: เชื่อมต่อกับข้อมูลแบบ Real-time
- **ข้อดี**:
  - ข้อมูลเป็นปัจจุบันเสมอ
  - ไม่ใช้พื้นที่เก็บข้อมูล
  - รองรับข้อมูลขนาดใหญ่
  - Real-time Analytics
- **ข้อเสีย**:
  - Performance ช้ากว่า
  - จำกัดฟีเจอร์บางอย่าง
  - ต้องเชื่อมต่อกับแหล่งข้อมูลเสมอ
  - จำกัด DAX Functions

#### 3.2.3 Live Connection
- **คำนิยาม**: เชื่อมต่อกับ Analysis Services
- **ข้อดี**:
  - ข้อมูลเป็นปัจจุบัน
  - ใช้ Existing Data Model
  - Performance ดี
  - Enterprise Features
- **ข้อเสีย**:
  - ต้องมี Analysis Services
  - จำกัดการแก้ไข Model
  - ต้องการ Infrastructure

#### 3.2.4 Composite Models
- **คำนิยาม**: รวม Import และ DirectQuery
- **ข้อดี**:
  - ความยืดหยุ่นสูง
  - Performance ที่เหมาะสม
  - รองรับ Large Datasets
  - Best of Both Worlds
- **ข้อเสีย**:
  - ซับซ้อนในการจัดการ
  - ต้องวางแผนดี
  - ต้องการ Expertise

### 3.3 Data Gateway

#### 3.3.1 Gateway Types
- **On-premises Data Gateway**: เชื่อมต่อ On-premises
- **On-premises Data Gateway (Personal Mode)**: สำหรับส่วนบุคคล
- **VNet Gateway**: สำหรับ Azure VNet
- **Power BI Gateway**: Cloud-based gateway

#### 3.3.2 Gateway Setup
1. **Download และ Install**
2. **Configure Gateway**
3. **Add Data Sources**
4. **Set Permissions**
5. **Test Connections**

#### 3.3.3 Gateway Management
- **Monitor Performance**
- **Manage Users**
- **Update Gateway**
- **Troubleshoot Issues**

### 3.4 Data Refresh

#### 3.4.1 Refresh Types
- **Scheduled Refresh**: รีเฟรชตามกำหนด
- **On-demand Refresh**: รีเฟรชเมื่อต้องการ
- **Incremental Refresh**: รีเฟรชเฉพาะส่วนที่เปลี่ยนแปลง
- **Real-time Refresh**: รีเฟรชแบบ Real-time

#### 3.4.2 Refresh Configuration
- **Set Refresh Schedule**
- **Configure Data Sources**
- **Set Refresh Options**
- **Monitor Refresh Status**

#### 3.4.3 Troubleshooting Refresh
- **Common Issues**
- **Error Messages**
- **Performance Problems**
- **Data Quality Issues**

### 3.5 Privacy & Security

#### 3.5.1 Privacy Levels
- **Public**: ข้อมูลสาธารณะ
- **Organizational**: ข้อมูลภายในองค์กร
- **Private**: ข้อมูลส่วนตัว
- **None**: ไม่มีการจำแนก

#### 3.5.2 Security Best Practices
- **Use Appropriate Privacy Levels**
- **Implement Row Level Security**
- **Use Service Principal**
- **Monitor Data Access**

## 🛠️ การปฏิบัติ

### Lab 1: Multiple Data Sources
1. **Connect to File Sources**
   - Excel files
   - CSV files
   - JSON files

2. **Connect to Database Sources**
   - SQL Server
   - Azure SQL Database
   - MySQL

3. **Connect to Cloud Services**
   - Azure Data Lake
   - SharePoint
   - Salesforce

### Lab 2: Connection Modes
1. **Import Mode Setup**
   - Configure import settings
   - Set refresh schedule
   - Test performance

2. **DirectQuery Mode Setup**
   - Configure DirectQuery
   - Test real-time data
   - Optimize queries

3. **Composite Model**
   - Combine import and DirectQuery
   - Test functionality
   - Optimize performance

### Lab 3: Gateway & Refresh
1. **Gateway Setup**
   - Install gateway
   - Configure data sources
   - Test connections

2. **Refresh Configuration**
   - Set refresh schedule
   - Configure incremental refresh
   - Monitor refresh status

## 📊 ข้อมูลตัวอย่าง

### Data Source Scenarios
- **Enterprise Data**: SQL Server, Oracle
- **Cloud Data**: Azure, AWS, Google Cloud
- **File Data**: Excel, CSV, JSON
- **API Data**: REST APIs, Web Services

### Connection Scenarios
- **Small Dataset**: Import mode
- **Large Dataset**: DirectQuery mode
- **Mixed Dataset**: Composite model
- **Real-time**: Live connection

## 🎯 แบบฝึกหัด

### Exercise 1: Data Source Integration
**สถานการณ์**: บริษัทต้องการเชื่อมต่อข้อมูลจากหลายแหล่ง

**งาน**:
1. เชื่อมต่อกับ SQL Server Database
2. เชื่อมต่อกับ Excel Files
3. เชื่อมต่อกับ REST API
4. ทดสอบการทำงาน

### Exercise 2: Connection Mode Optimization
**สถานการณ์**: ต้องเลือก Connection Mode ที่เหมาะสม

**งาน**:
1. วิเคราะห์ข้อมูลและความต้องการ
2. เลือก Connection Mode ที่เหมาะสม
3. ตั้งค่าการเชื่อมต่อ
4. ทดสอบประสิทธิภาพ

### Exercise 3: Enterprise Setup
**สถานการณ์**: ตั้งค่า Power BI สำหรับองค์กร

**งาน**:
1. ติดตั้งและตั้งค่า Gateway
2. ตั้งค่า Data Refresh
3. กำหนด Privacy Levels
4. ทดสอบการทำงาน

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- ประเภทของ Data Sources
- Connection Modes และการเลือกใช้
- Data Gateway และการตั้งค่า
- Data Refresh และการจัดการ
- Privacy และ Security

### สิ่งที่จะเรียนต่อไป:
- Power Query Mastery
- Advanced Data Transformation
- Data Modeling Excellence

## 🔗 ลิงก์ที่เป็นประโยชน์

- [Power BI Data Sources](https://docs.microsoft.com/en-us/power-bi/connect-data/)
- [Data Gateway](https://docs.microsoft.com/en-us/power-bi/admin/service-gateway-onprem)
- [Data Refresh](https://docs.microsoft.com/en-us/power-bi/connect-data/refresh-data)
- [Privacy Levels](https://docs.microsoft.com/en-us/power-bi/admin/service-admin-privacy-levels)

## 📞 คำถามที่พบบ่อย

**Q: ควรใช้ Import หรือ DirectQuery?**
A: Import สำหรับข้อมูลขนาดเล็ก, DirectQuery สำหรับข้อมูลขนาดใหญ่

**Q: Gateway จำเป็นหรือไม่?**
A: จำเป็นสำหรับการเชื่อมต่อกับ On-premises Data Sources

**Q: ตั้งค่า Refresh อย่างไร?**
A: ไปที่ Dataset Settings > Schedule Refresh

---

**หมายเหตุ**: การเลือก Data Sources และ Connection Modes ที่เหมาะสมเป็นพื้นฐานสำคัญ
