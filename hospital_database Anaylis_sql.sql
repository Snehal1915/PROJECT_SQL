#"Mining a Hospital Database using SQL: Turning Data into Actionable Insights"

create database hospital;
#Creating required tables
use hospital;

CREATE TABLE Physician (
  employeeid INT PRIMARY KEY, 
  name VARCHAR(100) NOT NULL,  
  position VARCHAR(100) NOT NULL,
  ssn CHAR(11) UNIQUE NOT NULL
);

INSERT INTO Physician VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO Physician VALUES(2,'Elliot Reid','Attending Physician',222222222);
INSERT INTO Physician VALUES(3,'Christopher Turk','Surgical Attending Physician',333333333);
INSERT INTO Physician VALUES(4,'Percival Cox','Senior Attending Physician',444444444);
INSERT INTO Physician VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO Physician VALUES(6,'Todd Quinlan','Surgical Attending Physician',666666666);
INSERT INTO Physician VALUES(7,'John Wen','Surgical Attending Physician',777777777);
INSERT INTO Physician VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO Physician VALUES(9,'Molly Clock','Attending Psychiatrist',999999999);
select * from Physician;

CREATE TABLE Department (
  departmentid INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  head INT NOT NULL,
  FOREIGN KEY (head) REFERENCES Physician(employeeid)
);

INSERT INTO Department VALUES(1,'General Medicine',4);
INSERT INTO Department VALUES(2,'Surgery',7);
INSERT INTO Department VALUES(3,'Psychiatry',9);

CREATE TABLE affiliated_with (
  physician INT NOT NULL,
  department INT NOT NULL,
  primaryaffiliation BIT NOT NULL,
  PRIMARY KEY (physician, department),
  FOREIGN KEY (physician) REFERENCES Physician(employeeid),
  FOREIGN KEY (department) REFERENCES Department(departmentid)
);


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

CREATE TABLE procedures (
  code VARCHAR(20) PRIMARY KEY,
  name VARCHAR(100) NOT NULL, 
  cost DECIMAL(10,2) NOT NULL
);


INSERT INTO Procedures VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO Procedures VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO Procedures VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO Procedures VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Procedures VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO Procedures VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO Procedures VALUES(7,'Follicular Demiectomy',25.0);


CREATE TABLE Trained_In (
  Physician INTEGER NOT NULL,
  Treatment INTEGER NOT NULL,
  CertificationDate DATETIME NOT NULL,
  CertificationExpires DATETIME NOT NULL,
  CONSTRAINT fk_Physician_EmployeeID FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID),
  CONSTRAINT fk_Procedure_Code FOREIGN KEY (Treatment) REFERENCES Procedures(Code),
  PRIMARY KEY (Physician, Treatment)
);


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


CREATE TABLE patient (
  ssn CHAR(11) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  address VARCHAR(255) NOT NULL, 
  phone VARCHAR(20),
  insuranceid INT NOT NULL,
  pcp INT,
  FOREIGN KEY (pcp) REFERENCES physician(employeeid) 
);

INSERT INTO Patient VALUES(100000001,'rohan kumbar','42 Foobar Lane','555-7256',686776213,1);
INSERT INTO Patient VALUES(100000002,'sima sing','37 Snafu Drive','555-0572',366786321,2);
INSERT INTO Patient VALUES(100000003,'kiran J. patil','101 Omgbbq Street','555-1204',68465421,2);
INSERT INTO Patient VALUES(100000004,'tina sing','1100 Foobaz Avenue','575-2048',68451879,3);

  select * from patient;
  
CREATE TABLE nurse (
  employeeid INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  position VARCHAR(100) NOT NULL,
  registered BIT NOT NULL,
  ssn CHAR(11) UNIQUE NOT NULL
);

INSERT INTO nurse (employeeid, name, position, registered, ssn)
VALUES
  (101, 'Nurse Smith', 'Registered Nurse', 1, '111-22-3333'),
  (102, 'Nurse Johnson', 'Licensed Practical Nurse', 0, '222-33-4444'),
  (103, 'Nurse Williams', 'Registered Nurse', 1, '333-44-5555'),
  (104, 'Nurse Davis', 'Registered Nurse', 1, '444-55-6666'),
  (105, 'Nurse Anderson', 'Licensed Practical Nurse', 0, '555-66-7777');
 select * from nurse;
 
