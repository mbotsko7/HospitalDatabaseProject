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
	CCName VARCHAR(40),
	CONSTRAINT pk_volunteerID PRIMARY KEY (personID),
	CONSTRAINT fk_volunteerID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID),
	CONSTRAINT fk_CCAssignment FOREIGN KEY (CCName)
	REFERENCES CareCenter(Name),
	CONSTRAINT fk_skill FOREIGN KEY (Skill)
	REFERENCES Skill(Skill)
);

CREATE TABLE Skill(
	Skill VARCHAR(40),
	CONSTRAINT pk_skill PRIMARY KEY (Skill)
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

ALTER TABLE Technician
ADD CONSTRAINT fk_techSkill FOREIGN KEY (Skill)
REFERENCES Skill(Skill)

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
	CONSTRAINT fk_physID FOREIGN KEY (physID)
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

ALTER TABLE RegisteredNurse
DROP FOREIGN KEY fk_RNCCName;

ALTER TABLE RegisteredNurse
DROP COLUMN Name;

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

INSERT INTO PersonInHospital
VALUES (720, 'Bobby', 'McBob', '2012-02-20', '311-465-8897');

INSERT INTO PersonInHospital
VALUES (721, 'Bob', 'McSmirff', '2012-02-21', '331-465-8897');
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
VALUES (600, 101, '2008-03-08', 'David');
 
INSERT INTO Patient
VALUES (601, 100, '2004-04-29', 'Edward');
 
INSERT INTO Patient
VALUES (602, 100, '1995-04-01', 'Carol');
 
INSERT INTO Patient
VALUES (603, 100, '2009-11-08', 'Betty');
 
INSERT INTO Patient
VALUES (604, 101, '1998-09-17', 'Kenneth');
 
INSERT INTO Patient
VALUES (605, 102, '1993-08-14', 'Linda');
 
INSERT INTO Patient
VALUES (606, 103, '2000-11-21', 'Ruth');
 
INSERT INTO Patient
VALUES (607, 101, '2000-12-09', 'Jason');
 
INSERT INTO Patient
VALUES (608, 101, '2001-02-22', 'William');
 
INSERT INTO Patient
VALUES (609, 101, '1995-10-15', 'Margaret');
 
INSERT INTO Patient
VALUES (610, 100, '1996-10-01', 'David');
 
INSERT INTO Patient
VALUES (611, 102, '2001-08-13', 'Frank');
 
INSERT INTO Patient
VALUES (612, 102, '2002-03-06', 'Jeffrey');
 
INSERT INTO Patient
VALUES (613, 104, '2009-12-22', 'Mary');
 
INSERT INTO Patient
VALUES (614, 101, '2009-10-21', 'Christopher');
 
INSERT INTO Patient
VALUES (615, 100, '1998-09-20', 'James');
 
INSERT INTO Patient
VALUES (616, 103, '2004-09-13', 'Jeffrey');
 
INSERT INTO Patient
VALUES (617, 100, '2007-12-04', 'Matthew');
 
INSERT INTO Patient
VALUES (618, 102, '1995-04-22', 'Sandra');
 
INSERT INTO Patient
VALUES (619, 103, '2008-04-02', 'Patricia');
 
INSERT INTO Patient
VALUES (620, 101, '2003-08-28', 'George');
 
INSERT INTO Patient
VALUES (621, 101, '2005-04-03', 'Jennifer');
 
INSERT INTO Patient
VALUES (622, 100, '1992-07-21', 'Maria');
 
INSERT INTO Patient
VALUES (623, 104, '2005-08-26', 'Donna');
 
INSERT INTO Patient
VALUES (624, 100, '2004-10-12', 'Maria');
 
INSERT INTO Patient
VALUES (625, 103, '1997-03-12', 'Lisa');
 
INSERT INTO Patient
VALUES (626, 101, '2002-02-26', 'Christopher');
 
INSERT INTO Patient
VALUES (627, 104, '2005-02-18', 'Jose');
 
INSERT INTO Patient
VALUES (628, 100, '2000-09-15', 'Matthew');
 
INSERT INTO Patient
VALUES (629, 100, '1998-09-17', 'Daniel');
 
INSERT INTO Patient
VALUES (630, 103, '1998-03-01', 'Robert');
 
INSERT INTO Patient
VALUES (631, 103, '2004-02-05', 'Jeffrey');
 
INSERT INTO Patient
VALUES (632, 104, '2000-07-24', 'Steven');
 
INSERT INTO Patient
VALUES (633, 103, '1995-09-07', 'Barbara');
 
INSERT INTO Patient
VALUES (634, 101, '1992-02-03', 'George');
 
INSERT INTO Patient
VALUES (635, 101, '2001-03-19', 'John');
 
INSERT INTO Patient
VALUES (636, 101, '1995-12-26', 'Mark');
 
INSERT INTO Patient
VALUES (637, 101, '2004-12-22', 'Lisa');
 
INSERT INTO Patient
VALUES (638, 104, '1998-11-11', 'Timothy');
 
INSERT INTO Patient
VALUES (639, 101, '2004-07-09', 'James');
 
INSERT INTO Patient
VALUES (640, 101, '1997-08-24', 'Ruth');
 
INSERT INTO Patient
VALUES (641, 100, '1997-08-23', 'Jennifer');
 
INSERT INTO Patient
VALUES (642, 101, '1999-04-01', 'Richard');
 
INSERT INTO Patient
VALUES (643, 102, '2006-10-07', 'Linda');
 
INSERT INTO Patient
VALUES (644, 101, '2002-02-12', 'Steven');
 
INSERT INTO Patient
VALUES (645, 100, '2001-12-23', 'Helen');
 
INSERT INTO Patient
VALUES (646, 103, '2007-10-20', 'David');
 
INSERT INTO Patient
VALUES (647, 100, '1995-07-17', 'Donna');
 
INSERT INTO Patient
VALUES (648, 102, '1993-07-15', 'Maria');
 
INSERT INTO Patient
VALUES (649, 104, '2007-02-05', 'Jason');
 
INSERT INTO Patient
VALUES (650, 103, '1998-08-01', 'George');
 
INSERT INTO Patient
VALUES (651, 102, '1998-05-02', 'Elizabeth');
 
INSERT INTO Patient
VALUES (652, 103, '2007-04-24', 'Barbara');
 
INSERT INTO Patient
VALUES (653, 101, '1992-09-12', 'Timothy');
 
INSERT INTO Patient
VALUES (654, 101, '1995-01-15', 'Larry');
 
INSERT INTO Patient
VALUES (655, 104, '1998-05-28', 'David');
 
INSERT INTO Patient
VALUES (656, 102, '2002-10-12', 'Kenneth');
 
INSERT INTO Patient
VALUES (657, 101, '1992-12-22', 'Frank');
 
INSERT INTO Patient
VALUES (658, 100, '1990-01-21', 'George');
 
INSERT INTO Patient
VALUES (659, 101, '2002-12-29', 'James');

INSERT INTO Patient
VALUES (720, 101, '2012-02-25', 'Mimi');

INSERT INTO Patient
VALUES (721, 102, '2012-02-25', 'Zurg');
# Patient Populated
 
# Populate Volunteer
INSERT INTO Volunteer
VALUES (700, 'Care', 'Emergency Center');
 
INSERT INTO Volunteer
VALUES (701, 'Care','Emergency Center');

INSERT INTO Volunteer
VALUES (702,'Care', 'Emergency Center');
 
INSERT INTO Volunteer
VALUES (703,'Care', 'Emergency Center');
 
INSERT INTO Volunteer
VALUES (704, 'Care','Emergency Center');
 
INSERT INTO Volunteer
VALUES (705, 'Counseling', 'Maternity Center');
 
INSERT INTO Volunteer
VALUES (706, 'Counseling', 'Maternity Center');
 
INSERT INTO Volunteer
VALUES (707, 'Counseling', 'Maternity Center');
 
INSERT INTO Volunteer
VALUES (708, 'Counseling', 'Maternity Center');
 
INSERT INTO Volunteer
VALUES (709,'Counseling', 'Maternity Center');
 
INSERT INTO Volunteer
VALUES (710,'Counseling','Cardiology Center');
 
INSERT INTO Volunteer
VALUES (711,'Counseling', 'Cardiology Center');
 
INSERT INTO Volunteer
VALUES (712, 'Hospice', 'Cardiology Center');
 
INSERT INTO Volunteer
VALUES (713, 'Hospice', 'Cardiology Center');
 
INSERT INTO Volunteer
VALUES (714,'Hospice','Cardiology Center');
 
INSERT INTO Volunteer
VALUES (715, 'Hospice','Cardiology Center');
 
INSERT INTO Volunteer
VALUES (716,'Hospice', 'Cardiology Center');
 
INSERT INTO Volunteer
VALUES (717, Null, Null);
 
INSERT INTO Volunteer
VALUES (718, Null, Null);
 
INSERT INTO Volunteer
VALUES (719, Null,Null);
#Volunteer Populated
 
 
 
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
#Volunteer Populated


# Populate Laboratory
INSERT INTO Laboratory
VALUES ('Prenatal Laboratory', 'Maternity');
 
INSERT INTO Laboratory
VALUES ('Hematology', 'Research');
# Laboratory populated
alter table CareCenter
drop FOREIGN KEY fk_NurseInCharge
alter table CareCenter
drop personID
# Populate CareCenter
INSERT INTO CareCenter
VALUES ('Maternity Center', 'Maternity', '10:00', '22:00');
 
INSERT INTO CareCenter
VALUES ('Emergency Center', 'ER', '06:00', '22:00');
 
INSERT INTO CareCenter
VALUES ('Cardiology Center', 'Cardiology', '10:00', '22:00');
# CareCenter populated
 
# populate Nurse
INSERT INTO Nurse
VALUES ('Emergency Center', 200, 'Critical Care');
 
INSERT INTO Nurse
VALUES ('Emergency Center', 201, 'Critical Care');
 
INSERT INTO Nurse
VALUES ('Emergency Center', 202, 'Critical Care');
 
INSERT INTO Nurse
VALUES ('Emergency Center', 203, 'Critical Care');
 
INSERT INTO Nurse
VALUES ('Cardiology Center', 204, 'Progressive Care');
 
INSERT INTO Nurse
VALUES ('Cardiology Center', 205, 'Progressive Care');
 
INSERT INTO Nurse
VALUES ('Cardiology Center', 206, 'Progressive Care');
 
INSERT INTO Nurse
VALUES ('Maternity Center', 207, 'Pediatric Clinical Specialist');
 
INSERT INTO Nurse
VALUES ('Maternity Center',208, 'Pediatric Clinical Specialist');
 
INSERT INTO Nurse
VALUES ('Maternity Center',209, 'Pediatric Clinical Specialist');
 
INSERT INTO Nurse
VALUES ('Maternity Center',210, 'Pediatric Clinical Specialist');
 
INSERT INTO Nurse
VALUES ('Cardiology Center', 211, 'Progressive Care');
 
INSERT INTO Nurse
VALUES ('Cardiology Center', 212, 'Neonatal');
 
INSERT INTO Nurse
VALUES ('Maternity Center',213, 'Neonatal');
 
INSERT INTO Nurse
VALUES ('Maternity Center',214, 'Neonatal');
 
INSERT INTO Nurse
VALUES ('Maternity Center',300, 'Pediatric Clinical Specialist');
 
INSERT INTO Nurse
VALUES ('Emergency Center', 301, 'Critical Care');
 
INSERT INTO Nurse
VALUES ('Cardiology Center',302, 'Progressive Care');
 
INSERT INTO Nurse
VALUES ('Emergency Center',303, 'Critical Care');
 
INSERT INTO Nurse
VALUES ('Maternity Center',304, 'Neonatal');
# Nurse populated
 
# Populate RegisteredNurse
INSERT INTO RegisteredNurse
VALUES (300, 'Maternity Center');
 
INSERT INTO RegisteredNurse
VALUES (301, 'Maternity Center');
 
INSERT INTO RegisteredNurse
VALUES (302, 'Emergency Center');
 
INSERT INTO RegisteredNurse
VALUES (303, 'Emergency Center');
 
INSERT INTO RegisteredNurse
VALUES (304, 'Cardiology Center');

update RegisteredNurse
set Name = Null
where personID = 300

update RegisteredNurse
set Name = Null
where personID = 302

ALTER TABLE CareCenter
ADD personID INT;

ALTER TABLE CareCenter
ADD CONSTRAINT fk_NurseInCharge FOREIGN KEY (personID)
REFERENCES RegisteredNurse(personID);

update CareCenter
set PersonID = 300
where Name = 'Maternity Center'


update CareCenter
set PersonID = 302
where Name = 'Emergency Center'


update CareCenter
set PersonID = 304
where Name = 'Cardiology Center'


#Populate Room
INSERT INTO Room
VALUES ('Maternity Center', 201, 2);
 
INSERT INTO Room
VALUES ('Maternity Center', 202, 2);
 
INSERT INTO Room
VALUES ('Maternity Center', 203, 2);
 
INSERT INTO Room
VALUES ('Maternity Center', 204, 2);
 
INSERT INTO Room
VALUES ('Maternity Center', 205, 2);
 
INSERT INTO Room
VALUES ('Emergency Center', 101, 1);
 
INSERT INTO Room
VALUES ('Emergency Center', 102, 1);
 
INSERT INTO Room
VALUES ('Emergency Center', 103, 1);
 
INSERT INTO Room
VALUES ('Emergency Center', 104, 1);
 
INSERT INTO Room
VALUES ('Emergency Center', 105, 1);
 
INSERT INTO Room
VALUES ('Cardiology Center', 301, 3);
 
INSERT INTO Room
VALUES ('Cardiology Center', 302, 3);
 
INSERT INTO Room
VALUES ('Cardiology Center', 303, 3);
 
INSERT INTO Room
VALUES ('Cardiology Center', 304, 3);
 
INSERT INTO Room
VALUES ('Cardiology Center', 305, 3);
# Room Populated
 
#Populate Bed
INSERT INTO Bed
VALUES (600, 1, 101);
 
INSERT INTO Bed
VALUES (601, 2, 101);
 
INSERT INTO Bed
VALUES (602, 1, 102);
 
INSERT INTO Bed
VALUES (603, 2, 102);
 
INSERT INTO Bed
VALUES (604, 1, 103);
 
INSERT INTO Bed
VALUES (605, 2, 103);
 
INSERT INTO Bed
VALUES (606, 1, 104);
 
INSERT INTO Bed
VALUES (607, 2, 104);
 
INSERT INTO Bed
VALUES (608, 1, 105);
 
INSERT INTO Bed
VALUES (609, 2, 105);
 
INSERT INTO Bed
VALUES (610, 1, 201);
 
INSERT INTO Bed
VALUES (611, 2, 201);
 
INSERT INTO Bed
VALUES (612, 1, 202);
 
INSERT INTO Bed
VALUES (613, 2, 202);
 
INSERT INTO Bed
VALUES (614, 1, 203);
 
INSERT INTO Bed
VALUES (615, 2, 203);
 
INSERT INTO Bed
VALUES (616, 1, 204);
 
INSERT INTO Bed
VALUES (617, 2, 204);
 
INSERT INTO Bed
VALUES (618, 1, 205);
 
INSERT INTO Bed
VALUES (619, 2, 205);
 
INSERT INTO Bed
VALUES (620, 1, 301);
 
INSERT INTO Bed
VALUES (621, 2, 301);
 
INSERT INTO Bed
VALUES (622, 1, 302);
 
INSERT INTO Bed
VALUES (623, 2, 302);
 
INSERT INTO Bed
VALUES (624, 1, 303);
 
INSERT INTO Bed
VALUES (625, 2, 303);
 
INSERT INTO Bed
VALUES (626, 1, 304);
 
INSERT INTO Bed
VALUES (627, 2, 304);
 
INSERT INTO Bed
VALUES (628, 1, 305);
 
INSERT INTO Bed
VALUES (629, 2, 305);
# Bed Populated

# Populate Resident
INSERT INTO Resident
VALUES (600, '2010-07-19', 'Stable');
 
INSERT INTO Resident
VALUES (601, '2012-01-06', 'Stable');
 
INSERT INTO Resident
VALUES (602, '2015-07-02', 'Coma');
 
INSERT INTO Resident
VALUES (603, '2001-06-27', 'Care');
 
INSERT INTO Resident
VALUES (604, '2014-04-23', 'Anesthetized');
 
INSERT INTO Resident
VALUES (605, '2010-09-25', 'Stable');
 
INSERT INTO Resident
VALUES (606, '2004-08-03', 'Stable');
 
INSERT INTO Resident
VALUES (607, '2005-05-30', 'Stable');
 
INSERT INTO Resident
VALUES (608, '2002-02-25', 'Stable');
 
INSERT INTO Resident
VALUES (609, '2006-01-20', 'Stable');
 
INSERT INTO Resident
VALUES (610, '2010-06-20', 'Coma');
 
INSERT INTO Resident
VALUES (611, '2017-02-06', 'Care');
 
INSERT INTO Resident
VALUES (612, '2000-11-27', 'Care');
 
INSERT INTO Resident
VALUES (613, '2016-05-28', 'Care');
 
INSERT INTO Resident
VALUES (614, '2011-02-10', 'Anesthetized');
 
INSERT INTO Resident
VALUES (615, '2008-12-29', 'Anesthetized');
 
INSERT INTO Resident
VALUES (616, '2004-11-09', 'Anesthetized');
 
INSERT INTO Resident
VALUES (617, '2015-01-03', 'Stable');
 
INSERT INTO Resident
VALUES (618, '2011-08-16', 'Stable');
 
INSERT INTO Resident
VALUES (619, '2012-05-21', 'Stable');
 
INSERT INTO Resident
VALUES (620, '2012-06-13', 'Stable');
 
INSERT INTO Resident
VALUES (621, '2014-05-25', 'Stable');
 
INSERT INTO Resident
VALUES (622, '2015-09-23', 'Stable');
 
INSERT INTO Resident
VALUES (623, '2004-06-21', 'Stable');
 
INSERT INTO Resident
VALUES (624, '2014-05-19', 'Stable');
 
INSERT INTO Resident
VALUES (625, '2000-10-24', 'Care');
 
INSERT INTO Resident
VALUES (626, '2008-04-11', 'Care');
 
INSERT INTO Resident
VALUES (627, '2010-08-11', 'Care');
 
INSERT INTO Resident
VALUES (628, '2010-10-18', 'Care');
 
INSERT INTO Resident
VALUES (629, '2002-01-08', 'Care');

INSERT INTO Resident
VALUES (720, '2012-02-26', 'Care');
# Resident Populated

INSERT INTO Skill
VALUES ('Care');
INSERT INTO Skill
VALUES ('Hospice');
INSERT INTO Skill
VALUES ('Counseling');
INSERT INTO Skill
VALUES ('Clinical Laboratory');
INSERT INTO Skill
VALUES('Phlebotomy');
INSERT INTO Skill
VALUES ('Surgical');
INSERT INTO Skill
VALUES ('Medical Lab');
 
# Populate Outpatient
INSERT INTO Outpatient
VALUES (630);

INSERT INTO Outpatient
VALUES (631);

INSERT INTO Outpatient
VALUES (632);

INSERT INTO Outpatient
VALUES (633);

INSERT INTO Outpatient
VALUES (634);

INSERT INTO Outpatient
VALUES (635);

INSERT INTO Outpatient
VALUES (636);

INSERT INTO Outpatient
VALUES (637);

INSERT INTO Outpatient
VALUES (638);

INSERT INTO Outpatient
VALUES (639);

INSERT INTO Outpatient
VALUES (640);

INSERT INTO Outpatient
VALUES (641);

INSERT INTO Outpatient
VALUES (642);

INSERT INTO Outpatient
VALUES (643);

INSERT INTO Outpatient
VALUES (644);

INSERT INTO Outpatient
VALUES (645);

INSERT INTO Outpatient
VALUES (646);

INSERT INTO Outpatient
VALUES (647);

INSERT INTO Outpatient
VALUES (648);

INSERT INTO Outpatient
VALUES (649);

INSERT INTO Outpatient
VALUES (650);

INSERT INTO Outpatient
VALUES (651);

INSERT INTO Outpatient
VALUES (652);

INSERT INTO Outpatient
VALUES (653);

INSERT INTO Outpatient
VALUES (654);

INSERT INTO Outpatient
VALUES (655);

INSERT INTO Outpatient
VALUES (656);

INSERT INTO Outpatient
VALUES (657);

INSERT INTO Outpatient
VALUES (658);

INSERT INTO Outpatient
VALUES (659);

INSERT INTO Outpatient
VALUES (721);
# Outpatient Populated

# Populate Visit
INSERT INTO Visit
VALUES (630, 101, '2013-11-18', 'Recovered');

INSERT INTO Visit
VALUES (631, 100, '2014-08-27', 'Recovered');

INSERT INTO Visit
VALUES (632, 102, '2014-08-05', 'Recovered');

INSERT INTO Visit
VALUES (633, 100, '2014-11-10', 'Recovered');

INSERT INTO Visit
VALUES (634, 100, '2011-07-30', 'Recovered');

INSERT INTO Visit
VALUES (635, 100, '2012-03-17', 'Recovered');

INSERT INTO Visit
VALUES (636, 101, '2014-06-26', 'Recovered');

INSERT INTO Visit
VALUES (637, 101, '2011-05-30', 'Recovered');

INSERT INTO Visit
VALUES (638, 101, '2010-02-13', 'Recovered');


INSERT INTO Visit
VALUES (641, 101, '2011-01-05', 'Recovered');

INSERT INTO Visit
VALUES (642, 104, '2014-05-28', 'Recovered');

INSERT INTO Visit
VALUES (643, 101, '2014-10-27', 'Recovered');

INSERT INTO Visit
VALUES (644, 101, '2014-04-06', 'Recovered');

INSERT INTO Visit
VALUES (645, 100, '2014-04-08', 'Recovered');

INSERT INTO Visit
VALUES (646, 104, '2010-07-30', 'Recovered');

INSERT INTO Visit
VALUES (647, 104, '2011-03-13', 'Recovered');

INSERT INTO Visit
VALUES (648, 102, '2012-12-15', 'Recovered');

INSERT INTO Visit
VALUES (649, 104, '2011-03-08', 'Recovered');

INSERT INTO Visit
VALUES (650, 100, '2010-03-03', 'Recovered');

INSERT INTO Visit
VALUES (651, 101, '2014-10-13', 'Recovered');

INSERT INTO Visit
VALUES (652, 100, '2011-06-18', 'Recovered');

INSERT INTO Visit
VALUES (653, 104, '2011-07-18', 'Recovered');

INSERT INTO Visit
VALUES (654, 103, '2014-08-30', 'Recovered');

INSERT INTO Visit
VALUES (655, 102, '2013-02-11', 'Recovered');

INSERT INTO Visit
VALUES (656, 104, '2010-01-17', 'Recovered');

INSERT INTO Visit
VALUES (657, 101, '2012-01-17', 'Recovered');

INSERT INTO Visit
VALUES (658, 104, '2011-02-28', 'Recovered');

INSERT INTO Visit
VALUES (659, 102, '2010-02-15', 'Recovered');

INSERT INTO Visit
VALUES (659, 102, '2012-03-05', 'Recovered');


INSERT INTO Visit
VALUES (721, 102, '2012-03-05', 'Recovered');
# Visit Populated 

update Visit
set VisitDate = '2012-03-05'
where personID = 632

update Visit
set VisitDate = '2012-03-05'
where personID = 648

INSERT INTO PersonInHospital
VALUES (660, 'Homer', 'Simpson', '1980-02-12', '512-125-1298');
 
INSERT INTO PersonInHospital
VALUES (661, 'Peter', 'Griffin', '1980-06-21', '512-693-7412');
 
INSERT INTO Patient
VALUES (660, 104, '2010-12-29', 'Marge');
 
INSERT INTO Patient
VALUES (661, 104, '2011-11-21', 'Lois');
 
INSERT INTO Volunteer
VALUES (660, 'Hospice', 'Emergency Center');
 
INSERT INTO Volunteer
VALUES (661, 'Hospice', 'Emergency Center');