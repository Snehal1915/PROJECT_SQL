#"Mining a Hospital Database using SQL: Turning Data into Actionable Insights"

create database Hospital1;
use hospital1;

CREATE TABLE Physician (
EmployeeID INTEGER NOT NULL,
Name VARCHAR(30) NOT NULL,
Position VARCHAR(30) NOT NULL,
SSN INTEGER NOT NULL,
CONSTRAINT pk_physician PRIMARY KEY(EmployeeID)
);

CREATE TABLE Department (
DepartmentID INTEGER NOT NULL,
Name VARCHAR(30) NOT NULL,
Head INTEGER NOT NULL,
CONSTRAINT pk_Department PRIMARY KEY(DepartmentID),
CONSTRAINT fk_Department_Physician_EmployeeID FOREIGN KEY(Head) REFERENCES Physician(EmployeeID)
);

CREATE TABLE Affiliated_With (
Physician INTEGER NOT NULL,
Department INTEGER NOT NULL,
PrimaryAffiliation BOOLEAN NOT NULL,
CONSTRAINT fk_Affiliated_With_Physician_EmployeeID FOREIGN KEY(Physician) REFERENCES Physician(EmployeeID),
CONSTRAINT fk_Affiliated_With_Department_DepartmentID FOREIGN KEY(Department) REFERENCES Department(DepartmentID),
PRIMARY KEY(Physician, Department)
);

CREATE TABLE Procedures (
Code INTEGER PRIMARY KEY NOT NULL,
Name VARCHAR(30) NOT NULL,
Cost REAL NOT NULL
);

CREATE TABLE Trained_In (
Physician INTEGER NOT NULL,
Treatment INTEGER NOT NULL,
CertificationDate DATETIME NOT NULL,
CertificationExpires DATETIME NOT NULL,
CONSTRAINT fk_Trained_In_Physician_EmployeeID FOREIGN KEY(Physician) REFERENCES Physician(EmployeeID),
CONSTRAINT fk_Trained_In_Procedures_Code FOREIGN KEY(Treatment) REFERENCES Procedures(Code),
PRIMARY KEY(Physician, Treatment)
);

CREATE TABLE Patient (
SSN INTEGER PRIMARY KEY NOT NULL,
Name VARCHAR(30) NOT NULL,
Address VARCHAR(30) NOT NULL,
Phone VARCHAR(30) NOT NULL,
InsuranceID INTEGER NOT NULL,
PCP INTEGER NOT NULL,
CONSTRAINT fk_Patient_Physician_EmployeeID FOREIGN KEY(PCP) REFERENCES Physician(EmployeeID)
);

CREATE TABLE Nurse (
EmployeeID INTEGER PRIMARY KEY NOT NULL,
Name VARCHAR(30) NOT NULL,
Position VARCHAR(30) NOT NULL,
Registered BOOLEAN NOT NULL,
SSN INTEGER NOT NULL
);

CREATE TABLE Appointment (
AppointmentID INTEGER PRIMARY KEY NOT NULL,
Patient INTEGER NOT NULL,
PrepNurse INTEGER,
Physician INTEGER NOT NULL,
Start DATETIME NOT NULL,
End DATETIME NOT NULL,
ExaminationRoom TEXT NOT NULL,
CONSTRAINT fk_Appointment_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
CONSTRAINT fk_Appointment_Nurse_EmployeeID FOREIGN KEY(PrepNurse) REFERENCES Nurse(EmployeeID),
CONSTRAINT fk_Appointment_Physician_EmployeeID FOREIGN KEY(Physician) REFERENCES Physician(EmployeeID)
);

CREATE TABLE Medication (
Code INTEGER PRIMARY KEY NOT NULL,
Name VARCHAR(30) NOT NULL,
Brand VARCHAR(30) NOT NULL,
Description VARCHAR(30) NOT NULL
);