CREATE TABLE appointment (
  appointmentid INT PRIMARY KEY,
  patient CHAR(11) NOT NULL,
  prepnurse INT, 
  physician INT NOT NULL,
  start_dt_time DATETIME NOT NULL,
  end_dt_time DATETIME NOT NULL,
  examinationroom VARCHAR(20) NOT NULL,
  FOREIGN KEY (patient) REFERENCES patient(ssn),
  FOREIGN KEY (prepnurse) REFERENCES nurse(employeeid), 
  FOREIGN KEY (physician) REFERENCES physician(employeeid)
);

INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');
 
CREATE TABLE medication (
  code VARCHAR(20) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  brand VARCHAR(100) NOT NULL,
  description TEXT 
);

INSERT INTO medication (code, name, brand, description)
VALUES
  ('M001', 'Aspirin', 'Bayer', 'Pain reliever and anti-inflammatory'),
  ('M002', 'Amoxicillin', 'Generic', 'Antibiotic used to treat bacterial infections'),
  ('M003', 'Lisinopril', 'Prinivil', 'Used to treat high blood pressure'),
  ('M004', 'Simvastatin', 'Zocor', 'Lipid-lowering medication for cholesterol'),
  ('M005', 'Levothyroxine', 'Synthroid', 'Thyroid hormone replacement');
select * from medication;

CREATE TABLE prescribes (
  physician INT NOT NULL,
  patient CHAR(11) NOT NULL,
  medication VARCHAR(20) NOT NULL,
  date DATETIME NOT NULL,
  appointment INT,
  dose VARCHAR(100) NOT NULL,
  PRIMARY KEY (physician, patient, medication, date), 
  FOREIGN KEY (physician) REFERENCES physician (employeeid),
  FOREIGN KEY (patient) REFERENCES patient (ssn),
  FOREIGN KEY (medication) REFERENCES medication (code),
  FOREIGN KEY (appointment) REFERENCES appointment(appointmentid)
);


INSERT INTO prescribes (physician, patient, medication, date, appointment, dose)
VALUES
  (1, 100000001, 'M001', '2024-01-20 09:30:00', 13216584, '1 tablet daily'), 
  (2, 100000002, 'M002', '2024-01-21 11:00:00', 26548913, '500 mg twice daily'),
  (3, 100000003, 'M003', '2024-01-22 13:30:00', 36549879, '10 mg daily'),
  (4, 100000004, 'M004', '2024-01-23 15:00:00', 46846589, '20 mg daily'),
  (5, 100000004, 'M005', '2024-01-24 16:30:00', 59871321, '50 mcg daily');
  

CREATE TABLE block (
  blockfloor INT NOT NULL,
  blockcode INT NOT NULL,
  PRIMARY KEY (blockfloor, blockcode)
);

INSERT INTO block (blockfloor, blockcode)
VALUES
  (1, 101),
  (1, 102),
  (2, 201),
  (2, 202),
  (3, 301);

CREATE TABLE room (
  roomnumber INT PRIMARY KEY,
  roomtype VARCHAR(100) NOT NULL,
  blockfloor INT NOT NULL,
  blockcode INT NOT NULL,  
  unavailable BIT NOT NULL,
  FOREIGN KEY (blockfloor, blockcode) REFERENCES block(blockfloor, blockcode)
);

INSERT INTO room (roomnumber, roomtype, blockfloor, blockcode, unavailable)
VALUES
  (101, 'Single', 1, 101, 0),
  (102, 'Double', 1, 101, 0),
  (201, 'Suite', 2, 201, 1),
  (202, 'Single', 2, 201, 0),
  (301, 'Double', 3, 301, 1);

CREATE TABLE on_call (
  nurse INT NOT NULL,
  blockfloor INT NOT NULL,
  blockcode INT NOT NULL, 
  oncallstart DATETIME NOT NULL,
  oncallend DATETIME NOT NULL,
  PRIMARY KEY (nurse, blockfloor, blockcode, oncallstart, oncallend),
  FOREIGN KEY (nurse) REFERENCES nurse(employeeid),
  FOREIGN KEY (blockfloor, blockcode) REFERENCES block(blockfloor, blockcode)
);

