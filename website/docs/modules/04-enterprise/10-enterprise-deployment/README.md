# Module 10: Enterprise Deployment & Governance (1 ชั่วโมง)

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- ออกแบบ Enterprise Architecture
- วางแผน Security และ Governance
- ตั้งค่า Performance Monitoring
- ใช้ Best Practices และ Maintenance
- สร้าง Enterprise BI Strategy

## 📚 เนื้อหาบทเรียน (60 นาที)

### 10.1 Enterprise Architecture (15 นาที)

#### 10.1.1 Architecture Design
```
Enterprise Power BI Architecture
├── Data Sources
│   ├── On-premises (SQL Server, Oracle)
│   ├── Cloud (Azure SQL, AWS RDS)
│   └── SaaS (Salesforce, Dynamics 365)
├── Data Gateway
│   ├── On-premises Data Gateway
│   ├── VNet Gateway
│   └── Power BI Gateway
├── Power BI Service
│   ├── Premium Capacity
│   ├── Workspaces
│   └── Apps
└── End Users
    ├── Power BI Desktop
    ├── Power BI Mobile
    └── Embedded Analytics
```

#### 10.1.2 Capacity Planning
```json
// Premium Capacity Configuration
{
  "capacityType": "P3",
  "vCores": 32,
  "memory": 100,
  "storage": "100TB",
  "users": 1000,
  "workspaces": 100,
  "datasets": 1000,
  "refreshFrequency": "8 times per day"
}
```

#### 10.1.3 Data Architecture Patterns
- **Hub and Spoke**: Centralized data with distributed analytics
- **Federated**: Distributed data with centralized governance
- **Hybrid**: Combination of centralized and distributed
- **Self-Service**: Decentralized with minimal governance

### 10.2 Security & Governance (20 นาที)

#### 10.2.1 Security Framework
```json
// Security Configuration
{
  "authentication": {
    "method": "Azure AD",
    "multiFactor": true,
    "conditionalAccess": true
  },
  "authorization": {
    "rowLevelSecurity": true,
    "columnLevelSecurity": true,
    "workspaceSecurity": true
  },
  "dataProtection": {
    "encryption": "Azure Key Vault",
    "classification": "Sensitive",
    "retention": "7 years"
  }
}
```

#### 10.2.2 Governance Framework
```json
// Governance Configuration
{
  "dataGovernance": {
    "dataOwners": ["Data Stewards"],
    "dataClassification": ["Public", "Internal", "Confidential"],
    "dataLineage": true,
    "dataQuality": "Automated"
  },
  "contentGovernance": {
    "namingConventions": "Standardized",
    "contentApproval": "Required",
    "versionControl": "Enabled",
    "retentionPolicy": "7 years"
  },
  "userGovernance": {
    "roleBasedAccess": true,
    "trainingRequired": true,
    "certification": "Annual",
    "auditLogging": "Enabled"
  }
}
```

#### 10.2.3 Compliance & Audit
```sql
-- Audit Log Query
SELECT 
    Activity,
    UserId,
    ItemName,
    ItemType,
    ActivityTime,
    Details
FROM PowerBIAdmin.ActivityLog
WHERE ActivityTime >= DATEADD(day, -30, GETDATE())
ORDER BY ActivityTime DESC;

-- Security Audit Query
SELECT 
    UserId,
    AccessRight,
    ResourceType,
    ResourceName,
    AccessTime
FROM PowerBIAdmin.AccessLog
WHERE AccessTime >= DATEADD(day, -7, GETDATE())
ORDER BY AccessTime DESC;
```

### 10.3 Performance Monitoring (15 นาที)

#### 10.3.1 Performance Metrics
```dax
// Performance Monitoring Measures
Dataset Refresh Time = 
AVERAGE(DatasetMetrics[RefreshDuration])

Report Load Time = 
AVERAGE(ReportMetrics[LoadDuration])

User Activity = 
COUNTROWS(UserActivity)

Capacity Utilization = 
DIVIDE(
    [Active Users],
    [Total Capacity]
)

Query Performance = 
AVERAGE(QueryMetrics[QueryDuration])
```

#### 10.3.2 Monitoring Dashboard
```json
// Performance Monitoring Dashboard
{
  "tiles": [
    {
      "title": "Capacity Utilization",
      "visual": "Gauge",
      "metric": "Capacity Utilization"
    },
    {
      "title": "Dataset Refresh Status",
      "visual": "Table",
      "metric": "Dataset Refresh Time"
    },
    {
      "title": "User Activity",
      "visual": "Line Chart",
      "metric": "User Activity"
    },
    {
      "title": "Query Performance",
      "visual": "Bar Chart",
      "metric": "Query Performance"
    }
  ]
}
```

#### 10.3.3 Alerting & Notifications
```powershell
# Performance Alert Configuration
$alertConfig = @{
    name = "High Capacity Utilization"
    condition = "Capacity Utilization > 80%"
    frequency = "Every 15 minutes"
    notification = @{
        email = "admin@company.com"
        webhook = "https://alerts.company.com/powerbi"
    }
}

# Create Alert
New-PowerBIAlert -Configuration $alertConfig
```

