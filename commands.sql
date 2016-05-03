/*
Hospital Plan for test data
Locations are divided between a north wing, south wing, west wing, and so forth.
12 Floors, 10 rooms a floor, 2 beds a room
Example for identifying numbers: 12101 ---> Floor 12, 10th room, bed or office 1
Person IDs can be randomly generated or seqential (1,2,3...)
*/
CREATE TABLE PersonInHospital (
	personID INT,
	FirstName VARCHAR(40),
	LastName VARCHAR(40),
	DateOfBirth DATE,
	ContactNumber VARCHAR(12),
	CONSTRAINT pk_personID PRIMARY KEY (personID)
);

CREATE TABLE Employee (
	personID INT, 
	HireDate DATE,
	CONSTRAINT pk_employeeID PRIMARY KEY (personID),
	CONSTRAINT fk_employeeID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID)
);

CREATE TABLE Physician (
	personID INT,
	Specialty VARCHAR(40),
	Pager VARCHAR(10),
	CONSTRAINT pk_physicianID PRIMARY KEY (personID),
	CONSTRAINT fk_physicianID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID)
);

CREATE TABLE Patient (
	personID INT,
	physID INT,
	ContactDate DATE,
	EmergencyContact VARCHAR(12),
	CONSTRAINT pk_patientID PRIMARY KEY (personID),
	CONSTRAINT fk_patientID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID),
	CONSTRAINT fk_drID FOREIGN KEY (physID)
	REFERENCES Physician(personID)
);

CREATE TABLE Volunteer (
	personID INT,
	Skill VARCHAR(40),
	CONSTRAINT pk_volunteerID PRIMARY KEY (personID),
	CONSTRAINT fk_volunteerID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID)
);

CREATE TABLE Staff (
	personID INT,
	JobClass VARCHAR(40),
	CONSTRAINT pk_staffID PRIMARY KEY (personID),
	CONSTRAINT fk_staffID FOREIGN KEY (personID)
	REFERENCES Employee (personID)
);

CREATE TABLE Technician (
	personID INT,
	Skill VARCHAR(40),
	CONSTRAINT pk_technicianID PRIMARY KEY (personID),
	CONSTRAINT fk_technicianID FOREIGN KEY (personID)
	REFERENCES Employee (personID)
);

CREATE TABLE Laboratory ( 
	Name VARCHAR(40),
	LabLoc VARCHAR(40),
	CONSTRAINT pk_LabName PRIMARY KEY (Name)
);

CREATE TABLE TechnicianLab (
	Name VARCHAR(40),
	personID INT,
	CONSTRAINT fk_LabName FOREIGN KEY (Name)
	REFERENCES Laboratory(Name),
	CONSTRAINT fk_Technician FOREIGN KEY (personID)
	REFERENCES Technician(personID),
	CONSTRAINT pk_techlab PRIMARY KEY (Name, personID)
);

CREATE TABLE Resident (
	personID INT,
	AdmittedDate DATE,
	Status VARCHAR(40),
	CONSTRAINT pk_residentID PRIMARY KEY (personID),
	CONSTRAINT fk_residentID FOREIGN KEY (personID)
	REFERENCES Patient (personID)
);

CREATE TABLE Outpatient (
	personID INT,
	CONSTRAINT pk_outpatientID PRIMARY KEY (personID),
	CONSTRAINT fk_outpatientID FOREIGN KEY (personID)
	REFERENCES Patient (personID)
);

CREATE TABLE Visit (
	personID INT,
	physID INT,
	VisitDate DATE,
	Comment VARCHAR(40),
	CONSTRAINT fk_visitorID FOREIGN KEY (personID)
	REFERENCES Outpatient (personID),
	CONSTRAINT fk_physID FOREIGN KEY (personID)
	REFERENCES Physician(personID),
	CONSTRAINT pk_visit PRIMARY KEY (personID, physID, VisitDate)
);

#Cannot execute command

CREATE TABLE CareCenter ( #actual
	Name VARCHAR(40),
	Location VARCHAR(40),
	CONSTRAINT pk_CCName PRIMARY KEY (Name)
);
/*
CREATE TABLE CareCenter (
	Name VARCHAR(40),
	Location VARCHAR(40)
	pk_CCName PRIMARY KEY (Name),
	fk_NurseInCharge FOREIGN KEY (personID)
	REFERENCES RegisteredNurse (personID)
); */

CREATE TABLE Nurse (
    Name VARCHAR(40),
	personID INT,
	Certificate VARCHAR(40),
	CONSTRAINT pk_nurseID PRIMARY KEY (personID),
	CONSTRAINT fk_nurseID FOREIGN KEY (personID)
	REFERENCES Employee (personID),
	CONSTRAINT fk_CCName FOREIGN KEY (Name)
	REFERENCES CareCenter (Name)
);

