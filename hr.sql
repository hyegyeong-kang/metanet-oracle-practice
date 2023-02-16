SELECT employee_id AS �����ȣ, last_name "����̸�" FROM employees;

SELECT employee_id, last_name, hire_date
from employees
where hire_date >= '03/01/01'
and last_name = 'King';

select department_id, department_name
from departments
where NOT department_id = 10;


select last_name 
from employees 
where not last_name like '%a%';


select department_id, count(*) "�����", count(commission_pct) "Ŀ�̼ǹ޴� �����"
from employees
group by department_id
order by department_id;


select department_id, avg(salary)
from employees
group by department_id
having avg(salary) < 5000;

select sysdate - 1 "����", sysdate "����", sysdate + 1 "����" from dual;


--����� �ټӳ��� ����ض� ex) 10.5 �� employees: hire_date
select last_name, round((SYSDATE - hire_date)/365,1) || '��'
from employees;


select to_char(sysdate, 'yyyy-mm-dd'),
	to_char(500000000, '$999,999,999')
	from dual;


select employee_id, salary, NVL(commission_pct, 0)
from employees;

select employee_id, salary, NVL2(commission_pct, 'O', 'X')
from employees;


select job_id, decode(job_id, 'SA_MAN', 'Sales Dept', 'SH_CLERK', 'Sales Dept', 'Another') 
from employees;

select job_id,
	case job_id
		when 'SA_MAN' then 'Sales Dept'
		when 'SH_CLERK' then 'Sales Dept'
		else 'ANOTHER2'
	end "CASE"
from employees;



CREATE TABLE emp01
	AS SELECT * FROM employees;
    
CREATE TABLE emp02
 as select * from employees where 1 = 0;
 
ALTER TABLE emp02 
    ADD(job VARCHAR2(50));
    
drop table emp01;
drop table emp02;


CREATE TABLE dept01
as select * from departments;

CREATE TABLE emp01
as select * from employees;

-- ����> emp01 ���̺��� salary 3000�̻� ����ڿ��� salary 10% �λ��� ����.

update emp01 set salary = salary * 1.1
where salary >= 3000;


-- ���� 2> dept1 ���̺��� �μ��̸� 'it service' ���� ���� �ο츦 ����
delete from dept01 
where department_name = 'it Service';

------------------------------------------


create table emp03(
	empno NUMBER,
	ename VARCHAR2(20),
	job VARCHAR2(20),
	deptno NUMBER
);

create table emp02(
	empno NUMBER NOT NULL,
	ename VARCHAR2(20) NOT NULL,
	job VARCHAR2(20),
	deptno NUMBER
);

create table emp07(
	empno NUMBER ,
	ename VARCHAR2(20),
	job VARCHAR2(20),
	deptno NUMBER
);

ALTER TABLE emp07 
		ADD CONSTRAINT emp07_empno_pk PRIMARY KEY(empno);
        
        
ALTER TABLE emp07
 ADD CONsTRAINT emp07_deptno_fk FOREIGN KEY(deptno)
 REFERENCES departments(department_id);        
        
        
create table emp12(
empno NUMBER,
ename VARCHAR2(20),
job VARCHAR2(20),
deptno NUMBER,
loc VARCHAR2(20) default 'Seoul'	
)

alter table emp12 
add constraint emp12_empno_ename_pk primary key(empno, ename);

--==> ����
--dept01 ���̺��� department_id �⺻Ű �������� �����ϰ� 
-- emp13 ���̺��� deptno �÷��� dept01 ���̺��� department_id �� �����ϵ��� ��������. (���̺� ���� ���)
        
alter table dept01
add constraint dept01_no_pk primary key(department_id);

create table emp13(
	empno NUMBER,
	ename VARCHAR2(20),
	job VARCHAR2(20),
	deptno NUMBER	
)
--
--alter table emp13
--add constraint emp13_empno_pk PRIMARY KEY(empno)
--add constraint emp13_deptno_fk FOREIGN KEY(deptno) references dept01(department_id)
--        
        
create table emp14(
empno NUMBER primary key,
ename VARCHAR2(20) not null,
job VARCHAR2(20),
deptno NUMBER REFERENCES dept01(department_id)
on delete cascade 
)


-----------------20230213----------------------------






SELECT employee_id, department_id
	FROM employees
	WHERE last_name = 'King';

SELECT e.employee_id, e.department_id, d.department_name
	FROM employees e, departments d
	WHERE e.department_id = d.department_id
	AND last_name = 'King';




SELECT e.employee_id, e.department_id, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
WHERE last_name = 'King';



