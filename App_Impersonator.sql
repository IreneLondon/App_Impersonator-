-- Think about a calculating salary app and how it functions without task deductions. This query is an app impersonator.
-- The sole aim is to write SQL queries and statements to mimic app interactions. 
-- These statements and queries include; 
-- Creating a table to store the data.
-- Inserting data rows in the multiple tables.
-- Using an Update to emulate what happens when you edit the data in the app.
-- Using a DELETE to emulate what happens when you delete data in the app.

-- The database includes three tables namely task_deadline, workers, and quality_of_work.
-- The task_deadline table contains names of workers, names of tasks, and hours assigned.
-- Workers table also contained names, age, department, gender, and address of workers.
-- Finally, the quality_of_work table contained days worked, hours worked and task status whether completed or pending.


-- Salary Calculation App

CREATE DATABASE salary_payment;
USE salary_payment;

CREATE TABLE  workers (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name TEXT,
    age INTEGER,
    department TEXT,
    gender TEXT,
	address TEXT(225));
    
INSERT INTO workers (name,age,department,gender,address) VALUES ("Jen Rimona", 45, "Engineering","Female", "Accra");
INSERT INTO workers (name,age,department,gender,address) VALUES ("Dona Cherry", 38, "DataScience","Female","Kumasi");
INSERT INTO workers (name,age,department,gender,address) VALUES ("Kamelia Prada", 31,"Marketing","Female" ,"Accra");
INSERT INTO workers (name,age,department,gender,address) VALUES ("Penny DiKaprio", 61, "Art","Male","Takoradi" );
INSERT INTO workers (name,age,department,gender,address) VALUES ("Thomas Carr", 33, "Engineering","Male","Takoradi");
INSERT INTO workers (name,age,department,gender,address) VALUES ("Mensah Arthur", 38, "Art","Male","Kumasi");
INSERT INTO workers (name,age,department,gender,address) VALUES ("Yaw Konadu", 20,"Art", "Male","Accra");
INSERT INTO workers (name,age,department,gender,address) VALUES ("Efia Kakari", 22, "Art","Female","Accra");
INSERT INTO workers (name,age,department,gender,address) VALUES ("Kwame Carr", 33, "Engineering","Male","Takoradi");
INSERT INTO workers (name,age,department,gender,address) VALUES ("kweku Arthur", 38, "Marketing","Male","Kumasi");
INSERT INTO workers (name,age,department,gender,address) VALUES ("Yaw Konadu", 20,"Marketing","Female","Accra");
INSERT INTO workers (name,age,department,gender,address) VALUES ("Kofi Kakari", 22, "DataScience","Male","Takoradi");    
    
CREATE TABLE quality_of_work (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    days_worked INTEGER,
	hrs_worked INTEGER,
    task_status TEXT);
    
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (20, 10,"Completed");
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (15, 8,"Pending");
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (8, 8,"Completed");
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (27, 10,"Completed");   
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status)VALUES (25, 5,"Pending");
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (17, 5,"Pending");
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (18, 10,"Pending");
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (12, 8,"Completed");  
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (13, 7,"Pending");
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (15, 7,"Completed");
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (15, 6,"Pending");
INSERT INTO quality_of_work (days_worked, hrs_worked,task_status) VALUES (25, 12,"Pending");          
    
CREATE TABLE  task_deadline (id INTEGER PRIMARY KEY AUTO_INCREMENT,name TEXT,name_of_task TEXT,hrs_assigned INTEGER);

INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Jen Rimona","repair light", 12  );
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Dona Cherry","clean dataset", 10  );
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Kamelia Prada","make a poster", 4  );  
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Penny DiKaprio","design a pot", 15  );  
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Thomas Carr","trouble shoot genset", 6  );
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Mensah Arthur","design a pot", 12  );  
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Yaw Konadu","launch a campaign", 8  );  
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Efia Kakari","bead making ", 6 );  
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Kwame Carr","insulation test of rotors" , 8 );  
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("kweku Arthur","develop add campagin", 6  );
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Yaw Konadu","repair light", 7  );  
INSERT INTO task_deadline (name,name_of_task,hrs_assigned) VALUES("Kofi Kakari","K-means cluserting project", 12  );     
           
           
-- QUerying Tables
SELECT * FROM task_deadline;
SELECT * FROM workers;
SELECT * FROM quality_of_work;