CREATE TABLE RegisteredNurse (
         personID INT,
         Name VARCHAR(40),
	 CONSTRAINT pk_rnID PRIMARY KEY (personID),	
	 CONSTRAINT fk_rnID FOREIGN KEY (personID)
         REFERENCES PersonInHospital (personID),
	 CONSTRAINT fk_RNCCName FOREIGN KEY (Name)
         REFERENCES CareCenter (Name)
);

ALTER TABLE CareCenter
ADD personID INT;

ALTER TABLE CareCenter
ADD CONSTRAINT fk_NurseInCharge FOREIGN KEY (personID)
REFERENCES RegisteredNurse(personID);

CREATE TABLE Room (
	Name VARCHAR(40),
	RoomNum INT,
	Floor INT,
	CONSTRAINT pk_roomNum PRIMARY KEY (RoomNum),
	CONSTRAINT fk_RName FOREIGN KEY (Name)
	REFERENCES CareCenter(Name)
);


CREATE TABLE Bed (
	personID INT,
	BedNum INT,
    RoomNum INT,
	CONSTRAINT pk_BedRoom PRIMARY KEY (BedNum, RoomNum),
	CONSTRAINT fk_roomNum FOREIGN KEY (RoomNum)
	REFERENCES Room (RoomNum),
	CONSTRAINT fk_rID FOREIGN KEY (personID)
	REFERENCES Resident(personID)
);

#EDIT 05_02, new business rules
ALTER TABLE CareCenter
ADD beginVisitHours TIME;

ALTER TABLE CareCenter
ADD endVisitHours TIME;

ALTER TABLE Laboratory
ADD beginBusinessHours TIME;

ALTER TABLE Laboratory
ADD endBusinessHours TIME;

ALTER TABLE Physician
    MODIFY Pager VARCHAR(12);

# Poulate the PersonInHospital

INSERT INTO PersonInHospital
VALUES (100, 'Jose', 'Kay', '1962-02-01', '424-435-4806');
 
INSERT INTO PersonInHospital
VALUES (101, 'Edward', 'Daley', '1976-04-06', '424-795-1878');
 
INSERT INTO PersonInHospital
VALUES (102, 'Robert', 'Holland', '1968-08-19', '424-468-3353');
 
INSERT INTO PersonInHospital
VALUES (103, 'Frank', 'Thayer', '1975-03-18', '310-351-3087');
 
INSERT INTO PersonInHospital
VALUES (104, 'Linda', 'Gomer', '1968-08-19', '310-351-3087');
 
INSERT INTO PersonInHospital
VALUES (200, 'Patricia', 'Hamley', '1993-03-11', '310-965-6337');
 
INSERT INTO PersonInHospital
VALUES (201, 'Charles', 'York', '1989-01-10', '424-808-6698');
 
INSERT INTO PersonInHospital
VALUES (202, 'Sandra', 'Holland', '1981-02-13', '424-918-4509');
 
INSERT INTO PersonInHospital
VALUES (203, 'Donna', 'Garber', '1984-12-29', '310-692-7304');
 
INSERT INTO PersonInHospital
VALUES (204, 'Kenneth', 'Pickens', '1991-03-30', '310-707-8829');
 
INSERT INTO PersonInHospital
VALUES (205, 'Maria', 'McGuire', '1991-09-17', '424-918-4509');
 
INSERT INTO PersonInHospital
VALUES (206, 'Mary', 'Hamley', '1879-05-06', '424-468-3353');
 
INSERT INTO PersonInHospital
VALUES (207, 'Edward', 'Davis', '1975-05-06', '424-313-5985');
 
INSERT INTO PersonInHospital
VALUES (208, 'William', 'McCreary', '1988-12-28', '310-358-5513');
 
INSERT INTO PersonInHospital
VALUES (209, 'Frank', 'Tredway', '1990-02-01', '310-707-8829');
 
INSERT INTO PersonInHospital
VALUES (210, 'Gary', 'Thayer', '1990-03-11', '424-711-8008');
 
INSERT INTO PersonInHospital
VALUES (211, 'Betty', 'Shapiro', '1981-05-10', '424-485-5828');
 
INSERT INTO PersonInHospital
VALUES (212, 'Susan', 'Daley', '1982-09-23', '424-763-3802');
 
INSERT INTO PersonInHospital
VALUES (213, 'Daniel', 'Brighton', '1980-03-06', '310-707-8829');
 
INSERT INTO PersonInHospital
VALUES (214, 'Thomas', 'York', '1984-06-26', '310-351-3087');
 
INSERT INTO PersonInHospital
VALUES (300, 'Linda', 'Hyde', '1980-09-17', '424-796-7133');
 
INSERT INTO PersonInHospital
VALUES (301, 'Karen', 'LeRoy', '1978-05-02', '424-406-9557');
 