--����: 3�� �̻� ���̺��� ������
--(����̸�, �̸���, �μ���ȣ, �μ��̸�, ������ȣ(job_id), �����̸�(JOB_TITLE)�� ����غ���.
-- WHERE , ANSI 

SELECT e.employee_id, e.email, e.department_id, d.department_name, j.job_id, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e. job_id = j.job_id;


SELECT e.employee_id, e.email, e.department_id, d.department_name, j.job_id, j.job_title
FROM employees e 
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN jobs j
ON e.job_id = j.job_id;


-- 'Seattle' (city) �� �ٹ��ϴ� ����̸�, �μ���ȣ, ������ȣ, �����̸�, �����̸� ����ϴ�.
-- (where, ansi)

SELECT  e.employee_id, e.first_name, e.department_id, e.job_id, j.job_title, l.city
FROM employees e, jobs j, departments d, locations l
where e.job_id = j.job_id
AND e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.city = 'Seattle';


SELECT  e.employee_id, e.first_name, e.department_id, e.job_id, j.job_title, l.city
FROM employees e
INNER JOIN jobs j
ON e.job_id = j.job_id
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations l
ON d.location_id = l.location_id
WHERE l.city = 'Seattle';



SELECT A.last_name || '�� �Ŵ�����' || B.last_name || '�̴�.'
FROM employees A, employees B
WHERE A.manager_id = B.employee_id
AND A.last_name = 'Kochhar';


SELECT * FROM employees;

SELECT e.employee_id, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;


---1. �̸��� ��Himuro���� ����� �μ����� ����϶�.
SELECT e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.last_name = 'Himuro';

SELECT e.last_name, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.last_name = 'Himuro';


---2. �������� 'Accountant'�� ����� �̸��� �μ����� ����϶�.
SELECT e.last_name, d.department_name, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id
AND j.job_title = 'Accountant';

SELECT e.last_name, d.department_name, j.job_title
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN jobs j
ON e.job_id = j.job_id
WHERE j.job_title = 'Accountant';





---3. Ŀ�̼��� �޴� ����� �̸��� �װ� ���� �μ��� ����϶�.

--50
select * from employees;

SELECT e.last_name, d.department_name, e.Commission_pct
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.Commission_pct IS NOT NULL;


SELECT e.last_name, d.department_name, e.Commission_pct
FROM employees e 
JOIN departments d
ON e.department_id = d.department_id
AND e.Commission_pct IS NOT NULL;



---4. �޿��� 4000������ ����� �̸�, �޿�, �ٹ����� ����϶�.

SELECT e.last_name, e.salary, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND e.salary <= 4000;

SELECT e.last_name, e.salary, l.city
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE e.salary <= 4000;


CREATE OR REPLACE VIEW emp_view AS
SELECT last_name, salary, l.city
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE e.salary < = 4000;

select * from emp_view;



---5. 'Chen'�� ������ �μ����� �ٹ��ϴ� ����� �̸��� ����϶�.

SELECT e.last_name, d.department_id
FROM employees e;



--- ���� hr> 'Chen' ������� salary �� ���� �޴� ����� ����� ����ض�.

SELECT salary FROM employees where last_name = 'Chen';

SELECT last_name, salary
FROM employees 
WHERE salary > (SELECT salary FROM employees where last_name = 'Chen');





SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE salary = (SELECT MAX(salary) 
FROM employees
GROUP BY job_id);


SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE (salary, job_id) IN(SELECT MAX(salary), job_id 
FROM employees
GROUP BY job_id);



-- �̼� HR >

-- �μ���ȣ 30�� �ִ� �޿��ں��� �޿��� ���� ����� ����ض�
SELECT employee_id, last_name
FROM employees
WHERE salary > ALL(SELECT salary from employees where department_id = 30);


-- �μ���ȣ 30�� �ִ� �޿��ں��� �޿��� ���� ����� ����ض�
SELECT employee_id, last_name
FROM employees
WHERE salary < ANY(SELECT salary from employees where department_id = 30);




--- ���� hr> �޿��� ���� �޴� ���� 3���� ��������� ����ض�

SELECT ROWNUM , salary, last_name
FROM (select employee_id, last_name, salary from employees order by salary desc)
WHERE ROWNUM <= 3;



--------------------------------------------------------------
-----------20230213 homweork ��������----------------------------------

--1. ����) ��Patel���� �����ִ� �μ��� ��� ����� �����ȣ, �̸�, �Ի���, �޿��� ����϶�.

select department_id from employees where last_name = 'Patel';


SELECT e.employee_id, e.last_name, e.hire_date, e.salary
FROM employees e
WHERE e.department_id = (select department_id from employees where last_name = 'Patel' );


-- 2. ����) ��Austin'�� ����(job)�� ���� ����� �̸�, �μ���, �޿�, ������ ����϶�.

select job_title from employees e, jobs j where e.job_id = j.job_id and last_name = 'Austin';


SELECT e.last_name, e.hire_date, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;


SELECT e.last_name, e.hire_date, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
and e.department_id = (select job_title from employees e, jobs j where e.job_id = j.job_id and last_name = 'Austin' );




-- 3. ����) 'Seo'�� �޿��� ���� ����� �����ȣ, �̸�, �޿��� ����϶�.

select salary from employees where last_name = 'Seo';


SELECT employee_id, last_name, salary
FROM employees
WHERE salary = (select salary from employees where last_name = 'Seo');

-- 4. ����) �޿��� 30�� �μ��� �ְ� �޿����� ���� ����� �����ȣ, �̸�, �޿��� ����϶�.

SELECT MAX(salary) FROM employees WHERE department_id = 30;


SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE department_id = 30);

-- 5. ����) �޿��� 30�� �μ��� ���� �޿����� ���� ����� �����ȣ, �̸�, �޿��� ����϶�.

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT MIN(salary) FROM employees WHERE department_id = 30);


-- 6. ����) ��ü ����� ��� �ӱݺ��� ���� ����� �����ȣ, �̸�, �μ���, �Ի���, ����(city), �޿��� ����϶�.

SELECT e.employee_id, e.last_name, d.department_name, e.hire_date, e.salary, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
and d.location_id = l.location_id
and salary > (SELECT AVG(salary) FROM employees);

--7. ����) 100�� �μ� �߿��� 30�� �μ����� ���� ������ �ϴ� ����� �����ȣ, �̸�, �μ���, �Ի���, ������ ����϶�.