CREATE TABLE Prescribes (
Physician INTEGER NOT NULL,
Patient INTEGER NOT NULL,
Medication INTEGER NOT NULL,
Date DATETIME NOT NULL,
Appointment INTEGER,
Dose VARCHAR(30) NOT NULL,
PRIMARY KEY(Physician, Patient, Medication, Date),
CONSTRAINT fk_Prescribes_Physician_EmployeeID FOREIGN KEY(Physician) REFERENCES Physician(EmployeeID),
CONSTRAINT fk_Prescribes_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
CONSTRAINT fk_Prescribes_Medication_Code FOREIGN KEY(Medication) REFERENCES Medication(Code),
CONSTRAINT fk_Prescribes_Appointment_AppointmentID FOREIGN KEY(Appointment) REFERENCES Appointment(AppointmentID)
);

CREATE TABLE Block (
BlockFloor INTEGER NOT NULL,
BlockCode INTEGER NOT NULL,
PRIMARY KEY(BlockFloor, BlockCode)
);

CREATE TABLE Room (
RoomNumber INTEGER PRIMARY KEY NOT NULL,
RoomType VARCHAR(30) NOT NULL,
BlockFloor INTEGER NOT NULL,
BlockCode INTEGER NOT NULL,
Unavailable BOOLEAN NOT NULL,
CONSTRAINT fk_Room_Block_PK FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(BlockFloor, BlockCode)
);

CREATE TABLE On_Call (
Nurse INTEGER NOT NULL,
BlockFloor INTEGER NOT NULL,
BlockCode INTEGER NOT NULL,
OnCallStart DATETIME NOT NULL,
OnCallEnd DATETIME NOT NULL,
PRIMARY KEY(Nurse, BlockFloor, BlockCode, OnCallStart, OnCallEnd),
CONSTRAINT fk_OnCall_Nurse_EmployeeID FOREIGN KEY(Nurse) REFERENCES Nurse(EmployeeID),
CONSTRAINT fk_OnCall_Block_Floor FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(BlockFloor, BlockCode)
);

CREATE TABLE Stay (
StayID INTEGER PRIMARY KEY NOT NULL,
Patient INTEGER NOT NULL,
Room INTEGER NOT NULL,
StayStart DATETIME NOT NULL,
StayEnd DATETIME NOT NULL,
CONSTRAINT fk_Stay_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
CONSTRAINT fk_Stay_Room_Number FOREIGN KEY(Room) REFERENCES Room(RoomNumber)
);

CREATE TABLE Undergoes (
Patient INTEGER NOT NULL,
Procedures INTEGER NOT NULL,
Stay INTEGER NOT NULL,
DateUndergoes DATETIME NOT NULL,
Physician INTEGER NOT NULL,
AssistingNurse INTEGER,
PRIMARY KEY(Patient, Procedures, Stay, DateUndergoes),
CONSTRAINT fk_Undergoes_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
CONSTRAINT fk_Undergoes_Procedures_Code FOREIGN KEY(Procedures) REFERENCES Procedures(Code),
CONSTRAINT fk_Undergoes_Stay_StayID FOREIGN KEY(Stay) REFERENCES Stay(StayID),
CONSTRAINT fk_Undergoes_Physician_EmployeeID FOREIGN KEY(Physician) REFERENCES Physician(EmployeeID),
CONSTRAINT fk_Undergoes_Nurse_EmployeeID FOREIGN KEY(AssistingNurse) REFERENCES Nurse(EmployeeID)
);



INSERT INTO Physician VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO Physician VALUES(2,'Elliot Reid','Attending Physician',222222222);
INSERT INTO Physician VALUES(3,'Christopher Turk','Surgical Attending Physician',333333333);
INSERT INTO Physician VALUES(4,'Percival Cox','Senior Attending Physician',444444444);
INSERT INTO Physician VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO Physician VALUES(6,'Todd Quinlan','Surgical Attending Physician',666666666);
INSERT INTO Physician VALUES(7,'John Wen','Surgical Attending Physician',777777777);
INSERT INTO Physician VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO Physician VALUES(9,'Molly Clock','Attending Psychiatrist',109999999);
INSERT INTO Physician VALUES(10,'kolly Clock','Attending Psychiatrist',119999999);
INSERT INTO Physician VALUES(11,'Reddy Clock','Attending Psychiatrist',120000000);