INSERT INTO PersonInHospital
VALUES (302, 'Donna', 'Kaufman', '1978-01-25', '424-795-1878');
 
INSERT INTO PersonInHospital
VALUES (303, 'George', 'Ketchum', '1981-04-06', '424-918-4509');
 
INSERT INTO PersonInHospital
VALUES (304, 'Linda', 'Hamley', '1990-02-13', '310-515-7824');
 
INSERT INTO PersonInHospital
VALUES (400, 'Paul', 'LeRoy', '1969-08-02', '424-711-8008');
 
INSERT INTO PersonInHospital
VALUES (401, 'Mary', 'Davis', '1956-05-06', '310-692-7304');
 
INSERT INTO PersonInHospital
VALUES (402, 'Helen', 'Gomer', '1969-11-26', '424-560-5196');
 
INSERT INTO PersonInHospital
VALUES (403, 'Daniel', 'McGuire', '1955-06-26', '424-795-1878');
 
INSERT INTO PersonInHospital
VALUES (404, 'James', 'Hamley', '1969-03-16', '310-361-8461');
 
INSERT INTO PersonInHospital
VALUES (405, 'Edward', 'Harte', '1964-11-18', '310-692-7304');
 
INSERT INTO PersonInHospital
VALUES (406, 'Barbara', 'Garber', '1962-02-0-1', '310-758-9954');
 
INSERT INTO PersonInHospital
VALUES (407, 'Donna', 'Tredway', '1955-06-26', '424-918-4509');
 
INSERT INTO PersonInHospital
VALUES (408, 'Helen', 'Garber', '1955-06-26', '424-702-5854');
 
INSERT INTO PersonInHospital
VALUES (409, 'Susan', 'Holland', '1968-08-19', '310-535-6933');
 
INSERT INTO PersonInHospital
VALUES (500, 'Richard', 'Davis', '1982-03-30', '310-515-7824');
 
INSERT INTO PersonInHospital
VALUES (501, 'Jose', 'Orman', '1988-04-30', '424-485-5828');
 
INSERT INTO PersonInHospital
VALUES (502, 'Lisa', 'York', '1977-09-28', '424-247-6464');
 
INSERT INTO PersonInHospital
VALUES (503, 'Timothy', 'Thayer', '1972-03-21', '310-413-8247');
 
INSERT INTO PersonInHospital
VALUES (504, 'James', 'Kay', '1974-05-30', '310-283-7289');
 
INSERT INTO PersonInHospital
VALUES (600, 'Dorothy', 'Zimmer', '1973-12-29', '424-249-6484');
 
INSERT INTO PersonInHospital
VALUES (601, 'Helen', 'Swanson', '1956-09-23', '424-855-8402');
 
INSERT INTO PersonInHospital
VALUES (602, 'Anthony', 'Harte', '1956-05-06', '310-358-5513');
 
INSERT INTO PersonInHospital
VALUES (603, 'Michael', 'Grimes', '1976-02-01', '310-758-9954');
 
INSERT INTO PersonInHospital
VALUES (604, 'Gary', 'Hyde', '1971-05-02', '424-581-8797');
 
INSERT INTO PersonInHospital
VALUES (605, 'Richard', 'Gomer', '1965-08-12', '424-432-4797');
 
INSERT INTO PersonInHospital
VALUES (606, 'Mary', 'Heron', '1951-03-25', '424-512-5373');
 
INSERT INTO PersonInHospital
VALUES (607, 'Anthony', 'Parker', '1988-04-30', '310-720-2079');
 
INSERT INTO PersonInHospital
VALUES (608, 'Robert', 'Heron', '1975-09-17', '310-254-8330');
 
INSERT INTO PersonInHospital
VALUES (609, 'Mary', 'Thayer', '1986-08-05', '310-692-7304');
 
INSERT INTO PersonInHospital
VALUES (610, 'Ronald', 'Zoer', '1965-08-12', '424-921-9536');
 
INSERT INTO PersonInHospital
VALUES (611, 'Sandra', 'Marx', '1972-03-21', '424-512-5373');
 
INSERT INTO PersonInHospital
VALUES (612, 'Thomas', 'Orman', '1984-11-18', '310-707-8829');
 
INSERT INTO PersonInHospital
VALUES (613, 'Brian', 'McCourt', '1970-10-10', '424-432-4797');
 
INSERT INTO PersonInHospital
VALUES (614, 'Paul', 'Pickens', '1974-05-30', '424-795-1878');
 
INSERT INTO PersonInHospital
VALUES (615, 'Christopher', 'Gomer', '1978-11-28', '424-808-6698');
 
INSERT INTO PersonInHospital
VALUES (616, 'Brian', 'McGuire', '1956-05-06', '424-796-7133');
 
