-- Question No 1 */ alumni database created
CREATE DATABaSE alumni;
-- For Question No2 attached all .csv file in alumni table 
USE alumni;

-- Question No 3
DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

-- Question No 6
CREATE OR REPLACE VIEW college_a_hs_v as
SELECT * FROM college_a_hs
WHERE RollNo IS NOT NULL
AND LastUpdate IS NOT NULL
AND Name IS NOT NULL
AND FatherName IS NOT NULL
AND MotherName IS NOT NULL
AND Batch IS NOT NULL
AND Degree IS NOT NULL
AND PresentStatus IS NOT NULL
AND EntranceExam IS NOT NULL
AND HSDegree IS NOT NULL
AND Institute IS NOT NULL
AND Location IS NOT NULL;

/* Show the View college_a_hs_v */

SELECT * FROM college_a_hs_v;

-- Question No 7

CREATE OR REPLACE VIEW college_a_se_v as
SELECT * FROM college_a_se
WHERE RollNo IS NOT NULL
AND LastUpdate IS NOT NULL
AND Name IS NOT NULL
AND FatherName IS NOT NULL
AND MotherName IS NOT NULL
AND Batch IS NOT NULL
AND Degree IS NOT NULL
AND PresentStatus IS NOT NULL
AND Organization IS NOT NULL
AND Location IS NOT NULL;

/* Show the view college_a_se_v */

SELECT * FROM college_a_se_v;

-- Question No 8
CREATE OR REPLACE VIEW college_a_sj_v as
SELECT * FROM college_a_sj
WHERE RollNo IS NOT NULL
AND LastUpdate IS NOT NULL
AND Name IS NOT NULL
AND FatherName IS NOT NULL
AND MotherName IS NOT NULL
AND Batch IS NOT NULL
AND Degree IS NOT NULL
AND PresentStatus IS NOT NULL
AND Organization IS NOT NULL
AND Designation IS NOT NULL
AND Location IS NOT NULL;

/* Show the view college_a_sj_v */

SELECT * FROM college_a_sj_v;

-- Question No 9
CREATE OR REPLACE VIEW college_b_hs_v as
SELECT * FROM college_b_hs
WHERE RollNo IS NOT NULL
AND LastUpdate IS NOT NULL
AND Name IS NOT NULL
AND FatherName IS NOT NULL
AND MotherName IS NOT NULL
AND Branch IS NOT NULL
AND Batch IS NOT NULL
AND Degree IS NOT NULL
AND PresentStatus IS NOT NULL
AND HSDegree IS NOT NULL
AND EntranceExam IS NOT NULL
AND Institute IS NOT NULL
AND Location IS NOT NULL;

/* Show the view college_b_hs_v */

SELECT * FROM college_b_hs_v;

-- Question No 10 

/* Show the table college_b_se */

SELECT * FROM college_b_se;

/* Create View college_b_se_v */

CREATE OR REPLACE VIEW college_b_se_v as
SELECT * FROM college_b_se
WHERE RollNo IS NOT NULL
AND LastUpdate IS NOT NULL
AND Name IS NOT NULL
AND FatherName IS NOT NULL
AND MotherName IS NOT NULL
AND Branch IS NOT NULL
AND Batch IS NOT NULL
AND Degree IS NOT NULL
AND PresentStatus IS NOT NULL
AND Organization IS NOT NULL
AND Location IS NOT NULL;

/* Show the view college_b_se_v */

SELECT * FROM college_b_se_v;

-- 	Question No 11

CREATE OR REPLACE VIEW college_b_sj_v as
SELECT * FROM college_b_sj
WHERE RollNo IS NOT NULL
AND LastUpdate IS NOT NULL
AND Name IS NOT NULL
AND FatherName IS NOT NULL
AND MotherName IS NOT NULL
AND Branch IS NOT NULL
AND Batch IS NOT NULL
AND Degree IS NOT NULL
AND PresentStatus IS NOT NULL
AND Organization IS NOT NULL
AND Designation IS NOT NULL
AND Location IS NOT NULL;

/* Show the View college_b_sj_v */

SELECT * FROM college_b_sj;

