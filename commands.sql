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
	DateOfBirth DATE(),
	ContactNumber VARCHAR(12),
	CONSTRAINT pk_personID PRIMARY KEY (personID)
);

CREATE TABLE Employee ( 
	HireDate DATE(),
	CONSTRAINT pk_personID PRIMARY KEY (personID),
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID)
);

CREATE TABLE Physician (
	Specialty VARCHAR(40),
	Pager VARCHAR(10),
	CONSTRAINT pk_personID PRIMARY KEY (personID),
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID)
);

CREATE TABLE Patient (
	ContactDate DATE(),
	EmergencyContact VARCHAR(12),
	CONSTRAINT pk_personID PRIMARY KEY (personID),
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID)
);

CREATE TABLE Nurse (
	Certificate VARCHAR(40),
	CONSTRAINT pk_personID PRIMARY KEY (personID),
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID),
	CONSTRAINT fk_CCName FOREIGN KEY (Name)
	REFERENCES CareCenter (Name)
);

CREATE TABLE RegisteredNurse (
	CONSTRAINT pk_personID PRIMARY KEY (personID),	
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID),
	CONSTRAINT fk_CCName FOREIGN KEY (Name)
	REFERENCES CareCenter (Name)
);


CREATE TABLE CareCenter ( # Relationship with nurse?
	Name VARCHAR(40),
	Location VARCHAR(40),
	CONSTRAINT pk_CCName PRIMARY KEY (Name),
	CONSTRAINT fk_NurseInCharge FOREIGN KEY (personID)
	REFERENCES RegisteredNurse (personID)
);
#NOT DONE
CREATE TABLE Staff (
	JobClass VARCHAR(40),
	CONSTRAINT pk_personID PRIMARY KEY (personID),
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES Employee (personID)
);

CREATE TABLE Technician (
	Skill VARCHAR(40),
	CONSTRAINT pk_personID PRIMARY KEY (personID),
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES Employee (personID)
);

CREATE TABLE Laboratory ( #Relationship with technician?
	Name VARCHAR(40)
	Location VARCHAR(40)
	CONSTRAINT pk_LabName PRIMARY KEY (Name);
);

CREATE TABLE TechnicianLab (
	CONSTRAINT fk_LabName FOREIGN KEY (Name)
	REFERENCES Laboratory(Name),
	CONSTRAINT fk_Technician FOREIGN KEY (personID)
	REFERENCES Technician(Name)
);



#NOT DONE
CREATE TABLE Room (
	RoomNum INT(4),
	Floor INT(2),
	CONSTRAINT pk_roomNum PRIMARY KEY (Room),
	CONSTRAINT fk_CCName FOREIGN KEY (Name)
	REFERENCES CareCenter(Name)
);

CREATE TABLE Bed (
	Bed INT(5) # Floor Numer 2 digits, Room Number 2 digits, Bed 1 digit
	CONSTRAINT pk_BedRoom PRIMARY KEY (Bed, RoomNum)
	REFERENCES Room(RoomNum)
	CONSTRAINT fk_roomNum FOREIGN KEY (Room)
	REFERENCES Room (RoomNum)
);

#NOT DONE
CREATE TABLE Volunteer (
	Skill VARCHAR(40),
	CONSTRAINT pk_personID PRIMARY KEY (personID),
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES PersonInHospital (personID)
);

CREATE TABLE Resident (
	AdmittedDate DATE(),
	Status VARCHAR(40),
	CONSTRAINT pk_personID PRIMARY KEY (personID),
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES Patient (personID)
);

CREATE TABLE Outpatient (
	CONSTRAINT pk_personID PRIMARY KEY (personID),
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES Patient (personID)
);

CREATE TABLE Visit (
	VisitDate DATE(),
	Comment VARCHAR(40),
	CONSTRAINT fk_personID FOREIGN KEY (personID)
	REFERENCES Outpatient (personID),
	CONSTRAINT fk_physID FOREIGN KEY (personID)
	REFERENCES Physician(personID)
);
