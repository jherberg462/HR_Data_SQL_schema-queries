--List the following details of each employee: employee number, last name, 
--first name, gender, and salary.

--select required columns 
select employee.emp_no as "employee number", employee.last_name as "last name",
employee.first_name as "first name", employee.gender as "gender", 
salary.salary as "salary" 
from employee --table with data which I want all values returned
left join salary on -- used left join in case there is missing values in salary
salary.emp_no = employee.emp_no --fk relationship 
where salary.id  in 
(
	select salary.id
	from salary
	where (salary.to_date, salary.emp_no) in(
--find the pk of the end date, empployee id combination with the latest end date
		select max(salary.to_date), salary.emp_no
		from salary
		group by salary.emp_no
	)
)
order by "employee number"; 

--List employees who were hired in 1986.
select /*select required columns*/ employee.first_name as "First Name", 
employee.last_name as "Last Name", employee.hire_date as "Hire Date"
from employee --data from only one table is being pulled from
where employee.hire_date between '1986-01-01' and '1986-12-31'
--time is not in data, but if it was, '23:59:59.999' would need to be added to
--end date to capture rows with a hire date of the last day of the year
order by "Hire Date" desc;

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.

select /*select required columns*/ n.dept_no as "department number", 
n.dept_name as "department name", m.emp_no as "employee number", 
e.last_name as "last name", e.first_name as "first name", 
m.from_date as "start date", m.to_date as "end date"
from department_name n --create alias for department_name table
join department_manager m on --join department_manager table, and create alias
n.dept_no = m.dept_no -- fk relationship 
join employee e on
e.emp_no = m.emp_no
order by "end date" desc --show active dept managers first;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
select /*select required columns*/e.emp_no as "employee number", 
e.last_name as "last name", e.first_name as "first name", 
n.dept_name as "department name"
from employee e --create alias for employee table
join department_employees d on --join department employee table and create alias
d.emp_no = e.emp_no -- fk relationship
join department_name n on --join department name table
n.dept_no = d.dept_no
where d.id in ( --this is to only return the current/most recent department
	select d.id
	from department_employees d
	where (d.emp_no, d.to_date) in (
		select d.emp_no, max(d.to_date)
		from department_employees d
		group by d.emp_no
	)
);

--List all employees whose first name is "Hercules" and last names begin with "B."
select e.first_name as "first name", e.last_name as "last name" -- select required columns 
from employee e
where e.first_name = 'Hercules' and --first name needs to be 'Hercules'
e.last_name like 'B%'; -- last name needs to also start with "B"

--List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.
select /* select requiered columns */ e.emp_no as "employeen number", 
e.first_name as "first name", e.last_name as "last name", n.dept_name
from employee e --assign alis for table
join department_employees d on --join department employees table
d.emp_no = e.emp_no --fk relationship 
join department_name n on  -- join department name table to be able to pull department name
d.dept_no = n.dept_no 
where d.dept_no in (
	select d.dept_no
	from department_employees d
	join department_name n on
	d.dept_no = n.dept_no
	where n.dept_name = 'Sales' --filter to only select sales dept
);

--List all employees in the Sales and Development departments, including their employee 
--number, last name, first name, and department name.
select e.emp_no as "employeen number", e.first_name as "first name", 
e.last_name as "last name", n.dept_name 
from employee e
join department_employees d on
d.emp_no = e.emp_no
join department_name n on 
d.dept_no = n.dept_no
where d.dept_no in (
	select d.dept_no
	from department_employees d
	join department_name n on
	d.dept_no = n.dept_no
	where n.dept_name = 'Sales' or 
	n.dept_name ='Development' -- filter to select either sales or Development depts
);

--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
select last_name as "last name", count(last_name) as "number with last name"
--select last name column and create a count of instances of last name column
from employee
group by "last name" --group by the last name column 
order by "number with last name" desc;


