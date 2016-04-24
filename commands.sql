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

CREATE TABLE CareCenter (
	Name VARCHAR(40),
	Location VARCHAR(40)
);

CREATE TABLE Staff (
	JobClass VARCHAR(40)
);

CREATE TABLE Technician (
	Skill VARCHAR(40)
);

CREATE TABLE Laboratory (
	Name VARCHAR(40)
	Location VARCHAR(40)
);

CREATE TABLE TechnicianLab (
);

CREATE TABLE Bed (
	Bed# INT(3)
);

CREATE TABLE Room (
	Room INT(4),
	Floor INT(2)
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