INSERT INTO PersonInHospital
VALUES (617, 'Timothy', 'Grayson', '1951-03-25', '310-346-4892');
 
INSERT INTO PersonInHospital
VALUES (618, 'Robert', 'Grimes', '1968-08-19', '424-405-5327');
 
INSERT INTO PersonInHospital
VALUES (619, 'Paul', 'Benson', '1969-11-26', '310-283-7289');
 
INSERT INTO PersonInHospital
VALUES (620, 'Richard', 'Walker', '1976-04-06', '310-692-7304');
 
INSERT INTO PersonInHospital
VALUES (621, 'Barbara', 'Davis', '1971-05-02', '424-921-9536');
 
INSERT INTO PersonInHospital
VALUES (622, 'Thomas', 'Bruckner', '1962-02-01', '310-442-1401');
 
INSERT INTO PersonInHospital
VALUES (623, 'Donna', 'Heron', '1989-10-14', '424-432-4797');
 
INSERT INTO PersonInHospital
VALUES (624, 'John', 'Zoer', '1958-01-25', '424-702-5854');
 
INSERT INTO PersonInHospital
VALUES (625, 'George', 'Heron', '1951-09-29', '310-346-4892');
 
INSERT INTO PersonInHospital
VALUES (626, 'Elizabeth, McCreary', '1979-03-11', '424-921-9536');
 
INSERT INTO PersonInHospital
VALUES (627, 'Sandra', 'Hunter', '1975-03-18', '424-479-7376');
 
INSERT INTO PersonInHospital
VALUES (628, 'Helen', 'Thomas', '1977-09-28', '424-313-5985');
 
INSERT INTO PersonInHospital
VALUES (629, 'William', 'Holland', '1976-02-01', '424-468-3353');
 
INSERT INTO PersonInHospital
VALUES (630, 'Robert', 'Bruckner', '1958-01-25', '310-692-7304');
 
INSERT INTO PersonInHospital
VALUES (631, 'Larry', 'Tredway', '1988-04-30', '424-711-8008');
 
INSERT INTO PersonInHospital
VALUES (632, 'Jose', 'Harris', '1984-07-27', '424-983-5228');
 
INSERT INTO PersonInHospital
VALUES (633, 'Jose', 'Grimes', '1973-12-29', '424-512-5373');
 
INSERT INTO PersonInHospital
VALUES (634, 'Betty', 'Pickens', '1959-03-25', '310-319-4733');
 
INSERT INTO PersonInHospital
VALUES (635, 'Kenneth', 'Heron', '1964-11-18', '310-361-8461');
 
INSERT INTO PersonInHospital
VALUES (636, 'Maria', 'Wright', '1951-09-29', '310-319-4733');
 
INSERT INTO PersonInHospital
VALUES (637, 'Margaret', 'Tredway', '1984-07-27', '424-581-8797');
 
INSERT INTO PersonInHospital
VALUES (638, 'Linda', 'Tredway', '1958-01-25', '310-401-4089');
 
INSERT INTO PersonInHospital
VALUES (639, 'Kevin', 'Grayson', '1960-10-11', '310-965-6337');
 
INSERT INTO PersonInHospital
VALUES (640, 'Lisa', 'Heron', '1976-02-01', '310-361-8461');
 
INSERT INTO PersonInHospital
VALUES (641, 'Michael', 'Kay', '1959-03-25', '424-522-9521');
 
INSERT INTO PersonInHospital
VALUES (642, 'Anthony', 'Bennington', '1972-03-21', '424-249-6484');
 
INSERT INTO PersonInHospital
VALUES (643, 'Steven', 'Wright', '1981-01-28', '424-522-9521');
 
INSERT INTO PersonInHospital
VALUES (644, 'Edward', 'McCourt', '1961-02-13', '424-485-5828');
 
INSERT INTO PersonInHospital
VALUES (645, 'Donald', 'Tredway', '1956-09-23', '310-319-4733');
 
INSERT INTO PersonInHospital
VALUES (646, 'Frank', 'Zumbelh', '1975-09-17', '310-707-8829');
 
INSERT INTO PersonInHospital
VALUES (647, 'James', 'Grayson', '1986-01-10', '310-758-9954');
 
INSERT INTO PersonInHospital
VALUES (648, 'Anthony', 'Shapiro', '1968-08-19', '310-442-1401');
 
INSERT INTO PersonInHospital
VALUES (649, 'Kevin', 'Kaufman', '1968-08-19', '424-581-8797');
 
INSERT INTO PersonInHospital
VALUES (650, 'Nancy', 'Kay', '1962-02-01', '424-468-3353');
 
INSERT INTO PersonInHospital
VALUES (651, 'Daniel', 'Brighton', '1956-05-06', '424-212-2711');
 
