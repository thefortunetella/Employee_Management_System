CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_date DATE,
    sex CHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

CREATE TABLE branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

CREATE TABLE client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY (emp_id, client_id),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
    branch_id INT,
    supplier_name VARCHAR(20),
    supply_type VARCHAR(20),
    PRIMARY KEY (branch_id, supplier_name),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

ALTER TABLE employee
ADD FOREIGN  KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN  KEY(super_id) REFERENCES employee(emp_id) ON DELETE SET NULL;


--corporate

INSERT INTO employee VALUES(100,'David', 'Wallace', '1967-11-17','M', 250000, NULL, NULL);
INSERT INTO branch VALUES(1,'Corporate',100,'2006-02-09');

UPDATE employee SET branch_id = 1 WHERE emp_id = 100;

INSERT INTO employee VALUES(101,'Jan', 'Levinson', '1961-05-11','F', 110000, 100, 1);

--Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15','M', 75000, NULL, NULL);
INSERT INTO branch VALUES(2, 'Scranton', 102,'1992-04-06');

UPDATE employee SET branch_id = 2 WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25','F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05','F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19','M', 69000, 102, 2);

--Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05','M', 78000, NULL, NULL);
INSERT INTO branch VALUES(3, 'Stamford', 100,'1998-02-13');

UPDATE employee SET branch_id = 3 WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22','M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01','M', 71000, 106, 3);


--Branch Sup
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'JT Forms', 'Custom');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom');

--Clients
INSERT INTO client VALUES(400,'Dunmore HS',2);
INSERT INTO client VALUES(401,'Lackwana',2);
INSERT INTO client VALUES(402,'FedEx',3);
INSERT INTO client VALUES(403,'Daly Law',3);
INSERT INTO client VALUES(404,'Scranton Wp',2);
INSERT INTO client VALUES(405,'Times Newspaper',3);
INSERT INTO client VALUES(406,'FedEx',2);

--WorksWITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);


-- find all employees
SELECT * FROM employee;

--find all clients
SELECT * FROM client;

--find all employees ordered by salary
SELECT* FROM employee ORDER BY salary;

--find all employees by sex and name
SELECT * FROM employee ORDER BY sex, first_name, last_name;

--find first 5 employees in the table
SELECT* FROM employee LIMIT 5;

--find the first and last name of all employees
SELECT first_name, last_name FROM employee;

--find out all the different genders
SELECT DISTINCT sex FROM employee;

--find out all diferent branch id´s
SELECT DISTINCT branch_id FROM employee;

--find the number of employees
SELECT COUNT(emp_id) FROM employee;

--find ou the number of female employees born after 1970;
SELECT COUNT(emp_id) FROM employee WHERE sex ='F' AND birth_date > '1970-01-01';

--find out the average of all employee´s salaries
SELECT AVG(salary) FROM employee;

--find out the average of male employee´s salaries
SELECT AVG(salary) FROM employee WHERE sex='M';

--find out the average of female employee´s salaries
SELECT AVG(salary) FROM employee WHERE sex='F';

--find out the sum of employee´s salaries
SELECT SUM(salary) FROM employee;

--find out how many males and females there are
SELECT COUNT(sex), sex FROM employee GROUP BY sex;

-- find the total sales from each salesman
SELECT SUM(total_sales), emp_id FROM works_with GROUP BY emp_id;

-- find the total sales from each client
SELECT SUM(total_sales), client_id FROM works_with GROUP BY client_id;

--find client namealike
SELECT * FROM client WHERE client_name LIKE '%FedEx';

--find employees born in october
SELECT * FROM employee
WHERE birth_date LIKE '____-10%';

--find client namealike
SELECT * FROM client WHERE client_name LIKE '%paper%';

--find a list of employee and branch_names
SELECT first_name AS names FROM employee UNION SELECT branch_name from branch;

--find a list of all money spent or earned by the company
SELECT salary FROM employee UNION SELECT total_sales FROM works_with;

--find all names of the employees who have sold over 30.000 to a single client
SELECT employee.first_name, employee.last_name FROM employee WHERE employee.emp_id IN(
SELECT works_with.emp_id FROM works_with WHERE works_with.total_sales>30000);

--TRIGGER
CREATE TABLE trigger_test(
    message VARCHAR(100)
);

CREATE TRIGGER my_trigger BEFORE INSERT
ON employee FOR EACH ROW
BEGIN
    INSERT INTO trigger_test VALUES ('added new employee');
END;
