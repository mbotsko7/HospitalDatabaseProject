#Use the Create View statement to create the following views:
#1 Employees-Hired: This view returns the First Name, Last Name, and Date Hired of all Hospital Employees.
CREATE VIEW Employees_Hired AS
SELECT FirstName, LastName, HireDate FROM Employee e
	INNER JOIN PersonInHospital p
	ON p.personID = e.personID;

#2 NursesInCharge: This view returns the name of the Nurse in Charge for each Care Center along with the phone number of the Nurse.
CREATE VIEW NursesInCharge AS
SELECT FirstName, LastName, ContactNumber, cc.Name FROM RegisteredNurse rn
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
CREATE VIEW CareCenterBed AS
SELECT c.Name, COUNT(r.personID) AS "Occupied Beds", COUNT(*) - COUNT(r.personID) AS "Empty Beds", COUNT(*) AS "Total Beds" FROM Bed b
    INNER JOIN Room rm 
    ON rm.RoomNum = b.RoomNum
    INNER JOIN CareCenter c 
    ON c.Name = rm.Name
    LEFT JOIN Resident r 
    ON r.personID = b.personID
GROUP BY c.Name;

#5 OutPatientsNotVisited: This view returns all OutPatients who have not been visited by a Physician yet.
CREATE VIEW OutPatientsNotVisited AS
SELECT FirstName, LastName, o.personID FROM Outpatient o
	INNER JOIN Patient pa
	ON o.personID = pa.personID
	INNER JOIN PersonInHospital p
	ON o.personID = p.personID
	LEFT JOIN Visit v
	ON o.personID = v. personID
WHERE VisitDate IS NULL;

#Create the following Queries. Feel free to use any of the views that you created
#1 For each Job Class list all the staff members belonging to this class.
SELECT FirstName, LastName, JobClass FROM Staff s
	INNER JOIN Employee e
	ON e.personID = s.personID
	INNER JOIN PersonInHospital p
	ON p.personID = s.personID;

#2 Find all Volunteers who do not have any skills.
SELECT FirstName, LastName FROM Volunteer v
		INNER JOIN PersonInHospital p
		ON v.personID = p.personID
WHERE Skill IS NULL;

#3 List all Patients who are also Volunteers at the Hospital. ADD SOMEONE
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
    ON p.personID = pa.personID
    INNER JOIN Visit v
    ON o.personID = v.personID
    GROUP BY LastName, FirstName
HAVING COUNT(v.VisitDate) = 1;

#5  each Skill list the total number of volunteers and technicians that achieve this skill.
SELECT s.Skill, COUNT(*) AS "Number of People With Skill" FROM Skill s
   LEFT JOIN Technician t ON t.Skill = s.Skill
   LEFT JOIN Volunteer v ON v.Skill = s.Skill
GROUP BY s.Skill;

#6 Find all Care Centers where every bed is assigned to a Patient (i.e. no beds are available).
SELECT DISTINCT c.Name FROM CareCenter c
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
WHERE rn.personID NOT IN (
	SELECT personID FROM CareCenter
);

#8 List all Nurses that are in charge of a Care Center to which they are also assigned.
SELECT * FROM NursesInCharge
WHERE personID IN (
	SELECT c.personID FROM CareCenter c
            INNER JOIN Nurse n
            ON n.Name = c.Name
        WHERE n.personID = c.personID
);

#9 List all Laboratories, where all assigned technicians to that laboratory achieve at least one skill.
SELECT Name FROM Laboratory l
WHERE Name NOT IN (
    SELECT l.Name FROM Laboratory l
        INNER JOIN TechnicianLab tl ON l.Name = tl.Name
        INNER JOIN Technician t ON t.personID = tl.personID
    WHERE t.Skill IS NULL
);

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
SELECT * FROM OutPatientsNotVisited
WHERE personID NOT IN (
        SELECT o.personID FROM Outpatient o
               INNER JOIN Patient pa 
               ON pa.personID = o.personID
               INNER JOIN Visit v
               ON v.personID = o.personID
        WHERE ABS(DATEDIFF(v.VisitDate, pa.ContactDate)) <=7
);
#13 List all Physicians who have made more than 3 visits on a single day.
SELECT DISTINCT FirstName, LastName FROM Physician ph
    INNER JOIN PersonInHospital p ON p.personID = ph.personID
    INNER JOIN Visit v ON ph.personID = v.physID
    GROUP BY v.physID, VisitDate
    HAVING COUNT(*) > 3;

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
SELECT FirstName, LastName FROM Patient pa
    INNER JOIN Outpatient o 
    ON o.personID = pa.personID
    INNER JOIN Visit v 
    ON v.personID = o.personID
    INNER JOIN Physician ph 
    ON ph.personID = v.physID
    INNER JOIN PersonInHospital p 
    ON p.personID = ph.personID
WHERE v.physID <> pa.physID
GROUP BY v.physID;
	

#16 Three more queries that involve the business rules that you added. Feel free to create more views for this.
SELECT c.Name AS “Care Center”, COUNT(rm.RoomNum) AS “Number of Rooms”  FROM CareCenter c
	INNER JOIN Room rm
	ON c.Name = rm.Name
GROUP BY c.Name;

SELECT FirstName, LastName, c.Name FROM CareCenter c
	INNER JOIN Volunteer v
	ON c.Name = v.Name
	INNER JOIN PersonInHospital p
	ON p.personID = v.personID;
	
SELECT FirstName, LastName, Status FROM Resident r
	INNER JOIN Patient pa
	ON pa.personID = r.personID
	INNER JOIN PersonInHospital p
	ON p.personID = r.personID
ORDER BY Status, LastName ASC;












CREATE VIEW AS CareCenter-Beds
Select CareCenter.Name, Count(patient.personID) as TotalPatientsInBed, Count(BedNum)-Count(patient.personID), Count(BedNum)
from CareCenter natural join room natural join bed natural join resident
natural join patient

select * from (Nurse natural join CareCenter) where Nurse.personID = CareCenter.fk_NurseInCharge

select * from (Laboratory natural join TechnicianLab natural join Technician)
where Count(Technician.skill) > 0	

