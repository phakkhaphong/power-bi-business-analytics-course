# 🛠️ Labs - ไฟล์ประกอบการเรียน

โฟลเดอร์นี้เก็บไฟล์ประกอบการเรียนที่ผู้เรียนสามารถดาวน์โหลดได้

## 📁 โครงสร้าง

```
labs/
├── datasets/              # ไฟล์ข้อมูลตัวอย่าง
│   ├── AdventureWorks/    # AdventureWorks OLTP database files
│   └── sample/            # ข้อมูลตัวอย่างอื่นๆ
├── templates/             # Power BI templates (.pbit)
├── solutions/             # เฉลยแบบฝึกหัด (.pbix)
└── exercises/            # ไฟล์ประกอบแบบฝึกหัด
```

## 📥 วิธีการดาวน์โหลด

### **Option 1: Download จาก GitHub**
1. ไปที่ไฟล์ที่ต้องการใน GitHub
2. คลิก "Download" หรือ "Raw"
3. บันทึกไฟล์ลงเครื่อง

### **Option 2: Clone Repository**
```bash
git clone https://github.com/your-org/power-bi-business-analytics-course.git
cd power-bi-business-analytics-course/labs
```

### **Option 3: Download ZIP**
1. ไปที่หน้า GitHub Repository
2. คลิก "Code" → "Download ZIP"
3. Extract และเข้าไปที่โฟลเดอร์ `labs/`

## 📊 ไฟล์ที่แนะนำ

### **AdventureWorks OLTP**
- `AdventureWorks2019.bak` - Database backup file
- `restore-adventureworks.sql` - Restore script
- `connection-strings.json` - Connection strings

### **Power BI Templates**
- `sales-analytics-template.pbit` - Template สำหรับ Sales Analytics
- `customer-analytics-template.pbit` - Template สำหรับ Customer Analytics
- `product-analytics-template.pbit` - Template สำหรับ Product Analytics

### **Sample Data**
- `sample-sales-data.xlsx` - ข้อมูลยอดขายตัวอย่าง
- `sample-customer-data.csv` - ข้อมูลลูกค้าตัวอย่าง
- `sample-product-data.csv` - ข้อมูลผลิตภัณฑ์ตัวอย่าง

## ⚠️ หมายเหตุ

- ไฟล์ `.pbix` และ `.xlsx` อาจมีขนาดใหญ่
- ใช้ Git LFS สำหรับไฟล์ขนาดใหญ่
- ตรวจสอบไฟล์ก่อนดาวน์โหลด

## 🔗 ลิงก์ที่เป็นประโยชน์

- [AdventureWorks OLTP Download](https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure)
- [Power BI Templates](https://docs.microsoft.com/en-us/power-bi/create-reports/desktop-templates)
- [Git LFS](https://git-lfs.github.com/)

---

**Happy Learning! 🚀**