### 10.4 Best Practices & Maintenance (10 นาที)

#### 10.4.1 Development Best Practices
```dax
// DAX Best Practices
-- Use variables for complex calculations
VAR TotalSales = SUM(FactSales[SalesAmount])
VAR TotalCost = SUM(FactSales[TotalCost])
VAR Profit = TotalSales - TotalCost
RETURN Profit

-- Use DIVIDE for safe division
Safe Division = DIVIDE([Total Sales], [Total Orders], 0)

-- Use IF instead of nested IF when possible
Simple IF = IF([Total Sales] > 10000, "High", "Low")
```

#### 10.4.2 Data Model Best Practices
- **Star Schema**: ใช้ Star Schema สำหรับ Data Model
- **Relationships**: สร้าง Relationships ที่ถูกต้อง
- **Measures**: ใช้ Measures แทน Calculated Columns
- **Data Types**: เลือก Data Types ที่เหมาะสม
- **Naming Conventions**: ใช้ชื่อที่สอดคล้องกัน

#### 10.4.3 Maintenance Tasks
```powershell
# Weekly Maintenance Tasks
$maintenanceTasks = @(
    "Check dataset refresh status",
    "Review capacity utilization", 
    "Monitor user activity",
    "Update security policies",
    "Backup critical datasets",
    "Review audit logs",
    "Update documentation"
)

# Monthly Maintenance Tasks
$monthlyTasks = @(
    "Performance optimization review",
    "Security audit",
    "User access review",
    "Content lifecycle management",
    "Training updates",
    "Governance policy review"
)
```

## 🛠️ การปฏิบัติ (30 นาที)

### Lab 1: Enterprise Architecture Setup (15 นาที)
1. **Architecture Design**
   - ออกแบบ Enterprise Architecture
   - วางแผน Capacity Requirements
   - ตั้งค่า Data Sources

2. **Security Configuration**
   - ตั้งค่า Authentication
   - ตั้งค่า Authorization
   - ตั้งค่า Data Protection

### Lab 2: Governance & Monitoring (15 นาที)
1. **Governance Setup**
   - ตั้งค่า Governance Framework
   - ตั้งค่า Compliance Policies
   - ตั้งค่า Audit Logging

2. **Performance Monitoring**
   - ตั้งค่า Performance Metrics
   - สร้าง Monitoring Dashboard
   - ตั้งค่า Alerting

## 📊 ข้อมูลตัวอย่าง

### Enterprise Scenarios
- **Multi-tenant Architecture**: Architecture สำหรับหลายองค์กร
- **Global Deployment**: การติดตั้งทั่วโลก
- **Compliance Requirements**: ความต้องการด้าน Compliance
- **High Availability**: ความพร้อมใช้งานสูง

### Governance Use Cases
- **Data Stewardship**: การจัดการข้อมูล
- **Content Lifecycle**: วงจรชีวิต Content
- **User Management**: การจัดการผู้ใช้
- **Security Policies**: นโยบายความปลอดภัย

## 🎯 แบบฝึกหัด

### Exercise 1: Enterprise Architecture Design
**สถานการณ์**: ออกแบบ Enterprise Architecture

**งาน**:
1. ออกแบบ Architecture
2. วางแผน Capacity
3. ตั้งค่า Security
4. วางแผน Governance

### Exercise 2: Performance Monitoring & Maintenance
**สถานการณ์**: ตั้งค่า Monitoring และ Maintenance

**งาน**:
1. ตั้งค่า Performance Monitoring
2. สร้าง Monitoring Dashboard
3. ตั้งค่า Alerting
4. วางแผน Maintenance

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- Enterprise Architecture Design
- Security และ Governance
- Performance Monitoring
- Best Practices และ Maintenance

### สิ่งที่จะเรียนต่อไป:
- การประยุกต์ใช้ในองค์กรจริง
- การพัฒนาทักษะต่อเนื่อง
- การเป็น Power BI Expert

## 🔗 ลิงก์ที่เป็นประโยชน์

- [Power BI Enterprise Architecture](https://docs.microsoft.com/en-us/power-bi/guidance/whitepaper-powerbi-implementation-planning)
- [Power BI Security](https://docs.microsoft.com/en-us/power-bi/admin/service-admin-security)
- [Power BI Governance](https://docs.microsoft.com/en-us/power-bi/admin/service-admin-governance)
- [Power BI Performance](https://docs.microsoft.com/en-us/power-bi/guidance/whitepaper-powerbi-performance)

## 📞 คำถามที่พบบ่อย

**Q: Enterprise Architecture สำคัญอย่างไร?**
A: ช่วยวางแผนการติดตั้งที่เหมาะสมกับความต้องการขององค์กร

**Q: Governance คืออะไร?**
A: กรอบการจัดการข้อมูล, Content, และผู้ใช้ในองค์กร

**Q: Performance Monitoring ต้องทำอะไรบ้าง?**
A: ตรวจสอบ Capacity, Refresh Status, User Activity, และ Query Performance

---

**หมายเหตุ**: Enterprise Deployment และ Governance เป็นหัวใจสำคัญของการใช้งาน Power BI ในองค์กรขนาดใหญ่