INSERT INTO Department VALUES(1,'General Medicine',4);
INSERT INTO Department VALUES(2,'Surgery',7);
INSERT INTO Department VALUES(3,'Psychiatry',9);

INSERT INTO Affiliated_With VALUES(1,1,1);
INSERT INTO Affiliated_With VALUES(2,1,1);
INSERT INTO Affiliated_With VALUES(3,1,0);
INSERT INTO Affiliated_With VALUES(3,2,1);
INSERT INTO Affiliated_With VALUES(4,1,1);
INSERT INTO Affiliated_With VALUES(5,1,1);
INSERT INTO Affiliated_With VALUES(6,2,1);
INSERT INTO Affiliated_With VALUES(7,1,0);
INSERT INTO Affiliated_With VALUES(7,2,1);
INSERT INTO Affiliated_With VALUES(8,1,1);
INSERT INTO Affiliated_With VALUES(9,3,1);

INSERT INTO Procedures VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO Procedures VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO Procedures VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO Procedures VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Procedures VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO Procedures VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO Procedures VALUES(7,'Follicular Demiectomy',25.0);

INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);
INSERT INTO Patient VALUES(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2);
INSERT INTO Patient VALUES(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2);
INSERT INTO Patient VALUES(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

INSERT INTO Nurse VALUES(101,'Carla Espinosa','Head Nurse',1,111111110);
INSERT INTO Nurse VALUES(102,'Laverne Roberts','Nurse',1,222222220);
INSERT INTO Nurse VALUES(103,'Paul Flowers','Nurse',0,333333330);

INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO Medication VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO Medication VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO Medication VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO Medication VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

INSERT INTO Prescribes VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-27 10:53',86213939,'10');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-30 16:53',NULL,'5');

INSERT INTO Block VALUES(1,1);
INSERT INTO Block VALUES(1,2);
INSERT INTO Block VALUES(1,3);
INSERT INTO Block VALUES(2,1);
INSERT INTO Block VALUES(2,2);
INSERT INTO Block VALUES(2,3);
INSERT INTO Block VALUES(3,1);
INSERT INTO Block VALUES(3,2);
INSERT INTO Block VALUES(3,3);
INSERT INTO Block VALUES(4,1);
INSERT INTO Block VALUES(4,2);
INSERT INTO Block VALUES(4,3);

INSERT INTO Room VALUES(101,'Single',1,1,0);
INSERT INTO Room VALUES(102,'Single',1,1,0);
INSERT INTO Room VALUES(103,'Single',1,1,0);
INSERT INTO Room VALUES(111,'Single',1,2,0);
INSERT INTO Room VALUES(112,'Single',1,2,1);
INSERT INTO Room VALUES(113,'Single',1,2,0);
INSERT INTO Room VALUES(121,'Single',1,3,0);
INSERT INTO Room VALUES(122,'Single',1,3,0);
INSERT INTO Room VALUES(123,'Single',1,3,0);
INSERT INTO Room VALUES(201,'Single',2,1,1);
INSERT INTO Room VALUES(202,'Single',2,1,0);
INSERT INTO Room VALUES(203,'Single',2,1,0);
INSERT INTO Room VALUES(211,'Single',2,2,0);
INSERT INTO Room VALUES(212,'Single',2,2,0);
INSERT INTO Room VALUES(213,'Single',2,2,1);
INSERT INTO Room VALUES(221,'Single',2,3,0);
INSERT INTO Room VALUES(222,'Single',2,3,0);
INSERT INTO Room VALUES(223,'Single',2,3,0);
INSERT INTO Room VALUES(301,'Single',3,1,0);
INSERT INTO Room VALUES(302,'Single',3,1,1);
INSERT INTO Room VALUES(303,'Single',3,1,0);
INSERT INTO Room VALUES(311,'Single',3,2,0);
INSERT INTO Room VALUES(312,'Single',3,2,0);
INSERT INTO Room VALUES(313,'Single',3,2,0);
INSERT INTO Room VALUES(321,'Single',3,3,1);
INSERT INTO Room VALUES(322,'Single',3,3,0);
INSERT INTO Room VALUES(323,'Single',3,3,0);
INSERT INTO Room VALUES(401,'Single',4,1,0);
INSERT INTO Room VALUES(402,'Single',4,1,1);
INSERT INTO Room VALUES(403,'Single',4,1,0);
INSERT INTO Room VALUES(411,'Single',4,2,0);
INSERT INTO Room VALUES(412,'Single',4,2,0);
INSERT INTO Room VALUES(413,'Single',4,2,0);
INSERT INTO Room VALUES(421,'Single',4,3,1);
INSERT INTO Room VALUES(422,'Single',4,3,0);
INSERT INTO Room VALUES(423,'Single',4,3,0);

