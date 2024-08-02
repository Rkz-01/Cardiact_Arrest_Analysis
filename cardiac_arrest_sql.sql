
-- Created a new columns of Age_group and Cholesterol chol_group

select * from cardiac_arrest

ALTER TABLE cardiac_arrest
ADD Age_group VARCHAR(50);

UPDATE cardiac_arrest
SET Age_group =
    CASE
	    WHEN age BETWEEN 29 AND 38 THEN '29-38'
	    WHEN age BETWEEN 39 AND 48 THEN '39-48'
	    WHEN age BETWEEN 49 AND 58 THEN '49-58'
		WHEN age BETWEEN 58 AND 68 THEN '58-68'
		WHEN age BETWEEN 69 AND 78 THEN '69-78'
		WHEN age > 78 THEN '78-80'
		ELSE 'UNKNOWN'
    END;


ALTER TABLE cardiac_arrest
ADD Chol_group VARCHAR(50);

UPDATE cardiac_arrest
SET Chol_group =
    CASE
	    WHEN chol BETWEEN 126 AND 225 THEN '126-225'
		WHEN chol BETWEEN 226 AND 325 THEN '226-325'
		WHEN chol BETWEEN 326 AND 425 THEN '326-425'
		WHEN chol BETWEEN 426 AND 525 THEN '426-525'
		WHEN chol BETWEEN 526 AND 625 THEN '526-625'
		WHEN chol > 626 THEN '626+'
		ELSE 'UNKNOWN'
	END;


-- thalach group (maximum heart rate) column

ALTER TABLE cardiac_arrest
ADD Thalach_gp VARCHAR(50);

UPDATE cardiac_arrest
SET Thalach_gp =
    CASE 
	    WHEN thalach BETWEEN 71 AND 100 THEN '71-100'
		WHEN thalach BETWEEN 101 AND 130 THEN '101-130'
		WHEN thalach BETWEEN 131 AND 160 THEN '131-160'
		WHEN thalach BETWEEN 161 AND 190 THEN '161-190'
		WHEN thalach BETWEEN 191 AND 220 THEN '191-220'
		WHEN thalach > 220 THEN '220+'
		ELSE 'UNKNOWN'
	END;



-- What age group is most vulnerable or has a large number of patients with a higher risk of heart attack?
SELECT Age_group, 
                 SUM(CASE WHEN target = 0 THEN 1 ELSE 0 END) AS Heart_Attack,
				 SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS NO_Heart_Attack
FROM cardiac_arrest 
GROUP BY Age_group
ORDER BY Age_group;



-- Are men mostly prone to heart attacks or women? (0 - FEMALE AND 1 - MALE)
SELECT sex,
           SUM(CASE WHEN target = 0 THEN 1 ELSE 0 END) AS Heart_Attack,
		   SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS NO_Heart_Attack
FROM cardiac_arrest
GROUP BY sex
ORDER BY sex;



-- What chest pain types pose a severe risk of heart attack?
SELECT cp,
          SUM(CASE WHEN target = 0 THEN 1 ELSE 0 END) AS Heart_Attack,
		  SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS NO_Heart_Attack
FROM cardiac_arrest
GROUP BY cp
ORDER BY cp;



-- How fasting blood sugar is related to heart attack? (0 - FALSE AND 1 - TRUE) IN FASTING BLOOD SUGAR
SELECT fbs,
           SUM(CASE WHEN target = 0 THEN 1 ELSE 0 END) AS Heart_Attack,
		   SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS No_Heart_Attack
FROM cardiac_arrest
GROUP BY fbs
ORDER BY fbs;



-- What type of thalassemia severely leads to heart attack? 
SELECT thal,
            SUM(CASE WHEN target = 0 THEN 1 ELSE 0 END) AS Heart_Attack,
			SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS No_Heart_Attack
FROM cardiac_arrest
GROUP BY thal
ORDER BY thal;



-- Due to cholesterol, how many patients are at higher risk?
SELECT Chol_group,
                  SUM(CASE WHEN target = 0 THEN 1 ELSE 0 END) AS Heart_Attack,
				  SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS No_Heart_Attack
FROM cardiac_arrest
GROUP BY Chol_group
ORDER BY Chol_group;



-- Checking The Maximum Heart Rate(thalach) AND Heart Attacks
SELECT Thalach_gp,
                  SUM(CASE WHEN target = 0 THEN 1 ELSE 0 END) AS Heart_Attack,
				  SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS No_Heart_Attack,
				  COUNT(Thalach_gp) AS thalach_counts
FROM cardiac_arrest
GROUP BY Thalach_gp
ORDER BY Thalach_gp;
  


-- How many patients have different numbers of major vessels colored by fluoroscopy?
SELECT ca,
          SUM(CASE WHEN target = 0 THEN 1 ELSE 0 END) AS Heart_Attack,
		  SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS No_Heart_Attack,
		  COUNT(ca) AS ca_counts
FROM cardiac_arrest
GROUP BY ca
ORDER BY ca;



-- What are the different resting electrocardiographic results and their frequencies?
SELECT restecg,
               SUM(CASE WHEN target = 0 THEN 1 ELSE 0 END) AS Heart_Attack,
			   SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS Heart_Attack,
			   COUNT(restecg) AS restecg_counts
FROM cardiac_arrest
GROUP BY restecg
ORDER BY restecg;


SELECT * FROM cardiac_arrest