-- Question No 12
/* 1. college_a_hs_v */

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_a_hs_v;

/* 2. college_a_se_v */

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_a_se_v;

/* 3. college_a_sj_v */

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_a_sj_v;

/* 4. college_b_hs_v */

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_b_hs_v;

/* 5. college_b_se_v */

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_b_se_v;

/* 6. college_b_sj_v */

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_b_sj_v;

-- Question No 14
DROP PROCEDURE get_name_collegeA;
 DELIMITER //
 CREATE PROCEDURE get_name_collegeB  (  INOUT name1 TEXT(40000) ) 
 BEGIN   
 DECLARE na INT DEFAULT 0;  
 DECLARE namelist VARCHAR(16000) DEFAULT "";    
 DECLARE namedetail   CURSOR FOR  SELECT Name FROM college_b_hs  
 UNION   SELECT Name FROM college_b_se   
 UNION   SELECT Name FROM college_b_sj;    
 DECLARE CONTINUE HANDLER   FOR NOT FOUND SET na =1;   
 OPEN namedetail;    
 getame :  LOOP  
 FETCH FROM namedetail INTO namelist;  IF na = 1 THEN  LEAVE getame;  
 END IF;  
 SET name1 = CONCAT(namelist,";",name1);   
 END LOOP getame;  
 CLOSE namedetail; 
 END //
 
 DELIMITER ;

SET @Name = "";
CALL get_name_collegeB(@Name);
SELECT @Name Name;

-- Question No 15
DROP PROCEDURE get_name_collegeB;
 DELIMITER //
 CREATE PROCEDURE get_name_collegeB (  INOUT Fname TEXT(40000) ) 
 BEGIN  
 DECLARE finished INT DEFAULT 0;  DECLARE Fnamelist VARCHAR (16000) DEFAULT "";    
 DECLARE Fnamedetails  CURSOR FOR  SELECT name FROM college_b_hs  
 UNION ALL  SELECT name FROM college_b_se  
 UNION ALL  SELECT name FROM college_b_sj;   
 DECLARE CONTINUE HANDLER  FOR NOT FOUND SET finished=1;    
 OPEN Fnamedetails;  getname2:  LOOP  
 FETCH Fnamedetails INTO Fnamelist;  IF finished =1 THEN   LEAVE getname2;  
 END IF;    
 SET Fname = CONCAT  (Fnamelist,";",Fname);    
 END LOOP getname2;    
 CLOSE Fnamedetails;   
 END//
 DELIMITER ;

SET @name2="";
CALL get_name_collegeB(@name2);
SELECT @name2 Name;

-- Question N0 16
SELECT 'Higher Studies' ,
(SELECT count(*) FROM college_a_hs)/
((SELECT count(*) FROM college_a_hs)+(SELECT count(*) FROM college_a_se)+(SELECT count(*) FROM college_a_sj)) * 100
College_A_Percentage,
(SELECT count(*) FROM college_b_hs)/
((SELECT count(*) FROM college_b_hs)+(SELECT count(*) FROM college_b_se)+(SELECT count(*) FROM college_b_sj)) * 100
College_B_Percentage
UNION
SELECT 'Self Employed' ,
(SELECT count(*) FROM college_a_se)/
((SELECT count(*) FROM college_a_se)+(SELECT count(*) FROM college_a_hs)+(SELECT count(*) FROM college_a_sj)) * 100
College_A_Percentage ,
(SELECT count(*) FROM college_b_se)/
((SELECT count(*) FROM college_b_hs)+(SELECT count(*) FROM college_b_se)+(SELECT count(*) FROM college_b_sj)) * 100
College_B_Percentage
UNION
SELECT 'Service Job' ,
(SELECT count(*) FROM college_a_sj)/
((SELECT count(*) FROM college_a_hs)+(SELECT count(*) FROM college_a_se)+(SELECT count(*) FROM college_a_sj)) * 100
College_A_Percentage ,
(SELECT count(*) FROM college_b_sj)/
((SELECT count(*) FROM college_b_hs)+(SELECT count(*) FROM college_b_se)+(SELECT count(*) FROM college_b_sj)) * 100
College_B_Percentage ;