INSERT INTO PersonInHospital
VALUES (652, 'Donna', 'Harris', '1976-02-01', '424-468-3353');
 
INSERT INTO PersonInHospital
VALUES (653, 'Ronald', 'Brockman', '1977-05-02', '424-313-5985');
 
INSERT INTO PersonInHospital
VALUES (654, 'Anthony', 'Carr', '1975-03-18', '310-358-5513');
 
INSERT INTO PersonInHospital
VALUES (655, 'Dorothy', 'Swanson', '1970-10-10', '310-630-5744');
 
INSERT INTO PersonInHospital
VALUES (656, 'Karen', 'Benson', '1976-04-06', '310-361-8461');
 
INSERT INTO PersonInHospital
VALUES (657, 'Jeffrey', 'Harris', '1984-07-27', '424-702-5854');
 
INSERT INTO PersonInHospital
VALUES (658, 'Steven', 'McCreary', '1976-04-06', '424-313-5985');
 
INSERT INTO PersonInHospital
VALUES (659, 'Thomas', 'Tredway', '1988-12-28', '424-485-5828');
 
INSERT INTO PersonInHospital
VALUES (700, 'George', 'Walker', '1980-12-11', '310-539-2485');
 
INSERT INTO PersonInHospital
VALUES (701, 'Betty', 'Ketchum', '1950-04-16', '310-777-4461');
 
INSERT INTO PersonInHospital
VALUES (702, 'William', 'Ketchum', '1954-01-17', '424-310-7163');
 
INSERT INTO PersonInHospital
VALUES (703, 'Joseph', 'Tredway', '1989-06-10', '310-368-1615');
 
INSERT INTO PersonInHospital
VALUES (704, 'Matthew', 'Davis', '1950-07-18', '424-442-9302');
 
INSERT INTO PersonInHospital
VALUES (705, 'William', 'Harmes', '1966-02-12', '424-519-9350');
 
INSERT INTO PersonInHospital
VALUES (706, 'Kenneth', 'Bennington', '1950-07-18', '310-309-8803');
 
INSERT INTO PersonInHospital
VALUES (707, 'Ronald', 'Chapman', '1974-10-25', '310-286-8720');
 
INSERT INTO PersonInHospital
VALUES (708, 'Gary', 'Kay', '1975-12-27', '310-441-3754');
 
INSERT INTO PersonInHospital
VALUES (709, 'Edward', 'Hyde', '1962-11-17', '310-465-8897');
 
INSERT INTO PersonInHospital
VALUES (710, 'Edward', 'Kay', '1962-11-17', '310-317-3686');
 
INSERT INTO PersonInHospital
VALUES (711, 'Elizabeth', 'Zimmer', '1987-06-04', '310-414-8094');
 
INSERT INTO PersonInHospital
VALUES (712, 'Kenneth', 'Pickens', '1987-06-04', '310-703-3843');
 
INSERT INTO PersonInHospital
VALUES (713, 'George', 'LeRoy', '1986-01-02', '424-238-9226');
 
INSERT INTO PersonInHospital
VALUES (714, 'Frank', 'Hamley', '1986-12-27', '310-892-8558');
 
INSERT INTO PersonInHospital
VALUES (715, 'Helen', 'Kaufman', '1977-03-30', '424-662-1426');
 
INSERT INTO PersonInHospital
VALUES (716, 'Margaret', 'Chapman', '1957-02-20', '424-310-7163');
 
INSERT INTO PersonInHospital
VALUES (717, 'Susan', 'Davis', '1967-05-24', '310-776-8869');
 
INSERT INTO PersonInHospital
VALUES (718, 'Steven', 'Pickens', '1974-10-27', '424-310-7163');
 
INSERT INTO PersonInHospital
VALUES (719, 'Linda', 'Wright', '1957-02-20', '310-465-8897');
# PersonInHospital populated
 
# Populate Physician
INSERT INTO Physician
VALUES (100, 'Cardiologist', '310-123-9856');
 
INSERT INTO Physician
VALUES (101, 'Family Medicine', '310-123-1254');
 
INSERT INTO Physician
VALUES (102, 'Primary Care', '310-123-2365');
 
INSERT INTO Physician
VALUES (103, 'Pediatricians', '310-123-7458');
 
INSERT INTO Physician
VALUES (104, 'Surgeons', '310-123-7139');
# Physician populated
 
# Populate Employee
INSERT INTO Employee
VALUES (200, '2015-08-12');
INSERT INTO Employee
VALUES (201, '2015-08-05');
 
INSERT INTO Employee
VALUES (202, '2015-04-29');
 
INSERT INTO Employee
VALUES (203, '2014-03-24');
 
INSERT INTO Employee
VALUES (204, '2009-04-19');
 
INSERT INTO Employee
VALUES (205, '2014-11-15');
 
