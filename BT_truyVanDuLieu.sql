create database QuanLySinhVien;
use QuanLySinhVien;


create table  class
(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);
create table students
(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

CREATE TABLE Subject
(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

CREATE TABLE Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Students (StudentId)
);

INSERT INTO class
VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO class
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO class
VALUES (3, 'B3', current_date, 0);

INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);

INSERT INTO students (StudentName, Address, Phone, Status, ClassId)
VALUES ('b', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO students (StudentName, Address, Status, ClassId)
VALUES ('a', 'Hai phong', 1, 1);
INSERT INTO students (StudentName, Address, Phone, Status, ClassId)
VALUES ('c', 'HCM', '0123123123', 0, 2);

INSERT INTO Mark (SubId, StudentId, Mark,ExamTimes)
VALUES (1, 1, 8, 1),
       (2, 2, 10, 2),
       (2, 1, 10, 1);

SELECT *
FROM students;

SELECT *
FROM Students
WHERE Status = true;

SELECT *
FROM Subject
WHERE Credit < 10;

SELECT S.StudentId, S.StudentName, C.ClassName
FROM Students S join Class C on S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';

SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Students S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId

SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Students S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';
# hiên thi tên sinh vien bat dau bang ky tu h
select s.StudentName
from students s where StudentName like 'h%';
# Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12
select month(c.StartDate) AS months,
    c.ClassName, c.StartDate
from students s,class c
group by c.ClassName, c.StartDate
having months=12;
# Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select sub.Credit,sub.SubName
FROM subject sub
where Credit>=3 and Credit<=5;
# Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2
UPDATE students SET ClassId = 2 WHERE StudentName = 'Hung';
# Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select StudentName,SubName,Mark from students s join Mark M on s.StudentId = M.StudentId join Subject S2 on S2.SubId = M.SubId
order by Mark desc;
