# Power BI Business Analytics Course

<div align="center">

![Power BI Logo](website/static/img/Logo-9Expert.png)

**หลักสูตรเข้มข้น 12 ชั่วโมง - เน้นการใช้งานเชิงธุรกิจจริง**

[![GitHub stars](https://img.shields.io/github/stars/phakkhaphong/power-bi-business-analytics-course?style=social)](https://github.com/phakkhaphong/power-bi-business-analytics-course)
[![GitHub forks](https://img.shields.io/github/forks/phakkhaphong/power-bi-business-analytics-course?style=social)](https://github.com/phakkhaphong/power-bi-business-analytics-course)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

[📚 เริ่มเรียนทันที](https://phakkhaphong.github.io) • [📖 เอกสาร](https://phakkhaphong.github.io/docs) • [💬 Discussions](https://github.com/phakkhaphong/power-bi-business-analytics-course/discussions)

</div>

---

## 🎯 เกี่ยวกับหลักสูตร

หลักสูตร Power BI Business Analytics ที่ออกแบบมาให้เข้มข้นและเน้นการใช้งานเชิงธุรกิจจริง โดยใช้ **AdventureWorks OLTP** เป็นกรณีศึกษาหลัก และใช้ **Power Query** สร้าง Dimensional Model สำหรับการวิเคราะห์

### ✨ จุดเด่น

- 🚀 **12 ชั่วโมงเข้มข้น** - เรียนรู้ได้ใน 1 วัน
- 🏢 **เน้นธุรกิจจริง** - ใช้ AdventureWorks OLTP
- 🔧 **Power Query Mastery** - สร้าง Dimensional Model จาก OLTP
- 📊 **Advanced Analytics** - CLV, RFM, Churn Analysis
- 🌐 **Enterprise Ready** - Security, Governance, Deployment

## 📚 โครงสร้างหลักสูตร

### 🏗️ Foundation & Data Engineering (3 ชั่วโมง)
- Module 1: Business Intelligence Overview
- Module 2: AdventureWorks OLTP & Power Query Transformation
- Module 3: Advanced Power Query & Data Transformation

### 📊 Analytics & Visualizations (4 ชั่วโมง)
- Module 4: Sales Analytics Dashboard
- Module 5: Customer Analytics & Segmentation
- Module 6: Product & Inventory Analytics

### 💡 DAX & Advanced Analytics (3 ชั่วโมง)
- Module 7: DAX for Business Intelligence
- Module 8: Advanced Analytics & AI in Power BI

### 🌐 Enterprise & Deployment (2 ชั่วโมง)
- Module 9: Power BI Service & Collaboration
- Module 10: Enterprise Deployment & Governance

## 🚀 เริ่มต้นใช้งาน

### 1. Clone Repository
```bash
git clone https://github.com/phakkhaphong/power-bi-business-analytics-course.git
cd power-bi-business-analytics-course
```

### 2. Setup Docusaurus
```bash
cd website
npm install
npm start
```

### 3. เริ่มเรียน
- 📖 อ่าน [เอกสารหลักสูตร](https://phakkhaphong.github.io)
- 🎯 เริ่มจาก [Module 1](https://phakkhaphong.github.io/modules/01-foundation/01-business-intelligence-overview/README)
- 📚 ดู [Learning Path](https://phakkhaphong.github.io/learning-path)

## 📁 โครงสร้าง Repository

```
power-bi-business-analytics-course/
├── .github/workflows/      # CI/CD (GitHub Actions)
├── website/               # Docusaurus Project
│   ├── docs/              # เนื้อหาหลักสูตร (แก้ที่นี่)
│   ├── static/img/        # รูปภาพประกอบ
│   └── docusaurus.config.js
├── labs/                  # ไฟล์ประกอบการเรียน (.pbix, .xlsx, .csv)
├── README.md              # หน้าปก Repo (คุณอยู่ที่นี่)
└── .gitignore
```

## 🛠️ สำหรับผู้พัฒนา

### Setup Docusaurus
```bash
cd website
npm install
npm start
```

### Build Website
```bash
cd website
npm run build
```

### Deploy
Website จะถูก deploy อัตโนมัติเมื่อ push ไปที่ branch `main` ผ่าน GitHub Actions

**⚠️ สำคัญ:** ต้องแก้ไข `website/docusaurus.config.js` ให้มี URL และ baseUrl ถูกต้องก่อน deploy

ดูคำแนะนำใน [GITHUB-PAGES-SETUP.md](GITHUB-PAGES-SETUP.md)

## 📊 ข้อมูลตัวอย่าง

### AdventureWorks OLTP
- **Company**: AdventureWorks Cycles - Bicycle Manufacturer
- **Time Period**: 2005-2014 (10 years)
- **Orders**: 31,465+ sales orders
- **Customers**: 19,820+ customers
- **Products**: 504+ products
- **Revenue**: $109M+ across all sales

## 🎯 วัตถุประสงค์การเรียนรู้

เมื่อจบหลักสูตร ผู้เรียนจะสามารถ:
- ✅ เข้าใจ Business Intelligence และ Power BI Ecosystem
- ✅ ใช้ AdventureWorks OLTP เป็นกรณีศึกษาธุรกิจจริง
- ✅ สร้าง Dimensional Model จาก OLTP Data ด้วย Power Query
- ✅ คำนวณ Customer Lifetime Value (CLV) และทำ RFM Analysis
- ✅ สร้าง Advanced Analytics และ AI-Powered Reports
- ✅ Deploy Power BI Solutions ในองค์กร

## 📞 การสนับสนุน

- 📚 [Documentation](https://phakkhaphong.github.io/docs)
- 💬 [Discussions](https://github.com/phakkhaphong/power-bi-business-analytics-course/discussions)
- 🐛 [Issues](https://github.com/phakkhaphong/power-bi-business-analytics-course/issues)
- 📧 Email: support@example.com

## 🤝 Contributing

เรายินดีรับ contributions! กรุณาเปิด Issue หรือ Pull Request ใน GitHub repository

## 📄 License

This project is open source and available for educational purposes.

## 🙏 Acknowledgments

- [AdventureWorks Sample Databases](https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure)
- [Power BI Documentation](https://docs.microsoft.com/en-us/power-bi/)
- [Docusaurus](https://docusaurus.io/)

---

<div align="center">

**พร้อมเป็น Power BI Business Expert ใน 12 ชั่วโมง! 🚀**

Made with ❤️ by the Power BI Community

[⭐ Star this repo](https://github.com/phakkhaphong/power-bi-business-analytics-course) if you find it helpful!

</div>