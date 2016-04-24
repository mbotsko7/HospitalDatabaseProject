CREATE TABLE PersonInHospital (
	personID INT,
	FirstName VARCHAR(40),
	LastName VARCHAR(40),
	DateOfBirth DATE(),
	ContactNumber VARCHAR(12)
	CONSTRAINT pk_personID PRIMARY KEY (personID);
);

CREATE TABLE Employee (
	HireDate DATE()
	CONSTRAINT fk_personID FOREIGN KEY (personID);
);

CREATE TABLE Physician (
	Specialty VARCHAR(40),
	Pager VARCHAR(10)
	CONSTRAINT fk_personID FOREIGN KEY (personID);
);

CREATE TABLE Patient (
	ContactDate DATE(),
	EmergencyContact VARCHAR(12)
	CONSTRAINT fk_personID FOREIGN KEY (personID);
);

CREATE TABLE Nurse (
	Certificate VARCHAR(40)
);

CREATE TABLE RegisteredNurse (
);

CREATE TABLE OtherNurse (
);

CREATE TABLE CareCenter ( # Relationship with nurse?
	Name VARCHAR(40),
	Location VARCHAR(40)
	CONSTRAINT pk_CCName PRIMARY KEY (Name);
);

CREATE TABLE Staff (
	JobClass VARCHAR(40)
);

CREATE TABLE Technician (
	Skill VARCHAR(40)	
);

CREATE TABLE Laboratory ( #Relationship with technician?
	Name VARCHAR(40)
	Location VARCHAR(40)
	CONSTRAINT pk_LabName PRIMARY KEY (Name);
);

CREATE TABLE TechnicianLab (
);

CREATE TABLE Bed (
	Bed INT(5) # Floor Numer 2 digits, Room Number 2 digits, Bed 1 digit
	CONSTRAINT fk_roomNum FOREIGN KEY (Room);
);

CREATE TABLE Room (
	Room INT(4),
	Floor INT(2)
	CONSTRAINT fk_CCName FOREIGN KEY (Name);
	CONSTRAINT pk_roomNum PRIMARY KEY (Room);
);

CREATE TABLE Volunteer (
	Skill VARCHAR(40)
);

CREATE TABLE Resident (
	AdmittedDate DATE(),
	Status VARCHAR(40)
);

CREATE TABLE Outpatient (
);

CREATE TABLE Visit (
	VisitDate DATE(),
	Comment VARCHAR(40)
);