INSERT INTO on_call (nurse, blockfloor, blockcode, oncallstart, oncallend)
VALUES
  (101, 1, 101, '2024-01-20 08:00:00', '2024-01-20 16:00:00'),
  (102, 1, 102, '2024-01-21 09:00:00', '2024-01-21 17:00:00'),
  (103, 2, 201, '2024-01-22 10:00:00', '2024-01-22 18:00:00'),
  (104, 2, 202, '2024-01-23 11:00:00', '2024-01-23 19:00:00'),
  (105, 3, 301, '2024-01-24 12:00:00', '2024-01-24 20:00:00');

CREATE TABLE stay (
  stayid INT PRIMARY KEY,
  patient CHAR(11) NOT NULL,
  room INT NOT NULL,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  FOREIGN KEY (patient) REFERENCES patient(ssn),
  FOREIGN KEY (room) REFERENCES room(roomnumber)  
);

INSERT INTO stay (stayid, patient, room, start_time, end_time) VALUES
  (1, 100000001, 101, '2024-01-20 14:00:00', '2024-01-21 10:00:00'),
  (2, 100000002, 102, '2024-01-21 15:30:00', '2024-01-22 11:30:00'),
  (3, 100000003, 201, '2024-01-22 08:45:00', '2024-01-24 12:30:00');


CREATE TABLE Undergoes (
  Patient CHAR(11) NOT NULL,
  FOREIGN KEY (Patient) REFERENCES Patient(SSN),

  ProcedureCode INT NOT NULL,
  FOREIGN KEY (ProcedureCode) REFERENCES Procedures(Code)
);

INSERT INTO Undergoes (Patient, ProcedureCode)
VALUES
  ('100000001', 1),
  ('100000002', 2),
  ('100000003', 3),
  ('100000004', 4);
  
  
  #Following are the Questions:-
  
  
 # 1) Write a query in SQL to find all the information of the nurses who are yet to be registered. 
 
 Select name, position from nurse where registered = 0;

#2) Write a query in SQL to find the name of the nurse who are the head of their department.

Select name from nurse where position = 'Head Nurse';

#3) Write a query in SQL to obtain the name of the physicians who are the head of each department.

Select p.name from physician p inner join department d on p.employeeid = d.head;

#4)Write a query in SQL to count the number of patients who taken appointment with at least one physician.

Select count(distinct patient) from appointment;

#5)Write a query in SQL to find the floor and block where the room number 212 belongs to.

Select blockfloor, blockcode 
from block b inner join room r on b.blockfloor = r.blockfloor and b.blockcode = r.blockcode
 where roomnumber = 212;

#6)Write a query in SQL to count the number available rooms

Select count(*) from room where unavailable = 0;

#7)Write a query in SQL to count the number of unavailable rooms.

Select count(*) from room where unavailable = 1;

#8)Write a query in SQL to obtain the name of the physician and the departments they are affiliated with. 

Select p.name, d.name from physician p inner join affiliated_with a
 on p.employeeid = a.physician inner join department d 
 on a.department = d.departmentid;

#9)Write a query in SQL to obtain the name of the physicians who are trained for a special treatement.

Select p.name 
from physician p 
inner join trained_in t 
on p.employeeid = t.physician;

#10)Write a query in SQL to obtain the name of the physicians with department who are yet to be affiliated.

Select p.name, d.name from physician p 
left join affiliated_with a on p.employeeid = a.physician
left join department d on a.department = d.departmentid 
 where a.physician is null;

#11)Write a query in SQL to obtain the name of the physicians who are not a specialized physician.

Select p.name from physician p
 where p.employeeid not in (select physician 
 from trained_in);

#12)Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement. 

Select p.name, pt.name 
from patient pt inner join physician p 
on pt.pcp = p.employeeid;

#13)Write a query in SQL to find the name of the patients and the number of physicians they have taken appointment.

Select pt.name, count(distinct a.physician)
 from patient pt inner join appointment a 
 on pt.ssn = a.patient group by pt.name;

#14)Write a query in SQL to count number of unique patients who got an appointment for examination room C. 

Select count(distinct patient) from appointment where examinationroom = 'C';

#15)Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment. 

