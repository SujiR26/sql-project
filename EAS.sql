create schema EAS;
use EAS;
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    position VARCHAR(100),
    date_of_joining DATE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE AttendanceRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    date DATE NOT NULL,
    clock_in TIME,
    clock_out TIME,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

CREATE TABLE LeaveRequests (
    leave_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    leave_date DATE NOT NULL,
    leave_type VARCHAR(50) NOT NULL,
    leave_status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);
INSERT INTO Departments (department_name) 
VALUES ('Engineering'), ('HR'), ('Sales');
INSERT INTO Employees (name, department_id, position, date_of_joining) 
VALUES 
('Suji', 1, 'Software Engineer', '2023-01-15'),
('Jane Smith', 2, 'HR Manager', '2022-05-10'),
('Alice Johnson', 3, 'Sales Executive', '2023-07-20');
INSERT INTO AttendanceRecords (emp_id, date, clock_in, clock_out) 
VALUES 
(1, '2024-12-20', '09:00:00', '17:00:00'),
(2, '2024-12-20', '08:30:00', '16:30:00');
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