-- Counting unique entries
SELECT count(DISTINCT address),count(name) as total_workers,count(DISTINCT department) FROM workers;

-- min age
SELECT min(age) as MIN_AGE FROM workers;

-- max age
SELECT max(age) as Max_AGE FROM workers;


-- MAX HRS ASSIGNED 
SELECT MAX(hrs_assigned) AS 'MAX HRS ASSIGNED' FROM task_deadline;
-- MIN HOURS ASSIGNED
SELECT MIN(hrs_assigned) AS 'MIN HRS ASSIGNED' FROM task_deadline;

-- HOW MANY WORKERS ARE IN ART DEPARTMENT AND STAYS IN ACCRA
SELECT name,department,address FROM workers WHERE department = 'Art' AND address = 'Accra';

-- WHAT IS THE AVERAGE HOURS EACH DEPARTMENT FINISHES A TASK
SELECT a.department,Task_status,avg(hrs_worked)
FROM workers a
JOIN quality_of_work 
ON a.id = quality_of_work.id 
JOIN workers b
ON b.id = quality_of_work.id
GROUP BY department
HAVING task_status = 'Completed';

-- WHAT IS THE SALARY FOR PERSON WITH THE MAX HRS WORKED. IF AN HOURS RATE IS 13.53 GHANA CEDI 
SELECT (max(hrs_worked) * 13.53 * days_worked) AS MAX_SALARY FROM quality_of_work WHERE task_status = 'Completed';

SELECT name, (max(d.hrs_worked) * 13.53 * d.days_worked) AS MAX_SALARY
FROM quality_of_work c
JOIN workers v
ON  c.id =  v.id
JOIN quality_of_work d
ON v.id = d.id
WHERE c.task_status = 'completed';

-- WHAT IS THE AVERAGE SALARY TO BE PAID FOR ART DEPARTMENT AND ENGINEERING
SELECT a.department,avg(hrs_worked * 13.53 * days_worked) AS AVERAGE_SALARY
FROM workers a
JOIN quality_of_work 
ON a.id = quality_of_work.id 
JOIN workers b
ON b.id = quality_of_work.id
GROUP BY department;
-- HAVING task_status = 'Completed';

-- MAX SALARY
SELECT a.department,MAX(hrs_worked * 13.53 * days_worked) AS MAX_SALARY
FROM workers a
JOIN quality_of_work 
ON a.id = quality_of_work.id 
JOIN workers b
ON b.id = quality_of_work.id
GROUP BY department;

-- MIN SALARY
SELECT a.department,MIN(hrs_worked * 13.53 * days_worked) AS MIN_SALARY
FROM workers a
JOIN quality_of_work 
ON a.id = quality_of_work.id 
JOIN workers b
ON b.id = quality_of_work.id
GROUP BY department;

-- name of person,name of task and department
SELECT a.name,a.department,c.name_of_task
FROM workers a
JOIN task_deadline c
ON a.name = c.name
JOIN workers b
ON b.name = c.name
GROUP BY name;

-- name of task, name of worker age and and days worked 
SELECT a.name,a.age,a.department,c.name_of_task,days_worked
FROM workers a
JOIN task_deadline c
ON a.name = c.name
JOIN workers b
ON b.name = c.name
JOIN quality_of_work d
ON b.id = d.id
GROUP BY name;

-- HOURS ASSIGNED AND HOURS WORKED
SELECT c.name,c.hrs_assigned, a.hrs_worked
FROM quality_of_work a
JOIN task_deadline c
ON a.id = c.id
JOIN quality_of_work b
ON b.id = c.id
GROUP BY name;

-- quality_of_work-- min salary
SELECT * -- a.name,min(b.hrs_worked) * 13.53  AS MIN_SALARY
FROM workers a
JOIN quality_of_work b
ON a.id = b.id
JOIN workers c
ON b.id = c.id;

-- Updating/editing data
UPDATE task_deadline SET name_of_task = 'electrical repairs' WHERE id = 1;

-- Deleting data
DELETE FROM workers WHERE id = 8;
