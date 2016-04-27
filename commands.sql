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
	ContactDate DATE,
	EmergencyContact VARCHAR(12),
	CONSTRAINT pk_patientID PRIMARY KEY (personID),
	CONSTRAINT fk_patientID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID)
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
	REFERENCES Technician(personID)
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
	VisitDate DATE,
	Comment VARCHAR(40),
	CONSTRAINT fk_visitorID FOREIGN KEY (personID)
	REFERENCES Outpatient (personID),
	CONSTRAINT fk_physID FOREIGN KEY (personID)
	REFERENCES Physician(personID)
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
ADD personID INT

ALTER TABLE CareCenter
ADD CONSTRAINT fk_NurseInCharge FOREIGN KEY (personID)
REFERENCES RegisteredNurse(personID)

CREATE TABLE Room (
	Name VARCHAR(40),
	RoomNum INT,
	Floor INT,
	CONSTRAINT pk_roomNum PRIMARY KEY (RoomNum),
	CONSTRAINT fk_RName FOREIGN KEY (Name)
	REFERENCES CareCenter(Name)
);


CREATE TABLE Bed (
	Bed INT,
        RoomNum INT,
	CONSTRAINT pk_BedRoom PRIMARY KEY (Bed, RoomNum),
	CONSTRAINT fk_roomNum FOREIGN KEY (RoomNum)
	REFERENCES Room (RoomNum)
);



INSERT INTO PersonInHospital 
VALUES (100, Frank, McGuire, 1986-04-02, 310-636-9955);

INSERT INTO PersonInHospital 
VALUES (101, Jennifer, Matthews, 1973-12-10, 310-819-6721);

INSERT INTO PersonInHospital 
VALUES (102, William, Thomas, 1971-05-24, 310-611-3773);

INSERT INTO PersonInHospital 
VALUES (103, Jason, Hamley, 1981-08-16, 310-487-3585);

INSERT INTO PersonInHospital 
VALUES (104, Christopher, Ketchum, 1982-11-06, 310-564-4582);

INSERT INTO PersonInHospital 
VALUES (105, Kenneth, Clark, 1975-12-21, 310-449-6425);

INSERT INTO PersonInHospital 
VALUES (106, Elizabeth, Parker, 1951-12-10, 310-801-3924);

INSERT INTO PersonInHospital 
VALUES (107, Maria, Shapiro, 1986-09-22, 310-670-5556);

INSERT INTO PersonInHospital 
VALUES (108, Charles, Orman, 1975-07-18, 424-881-2396);

INSERT INTO PersonInHospital 
VALUES (109, Betty, Swanson, 1953-03-19, 424-264-2158);

INSERT INTO PersonInHospital 
VALUES (110, Elizabeth, Hamley, 1981-11-23, 310-988-8859);

INSERT INTO PersonInHospital 
VALUES (111, Susan, Pickens, 1950-05-08, 424-410-1875);

INSERT INTO PersonInHospital 
VALUES (112, Karen, Garber, 1976-03-11, 424-871-6739);

INSERT INTO PersonInHospital 
VALUES (113, Carol, Heron, 1953-09-10, 424-978-7044);

INSERT INTO PersonInHospital 
VALUES (114, Paul, Howell, 1977-04-23, 310-564-4582);

INSERT INTO PersonInHospital 
VALUES (115, Lisa, Orman, 1971-05-24, 310-258-5684);

INSERT INTO PersonInHospital 
VALUES (116, Edward, Bennington, 1987-06-13, 310-449-6425);

INSERT INTO PersonInHospital 
VALUES (117, Daniel, LeRoy, 1971-06-08, 310-828-1064);

INSERT INTO PersonInHospital 
VALUES (118, Richard, Howell, 1987-04-27, 424-974-6843);

INSERT INTO PersonInHospital 
VALUES (119, Carol, Hunter, 1952-02-0-1, 310-828-1064);

INSERT INTO PersonInHospital 
VALUES (120, Nancy, Carr, 1966-02-02, 424-410-1875);

INSERT INTO PersonInHospital 
VALUES (121, David, Tredway, 1962-02-14, 310-501-3198);

INSERT INTO PersonInHospital 
VALUES (122, William, Kay, 1986-09-22, 310-330-9669);

INSERT INTO PersonInHospital 
VALUES (123, Joseph, Nichols, 1983-10-17, 310-360-6896);

INSERT INTO PersonInHospital 
VALUES (124, Barbara, Heron, 1962-02-14, 424-871-6739);

INSERT INTO PersonInHospital 
VALUES (125, Edward, Garber, 1986-04-02, 424-574-4754);

INSERT INTO PersonInHospital 
VALUES (126, Helen, Matthews, 1962-02-14, 310-258-5684);

INSERT INTO PersonInHospital 
VALUES (127, Edward, Brockman, 1983-10-17, 424-649-3944);

INSERT INTO PersonInHospital 
VALUES (128, Frank, Marx, 1989-01-03, 424-878-9584);

INSERT INTO PersonInHospital 
VALUES (129, Thomas, Howell, 1966-02-02, 424-574-4754);

INSERT INTO PersonInHospital 
VALUES (130, Carol, Harmes, 1966-05-17, 424-410-1875);

INSERT INTO PersonInHospital 
VALUES (131, Lisa, Harmes, 1959-02-00, 310-449-6425);

INSERT INTO PersonInHospital 
VALUES (132, Charles, Parker, 1950-05-08, 424-264-2158);

INSERT INTO PersonInHospital 
VALUES (133, John, Grayson, 1959-02-00, 424-410-1875);

INSERT INTO PersonInHospital 
VALUES (134, Thomas, McCourt, 1971-01-05, 310-930-7092);

INSERT INTO PersonInHospital 
VALUES (135, Joseph, Carter, 1989-07-15, 310-284-6396);

INSERT INTO PersonInHospital 
VALUES (136, Ruth, Holland, 1953-09-10, 310-761-8501);

INSERT INTO PersonInHospital 
VALUES (137, Michael, Zumbelh, 1986-09-22, 310-375-6237);

INSERT INTO PersonInHospital 
VALUES (138, Jose, Gomer, 1956-06-17, 310-773-1288);

INSERT INTO PersonInHospital 
VALUES (139, Thomas, Ketchum, 1973-12-10, 310-761-8501);

INSERT INTO PersonInHospital 
VALUES (140, James, Hyde, 1965-09-09, 310-442-6168);

INSERT INTO PersonInHospital 
VALUES (141, Christopher, McCourt, 1958-02-09, 424-810-5798);

INSERT INTO PersonInHospital 
VALUES (142, Larry, Harmes, 1959-10-29, 424-881-2396);

INSERT INTO PersonInHospital 
VALUES (143, Paul, Kaufman, 1987-06-13, 424-679-7195);

INSERT INTO PersonInHospital 
VALUES (144, Jason, Harte, 1973-12-10, 310-930-7092);

INSERT INTO PersonInHospital 
VALUES (145, Steven, Kaufman, 1959-10-29, 310-330-9669);

INSERT INTO PersonInHospital 
VALUES (146, Ronald, Zimmer, 1962-11-20, 310-291-5165);

INSERT INTO PersonInHospital 
VALUES (147, Gary, Daley, 1952-02-0-1, 310-330-9518);

INSERT INTO PersonInHospital 
VALUES (148, Jose, Daley, 1976-12-01, 310-694-7270);

INSERT INTO PersonInHospital 
VALUES (149, Kenneth, Wright, 1977-06-21, 424-878-9584);