INSERT INTO Employee
VALUES (206, '2001-06-11');
 
INSERT INTO Employee
VALUES (207, '1999-08-06');
 
INSERT INTO Employee
VALUES (208, '2009-06-28');
 
INSERT INTO Employee
VALUES (209, '2007-01-27');
 
INSERT INTO Employee
VALUES (210, '2015-01-13');
 
INSERT INTO Employee
VALUES (211, '2014-10-25');
 
INSERT INTO Employee
VALUES (212, '2011-04-27');
 
INSERT INTO Employee
VALUES (213, '2011-06-25');
 
INSERT INTO Employee
VALUES (214, '2011-09-17');
 
INSERT INTO Employee
VALUES (300, '2015-03-21');
 
INSERT INTO Employee
VALUES (301, '1997-06-20');
 
INSERT INTO Employee
VALUES (302, '1996-07-26');
 
INSERT INTO Employee
VALUES (303, '1996-02-01');
 
INSERT INTO Employee
VALUES (304, '1990-01-20');
 
INSERT INTO Employee
VALUES (400, '2000-03-15');
 
INSERT INTO Employee
VALUES (401, '2001-03-19');
 
INSERT INTO Employee
VALUES (402, '2002-10-04');
 
INSERT INTO Employee
VALUES (403, '2003-02-18');
 
INSERT INTO Employee
VALUES (404, '2004-04-07');
 
INSERT INTO Employee
VALUES (405, '2005-12-10');
 
INSERT INTO Employee
VALUES (406, '2006-11-14');
 
INSERT INTO Employee
VALUES (407, '2007-02-21');
 
INSERT INTO Employee
VALUES (408, '2008-06-22');
 
INSERT INTO Employee
VALUES (409, '2009-07-24');
 
INSERT INTO Employee
VALUES (500, '1999-05-14');
 
INSERT INTO Employee
VALUES (501, '1994-07-10');
 
INSERT INTO Employee
VALUES (502, '1992-04-27');
 
INSERT INTO Employee
VALUES (503, '1998-05-06');
 
INSERT INTO Employee
VALUES (504, '2000-12-29');
# Employee populated
 
# populate Nurse
INSERT INTO Nurse
VALUES (200, 'Critical Care');
 
INSERT INTO Nurse
VALUES (201, 'Critical Care');
 
INSERT INTO Nurse
VALUES (202, 'Critical Care');
 
INSERT INTO Nurse
VALUES (203, 'Critical Care');
 
INSERT INTO Nurse
VALUES (204, 'Progressive Care');
 
INSERT INTO Nurse
VALUES (205, 'Progressive Care');
 
INSERT INTO Nurse
VALUES (206, 'Progressive Care');
 
INSERT INTO Nurse
VALUES (207, 'Pediatric Clinical Specialist');
 
INSERT INTO Nurse
VALUES (208, 'Pediatric Clinical Specialist');
 
INSERT INTO Nurse
VALUES (209, 'Pediatric Clinical Specialist');
 
INSERT INTO Nurse
VALUES (210, 'Pediatric Clinical Specialist');
 
INSERT INTO Nurse
VALUES (211, 'Progressive Care');
 
INSERT INTO Nurse
VALUES (212, 'Neonatal');
 
INSERT INTO Nurse
VALUES (213, 'Neonatal');
 
INSERT INTO Nurse
VALUES (214, 'Neonatal');
 
INSERT INTO Nurse
VALUES (300, 'Pediatric Clinical Specialist');
 
INSERT INTO Nurse
VALUES (301, 'Critical Care');
 
INSERT INTO Nurse
VALUES (302, 'Progressive Care');
 
INSERT INTO Nurse
VALUES (303, 'Critical Care');
 
INSERT INTO Nurse
VALUES (304, 'Neonatal');
# Nurse populated
 
# Populate RegisteredNurse
INSERT INTO RegisteredNurse
VALUES (300);
 
INSERT INTO RegisteredNurse
VALUES (301);
 
INSERT INTO RegisteredNurse
VALUES (302);
 
INSERT INTO RegisteredNurse
VALUES (303);
 
INSERT INTO RegisteredNurse
VALUES (304);
# RegisteredNurse populated
 
# Populate Staff
INSERT INTO Staff
VALUES (400, 'Human Resources');
 
INSERT INTO Staff
VALUES (401, 'Human Resources');
 
INSERT INTO Staff
VALUES (402, 'IT');
 
INSERT INTO Staff
VALUES (403, 'IT');
 
INSERT INTO Staff
VALUES (404, 'Human Resources');
 
INSERT INTO Staff
VALUES (405, 'Finance');
 
INSERT INTO Staff
VALUES (406, 'Finance');
 
INSERT INTO Staff
VALUES (407, 'Administrator');
 
