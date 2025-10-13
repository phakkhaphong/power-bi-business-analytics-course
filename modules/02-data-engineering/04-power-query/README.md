# บทที่ 4: Power Query Mastery

## 🎯 วัตถุประสงค์การเรียนรู้
เมื่อจบบทนี้ ผู้เรียนจะสามารถ:
- ใช้ Power Query Editor ได้อย่างเชี่ยวชาญ
- เข้าใจ M Language และเขียน M Functions
- สร้าง Advanced Transformations
- จัดการ Error Handling และ Data Quality
- สร้าง Reusable Queries และ Functions

## 📚 เนื้อหาบทเรียน

### 4.1 Power Query Editor Mastery

#### 4.1.1 Advanced Interface Features
- **Formula Bar**: เขียนและแก้ไข M Code
- **Applied Steps**: จัดการ Transformation Steps
- **Query Dependencies**: ดูความสัมพันธ์ของ Queries
- **Query Groups**: จัดกลุ่ม Queries
- **Parameters**: สร้างและใช้ Parameters

#### 4.1.2 Data Preview & Navigation
- **Column Profiling**: วิเคราะห์ข้อมูลในคอลัมน์
- **Data Type Detection**: ตรวจจับ Data Types อัตโนมัติ
- **Error Handling**: จัดการ Errors และ Warnings
- **Data Quality**: ตรวจสอบคุณภาพข้อมูล

#### 4.1.3 Advanced Transformations
- **Custom Columns**: สร้างคอลัมน์แบบ Custom
- **Conditional Logic**: ใช้ IF, SWITCH Statements
- **List Operations**: ทำงานกับ Lists
- **Record Operations**: ทำงานกับ Records
- **Table Operations**: ทำงานกับ Tables

### 4.2 M Language Fundamentals

#### 4.2.1 M Syntax & Structure
```m
// Basic M Function Structure
(parameter1 as type, parameter2 as type) as returnType =>
    let
        // Variable declarations
        variable1 = expression1,
        variable2 = expression2,
        
        // Main logic
        result = finalExpression
    in
        result
```

#### 4.2.2 Data Types
- **Primitive Types**: text, number, datetime, logical
- **Structured Types**: list, record, table
- **Function Types**: function
- **Type Conversion**: การแปลง Data Types

#### 4.2.3 Expressions & Operators
- **Arithmetic Operators**: +, -, *, /, ^
- **Comparison Operators**: =, <>, <, >, <=, >=
- **Logical Operators**: and, or, not
- **Text Operators**: & (concatenation)

### 4.3 Advanced M Functions

#### 4.3.1 Text Functions
```m
// Text manipulation examples
Text.Combine({"Hello", "World"}, " ")  // "Hello World"
Text.Length("Power BI")                // 7
Text.Upper("power bi")                 // "POWER BI"
Text.Split("A,B,C", ",")              // {"A", "B", "C"}
```

#### 4.3.2 Date/Time Functions
```m
// Date/Time manipulation
Date.AddDays(#date(2024, 1, 1), 30)    // Add 30 days
DateTime.LocalNow()                    // Current date/time
Date.Year(#date(2024, 1, 1))          // 2024
Duration.Days(#date(2024, 1, 1) - #date(2023, 1, 1)) // 365
```

#### 4.3.3 List Functions
```m
// List operations
List.Sum({1, 2, 3, 4, 5})             // 15
List.Average({1, 2, 3, 4, 5})         // 3
List.Max({1, 2, 3, 4, 5})             // 5
List.Transform({1, 2, 3}, each _ * 2) // {2, 4, 6}
```

#### 4.3.4 Table Functions
```m
// Table operations
Table.AddColumn(Source, "NewColumn", each [Column1] + [Column2])
Table.SelectRows(Source, each [Value] > 100)
Table.Group(Source, {"Category"}, {{"Sum", each List.Sum([Amount]), type number}})
```

### 4.4 Error Handling & Data Quality

#### 4.4.1 Error Types
- **Syntax Errors**: ข้อผิดพลาดใน M Code
- **Runtime Errors**: ข้อผิดพลาดขณะทำงาน
- **Data Errors**: ข้อผิดพลาดในข้อมูล
- **Connection Errors**: ข้อผิดพลาดในการเชื่อมต่อ

#### 4.4.2 Error Handling Techniques
```m
// Try...otherwise pattern
try [ProblematicColumn] otherwise "Default Value"

// Error handling in custom functions
(optional input as text) as text =>
    let
        result = try 
            Text.Upper(input) 
        otherwise 
            "Invalid Input"
    in
        result
```

#### 4.4.3 Data Quality Checks
- **Null Value Handling**: จัดการ Null Values
- **Duplicate Detection**: ตรวจสอบข้อมูลซ้ำ
- **Data Validation**: ตรวจสอบความถูกต้อง
- **Outlier Detection**: ตรวจจับ Outliers

### 4.5 Reusable Queries & Functions

#### 4.5.1 Custom Functions
```m
// Create reusable function
let
    AddTax = (amount as number, taxRate as number) as number =>
        amount * (1 + taxRate)
in
    AddTax
```

#### 4.5.2 Parameter Queries
- **Create Parameters**: สร้าง Parameters
- **Use Parameters**: ใช้ใน Queries
- **Dynamic Queries**: Queries ที่เปลี่ยนแปลงได้
- **Parameter Management**: จัดการ Parameters

