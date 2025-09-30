create table emp(
emp_id int primary key,
emp_name varchar(49),
emp_dept varchar(50),
emp_salary int
);

insert into 
emp(emp_id,emp_name,emp_dept,emp_salary)
values 
(01,'jeshu','mech',1000),
(02,'manish','civil',2000),
(03,'vishnu','eee',4000),
(04,'nani','civil',2000),
(05,'kamal','vse',3000);


 select *from emp;


 SELECT AVG(emp_salary) as avg_sal FROM emp;

 select emp_id, emp_name, emp_salary
 from emp 
 where emp_salary > 2400;

 INSERT INTO emp (emp_id, emp_name, emp_dept, emp_salary) VALUES
(6, 'ravi', 'mech', 2500),
(7, 'sara', 'mech', 1800),
(8, 'deepak', 'civil', 1500),
(9, 'aarti', 'civil', 3000);

select *from emp;

select e.emp_id,e.emp_name,e.emp_dept,e.emp_salary
from emp e
where emp_salary >(
SELECT avg(emp_salary)
from emp
where emp_dept=e.emp_dept
);


 select emp_id, emp_name, emp_salary, emp_dept
 from emp 
 where emp_dept IN 
 (select emp_dept where emp_salary >3000);

  select emp_id, emp_name, emp_salary, emp_dept
 from emp 
 where emp_name IN
 (select emp_name where emp_salary >3000);

 SELECT emp_id, emp_name, emp_dept, emp_salary
FROM emp e
WHERE EXISTS (
    SELECT 1
    FROM emp
    WHERE emp_dept = e.emp_dept
      AND emp_salary > 3000
);

select *from emp;