INSERT INTO Staff
VALUES (408, 'Administrator');
 
INSERT INTO Staff
VALUES (409, 'Administrator');
# Staff Populated
 
# Populate Technician
INSERT INTO Technician
VALUES (500, 'Clinical Laboratory');
 
INSERT INTO Technician
VALUES (501, 'Phlebotomy');
 
INSERT INTO Technician
VALUES (502, 'Medical Lab');
 
INSERT INTO Technician
VALUES (503, 'Surgical');
 
INSERT INTO Technician
VALUES (504, 'Medical Lab');
# Technician populated
 
# Populate Patient
INSERT INTO Patient
VALUES (600, 'Dorothy', 'Zimmer', '1973-12-29', '424-249-6484');
 
INSERT INTO Patient
VALUES (601, 'Helen', 'Swanson', '1956-09-23', '424-855-8402');
 
INSERT INTO Patient
VALUES (602, 'Anthony', 'Harte', '1956-05-06', '310-358-5513');
 
INSERT INTO Patient
VALUES (603, 'Michael', 'Grimes', '1976-02-01', '310-758-9954');
 
INSERT INTO Patient
VALUES (604, 'Gary', 'Hyde', '1971-05-02', '424-581-8797');
 
INSERT INTO Patient
VALUES (605, 'Richard', 'Gomer', '1965-08-12', '424-432-4797');
 
INSERT INTO Patient
VALUES (606, 'Mary', 'Heron', '1951-03-25', '424-512-5373');
 
INSERT INTO Patient
VALUES (607, 'Anthony', 'Parker', '1988-04-30', '310-720-2079');
 
INSERT INTO Patient
VALUES (608, 'Robert', 'Heron', '1975-09-17', '310-254-8330');
 
INSERT INTO Patient
VALUES (609, 'Mary', 'Thayer', '1986-08-05', '310-692-7304');
 
INSERT INTO Patient
VALUES (610, 'Ronald', 'Zoer', '1965-08-12', '424-921-9536');
 
INSERT INTO Patient
VALUES (611, 'Sandra', 'Marx', '1972-03-21', '424-512-5373');
 
INSERT INTO Patient
VALUES (612, 'Thomas', 'Orman', '1984-11-18', '310-707-8829');
 
INSERT INTO Patient
VALUES (613, 'Brian', 'McCourt', '1970-10-10', '424-432-4797');
 
INSERT INTO Patient
VALUES (614, 'Paul', 'Pickens', '1974-05-30', '424-795-1878');
 
INSERT INTO Patient
VALUES (615, 'Christopher', 'Gomer', '1978-11-28', '424-808-6698');
 
INSERT INTO Patient
VALUES (616, 'Brian', 'McGuire', '1956-05-06', '424-796-7133');
 
INSERT INTO Patient
VALUES (617, 'Timothy', 'Grayson', '1951-03-25', '310-346-4892');
 
INSERT INTO Patient
VALUES (618, 'Robert', 'Grimes', '1968-08-19', '424-405-5327');
 
INSERT INTO Patient
VALUES (619, 'Paul', 'Benson', '1969-11-26', '310-283-7289');
 
INSERT INTO Patient
VALUES (620, 'Richard', 'Walker', '1976-04-06', '310-692-7304');
 
INSERT INTO Patient
VALUES (621, 'Barbara', 'Davis', '1971-05-02', '424-921-9536');
 
INSERT INTO Patient
VALUES (622, 'Thomas', 'Bruckner', '1962-02-01', '310-442-1401');
 
INSERT INTO Patient
VALUES (623, 'Donna', 'Heron', '1989-10-14', '424-432-4797');
 
INSERT INTO Patient
VALUES (624, 'John', 'Zoer', '1958-01-25', '424-702-5854');
 
INSERT INTO Patient
VALUES (625, 'George', 'Heron', '1951-09-29', '310-346-4892');
 
INSERT INTO Patient
VALUES (626, 'Elizabeth', 'McCreary', '1979-03-11', '424-921-9536');
 
INSERT INTO Patient
VALUES (627, 'Sandra', 'Hunter', '1975-03-18', '424-479-7376');
 
INSERT INTO Patient
VALUES (628, 'Helen', 'Thomas', '1977-09-28', '424-313-5985');
 
INSERT INTO Patient
VALUES (629, 'William', 'Holland', '1976-02-0-1', '424-468-3353');
 
INSERT INTO Patient
VALUES (630, 'Robert', 'Bruckner', '1958-01-25', '310-692-7304');
 
INSERT INTO Patient
VALUES (631, 'Larry', 'Tredway', '1988-04-30', '424-711-8008');
 
INSERT INTO Patient
VALUES (632, 'Jose', 'Harris', '1984-07-27', '424-983-5228');
 