INSERT INTO On_Call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

INSERT INTO Undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO Undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO Undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO Undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO Undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO Undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);

INSERT INTO Trained_In VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO Trained_In VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,7,'2008-01-01','2008-12-31');


#1. Write a query in SQL to find all the information of the nurses who are yet to be registered. 
SELECT * FROM nurse
WHERE registered='false';

#2. Write a query in SQL to find the name of the nurse who are the head of their department.
SELECT name AS "Name",
POSITION AS "Position"
FROM nurse
WHERE POSITION='Head Nurse';

#3. Write a query in SQL to obtain the name of the physicians who are the head of each department.
SELECT d.name AS "Department",
p.name AS "Physician"
FROM department d,
physician p
WHERE d.head=p.employeeid;

#4. Write a query in SQL to count the number of patients who taken appointment with at least one physician
SELECT count(DISTINCT patient) AS "No. of patients taken at least one appointment"
FROM appointment;

#5. Write a query in SQL to find the floor and block where the room number 212 belongs to
SELECT blockfloor AS "Floor",
blockcode AS "Block"
FROM room
WHERE roomnumber=212;

#6. Write a query in SQL to count the number available rooms
SELECT count(*) "Number of available rooms"
FROM room
WHERE unavailable='false';

#7. Write a query in SQL to count the number of unavailable rooms.
SELECT count(*) "Number of unavailable rooms"
FROM room
WHERE unavailable='true';

#8. Write a query in SQL to obtain the name of the physician and the departments they are affiliated with. 
SELECT p.name AS "Physician",
d.name AS "Department"
FROM physician p,
department d,
affiliated_with a
WHERE p.employeeid=a.physician
AND a.department=d.departmentid;

#9. Write a query in SQL to obtain the name of the physicians who are trained for a special treatement
SELECT p.name AS "Physician",
c.name AS "Treatment"
FROM physician p,
PROCEDURES c,
trained_in t
WHERE t.physician=p.employeeid
AND t.treatment=c.code;

#10. Write a query in SQL to obtain the name of the physicians with department who are yet to be affiliated.
-- SELECTing physician name, position, and department name
SELECT p.name AS "Physician",
p.position,
d.name AS "Department"
-- FROM physician table aliased as p
FROM physician p
-- INNER JOIN with affiliated_with table aliased as a based on physician's employeeid
JOIN affiliated_with a ON a.physician = p.employeeid
-- INNER JOIN with department table aliased as d based on affiliated_with's department
JOIN department d ON a.department = d.departmentid
-- WHERE clause to filter results where primary affiliation is false
WHERE primaryaffiliation = 'false';

#11. Write a query in SQL to obtain the name of the physicians who are not a specialized physician
-- SELECTing physician name and position (Designation)
SELECT p.name AS "Physician",
p.position AS "Designation"
-- FROM physician table aliased as p
FROM physician p
-- LEFT JOIN with trained_in table aliased as t based on physician's employeeid
LEFT JOIN trained_in t ON p.employeeid = t.physician
-- WHERE clause filters results where there is no corresponding treatment in trained_in
WHERE t.treatment IS NULL
-- ORDER BY employeeid
ORDER BY p.employeeid;

