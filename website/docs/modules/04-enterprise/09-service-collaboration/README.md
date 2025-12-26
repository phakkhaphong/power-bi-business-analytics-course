# Module 9: Power BI Service & Collaboration (1 ชั่วโมง)

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- ใช้ Power BI Service Features อย่างเชี่ยวชาญ
- จัดการ Workspace และ Team Collaboration
- ตั้งค่า Sharing และ Security
- ใช้ Mobile และ Embedded Analytics
- สร้าง Enterprise Collaboration Platform

## 📚 เนื้อหาบทเรียน (60 นาที)

### 9.1 Power BI Service Features (15 นาที)

#### 9.1.1 Service Overview & Architecture
```
Power BI Service Architecture
├── Workspaces (Personal, Shared, Premium)
├── Datasets (Import, DirectQuery, Live Connection)
├── Reports (Interactive, Paginated)
├── Dashboards (Real-time, Scheduled)
├── Apps (Curated Content Collections)
└── Dataflows (Self-Service Data Prep)
```

#### 9.1.2 Key Service Features
- **Workspace Management**: จัดการพื้นที่ทำงาน
- **Dataset Management**: จัดการชุดข้อมูล
- **Report Publishing**: เผยแพร่รายงาน
- **Dashboard Creation**: สร้างแดชบอร์ด
- **App Distribution**: แจกจ่ายแอป
- **Dataflow Management**: จัดการข้อมูล

#### 9.1.3 Service vs Desktop
| Feature | Power BI Desktop | Power BI Service |
|---------|------------------|------------------|
| **Data Modeling** | ✅ Full Support | ❌ Limited |
| **Report Creation** | ✅ Full Support | ✅ Full Support |
| **Dashboard Creation** | ❌ No | ✅ Full Support |
| **Sharing** | ❌ No | ✅ Full Support |
| **Scheduling** | ❌ No | ✅ Full Support |
| **Mobile Access** | ❌ No | ✅ Full Support |

### 9.2 Workspace Management (15 นาที)

#### 9.2.1 Workspace Types
```json
// Workspace Configuration
{
  "workspaceType": "Premium",
  "capacity": "P3",
  "users": [
    {
      "email": "user@company.com",
      "role": "Admin",
      "permissions": ["Full Access"]
    },
    {
      "email": "analyst@company.com", 
      "role": "Member",
      "permissions": ["Read", "Write"]
    },
    {
      "email": "viewer@company.com",
      "role": "Viewer", 
      "permissions": ["Read Only"]
    }
  ]
}
```

#### 9.2.2 Workspace Roles & Permissions
- **Admin**: จัดการ workspace, users, content
- **Member**: สร้าง, แก้ไข, แชร์ content
- **Contributor**: สร้าง, แก้ไข content
- **Viewer**: ดู content เท่านั้น

#### 9.2.3 Content Organization
```
Sales Analytics Workspace
├── Datasets
│   ├── Sales Data (Import)
│   ├── Customer Data (DirectQuery)
│   └── Product Data (Live Connection)
├── Reports
│   ├── Sales Performance Report
│   ├── Customer Analytics Report
│   └── Product Performance Report
├── Dashboards
│   ├── Executive Dashboard
│   ├── Sales Manager Dashboard
│   └── Regional Dashboard
└── Apps
    ├── Sales Analytics App
    └── Customer Intelligence App
```

### 9.3 Sharing & Security (15 นาที)

#### 9.3.1 Sharing Options
```powershell
# Power BI REST API - Share Report
$shareRequest = @{
    emailAddress = "user@company.com"
    accessRight = "Read"
    message = "Please review the sales report"
} | ConvertTo-Json

Invoke-RestMethod -Uri "https://api.powerbi.com/v1.0/myorg/reports/{reportId}/users" `
    -Method POST -Body $shareRequest `
    -Headers @{Authorization = "Bearer $accessToken"}
```

#### 9.3.2 Security Features
- **Row Level Security (RLS)**: ความปลอดภัยระดับแถว
- **Column Level Security**: ความปลอดภัยระดับคอลัมน์
- **Workspace Security**: ความปลอดภัยพื้นที่ทำงาน
- **Data Classification**: การจำแนกข้อมูล
- **Audit Logs**: บันทึกการตรวจสอบ

#### 9.3.3 Row Level Security Implementation
```dax
// RLS Filter for Sales Territory
Sales Territory Filter = 
DimSalesTerritory[SalesTerritoryKey] = USERPRINCIPALNAME()

// RLS Filter for Customer Data
Customer Data Filter = 
DimCustomer[CustomerKey] = USERPRINCIPALNAME()

// RLS Filter for Product Category
Product Category Filter = 
DimProductCategory[ProductCategoryKey] = USERPRINCIPALNAME()
```

### 9.4 Mobile & Embedded Analytics (15 นาที)

