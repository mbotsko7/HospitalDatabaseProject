#Use the Create View statement to create the following views:
#1 Employees-Hired: This view returns the First Name, Last Name, and Date Hired of all Hospital Employees.
CREATE VIEW Employees_Hired AS
SELECT FirstName, LastName, HireDate FROM Employee e
	INNER JOIN PersonInHospital p
	ON p.personID = e.personID;

#2 NursesInCharge: This view returns the name of the Nurse in Charge for each Care Center along with the phone number of the Nurse.
CREATE VIEW NursesInCharge AS
SELECT FirstName, LastName, ContactNumber, Name FROM RegisteredNurse rn
		INNER JOIN Nurse n
		ON rn.personID = n.personID
		INNER JOIN Employee e
		ON rn.personID = e.personID
INNER JOIN PersonInHospital p
		ON rn.personID = p.personID
		INNER JOIN CareCenter cc
		ON rn.personID = cc.personID
WHERE rn.personID IN (
		SELECT personID FROM CareCenter
	);
		
#3 : This view returns all the Technicians how have at least one skill.
CREATE VIEW GoodTechnician AS
SELECT FirstName, LastName FROM Technician t
		INNER JOIN Employee e
		ON t.personID = e.personID
		INNER JOIN PersonInHospital p
		ON t.personID = p.personID
WHERE skill IS NOT NULL;

#4 CareCenter-Beds: This view returns the name for each Care Center along with the number of beds that are assigned to patients (occupied beds), the number of beds not assigned to patients (free beds), and the total number of beds. 


#5 OutPatientsNotVisited: This view returns all OutPatients who have not been visited by a Physician yet.
CREATE VIEW OutPatientsNotVisited AS
SELECT personID FROM Outpatient o
		INNER JOIN Visit v
		ON o.personID = v. personID
WHERE VisitDate IS NULL;

#Create the following Queries. Feel free to use any of the views that you created
#1 For each Job Class list all the staff members belonging to this class.
SELECT JobClass, FirstName, LastName FROM Staff s
		INNER JOIN Employee e
		ON e.personID = s.personID
		INNER JOIN PersonInHospital p
		ON p.personID = s.personID;

#2 Find all Volunteers who do not have any skills.
SELECT FirstName, LastName FROM Volunteer v
		INNER JOIN PersonInHospital p
		ON v.personID = p.personID
WHERE Skill IS NULL;

#3 List all Patients who are also Volunteers at the Hospital.
SELECT FirstName, LastName FROM Patient pa
    INNER JOIN PersonInHospital p
    ON p.personID = pa.personID
WHERE pa.personID IN (
    SELECT personID FROM Volunteer
);

#4 Find each Outpatient who has been visited exactly once.
SELECT FirstName, LastName FROM Outpatient o
		INNER JOIN Patient pa
		ON o.personID = pa.personID
		INNER JOIN PersonInHospital p
		ON o.personID = p.personID
		INNER JOIN Visit v
		ON o.personID = v.personID
WHERE 

#5  each Skill list the total number of volunteers and technicians that achieve this skill.


#6 Find all Care Centers where every bed is assigned to a Patient (i.e. no beds are available).
SELECT c.Name FROM CareCenter c
		INNER JOIN Room rm
		ON c.Name = rm.Name
		INNER JOIN Bed b
		ON b.RoomNum = rm.RoomNum
WHERE b.BedNum NOT IN (
		SELECT BedNum FROM Bed b
			LEFT JOIN Resident r
			ON r.personID = b.personID
		WHERE r.personID IS NULL
);

#7 List all Nurses who have an RN certificate but are not in charge of a Care Center. 
SELECT FirstName, LastName FROM RegisteredNurse rn
		INNER JOIN Nurse n
		ON rn.personID = n.personID
		INNER JOIN Employee e
		ON rn.personID = e.personID
INNER JOIN PersonInHospital p
		ON rn.personID = p.personID
WHERE r.personID NOT IN (
		SELECT personID FROM CareCenter
	);

#8 List all Nurses that are in charge of a Care Center to which they are also assigned.

#9 List all Laboratories, where all assigned technicians to that laboratory achieve at least one skill.

#10 List all Resident patients that were admitted after the most current employee hire date.
SELECT FirstName, LastName FROM Resident r
		INNER JOIN Patient pa
		ON r.personID = pa.personID
		INNER JOIN PersonInHospital p
		ON r.personID = p.personID
WHERE AdmittedDate > (
		SELECT MAX(HireDate) FROM Employee
	);

#11 Find all Patients who have been admitted within one week of their Contact Date. 
SELECT FirstName, LastName FROM Patient pa
		INNER JOIN Resident r
		ON r.personID = pa.personID
		INNER JOIN PersonInHospital p
		ON pa.personID = p.personID
WHERE ABS(DATEDIFF(AdmittedDate, ContactDate)) <= 7;

#12 Find all Outpatients who have not been visited by a Physician within one week of their Contact Date.
SELECT FirstName, LastName FROM Outpatient o
		INNER JOIN Patient pa
		ON o.personID = pa.personID
		INNER JOIN PersonInHospital p
		ON o.personID = p.personID
		INNER JOIN Visit v
		ON o.personID = v.personID
WHERE 

#13 List all Physicians who have made more than 3 visits on a single day.


#14 List all Physicians that are responsible for more Outpatients than Resident Patients.
SELECT FirstName, LastName FROM Physician ph
		INNER JOIN PersonInHospital p
		ON p.personID = ph.personID
		INNER JOIN Patient pa
		ON pa.physID = ph.personID
		INNER JOIN Outpatient o
		ON pa.personID = o.personID
		INNER JOIN Resident r
		ON pa.personID = r.personID
GROUP BY FirstName, LastName
HAVING COUNT(o.personID) > COUNT(r.personID);

#15 Find each Physician who visited an Outpatient for whom he or she was not responsible for.
SELECT FirstName, LastName FROM Physician ph
		INNER JOIN PersonInHospital p
		ON p.personID = ph.personID
		INNER JOIN Patient pa
		ON pa.physID = ph.personID
		RIGHT JOIN Visit v
		ON v.physID = ph.personID
WHERE pa.personID IS NULL;
	

#16 Three more queries that involve the business rules that you added. Feel free to create more views for this.
SELECT c.Name, COUNT(rm.RoomNum)  FROM CareCenter c
		INNER JOIN Room rm
		ON c.Name = rm.Name
GROUP BY c.Name;

SELECT v.FirstName, v.LastName, c.Name FROM CareCenter c
		INNER JOIN Volunteer v
		ON c.Name = v.Name
		INNER JOIN PersonInHospital p
		ON p.personID = v.personID;
	
SELECT r.FirstName, r.LastName, Status FROM Resident r
		INNER JOIN Patient pa
		ON pa.personID = r.personID
		INNER JOIN PersonInHospital p
		ON p.personID = r.personID;
	
		