Select pt.name, r.roomnumber 
from patient pt inner join stay s 
on pt.ssn = s.patient inner join room r
 on s.room = r.roomnumber;

#16)Write a query in SQL to find the name of the nurses and the room scheduled, where they will assist the physicians.

Select n.name, a.examinationroom 
from nurse n inner join appointment a 
on n.employeeid = a.prepnurse;

#17)Write a query in SQL to find the name of the patients who taken the appointment on the 25th of April at 10 am, and also display their physician, assisting nurses and room no.

Select pt.name, p.name, n.name, a.examinationroom 
from patient pt inner join appointment a on pt.ssn = a.patient 
inner join physician p on a.physician = p.employeeid 
left join nurse n on a.prepnurse = n.employeeid 
where a.start_dt_time = '2008-04-25 10:00';

#18)Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse.

Select pt.name, p.name 
from appointment a inner join patient pt
 on a.patient = pt.ssn inner join physician p 
 on a.physician = p.employeeid 
 where a.prepnurse is null;

#19)Write a query in SQL to find the name of the patients, their treating physicians and medication

Select pt.name, p.name, m.name 
from patient pt inner join prescribes pre
 on pt.ssn = pre.patient inner join physician p 
 on pre.physician = p.employeeid inner join medication m 
 on pre.medication = m.code;

#20)Write a query in SQL to find the name of the patients who taken an advanced appointment, and also display their physicians and medication.

Select pt.name, p.name, m.name 
from patient pt inner join prescribes pre 
on pt.ssn = pre.patient inner join physician p 
on pre.physician = p.employeeid inner join medication m 
on pre.medication = m.code where pre.appointment is not null;

#21)Write a query in SQL to find the name and medication for those patients who did not take any appointment.

Select pt.name, m.name 
from patient pt inner join prescribes pre 
on pt.ssn = pre.patient inner join medication m 
on pre.medication = m.code left join appointment a
on pre.appointment = a.appointmentid 
where a.appointmentid is null;

#22)Write a query in SQL to count the number of available rooms in each block.  

Select b.blockcode, count(r.roomnumber) 
from block b left join room r on b.blockfloor = r.blockfloor 
and b.blockcode = r.blockcode 
where r.unavailable = 0 group by b.blockcode;

#23)Write a query in SQL to count the number of available rooms in each floor.

Select blockfloor, count(r.roomnumber) 
from room r where r.unavailable = 0 group by blockfloor;

#24)Write a query in SQL to count the number of available rooms for each block in each floor. 

Select b.blockfloor, b.blockcode, count(r.roomnumber) 
from block b left join room r on b.blockfloor = r.blockfloor
 and b.blockcode = r.blockcode 
 where r.unavailable = 0 group by b.blockfloor, b.blockcode;


#25)Write a query in SQL to count the number of unavailable rooms for each block in each floor. 

Select b.blockfloor, b.blockcode, count(r.roomnumber) 
from block b left join room r on b.blockfloor = r.blockfloor 
and b.blockcode = r.blockcode 
where r.unavailable = 1 group by b.blockfloor, b.blockcode;

#26)Write a query in SQL to find out the floor where the maximum no of rooms are available. 

Select blockfloor, count(roomnumber) as available_rooms 
from room where unavailable = 0 group by blockfloor 
order by available_rooms desc limit 1;

#27)Write a query in SQL to find out the floor where the minimum no of rooms are available

Select blockfloor, count(roomnumber) as available_rooms 
from room where unavailable = 0 group by blockfloor
 order by available_rooms asc limit 1;

#28)Write a query in SQL to obtain the name of the patients, their block, floor, and room number where they are admitted. 

Select pt.name, s.blockfloor, s.blockcode, s.room 
from patient pt inner join stay s on pt.ssn = s.patient;

#29)Write a query in SQL to obtain the nurses and the block where they are booked for attending the patients on call.

Select n.name, o.blockfloor, o.blockcode 
from nurse n inner join on_call o on n.employeeid = o.nurse;

#30)Write a query in SQL to make a report which will show -
#a) name of the patient,
#b) name of the physician who is treating him or her,
#c) name of the nurse who is attending him or her,
#d) which treatement is going on to the patient,
#e) the date of release,
#f) in which room the patient has admitted and which floor and block the room belongs to respectively.  