INSERT INTO Patient
VALUES (633, 'Jose', 'Grimes', '1973-12-29', '424-512-5373');
 
INSERT INTO Patient
VALUES (634, 'Betty', 'Pickens', '1959-03-25', '310-319-4733');
 
INSERT INTO Patient
VALUES (635, 'Kenneth', 'Heron', '1964-11-18', '310-361-8461');
 
INSERT INTO Patient
VALUES (636, 'Maria', 'Wright', '1951-09-29', '310-319-4733');
 
INSERT INTO Patient
VALUES (637, 'Margaret', 'Tredway', '1984-07-27', '424-581-8797');
 
INSERT INTO Patient
VALUES (638, 'Linda', 'Tredway', '1958-01-25', '310-401-4089');
 
INSERT INTO Patient
VALUES (639, 'Kevin', 'Grayson', '1960-10-11', '310-965-6337');
 
INSERT INTO Patient
VALUES (640, 'Lisa', 'Heron', '1976-02-0-1', '310-361-8461');
 
INSERT INTO Patient
VALUES (641, 'Michael', 'Kay', '1959-03-25', '424-522-9521');
 
INSERT INTO Patient
VALUES (642, 'Anthony', 'Bennington', '1972-03-21', '424-249-6484');
 
INSERT INTO Patient
VALUES (643, 'Steven', 'Wright', '1981-01-28', '424-522-9521');
 
INSERT INTO Patient
VALUES (644, 'Edward', 'McCourt', '1961-02-13', '424-485-5828');
 
INSERT INTO Patient
VALUES (645, 'Donald', 'Tredway', '1956-09-23', '310-319-4733');
 
INSERT INTO Patient
VALUES (646, 'Frank', 'Zumbelh', '1975-09-17', '310-707-8829');
 
INSERT INTO Patient
VALUES (647, 'James', 'Grayson', '1986-01-10', '310-758-9954');
 
INSERT INTO Patient
VALUES (648, 'Anthony', 'Shapiro', '1968-08-19', '310-442-1401');
 
INSERT INTO Patient
VALUES (649, 'Kevin', 'Kaufman', '1968-08-19', '424-581-8797');
 
INSERT INTO Patient
VALUES (650, 'Nancy', 'Kay', '1962-02-01', '424-468-3353');
 
INSERT INTO Patient
VALUES (651, 'Daniel', 'Brighton', '1956-05-06', '424-212-2711');
 
INSERT INTO Patient
VALUES (652, 'Donna', 'Harris', '1976-02-01', '424-468-3353');
 
INSERT INTO Patient
VALUES (653, 'Ronald', 'Brockman', '1977-05-02', '424-313-5985');
 
INSERT INTO Patient
VALUES (654, 'Anthony', 'Carr', '1975-03-18', '310-358-5513');
 
INSERT INTO Patient
VALUES (655, 'Dorothy', 'Swanson', '1970-10-10', '310-630-5744');
 
INSERT INTO Patient
VALUES (656, 'Karen', 'Benson', '1976-04-06', '310-361-8461');
 
INSERT INTO Patient
VALUES (657, 'Jeffrey', 'Harris', '1984-07-27', '424-702-5854');
 
INSERT INTO Patient
VALUES (658, 'Steven', 'McCreary', '1976-04-06', '424-313-5985');
 
INSERT INTO Patient
VALUES (659, 'Thomas', 'Tredway', '1988-12-28', '424-485-5828');
# Patient Populated
 
# Populate Volunteer
INSERT INTO Volunteer
VALUES (700, Skill);
 
INSERT INTO Volunteer
VALUES (701,Skill);
 
INSERT INTO Volunteer
VALUES (702, Skill);
 
INSERT INTO Volunteer
VALUES (703, Skill);
 
INSERT INTO Volunteer
VALUES (704, Skill);
 
INSERT INTO Volunteer
VALUES (705, Skill);
 
INSERT INTO Volunteer
VALUES (706, Skill);
 
INSERT INTO Volunteer
VALUES (707, Skill);
 
INSERT INTO Volunteer
VALUES (708, Skill);
 
INSERT INTO Volunteer
VALUES (709, Skill);
 
INSERT INTO Volunteer
VALUES (710, Skill);
 
INSERT INTO Volunteer
VALUES (711, Skill);
 
INSERT INTO Volunteer
VALUES (712, Skill);
 
INSERT INTO Volunteer
VALUES (713, Skill);
 
INSERT INTO Volunteer
VALUES (714, Skill);
 
INSERT INTO Volunteer
VALUES (715, Skill);
 
INSERT INTO Volunteer
VALUES (716, Skill);
 
INSERT INTO Volunteer
VALUES (717, Skill);
 
INSERT INTO Volunteer
VALUES (718, Skill);
 
INSERT INTO Volunteer
VALUES (719, Skill);
#Volunteer Populated
