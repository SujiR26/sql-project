---create database
create schema EAS;
use EAS;

-- create table DEPARTMENT 
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

---create table EMPLOYEES
CREATE TABLE Employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    position VARCHAR(100),
    date_of_joining DATE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

---  create table ATTENDANCERECORDS
CREATE TABLE AttendanceRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    date DATE NOT NULL,
    clock_in TIME,
    clock_out TIME,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

---create table LEAVEREQUEST
CREATE TABLE LeaveRequests (
    leave_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    leave_date DATE NOT NULL,
    leave_type VARCHAR(50) NOT NULL,
    leave_status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

---insert values in table(DEAPARTMENT)
INSERT INTO Departments (department_name) 
VALUES ('SW Engineering'), ('HR'), ('Sales'),('IT');

---insert values in table(EMPLOYEES)
INSERT INTO Employees (name, department_id, position, date_of_joining) 
VALUES 
('Suji', 1, 'SW Engineer', '2023-01-15'),
('Jananee', 2, 'HR', '2022-05-10'),
('Aleena', 3, 'Sales', '2023-07-20'),
('Santhiya', 1, 'SW Engineer', '2023-04-06'),
('Lisya', 2, 'HR', '2022-07-15'),
('Kaviya', 4, 'IT', '2023-09-04'),
('Bathma', 2, 'HR', '2022-06-10'),
('Josh', 3, 'Sales', '2023-08-14'),
('Rishetha', 4, 'IT', '2023-03-09');

---insert values in (ATTENDANCERECORDS)
INSERT INTO AttendanceRecords (emp_id, date, clock_in, clock_out) 
VALUES 
(1, '2024-12-20', '09:00:00', '17:00:00'),
(2, '2024-12-20', '08:30:00', '16:30:00'),
(3, '2024-12-20', '09:15:00', '17:30:00'),
(4, '2024-12-20', '08:30:00', '18:00:00'),
(5, '2024-12-20', '08:00:00', '17:30:00'),
(6, '2024-12-20', '09:30:00', '18:30:00'),
(7, '2024-12-20', '08:00:00', '16:15:00'),
(8, '2024-12-20', '09:00:00', '16:30:00'),
(9, '2024-12-20', '09:30:00', '18:30:00');

---insert values in (LEAVEREQUESTS)
INSERT INTO LeaveRequests (emp_id, leave_date, leave_type, leave_status) 
VALUES 
(1, '2024-12-25', 'Vacation', 'Approved'),
(2, '2024-12-26', 'Sick Leave', 'Pending');
SELECT 
    e.name AS Employee_Name,
    d.department_name AS Department,
    ar.date AS Attendance_Date,
    ar.clock_in AS Clock_In_Time,
    ar.clock_out AS Clock_Out_Time,
    TIMESTAMPDIFF(HOUR, ar.clock_in, ar.clock_out) AS Work_Hours
FROM 
    AttendanceRecords ar
JOIN 
    Employees e ON ar.emp_id = e.emp_id
JOIN 
    Departments d ON e.department_id = d.department_id
ORDER BY 
    ar.date DESC;
SELECT 
    e.name AS Employee_Name,
    d.department_name AS Department,
    lr.leave_date AS Leave_Date,
    lr.leave_type AS Leave_Type,
    lr.leave_status AS Status
FROM 
    LeaveRequests lr
JOIN 
    Employees e ON lr.emp_id = e.emp_id
JOIN 
    Departments d ON e.department_id = d.department_id
WHERE 
    lr.leave_status = 'Approved'
ORDER BY 
    lr.leave_date;
SELECT 
    e.name AS Employee_Name,
    d.department_name AS Department,
    ar.date AS Attendance_Date,
    ar.clock_in AS Clock_In,
    ar.clock_out AS Clock_Out
FROM 
    AttendanceRecords ar
JOIN 
    Employees e ON ar.emp_id = e.emp_id
JOIN 
    Departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-12-20';
SELECT 
    e.name AS Employee_Name,
    d.department_name AS Department,
    ar.date AS Attendance_Date,
    ar.clock_in AS Clock_In
FROM 
    AttendanceRecords ar
JOIN 
    Employees e ON ar.emp_id = e.emp_id
JOIN 
    Departments d ON e.department_id = d.department_id
WHERE 
    ar.clock_in > '09:00:00'
ORDER BY 
    ar.clock_in;
SELECT 
    e.name AS Employee_Name,
    lr.leave_date AS Leave_Date,
    lr.leave_type AS Leave_Type,
    lr.leave_status AS Status
FROM 
    LeaveRequests lr
JOIN 
    Employees e ON lr.emp_id = e.emp_id
WHERE 
    lr.leave_status = 'Pending'
ORDER BY 
    lr.leave_date;