#12. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement. 
-- SELECTing patient name, address, and physician name
SELECT t.name AS "Patient",
t.address AS "Address",
p.name AS "Physician"
-- FROM patient table aliased as t
FROM patient t
-- INNER JOIN with physician table aliased as p based on primary care physician's employeeid
JOIN physician p ON t.pcp = p.employeeid;

#13. Write a query in SQL to find the name of the patients and the number of physicians they have taken appointment.
-- SELECTing patient name and count of appointments for each patient
SELECT p.name AS "Patient",
COUNT(t.patient) AS "Appointment for No. of Physicians"
-- FROM appointment table aliased as t
FROM appointment t
-- INNER JOIN with patient table aliased as p based on patient's SSN
JOIN patient p ON t.patient = p.ssn
-- GROUP BY patient name
GROUP BY p.name
-- HAVING clause filters out patients with less than one appointment
HAVING COUNT(t.patient) >= 1;

#14. Write a query in SQL to count number of unique patients who got an appointment for examination room C. 
-- SELECTing the count of distinct patients who got appointments for room C
SELECT COUNT(DISTINCT patient) AS "No. of patients got appointment for room C"
-- FROM appointment table
FROM appointment
-- WHERE clause filters appointments for room C
WHERE examinationroom = 'C';

#15. Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment. 
SELECT p.name AS "Patient",
a.examinationroom AS "Room No.",
a.start AS "Date and Time of appointment"
FROM patient p
JOIN appointment a ON p.ssn = a.patient;

#16. Write a query in SQL to find the name of the nurses and the room scheduled, where they will assist the physicians.
SELECT n.name AS "Name of the Nurse",
a.examinationroom AS "Room No."
FROM nurse n
JOIN appointment a ON a.prepnurse=n.employeeid;

#17. Write a query in SQL to find the name of the patients who taken the appointment on the 25th of April at 10 am, 
#and also display their physician, assisting nurses and room no.
SELECT t.name AS "Name of the patient",
n.name AS "Name of the Nurse assisting the physician",
p.name AS "Name of the physician",
a.examinationroom AS "Room No.",
a.start AS "Appointment Start Time"
FROM patient t
JOIN appointment a ON a.patient = t.ssn
JOIN nurse n ON a.prepnurse = n.employeeid
JOIN physician p ON a.physician = p.employeeid
WHERE a.start = '2008-04-25 10:00:00';

#18. Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse.
SELECT t.name AS "Name of the patient",
p.name AS "Name of the physician",
a.examinationroom AS "Room No."
FROM patient t
JOIN appointment a ON a.patient=t.ssn
JOIN physician p ON a.physician=p.employeeid
WHERE a.prepnurse IS NULL;

#19. Write a query in SQL to find the name of the patients, their treating physicians and medication
SELECT t.name AS "Patient",
p.name AS "Physician",
m.name AS "Medication"
FROM patient t
JOIN prescribes s ON s.patient=t.ssn
JOIN physician p ON s.physician=p.employeeid
JOIN medication m ON s.medication=m.code;

#20. Write a query in SQL to find the name of the patients who taken an advanced appointment, and also display their 
#physicians and medication.
SELECT t.name AS "Patient",
p.name AS "Physician",
m.name AS "Medication"
FROM patient t
JOIN prescribes s ON s.patient=t.ssn
JOIN physician p ON s.physician=p.employeeid
JOIN medication m ON s.medication=m.code
WHERE s.appointment IS NOT NULL;

#21. Write a query in SQL to find the name and medication for those patients who did not take any appointment
SELECT t.name AS "Patient",
p.name AS "Physician",
m.name AS "Medication"
FROM patient t
JOIN prescribes s ON s.patient=t.ssn
JOIN physician p ON s.physician=p.employeeid
JOIN medication m ON s.medication=m.code
WHERE s.appointment IS NULL;

#22. Write a query in SQL to count the number of available rooms in each block.  
SELECT blockcode AS "Block",
count(*) "Number of available rooms"
FROM room
WHERE unavailable='false'
GROUP BY blockcode
ORDER BY blockcode;

