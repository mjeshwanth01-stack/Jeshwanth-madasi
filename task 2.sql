-- Create student table
CREATE TABLE student (
    sno INT PRIMARY KEY,
    name VARCHAR(50),
    roll_number VARCHAR(20),
    id INT UNIQUE,
    department VARCHAR(50)
);

-- Insert sample records
INSERT INTO student (sno,name, roll_number, id, department)
VALUES
(1,'prashanth', '21CS101', 101, 'Computer Science'),
(2,'nani', '21EE102', 102, 'Electrical'),
(3,'sai', '21ME103', 103, 'Mechanical'),
(4,'teja', '21CE104', 104, 'Civil'),
(5,'jeshu', '21IT105', 105, 'Information Technology');
select * from student

--update command
update student 
set name = 'raju'
where sno = 1;

select * from student

--delete command
delete from student where sno = '2';

 select * from student