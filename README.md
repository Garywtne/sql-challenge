## Background 

It’s a beautiful spring day, and it’s been two weeks since i was hired as a new data engineer at Pewlett Hackard. My first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remains of the database of employees from that period are six CSV files.

In this assignment, I will design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. 

To achieve this 3 steps need to be performed:

1. [Data Modeling](#data-modeling)
2. [Data Engineering](#data-engineering)
3. [Data Analysis](#data-analysis)

## Preperation 

1. Create a new repository for this project called `sql-challenge`

2. Clone the new repository to your computer.

3. Create a directory called 'EmployeeSQL' 

4. Add the 6 csv files to this folder.

5. Push these changes to GitHub.


## Main Task: <a id="main-task"></a>

## i. Data Modeling <a id="data-modeling"></a>

I started by reviewing the contents of the 6 csv files then sketched out an ERD (Entity Relationship Diagram) using the [QuickDBD](https://www.quickdatabasediagrams.com/) Web App:

I used this tool to list the Tables and thier Fields so that i could identify the Relasionships, Datatypes and Primary Keys.

![ERD_Employee_db_00](https://user-images.githubusercontent.com/85430216/166204754-efb41af9-150c-4ff3-ae5c-2960c13e7c0f.png)


## ii. Data Engineering <a id="data-engineering"></a>

The ERD is refined adding the relasionships between the individual Fields using Foriegn Keys to create a more detailed

![ERD_Employee_db_01](https://user-images.githubusercontent.com/85430216/166204830-2dbd8b52-3c3f-4cf4-9b17-f24c5cf2a0ef.png)


Quick DB creates an SQL which I exported, this code was used to create the Schemata using [pgAdmin](https://www.pgadmin.org/).

The data from each CSV file was imported to it's relevant SQL Table using the import tool. It is very important that the csv files are imported in the same order as the tables are created in the Schemata.

I also had to change the # - Locale and Formatting - datestyle setting in the postgressql.conf to datestyle = 'iso, mdy'  


## iii. Data Analysis <a id="data-analysis"></a>

My employer has asked me to create 8 lists, i created a seperate query for each list, the code and first 8 lines of output is shown below:

1. List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT  e.emp_no,
        e.last_name,
        e.first_name,
        e.sex,
        s.salary
FROM employees as e
    LEFT JOIN saleries as s
    ON (e.emp_no = s.emp_no)
ORDER BY e.last_name;

![Q1](https://user-images.githubusercontent.com/85430216/166204967-6a5dc2cd-e3b6-4723-90ed-67c137f9214d.PNG)

2. List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name,hire_date 
FROM employees
WHERE hire_date 
BETWEEN '1986-01-01' 
AND '1986-12-31'
ORDER BY last_name;

![Q2](https://user-images.githubusercontent.com/85430216/166205016-1e66eb83-8694-4f13-8c61-16a17e156a9a.PNG)

3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name

SELECT	dm.dept_no,
		d.dept_name,
		dm.emp_no,
		e.last_name,
		e.first_name
FROM	dept_manager AS dm
	INNER JOIN departments AS d
	ON (dm.dept_no = d.dept_no)
	INNER JOIN employees AS e
	ON (dm.emp_no = e.emp_no)
ORDER BY d.dept_name;

![Q3](https://user-images.githubusercontent.com/85430216/166205039-221676ea-5883-43bc-bf80-c1a7757bfcb9.PNG)

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT	e.emp_no,
		e.last_name,
		e.first_name,
		d.dept_name
FROM employees AS e
	INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_NO)
	INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
ORDER BY e.last_name;

![Q4](https://user-images.githubusercontent.com/85430216/166205074-f96e27fd-d8b0-4830-89be-b7e087b3eb89.PNG)

5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT	First_name,
		last_name,
		sex
FROM employees
WHERE first_name ='Hercules'
AND last_name LIKE 'B%'
ORDER BY last_name;

![Q5](https://user-images.githubusercontent.com/85430216/166205095-341dff86-808e-4454-a6ca-83322281ba43.PNG)

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT	e.emp_no,
		e.last_name,
		e.first_name,
		d.dept_name
FROM employees AS e
	INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
	INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales'
ORDER BY e.last_name;

![Q6](https://user-images.githubusercontent.com/85430216/166205122-77307537-cf7d-4b99-a350-58915c1d7575.PNG)

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT	e.emp_no,
		e.last_name,
		e.first_name,
		d.dept_name
FROM employees AS e
	INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
	INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development')
ORDER BY e.last_name;

![Q7](https://user-images.githubusercontent.com/85430216/166205135-1104f7d1-902b-4f91-97f7-81c973f11b90.PNG)

8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.

SELECT last_name,
COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name)
DESC;

![Q8](https://user-images.githubusercontent.com/85430216/166205174-ae345113-a17b-49ff-8e59-c7736f593329.PNG)

## Submission

* Create an image file of your ERD.

* Create a `.sql` file of your table schemata.

* Create a `.sql` file of your queries.

* Create and upload a repository with the above files to GitHub and post a link on BootCamp Spot.

* Ensure your repository has regular commits and a thorough README.md file

## Rubric

[Unit 9 Homework Rubric](https://docs.google.com/document/d/1OksnTYNCT0v0E-VkhIMJ9-iG0_oXNwCZAJlKV0aVMKQ/edit?usp=sharing)