Select pt.name, p.name as physician, n.name as nurse, t.name as treatment, s.end_time 
as release_date, r.roomnumber, r.blockfloor, r.blockcode 
from patient pt inner join appointment a on pt.ssn = a.patient 
inner join physician p on a.physician = p.employeeid left join nurse n on a.prepnurse = n.employeeid 
left join stay s on pt.ssn = s.patient left join room r on s.room = r.roomnumber left join procedures t
on t.code in (select procedurecode from undergoes u where u.patient = pt.ssn);

#31) Write a SQL query to obtain the names of all the physicians performed a medical procedure but they are not ceritifed to perform. 

Select p.name from physician p inner join undergoes u 
on p.employeeid = u.physician inner join procedures pr 
on u.procedurecode = pr.code where p.employeeid not in (select physician 
from trained_in where treatment = pr.code);


#32)Write a query in SQL to obtain the names of all the physicians, their procedure, date when the procedure was carried out and name of the patient on which procedure have been carried out but those physicians are not cetified for that procedure.

Select p.name, pr.name, u.date, pt.name from 
physician p inner join undergoes u on p.employeeid = u.physician 
inner join procedures pr on u.procedurecode = pr.code inner join patient pt 
on u.patient = pt.ssn where p.employeeid not in (select physician
 from trained_in where treatment = pr.code);

#33) Write a query in SQL to obtain the name and position of all physicians who completed a medical procedure with certification after the date of expiration of their certificate. 

Select p.name, p.position from physician p 
inner join undergoes u on p.employeeid = u.physician 
inner join procedures pr on u.procedurecode = pr.code inner join trained_in t 
on p.employeeid = t.physician and pr.code = t.treatment 
where u.date > t.certificationexpires;

#34) Write a query in SQL to obtain the name of all those physicians who completed a medical procedure with certification after the date of expiration of their certificate, their position, procedure they have done, date of procedure, name of the patient on which the procedure had been applied and the date when the certification expired.

Select p.name, p.position, pr.name, u.date, pt.name, t.certificationexpires 
from physician p inner join undergoes u on p.employeeid = u.physician 
inner join procedures pr on u.procedurecode = pr.code inner join patient pt
on u.patient = pt.ssn inner join trained_in t on p.employeeid = t.physician and pr.code = t.treatment 
where u.date > t.certificationexpires;

#35) Write a query in SQL to obtain the names of all the nurses who have ever been on call for room 122. 

Select distinct n.name from nurse n 
inner join on_call c on n.employeeid = c.nurse
 where c.blockfloor in (select blockfloor
 from room where roomnumber = 122) and c.blockcode 
 in (select blockcode from room where roomnumber = 122);


#36) Write a query in SQL to Obtain the names of all patients who has been prescribed some medication by his/her physician who has carried out primary care and the name of that physician.  

Select pt.name, p.name from patient pt 
inner join prescribes pre on pt.ssn = pre.patient 
inner join physician p on pt.pcp = p.employeeid 
where pre.physician = p.employeeid;

#37) Write a query in SQL to obtain the names of all patients who has been undergone a procedure costing more than $5,000 and the name of that physician who has carried out primary care.

Select pt.name, p.name from patient pt 
inner join physician p on pt.pcp = p.employeeid 
inner join undergoes u on pt.ssn = u.patient inner join procedures pr 
on u.procedurecode = pr.code where pr.cost > 5000;

#38)Write a query in SQL to Obtain the names of all patients who had at least two appointment where the nurse who prepped the appointment was a registered nurse and the physician who has carried out primary care. 

Select pt.name from patient pt inner join appointment a
 on pt.ssn = a.patient inner join physician p on a.physician = p.employeeid 
 inner join nurse n on a.prepnurse = n.employeeid where p.employeeid = pt.pcp 
 and n.registered = 1 group by pt.name having count(distinct a.prepnurse) >= 2;

#39) Write a query in SQL to Obtain the names of all patients whose primary care is taken by a physician who is not the head of any department and name of that physician along with their primary care physician.

Select pt.name, p.name, pt.pcp from patient pt inner join physician p 
on pt.pcp = p.employeeid where p.employeeid not in (select head from department) 
and pt.pcp != p.employeeid;


  
  