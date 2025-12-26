# 🔧 แก้ไขปัญหา GitHub Pages ไม่แสดงผล

## ✅ สิ่งที่แก้ไขแล้ว

### 1. **แก้ไข `baseUrl`**
- **เดิม**: `/power-bi-business-analytics-course/`
- **ใหม่**: `/` (สำหรับ user site: phakkhaphong.github.io)

### 2. **แก้ไข GitHub Links**
- แก้ไข GitHub URLs ทั้งหมดให้ชี้ไปที่ `phakkhaphong/power-bi-business-analytics-course`

## 📋 ขั้นตอนการแก้ไขปัญหา

### **Option 1: ใช้ User Site (แนะนำ)**

ถ้าคุณต้องการใช้ `phakkhaphong.github.io` โดยตรง:

1. **ตั้งค่า GitHub Pages:**
   - ไปที่ Repository Settings → Pages
   - Source: **Branch**: `gh-pages`
   - Folder: `/ (root)`
   - Save

2. **ตรวจสอบ GitHub Actions:**
   - ไปที่ Actions tab
   - ตรวจสอบว่า workflow `Deploy Docusaurus` ทำงาน
   - ถ้ายังไม่ทำงาน ให้ push code ใหม่

3. **Website URL:**
   - `https://phakkhaphong.github.io/`

### **Option 2: ใช้ Project Site**

ถ้าคุณต้องการใช้ `phakkhaphong.github.io/power-bi-business-analytics-course`:

1. **แก้ไข `docusaurus.config.js`:**
   ```javascript
   baseUrl: '/power-bi-business-analytics-course/',
   ```

2. **ตั้งค่า GitHub Pages:**
   - ไปที่ Repository Settings → Pages
   - Source: **Branch**: `gh-pages`
   - Folder: `/ (root)`
   - Save

3. **Website URL:**
   - `https://phakkhaphong.github.io/power-bi-business-analytics-course/`

## 🔍 ตรวจสอบปัญหา

### 1. **ตรวจสอบ GitHub Actions**
- ไปที่ **Actions** tab
- ดูว่า workflow ทำงานสำเร็จหรือไม่
- ถ้ามี error ให้ดู error message

### 2. **ตรวจสอบ GitHub Pages Settings**
- ไปที่ **Settings** → **Pages**
- ตรวจสอบว่า Source เป็น `gh-pages` branch
- ตรวจสอบว่า Folder เป็น `/ (root)`

### 3. **ตรวจสอบ Branch `gh-pages`**
- ไปที่ **Code** tab
- ดูว่ามี branch `gh-pages` หรือไม่
- ตรวจสอบว่า branch มีไฟล์ `index.html` หรือไม่

## 🚀 การ Deploy ใหม่

### 1. **Push Code**
```bash
git add .
git commit -m "Fix GitHub Pages configuration"
git push origin main
```

### 2. **รอ GitHub Actions**
- GitHub Actions จะ build และ deploy อัตโนมัติ
- ใช้เวลาประมาณ 2-5 นาที
- ตรวจสอบที่ **Actions** tab

### 3. **ทดสอบ Website**
- ไปที่ `https://phakkhaphong.github.io/`
- ตรวจสอบว่า website แสดงผลถูกต้อง

## ⚠️ ปัญหาที่พบบ่อย

### **ปัญหา: 404 Not Found**
**แก้ไข:**
- ตรวจสอบว่า `baseUrl` ถูกต้อง
- ตรวจสอบว่า GitHub Pages ตั้งค่าเป็น `gh-pages` branch
- รอ 2-5 นาที หลังจาก push code

### **ปัญหา: GitHub Actions ไม่ทำงาน**
**แก้ไข:**
- ตรวจสอบว่า workflow file อยู่ใน `.github/workflows/`
- ตรวจสอบว่า branch ชื่อ `main` (ไม่ใช่ `master`)
- ตรวจสอบว่า GitHub Actions enabled ใน repository settings

### **ปัญหา: Website แสดงแต่ blank page**
**แก้ไข:**
- ตรวจสอบว่า `baseUrl` เป็น `/` (สำหรับ user site)
- ตรวจสอบว่า build สำเร็จใน GitHub Actions
- ลอง clear browser cache

## 📝 Checklist

- [x] แก้ไข `baseUrl` เป็น `/`
- [x] แก้ไข GitHub URLs ทั้งหมด
- [ ] ตั้งค่า GitHub Pages ใน repository settings
- [ ] Push code ไปที่ `main` branch
- [ ] ตรวจสอบ GitHub Actions workflow
- [ ] รอ deployment เสร็จ (2-5 นาที)
- [ ] ทดสอบ website URL

---

**หลังจากแก้ไขเสร็จ Website จะแสดงผลที่ `https://phakkhaphong.github.io/` 🎉**
