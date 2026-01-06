create database crimedatabase;
use crimedatabase;

CREATE TABLE PoliceStation (
    StationID INT PRIMARY KEY,
    StationName VARCHAR(50),
    Location VARCHAR(50),
    ContactNo VARCHAR(15)
);

CREATE TABLE Officer (
    OfficerID INT PRIMARY KEY,
    OfficerName VARCHAR(50),
    OfficerRank VARCHAR(30),
    StationID INT,
    FOREIGN KEY (StationID) REFERENCES PoliceStation(StationID)
);

CREATE TABLE Criminal (
    CriminalID INT PRIMARY KEY,
    CriminalName VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    Address VARCHAR(100),
    CrimeType VARCHAR(50)
);

CREATE TABLE Victim (
    VictimID INT PRIMARY KEY,
    VictimName VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    Address VARCHAR(100)
);

CREATE TABLE Crime (
    CrimeID INT PRIMARY KEY,
    CrimeType VARCHAR(50),
    CrimeDate DATE,
    Location VARCHAR(50),
    OfficerID INT,
    CriminalID INT,
    VictimID INT,
    FOREIGN KEY (OfficerID) REFERENCES Officer(OfficerID),
    FOREIGN KEY (CriminalID) REFERENCES Criminal(CriminalID),
    FOREIGN KEY (VictimID) REFERENCES Victim(VictimID)
);