#### 9.4.1 Mobile App Features
- **Offline Access**: เข้าถึงแบบออฟไลน์
- **Push Notifications**: การแจ้งเตือน
- **QR Code Scanning**: สแกน QR Code
- **Location-based Analytics**: การวิเคราะห์ตามตำแหน่ง
- **Voice Commands**: คำสั่งเสียง

#### 9.4.2 Embedded Analytics
```javascript
// Power BI Embedded Configuration
const config = {
    type: 'report',
    id: 'reportId',
    embedUrl: 'https://app.powerbi.com/reportEmbed',
    accessToken: 'accessToken',
    tokenType: 'Embed',
    settings: {
        filterPaneEnabled: true,
        navContentPaneEnabled: true,
        background: 'transparent'
    }
};

// Embed Report
powerbi.embed(embedContainer, config);
```

#### 9.4.3 Mobile Dashboard Design
```json
// Mobile Dashboard Configuration
{
  "mobileLayout": {
    "phone": {
      "tiles": [
        {
          "id": "tile1",
          "position": {"x": 0, "y": 0, "width": 2, "height": 2},
          "visual": "KPI Card"
        },
        {
          "id": "tile2", 
          "position": {"x": 2, "y": 0, "width": 2, "height": 2},
          "visual": "Line Chart"
        }
      ]
    },
    "tablet": {
      "tiles": [
        {
          "id": "tile1",
          "position": {"x": 0, "y": 0, "width": 3, "height": 2},
          "visual": "KPI Card"
        }
      ]
    }
  }
}
```

## 🛠️ การปฏิบัติ (30 นาที)

### Lab 1: Workspace & Collaboration Setup (15 นาที)
1. **Create Workspace**
   - สร้าง Workspace ใหม่
   - ตั้งค่า Users และ Roles
   - จัดระเบียบ Content

2. **Publish Content**
   - Publish Reports จาก Desktop
   - สร้าง Dashboards
   - สร้าง Apps

### Lab 2: Sharing & Mobile Setup (15 นาที)
1. **Configure Sharing**
   - ตั้งค่า Sharing Options
   - ตั้งค่า Security
   - ทดสอบ Access

2. **Mobile Configuration**
   - ตั้งค่า Mobile Layout
   - ทดสอบ Mobile Access
   - ตั้งค่า Notifications

## 📊 ข้อมูลตัวอย่าง

### Enterprise Collaboration Scenarios
- **Executive Dashboards**: Dashboard สำหรับผู้บริหาร
- **Department Analytics**: การวิเคราะห์ตามแผนก
- **Regional Reports**: รายงานตามภูมิภาค
- **Mobile Analytics**: Analytics บนมือถือ

### Collaboration Use Cases
- **Team Collaboration**: การทำงานร่วมกันในทีม
- **Cross-department Sharing**: การแชร์ข้ามแผนก
- **External Sharing**: การแชร์กับภายนอก
- **Mobile Access**: การเข้าถึงบนมือถือ

## 🎯 แบบฝึกหัด

### Exercise 1: Enterprise Workspace Setup
**สถานการณ์**: ตั้งค่า Workspace สำหรับองค์กร

**งาน**:
1. สร้าง Workspace Structure
2. ตั้งค่า Users และ Permissions
3. จัดระเบียบ Content
4. ทดสอบ Collaboration

### Exercise 2: Mobile & Embedded Analytics
**สถานการณ์**: สร้าง Mobile และ Embedded Solutions

**งาน**:
1. ตั้งค่า Mobile Layout
2. สร้าง Embedded Analytics
3. ทดสอบ Mobile Access
4. ตั้งค่า Notifications

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- Power BI Service Features
- Workspace Management
- Sharing และ Security
- Mobile และ Embedded Analytics

### สิ่งที่จะเรียนต่อไป:
- Enterprise Deployment และ Governance
- Best Practices และ Maintenance
- Advanced Security และ Compliance

## 🔗 ลิงก์ที่เป็นประโยชน์

- [Power BI Service](https://docs.microsoft.com/en-us/power-bi/service-get-started)
- [Workspace Management](https://docs.microsoft.com/en-us/power-bi/service-create-the-new-workspaces)
- [Sharing and Security](https://docs.microsoft.com/en-us/power-bi/service-how-to-share-dashboards)
- [Mobile App](https://docs.microsoft.com/en-us/power-bi/mobile/mobile-apps-for-mobile-devices)

## 📞 คำถามที่พบบ่อย

**Q: Power BI Service แตกต่างจาก Desktop อย่างไร?**
A: Service เน้นการแชร์และ Collaboration, Desktop เน้นการสร้างและพัฒนา

**Q: Workspace คืออะไร?**
A: พื้นที่ทำงานสำหรับจัดระเบียบและแชร์ Content

**Q: Mobile App ใช้ทำอะไร?**
A: เข้าถึง Reports และ Dashboards บนมือถือ, รับ Notifications

---

**หมายเหตุ**: Power BI Service เป็นหัวใจสำคัญของ Enterprise Collaboration