#### 4.5.3 Query Templates
- **Template Structure**: โครงสร้าง Template
- **Reusable Patterns**: รูปแบบที่ใช้ซ้ำได้
- **Best Practices**: แนวทางปฏิบัติที่ดี
- **Documentation**: เอกสารประกอบ

### 4.6 Performance Optimization

#### 4.6.1 Query Performance
- **Folding**: การ Fold Queries ไปยัง Source
- **Query Reduction**: ลดความซับซ้อนของ Query
- **Index Usage**: ใช้ Index อย่างมีประสิทธิภาพ
- **Parallel Processing**: การประมวลผลแบบ Parallel

#### 4.6.2 Memory Management
- **Data Types**: เลือก Data Types ที่เหมาะสม
- **Column Selection**: เลือกคอลัมน์ที่จำเป็น
- **Row Filtering**: กรองแถวที่ไม่จำเป็น
- **Data Compression**: บีบอัดข้อมูล

#### 4.6.3 Caching Strategies
- **Query Caching**: Cache ผลลัพธ์ Query
- **Data Caching**: Cache ข้อมูล
- **Parameter Caching**: Cache Parameters
- **Result Caching**: Cache ผลลัพธ์

## 🛠️ การปฏิบัติ

### Lab 1: M Language Fundamentals
1. **Basic M Functions**
   - เขียน M Functions พื้นฐาน
   - ทดสอบ Data Types
   - ใช้ Operators

2. **Advanced M Functions**
   - Text Functions
   - Date/Time Functions
   - List Functions
   - Table Functions

### Lab 2: Error Handling
1. **Error Detection**
   - ตรวจจับ Errors
   - วิเคราะห์ Error Types
   - ตั้งค่า Error Handling

2. **Data Quality**
   - ตรวจสอบคุณภาพข้อมูล
   - จัดการ Null Values
   - ตรวจจับ Duplicates

### Lab 3: Performance Optimization
1. **Query Optimization**
   - วิเคราะห์ Query Performance
   - ปรับปรุง Query Efficiency
   - ใช้ Folding

2. **Memory Management**
   - ลดการใช้ Memory
   - บีบอัดข้อมูล
   - จัดการ Caching

## 📊 ข้อมูลตัวอย่าง

### M Language Examples
- **Text Processing**: การประมวลผลข้อความ
- **Date Calculations**: การคำนวณวันที่
- **Data Aggregation**: การรวมข้อมูล
- **Conditional Logic**: ตรรกะแบบมีเงื่อนไข

### Performance Scenarios
- **Large Datasets**: ข้อมูลขนาดใหญ่
- **Complex Transformations**: การแปลงที่ซับซ้อน
- **Multiple Data Sources**: หลายแหล่งข้อมูล
- **Real-time Processing**: การประมวลผลแบบ Real-time

## 🎯 แบบฝึกหัด

### Exercise 1: M Language Mastery
**สถานการณ์**: ต้องเขียน M Functions ที่ซับซ้อน

**งาน**:
1. สร้าง Custom Function สำหรับคำนวณ
2. เขียน Error Handling
3. ทดสอบ Performance
4. สร้าง Documentation

### Exercise 2: Data Quality Management
**สถานการณ์**: ข้อมูลมีคุณภาพต่ำ ต้องปรับปรุง

**งาน**:
1. วิเคราะห์ปัญหาในข้อมูล
2. เขียน M Code แก้ไขปัญหา
3. ตั้งค่า Data Validation
4. ทดสอบผลลัพธ์

### Exercise 3: Performance Optimization
**สถานการณ์**: Query ทำงานช้า ต้องเพิ่มประสิทธิภาพ

**งาน**:
1. วิเคราะห์ Performance Bottlenecks
2. ปรับปรุง Query Efficiency
3. ใช้ Advanced Techniques
4. ทดสอบ Performance

## 📝 สรุป

### สิ่งที่เราได้เรียนรู้:
- Power Query Editor ขั้นสูง
- M Language และ Functions
- Error Handling และ Data Quality
- Performance Optimization
- Reusable Queries และ Functions

### สิ่งที่จะเรียนต่อไป:
- Advanced Data Transformation
- Data Modeling Excellence
- Advanced Visualizations

## 🔗 ลิงก์ที่เป็นประโยชน์

- [Power Query M Formula Language](https://docs.microsoft.com/en-us/powerquery-m/)
- [M Language Reference](https://docs.microsoft.com/en-us/powerquery-m/m-syntax)
- [Power Query Best Practices](https://docs.microsoft.com/en-us/power-query/best-practices)
- [M Function Reference](https://docs.microsoft.com/en-us/powerquery-m/function-reference)

## 📞 คำถามที่พบบ่อย

**Q: M Language ยากไหม?**
A: เริ่มต้นไม่ยาก แต่ต้องฝึกฝนเพื่อเชี่ยวชาญ

**Q: ควรเขียน M Code หรือใช้ UI?**
A: ใช้ UI สำหรับงานพื้นฐาน เขียน M Code สำหรับงานซับซ้อน

**Q: Performance Optimization สำคัญไหม?**
A: สำคัญมากสำหรับข้อมูลขนาดใหญ่และ Query ที่ซับซ้อน

---

**หมายเหตุ**: Power Query Mastery เป็นพื้นฐานสำคัญสำหรับการจัดการข้อมูลใน Power BI