CREATE TABLE FIR (
    FIRID INT PRIMARY KEY,
    CrimeID INT,
    FIRDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

CREATE TABLE Evidence (
    EvidenceID INT PRIMARY KEY,
    CrimeID INT,
    EvidenceType VARCHAR(50),
    Description VARCHAR(100),
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

INSERT INTO PoliceStation VALUES
(1, 'Central Station', 'Chennai', '9876543210'),
(2, 'North Station', 'Delhi', '9876501234'),
(3, 'East Station', 'Mumbai', '9812345678'),
(4, 'West Station', 'Bangalore', '9898989898'),
(5, 'South Station', 'Hyderabad', '9123456789'),
(6, 'Hill Station', 'Ooty', '9789012345'),
(7, 'River Station', 'Kolkata', '9678901234'),
(8, 'Lake Station', 'Jaipur', '9901234567'),
(9, 'Town Station', 'Coimbatore', '9988776655'),
(10, 'Metro Station', 'Pune', '9112233445'),
(11, 'City Station', 'Lucknow', '9123409876'),
(12, 'Park Station', 'Bhopal', '9988223344'),
(13, 'Harbor Station', 'Goa', '9999111222'),
(14, 'Forest Station', 'Wayanad', '9456123789'),
(15, 'Valley Station', 'Shimla', '9123904567'),
(16, 'Bridge Station', 'Patna', '9543216789'),
(17, 'Airport Station', 'Kochi', '9234567890'),
(18, 'Rail Station', 'Nagpur', '9345678912'),
(19, 'Market Station', 'Indore', '9123098765'),
(20, 'Fort Station', 'Mysore', '9789123456');

SELECT * FROM PoliceStation

INSERT INTO Officer VALUES
(1, 'Arun Kumar', 'Inspector', 1),
(2, 'Meena Devi', 'Sub-Inspector', 1),
(3, 'Rajesh Nair', 'Constable', 2),
(4, 'Priya Das', 'Inspector', 3),
(5, 'Rohit Menon', 'Constable', 3),
(6, 'Sneha Patil', 'Inspector', 4),
(7, 'Vijay Rao', 'Sub-Inspector', 4),
(8, 'Kiran Lal', 'Constable', 5),
(9, 'Sunil Reddy', 'Inspector', 6),
(10, 'Geetha Iyer', 'Constable', 7),
(11, 'Naveen Bhat', 'Sub-Inspector', 8),
(12, 'Asha Gill', 'Inspector', 9),
(13, 'Deepak Joshi', 'Constable', 10),
(14, 'Lakshmi Roy', 'Inspector', 11),
(15, 'Manoj Singh', 'Sub-Inspector', 12),
(16, 'Rita Paul', 'Inspector', 13),
(17, 'Gopal Verma', 'Constable', 14),
(18, 'Anita Sharma', 'Inspector', 15),
(19, 'Karthik Rao', 'Sub-Inspector', 16),
(20, 'Neha Mehta', 'Inspector', 17);

SELECT * FROM Officer 

INSERT INTO Criminal VALUES
(1, 'Ravi', 'Male', 28, 'Chennai', 'Theft'),
(2, 'Manoj', 'Male', 35, 'Delhi', 'Robbery'),
(3, 'Sita', 'Female', 30, 'Mumbai', 'Fraud'),
(4, 'Hari', 'Male', 40, 'Bangalore', 'Murder'),
(5, 'Rekha', 'Female', 25, 'Hyderabad', 'Theft'),
(6, 'Ramesh', 'Male', 38, 'Pune', 'Cyber Crime'),
(7, 'Arjun', 'Male', 29, 'Chennai', 'Robbery'),
(8, 'Kiran', 'Male', 31, 'Goa', 'Smuggling'),
(9, 'Divya', 'Female', 27, 'Kolkata', 'Fraud'),
(10, 'Vijay', 'Male', 45, 'Lucknow', 'Murder'),
(11, 'Nisha', 'Female', 32, 'Indore', 'Theft'),
(12, 'Kamal', 'Male', 29, 'Coimbatore', 'Cyber Crime'),
(13, 'Pooja', 'Female', 26, 'Nagpur', 'Theft'),
(14, 'Suresh', 'Male', 33, 'Jaipur', 'Smuggling'),
(15, 'Rita', 'Female', 24, 'Bhopal', 'Fraud'),
(16, 'Anil', 'Male', 36, 'Mysore', 'Robbery'),
(17, 'Gowri', 'Female', 28, 'Ooty', 'Murder'),
(18, 'Kishore', 'Male', 42, 'Patna', 'Cyber Crime'),
(19, 'Mala', 'Female', 35, 'Kochi', 'Fraud'),
(20, 'Surya', 'Male', 39, 'Wayanad', 'Robbery');

SELECT * FROM Criminal

INSERT INTO Victim VALUES
(1, 'Anita', 'Female', 29, 'Chennai'),
(2, 'Ravi', 'Male', 33, 'Delhi'),
(3, 'Preeti', 'Female', 27, 'Mumbai'),
(4, 'Ajay', 'Male', 45, 'Bangalore'),
(5, 'Nila', 'Female', 30, 'Hyderabad'),
(6, 'Aravind', 'Male', 39, 'Goa'),
(7, 'Kavya', 'Female', 24, 'Pune'),
(8, 'Rohit', 'Male', 28, 'Jaipur'),
(9, 'Divya', 'Female', 32, 'Kolkata'),
(10, 'Sanjay', 'Male', 31, 'Lucknow'),
(11, 'Meera', 'Female', 26, 'Bhopal'),
(12, 'Vikram', 'Male', 34, 'Patna'),
(13, 'Latha', 'Female', 22, 'Indore'),
(14, 'Naveen', 'Male', 41, 'Nagpur'),
(15, 'Swathi', 'Female', 25, 'Shimla'),
(16, 'Deepa', 'Female', 29, 'Kochi'),
(17, 'Suresh', 'Male', 37, 'Ooty'),
(18, 'Kiran', 'Male', 33, 'Mysore'),
(19, 'Renu', 'Female', 27, 'Coimbatore'),
(20, 'Prakash', 'Male', 35, 'Goa');

SELECT * FROM Victim

INSERT INTO Crime VALUES
(1, 'Theft', '2024-01-15', 'Chennai', 1, 1, 1),
(2, 'Robbery', '2024-02-10', 'Delhi', 3, 2, 2),
(3, 'Fraud', '2024-03-05', 'Mumbai', 4, 3, 3),
(4, 'Murder', '2024-03-25', 'Bangalore', 6, 4, 4),
(5, 'Theft', '2024-04-02', 'Hyderabad', 8, 5, 5),
(6, 'Cyber Crime', '2024-05-18', 'Pune', 13, 6, 7),
(7, 'Smuggling', '2024-06-21', 'Goa', 16, 8, 6),
(8, 'Fraud', '2024-07-10', 'Kolkata', 10, 9, 9),
(9, 'Murder', '2024-08-01', 'Lucknow', 14, 10, 10),
(10, 'Theft', '2024-08-12', 'Indore', 12, 11, 13),
(11, 'Cyber Crime', '2024-09-15', 'Coimbatore', 19, 12, 19),
(12, 'Theft', '2024-10-01', 'Nagpur', 13, 13, 14),
(13, 'Smuggling', '2024-10-05', 'Jaipur', 11, 14, 8),
(14, 'Fraud', '2024-10-08', 'Bhopal', 15, 15, 11),
(15, 'Robbery', '2024-10-11', 'Mysore', 18, 16, 18),
(16, 'Murder', '2024-10-15', 'Ooty', 9, 17, 17),
(17, 'Cyber Crime', '2024-10-17', 'Patna', 19, 18, 12),
(18, 'Fraud', '2024-10-20', 'Kochi', 20, 19, 16),
(19, 'Robbery', '2024-10-22', 'Wayanad', 18, 20, 15),
(20, 'Theft', '2024-10-25', 'Chennai', 1, 1, 1);

SELECT * FROM Crime

INSERT INTO FIR VALUES
(1, 1, '2024-01-16', 'Closed'),
(2, 2, '2024-02-11', 'Ongoing'),
(3, 3, '2024-03-06', 'Closed'),
(4, 4, '2024-03-26', 'Closed'),
(5, 5, '2024-04-03', 'Ongoing'),
(6, 6, '2024-05-19', 'Closed'),
(7, 7, '2024-06-22', 'Ongoing'),
(8, 8, '2024-07-11', 'Closed'),
(9, 9, '2024-08-02', 'Ongoing'),
(10, 10, '2024-08-13', 'Closed'),
(11, 11, '2024-09-16', 'Closed'),
(12, 12, '2024-10-02', 'Closed'),
(13, 13, '2024-10-06', 'Ongoing'),
(14, 14, '2024-10-09', 'Closed'),
(15, 15, '2024-10-12', 'Ongoing'),
(16, 16, '2024-10-16', 'Closed'),
(17, 17, '2024-10-18', 'Ongoing'),
(18, 18, '2024-10-21', 'Closed'),
(19, 19, '2024-10-23', 'Ongoing'),
(20, 20, '2024-10-26', 'Closed');

SELECT * FROM FIR

INSERT INTO Evidence VALUES
(1, 1, 'CCTV', 'Video footage'),
(2, 2, 'Witness', 'Eye witness'),
(3, 3, 'Documents', 'Fake papers'),
(4, 4, 'Weapon', 'Knife found'),
(5, 5, 'CCTV', 'Shop footage'),
(6, 6, 'Email', 'Hacked mails'),
(7, 7, 'Package', 'Seized goods'),
(8, 8, 'Bank record', 'Fake transfer'),
(9, 9, 'Fingerprint', 'Found at site'),
(10, 10, 'CCTV', 'House camera'),
(11, 11, 'System log', 'Login data'),
(12, 12, 'Photo', 'Suspect image'),
(13, 13, 'Vehicle', 'Truck seized'),
(14, 14, 'Note', 'Written confession'),
(15, 15, 'Bag', 'Looted items'),
(16, 16, 'Weapon', 'Gun recovered'),
(17, 17, 'File', 'Cyber proof'),
(18, 18, 'CCTV', 'ATM video'),
(19, 19, 'Knife', 'Found nearby'),
(20, 20, 'CCTV', 'Footpath clip');

SELECT * FROM Evidence

---------------------------------------------------------------------------------------------------

SELECT:

1. Display_all_details_from_crime_table
SELECT * FROM Crime;

2.Show_all_female_victims
SELECT * FROM Victim WHERE Gender='Female';

3.List_all_crimes_that_happened_in_Chennai
SELECT * FROM Crime WHERE Location='Chennai';

---------------------------------------------------------------------------------------------------

WHERE + ORDER BY:

4.Find_crime_rates_that_happened_after_'2024-06-01'
SELECT * FROM Crime WHERE Crimedate>'2024-06-01';

5.List_officers_whoses_rank_is_'Inspector'_in_ascending_order_of_name
SELECT * FROM Officer WHERE OfficerRank='Inspector' ORDER BY OfficerName asc;

6.Display_all_FIRs_whose_status_is_'Ongoing'
SELECT * FROM FIR WHERE Status='Ongoing';

--------------------------------------------------------------------------------------------------

GROUP BY / AGGREGATION:

7.Count_total_crimes_per_crime_type
SELECT CrimeType, COUNT(*) AS Total_Crimes 
FROM Crime 
GROUP BY CrimeType;

8.Get_total_number_of_'Closed'_and_'Ongoing' FIRs
SELECT Status, COUNT(*) AS TotalFIRS
FROM FIR
GROUP BY Status;

9.Count_number_of_crimes_pers_location
SELECT Location, COUNT(*) AS TotalCrimes
FROM Crime
GROUP BY Location;

10.Count_number_of_FIRs_by_their_Status
SELECT Status, COUNT(*) AS TotalFIRs
FROM FIR
GROUP BY Status;

--------------------------------------------------------------------------------------------------

INBUILT FUNCTIONS:

11.Display_all_officer_names_in_upper_case
SELECT UPPER(OfficerName) FROM Officer;

12.Show_length_of_each_police_station
SELECT StationName, LENGTH(StationName) AS NameLength
FROM PoliceStation;

13.Get_average_age_of_all_criminals
SELECT AVG(Age) as Average_age
FROM Criminal;

--------------------------------------------------------------------------------------------------

CONDITION FUNCTION(IF/CASE);

14.Use CASE to show crime severity:
“Murder” → ‘High’
“Robbery” → ‘Medium’
Others → ‘Low’

SELECT CrimeID, CrimeType,
CASE
WHEN CrimeType='Murder' THEN 'High'
WHEN CrimeType='Robbery' THEN 'Medium'
ELSE 'Low'
END AS 'Severity'
FROM CRIME;

15.Use_IF_to_check_if_FIR_status = ‘Closed’, display “Solved”, else “Pending”.
SELECT FIRID, Status,
IF(Status='Closed','Solved','Pending') AS FIR_Status
FROM FIR;

--------------------------------------------------------------------------------------------------

STORED PROCEDURES:

16.Stored_procedure_to_get_crimes_by_type
Delimiter $$
CREATE PROCEDURE GetCrimeByTypee( IN type_name VARCHAR(50))
BEGIN
	SELECT * FROM Crime WHERE CrimeType=type_name;
END $$
DELIMITER ;
CALL GetCrimeByTypee('Theft');
CALL GetCrimeByTypee('Cyber Crime');
CALL GetCrimeByTypee('Robbery');
CALL GetCrimeByTypee('Smuggling');
CALL GetCrimeByTypee('Murder');


17.Stored_procedure_to_get_crime_details_by_officer_name

DELIMITER $$
CREATE PROCEDURE GetCrimebyOfficer (IN Officer_Name varchar(30))
BEGIN
	SELECT C.CrimeID, C.CrimeType, C.CrimeDate, C.Location, O.OfficerName
    FROM Crime AS C
    INNER JOIN Officer AS O ON C.OfficerID=O.OfficerID
    WHERE O.OfficerName=Officer_name;
END $$
DELIMITER ;;
CALL GetCrimebyOfficer('Arun Kumar');
CALL GetCrimebyOfficer('Sneha Patil');
CALL GetCrimebyOfficer('Manoj Singh');
CALL GetCrimebyOfficer('Rita Paul');
CALL GetCrimebyOfficer('Anita Sharma');

---------------------------------------------------------------------------------------------------

JOINS:

18.Show_all_crimes_along_with_the_Officers_name_who_handled_them
SELECT 
	C.CrimeID, 
	C.CrimeType, 
    C.CrimeDate, 
    C.Location, 
    O.OfficerName
FROM 
	Crime AS C
INNER JOIN 
	Officer AS O ON C.OfficerID = O.OfficerID;

19.List_all_victims_with_their_related_criminal_names
SELECT 
	V.VictimName, 
    CR.CriminalName
FROM 
	Victim AS V
INNER JOIN 
	Criminal AS CR ON V.VictimID=CR.CriminalID;

20.Find_all_crimes_handled_by_‘Central Station’_officers
SELECT 
	C.CrimeID, 
    C.CrimeType, 
    O.OfficerName, 
    PS.StationName
FROM 
	Crime AS C
INNER JOIN 
	Officer AS O ON C.OfficerID = O.OfficerID
INNER JOIN 
	PoliceStation AS PS ON O.StationID = PS.StationID
WHERE 
	PS.StationName='Central Station';

21.Display_each_evidence_type_with_the_related_crime_type
SELECT 
	E.EvidenceType, 
	C.CrimeType
FROM 
	Crime as C
INNER JOIN 
	Evidence as E on E.CrimeID = C.CrimeID;

22.Show_all_FIRs_along_with_crime_type_and_victime_name
SELECT 
	F.FIRID, 
    C.CrimeType, 
    V.VictimName, 
    F.Status
FROM 
	FIR AS F
INNER JOIN 
	Crime AS C ON F.CrimeID = C.CrimeID
INNER JOIN 
	Victim AS V ON C.VictimID = V.VictimID;

23.List_all_FIR_details_along_with_the_related_Crime_Type
SELECT 
	F.FIRID, 
    F.FIRDate, 
    C.CrimeType, 
    C.Location
FROM 
	FIR AS F
INNER JOIN 
	CRIME AS C ON F.CrimeID = C.CrimeID;

24.Show_Officer_Names_with_the_Crimes_they_are_handling
SELECT 
	O.OfficerName, 
	C.CrimeType
FROM 
	Officer as O
INNER JOIN 
	CRIME AS C ON O.OfficerID = C.OfficerID;

25.List_FIRs_with_the_Officer_who_handled_each_case
SELECT 
    F.FIRID, 
    F.FIRDate, 
    O.OfficerName
FROM 
    FIR AS F
INNER JOIN 
    Crime AS C ON F.CrimeID = C.CrimeID
INNER JOIN 
    Officer AS O ON C.OfficerID = O.OfficerID;
    
--------------------------------------------------------------------------------------------------

SUBQUERY

26. Find the officers who handled crimes that occurred in 'Chennai'.
	
SELECT OfficerName
FROM Officer
WHERE OfficerID IN (
    SELECT OfficerID 
    FROM Crime
    WHERE Location = 'Chennai'
);

--------------------------------------------------------------------------------------------------
        