#23. Write a query in SQL to count the number of available rooms in each floor.
SELECT blockfloor AS "Floor",
count(*) "Number of available rooms"
FROM room
WHERE unavailable='false'
GROUP BY blockfloor
ORDER BY blockfloor;

#24. Write a query in SQL to count the number of available rooms for each block in each floor. 
SELECT blockfloor AS "Floor",
blockcode AS "Block",
count(*) "Number of available rooms"
FROM room
WHERE unavailable='false'
GROUP BY blockfloor,
blockcode
ORDER BY blockfloor,
blockcode;

#25. Write a query in SQL to count the number of unavailable rooms for each block in each floor
SELECT blockfloor AS "Floor",
blockcode AS "Block",
count(*) "Number of unavailable rooms"
FROM room
WHERE unavailable='true'
GROUP BY blockfloor,
blockcode
ORDER BY blockfloor,
blockcode;

#26. Write a query in SQL to find out the floor where the maximum no of rooms are available. 
SELECT blockfloor AS "Floor",
COUNT(*) AS "Number of available rooms"
FROM room
WHERE unavailable = 0
GROUP BY blockfloor
HAVING COUNT(*) = (
SELECT MAX(zz) AS highest_total
FROM (
SELECT blockfloor, COUNT(*) AS zz
FROM room
WHERE unavailable = 0
GROUP BY blockfloor
) AS t
);

#27. Write a query in SQL to find out the floor where the minimum no of rooms are available
SELECT blockfloor as "Floor",
count(*) AS  "No of available rooms"
FROM room
WHERE unavailable='false'
GROUP BY blockfloor
HAVING count(*) =
(SELECT min(zz) AS highest_total
FROM
( SELECT blockfloor ,
count(*) AS zz
FROM room
WHERE unavailable='false'
GROUP BY blockfloor ) AS t );

#28. Write a query in SQL to obtain the name of the patients, their block, floor, and room number where they are admitted. 
SELECT p.name AS "Patient",
s.room AS "Room",
r.blockfloor AS "Floor",
r.blockcode AS "Block"
FROM stay s
JOIN patient p ON s.patient=p.ssn
JOIN room r ON s.room=r.roomnumber;

#29. Write a query in SQL to obtain the nurses and the block where they are booked for attending the patients on call.
SELECT n.name AS "Nurse",
o.blockcode AS "Block"
FROM nurse n
JOIN on_call o ON o.nurse=n.employeeid;

#30. Write a query in SQL to make a report which will show -
# a) name of the patient,
# b) name of the physician who is treating him or her,
# c) name of the nurse who is attending him or her,
# d) which treatement is going on to the patient,
# e) the date of release,
# f) in which room the patient has admitted and which floor and block the room belongs to respectively.  

SELECT p.name AS "Patient",
y.name AS "Physician",
n.name AS "Nurse",
s.StayEnd AS "Date of release",
pr.name AS "Treatment going on",
r.roomnumber AS "Room",
r.blockfloor AS "Floor",
r.blockcode AS "Block"
FROM undergoes u
JOIN patient p ON u.patient = p.ssn
JOIN physician y ON u.physician = y.employeeid
JOIN nurse n ON u.assistingnurse = n.employeeid
JOIN stay s ON u.patient = s.patient
JOIN room r ON s.room = r.roomnumber
JOIN procedures pr ON u.procedures = pr.code;

#31. Write a SQL query to obtain the names of all the physicians performed a medical procedure but they are not ceritifed to perform. 
SELECT name AS "Physician"
FROM physician
WHERE employeeid IN
(SELECT u.physician
FROM undergoes u
LEFT JOIN trained_in ti ON u.physician = ti.physician
AND u.procedures = ti.treatment
WHERE ti.treatment IS NULL);

