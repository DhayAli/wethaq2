CREATE SCHEMA IF NOT EXISTS Wethaq;


-- التبديل للسكيمة الجديدة
SET search_path TO Wethaq;
-- جدول القضايا (Cases)
CREATE TABLE IF NOT EXISTS Cases (
    CaseID SERIAL PRIMARY KEY,               -- معرف القضية (تلقائي)
    CaseNumber INT NOT NULL UNIQUE,          -- رقم القضية
    DefendantName VARCHAR(100) NOT NULL,    -- اسم المتهم
    Nationality VARCHAR(50) NOT NULL,       -- جنسية المتهم
    NationalID VARCHAR(15) NOT NULL,        -- رقم الهوية الوطنية
    CaseStatus VARCHAR(50) NOT NULL,        -- حالة القضية (مثلاً: "في المحكمة", "صدر الحكم")
    CourtDate DATE,                         -- تاريخ المحاكمة (إذا كانت القضية في المحكمة)
    JudgmentDate DATE,                      -- تاريخ صدور الحكم (إذا صدر الحكم)
    SentenceDuration VARCHAR(50),           -- مدة العقوبة (مثلاً: "2 سنوات و0 أشهر")
    SentenceStartDate DATE,                 -- تاريخ بدء العقوبة
    SentenceEndDate DATE,                   -- تاريخ انتهاء العقوبة
    ArrestDate DATE                         -- تاريخ القبض (للحالات قيد التحقيق)
);

-- جدول الإشعارات (Notification)
CREATE TABLE IF NOT EXISTS Notification (
    NotificationID SERIAL PRIMARY KEY,      -- معرف الإشعار (تلقائي)
    FileID INT NOT NULL,                    -- معرف الملف المرتبط
    StatusChange BOOLEAN NOT NULL          -- تغيير في الحالة
);

-- جدول الملفات (File)
CREATE TABLE IF NOT EXISTS File (
    FileID SERIAL PRIMARY KEY,              -- معرف الملف (تلقائي)
    CaseStatus VARCHAR(30),                 -- حالة القضية (مثل: "قيد التحقيق")
    Center VARCHAR(30),                     -- المركز (مثل: "الشرطة")
    DetaineeStatus VARCHAR(30),             -- حالة الموقوف (مثل: "موقوف")
    NotificationID INT NOT NULL,            -- معرف الإشعار
    CaseID INT NOT NULL,                    -- معرف القضية
    CONSTRAINT File_FK1 FOREIGN KEY (NotificationID) REFERENCES Notification(NotificationID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT File_FK2 FOREIGN KEY (CaseID) REFERENCES Cases(CaseID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- جدول المراكز (Center)
CREATE TABLE IF NOT EXISTS Center (
    CenterID SERIAL PRIMARY KEY,            -- معرف المركز (تلقائي)
    CenterName VARCHAR(30),                 -- اسم المركز
    Location VARCHAR(30),                   -- الموقع
    FileID INT NOT NULL,                    -- معرف الملف المرتبط
    CONSTRAINT Center_FK1 FOREIGN KEY (FileID) REFERENCES File(FileID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- جدول الموقوفين (Detainee)
CREATE TABLE IF NOT EXISTS Detainee (
    DetaineeID SERIAL PRIMARY KEY,          -- معرف الموقوف (تلقائي)
    IDType VARCHAR(20) NOT NULL,            -- نوع الهوية (مثل: "بطاقة بديلة")
    CaseNumber INT NOT NULL,                -- رقم القضية
    FullName VARCHAR(150),                  -- الاسم الكامل
    ArrestDate DATE,                        -- تاريخ القبض
    DateOfBirth DATE,                       -- تاريخ الميلاد
    ArrestingAuthority VARCHAR(60),         -- جهة القبض
    DetentionAuthority VARCHAR(60),         -- جهة التوقيف
    Address VARCHAR(255),                   -- العنوان
    Status VARCHAR(10),                     -- الحالة (مثل: "موقوف")
    PlaceOfArrest VARCHAR(60),              -- مكان القبض
    Nationality VARCHAR(30),                -- الجنسية
    MobileNumber VARCHAR(15),               -- رقم الجوال
    Charge VARCHAR(100),                    -- التهمة
    CenterID INT NOT NULL,                  -- معرف المركز
    FileID INT NOT NULL,                    -- معرف الملف
    CaseID INT NOT NULL,                    -- معرف القضية
    CONSTRAINT Detainee_FK1 FOREIGN KEY (CenterID) REFERENCES Center(CenterID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT Detainee_FK2 FOREIGN KEY (FileID) REFERENCES File(FileID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT Detainee_FK3 FOREIGN KEY (CaseID) REFERENCES Cases(CaseID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- جدول مدير السجن (PrisonDirector)
CREATE TABLE IF NOT EXISTS PrisonDirector (
    DirectorID SERIAL PRIMARY KEY,          -- معرف المدير (تلقائي)
    Password VARCHAR(255),                  -- كلمة المرور
    DirectorName VARCHAR(40),               -- اسم المدير
    Branch VARCHAR(60),                     -- الفرع
    FileID INT NOT NULL,                    -- معرف الملف المرتبط
    CONSTRAINT PrisonDirector_FK FOREIGN KEY (FileID) REFERENCES File(FileID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- جدول الإرسال (PrisonTransfers)
CREATE TABLE IF NOT EXISTS PrisonTransfers (
    TransferID SERIAL PRIMARY KEY,          -- معرف النقل (تلقائي)
    CaseNumber INT NOT NULL,                -- رقم القضية المرتبطة بالنقل
    TransferDate DATE NOT NULL,             -- تاريخ النقل إلى السجن
    CONSTRAINT PrisonTransfers_FK FOREIGN KEY (CaseNumber) REFERENCES Cases(CaseNumber)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- جدول الإفراجات (Releases)
CREATE TABLE IF NOT EXISTS Releases (
    ReleaseID SERIAL PRIMARY KEY,           -- معرف الإفراج (تلقائي)
    CaseNumber INT NOT NULL,                -- رقم القضية المرتبطة بالإفراج
    ReleaseDate DATE NOT NULL,              -- تاريخ الإفراج
    CONSTRAINT Releases_FK FOREIGN KEY (CaseNumber) REFERENCES Cases(CaseNumber)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- جدول المراقب (Observer)
CREATE TABLE IF NOT EXISTS Observer (
    ObserverID SERIAL PRIMARY KEY,          -- معرف المراقب (تلقائي)
    ObserverName VARCHAR(60),               -- اسم المراقب
    Password VARCHAR(255),                  -- كلمة المرور
    FileID INT NOT NULL,                    -- معرف الملف المرتبط
    CONSTRAINT Observer_FK1 FOREIGN KEY (FileID) REFERENCES File(FileID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);