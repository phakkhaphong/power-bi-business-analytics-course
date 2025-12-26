# 🚀 การตั้งค่า GitHub Pages สำหรับ Docusaurus

## 📋 ขั้นตอนการตั้งค่า

### 1. แก้ไข `docusaurus.config.js`

แก้ไข URL และ baseUrl ใน `website/docusaurus.config.js`:

```javascript
// สำหรับ Repository ชื่อ: power-bi-business-analytics-course
// และ GitHub Username/Org: YOUR-USERNAME

url: 'https://YOUR-USERNAME.github.io',
baseUrl: '/power-bi-business-analytics-course/',  // หรือ '/' ถ้าใช้ custom domain
organizationName: 'YOUR-USERNAME',
projectName: 'power-bi-business-analytics-course',
```

**ตัวอย่าง:**
- ถ้า GitHub Username คือ `john-doe`
- Repository ชื่อ `power-bi-business-analytics-course`
- URL จะเป็น: `https://john-doe.github.io`
- baseUrl จะเป็น: `/power-bi-business-analytics-course/`

### 2. ตั้งค่า GitHub Pages ใน Repository

1. ไปที่ **Repository Settings** → **Pages**
2. ตั้งค่า **Source** เป็น:
   - **Branch**: `gh-pages`
   - **Folder**: `/ (root)`
3. คลิก **Save**

### 3. ตรวจสอบ GitHub Actions

1. ไปที่ **Actions** tab ใน GitHub
2. ตรวจสอบว่า workflow `Deploy Docusaurus` ทำงาน
3. ถ้ายังไม่ทำงาน ให้ push ไฟล์ใหม่ไปที่ `main` branch

### 4. รอ Deployment

- GitHub Actions จะ build และ deploy website อัตโนมัติ
- ใช้เวลาประมาณ 2-5 นาที
- ตรวจสอบที่ **Actions** tab เพื่อดูสถานะ

### 5. เข้าถึง Website

หลังจาก deployment เสร็จ:
- URL: `https://YOUR-USERNAME.github.io/power-bi-business-analytics-course/`
- หรือ: `https://YOUR-USERNAME.github.io/` (ถ้า baseUrl เป็น `/`)

## 🔧 การแก้ไขปัญหา

### ปัญหา: Website ไม่แสดงผล

**แก้ไข:**
1. ตรวจสอบว่า `docusaurus.config.js` มี URL และ baseUrl ถูกต้อง
2. ตรวจสอบว่า GitHub Actions workflow ทำงานสำเร็จ
3. ตรวจสอบว่า GitHub Pages ตั้งค่าเป็น `gh-pages` branch

### ปัญหา: Links ไม่ทำงาน

**แก้ไข:**
- ตรวจสอบว่า `baseUrl` ถูกต้อง
- ถ้าใช้ subdirectory (เช่น `/power-bi-business-analytics-course/`) ต้องมี trailing slash `/`

### ปัญหา: GitHub Actions ไม่ทำงาน

**แก้ไข:**
1. ตรวจสอบว่า workflow file อยู่ใน `.github/workflows/`
2. ตรวจสอบว่า branch ชื่อ `main` (ไม่ใช่ `master`)
3. ตรวจสอบว่า GitHub Actions enabled ใน repository settings

## 📝 ตัวอย่างการตั้งค่า

### สำหรับ Repository: `power-bi-business-analytics-course`
### GitHub Username: `your-username`

```javascript
// docusaurus.config.js
url: 'https://your-username.github.io',
baseUrl: '/power-bi-business-analytics-course/',
organizationName: 'your-username',
projectName: 'power-bi-business-analytics-course',
```

**Website URL:** `https://your-username.github.io/power-bi-business-analytics-course/`

### สำหรับ Custom Domain

```javascript
// docusaurus.config.js
url: 'https://yourdomain.com',
baseUrl: '/',
```

**Website URL:** `https://yourdomain.com`

## ✅ Checklist

- [ ] แก้ไข `docusaurus.config.js` ให้มี URL และ baseUrl ถูกต้อง
- [ ] ตั้งค่า GitHub Pages ใน repository settings
- [ ] Push code ไปที่ `main` branch
- [ ] ตรวจสอบ GitHub Actions workflow
- [ ] รอ deployment เสร็จ
- [ ] ทดสอบ website URL

---

**หลังจากตั้งค่าเสร็จ Website จะพร้อมใช้งาน! 🎉**
