create type Person as Object(
    fname varchar(40),
    lname varchar(40),
    dob Date,

    member function fullname return varchar,
    member function ondate return date
)Not Final;


--implementation of methods for the Person type--

Create or Replace type body Person as 
    Member function fullname Return varchar is 
    Begin
        Return fname || ' ' || lname;
    End fullname;
    
    Member function ondate Return Date as
    Begin
        Return dob;
    End ondate;
End;
    
    
//Create subtype EmpObj

Create type EmpObj under Person(
    emp_id number,
    job varchar(50),
    sal Number,
    da Number,
    doj Date,
    Overriding Member Function ondate return date,
    Member function Earn return Number
);

Drop type EmpObj force;
Drop type Person force;  

--implementation of methods for the EmpObj
Create or Replace type body EmpObj as
    Overriding Member function ondate return Date Is
    Begin
        Return doj;
    End ondate;
    
    Member function earn return Number Is
    Begin 
        Return sal+da;
    End earn;
End;

Create table Employee of EmpObj(
     PRIMARY KEY(fname , lname)
);
drop table Employee

Create table Employee of EmpObj(
    emp_id PRIMARY KEY
);

//Insert Data//
-- Inserting data into the Employee table
-- Corrected Inserting data into the Employee table
INSERT INTO Employee VALUES (
    EmpObj( 'Prachi', 'Patil', DATE '2003-01-01',1, 'Software Engineer', 50000, 10000, DATE '2024-01-01')
);

INSERT INTO Employee VALUES (
    EmpObj('Komal', 'Jadhav', DATE '2002-05-15',2, 'Data Analyst', 60000, 8000, DATE '2023-06-15')
);

INSERT INTO Employee VALUES (
    EmpObj('Aishwarya', 'Pavane', DATE '2002-05-05',3,'Computer Engineer', 55000, 8000, DATE '2023-06-05')
);


Select emp_id, e.fullname() as Employee_fullName,e.ondate() as Employee_dateOfJoining,
        e.dob as employee_dateOfBirth, e.earn() as EMployee_earning
From Employee e;

Select *
from Employee;
    
    