#32. Write a query in SQL to obtain the names of all the physicians, their procedure, date when the procedure was carried out 
#and name of the patient on which procedure have been carried out but those physicians are not cetified for that procedure.
SELECT p.name AS "Physician",
pr.name AS "Procedure",
u.DateUndergoes,
pt.name AS "Patient"
FROM undergoes u
JOIN physician p ON u.physician = p.EmployeeID
JOIN patient pt ON u.patient = pt.SSN
JOIN procedures pr ON u.procedures = pr.Code
WHERE NOT EXISTS
(SELECT 1
FROM trained_in t
WHERE t.treatment = u.procedures
AND t.physician = u.physician)
LIMIT 0, 1000;

#33. Write a query in SQL to obtain the name and position of all physicians who completed a medical procedure with 
#certification after the date of expiration of their certificate. 
SELECT name AS "Physician",
position AS "Position"
FROM physician
WHERE employeeid IN
( SELECT physician
FROM undergoes u
WHERE DateUndergoes >
( SELECT certificationexpires
FROM trained_in t
WHERE t.physician = u.physician
AND t.treatment = u.procedures ) );

#34. Write a query in SQL to obtain the name of all those physicians who completed a medical procedure with certification after 
#the date of expiration of their certificate, their position, procedure they have done, date of procedure, 
#name of the patient on which the procedure had been applied and the date when the certification expired.
SELECT p.name AS "Physician",
p.position AS "Position",
pr.name AS "Procedure",
u.DateUndergoes AS "Date of Procedure",
pt.name AS "Patient",
t.certificationexpires AS "Expiry Date of Certificate"
FROM physician p,
undergoes u,
patient pt,
PROCEDURES pr,
trained_in t
WHERE u.patient = pt.ssn
AND u.procedures = pr.code
AND u.physician = p.employeeid
AND Pr.code = t.treatment
AND P.employeeid = t.physician
AND u.DateUndergoes > t.certificationexpires;

#35. Write a query in SQL to obtain the names of all the nurses who have ever been on call for room 122. 
SELECT n.name
FROM nurse n
WHERE employeeid IN
( SELECT oc.nurse
FROM on_call oc,
room r
WHERE oc.blockfloor = r.blockfloor
AND oc.blockcode = r.blockcode
AND r.roomnumber = 122 );

#36. Write a query in SQL to Obtain the names of all patients who has been prescribed some medication 
#by his/her physician who has carried out primary care and the name of that physician.  
SELECT pt.name AS "Ptient",
p.name AS "Physician"
FROM patient pt
JOIN prescribes pr ON pr.patient=pt.ssn
JOIN physician p ON pt.pcp=p.employeeid
WHERE pt.pcp=pr.physician
AND pt.pcp=p.employeeid;

#37. Write a query in SQL to obtain the names of all patients who has been undergone a procedure costing more than $5,000 and 
#the name of that physician who has carried out primary care
SELECT pt.name AS " Patient ",
p.name AS "Primary Physician",
pd.cost AS " Procedure Cost"
FROM patient pt
JOIN undergoes u ON u.patient=pt.ssn
JOIN physician p ON pt.pcp=p.employeeid
JOIN PROCEDURES pd ON u.procedures=pd.code
WHERE pd.cost>5000;

#38. Write a query in SQL to Obtain the names of all patients who had at least two appointment where the nurse who 
#prepped the appointment was a registered nurse and the physician who has carried out primary care. 
SELECT pt.name AS "Patient",
p.name AS "Primary Physician",
n.name AS "Nurse"
FROM appointment a
JOIN patient pt ON a.patient=pt.ssn
JOIN nurse n ON a.prepnurse=n.employeeid
JOIN physician p ON pt.pcp=p.employeeid
WHERE a.patient IN
(SELECT patient
FROM appointment a
GROUP BY a.patient
HAVING count(*)>=2)
AND n.registered='true'
ORDER BY pt.name;

#39. Write a query in SQL to Obtain the names of all patients whose primary care is taken by a physician who is not the head of 
#any department and name of that physician along with their primary care physician.
SELECT pt.name AS "Patient",
p.name AS "Primary care Physician"
FROM patient pt
JOIN physician p ON pt.pcp=p.employeeid
WHERE pt.pcp NOT IN
(SELECT head
FROM department);
