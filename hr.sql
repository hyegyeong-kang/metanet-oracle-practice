SELECT employee_id AS 사원번호, last_name "사원이름" FROM employees;

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


select department_id, count(*) "사원수", count(commission_pct) "커미션받는 사원수"
from employees
group by department_id
order by department_id;


select department_id, avg(salary)
from employees
group by department_id
having avg(salary) < 5000;

select sysdate - 1 "어제", sysdate "오늘", sysdate + 1 "내일" from dual;


--사원의 근속년을 출력해라 ex) 10.5 년 employees: hire_date
select last_name, round((SYSDATE - hire_date)/365,1) || '년'
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

-- 퀴즈> emp01 테이블에서 salary 3000이상 대상자에게 salary 10% 인상을 하자.

update emp01 set salary = salary * 1.1
where salary >= 3000;


-- 퀴즈 2> dept1 테이블에서 부서이름 'it service' 값을 가진 로우를 삭제
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

--==> 퀴즈
--dept01 테이블의 department_id 기본키 제약조건 구현하고 
-- emp13 테이블의 deptno 컬럼이 dept01 테이블의 department_id 를 참조하도록 구현하자. (테이블 수정 방식)
        
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



--퀴즈: 3개 이상 테이블을 조인해
--(사원이름, 이메일, 부서번호, 부서이름, 직종번호(job_id), 직종이름(JOB_TITLE)을 출력해보자.
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


-- 'Seattle' (city) 에 근무하는 사원이름, 부서번호, 직종번호, 직종이름, 도시이름 출력하다.
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



SELECT A.last_name || '의 매니저는' || B.last_name || '이다.'
FROM employees A, employees B
WHERE A.manager_id = B.employee_id
AND A.last_name = 'Kochhar';


SELECT * FROM employees;

SELECT e.employee_id, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;


---1. 이름이 ‘Himuro’인 사원의 부서명을 출력하라.
SELECT e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.last_name = 'Himuro';

SELECT e.last_name, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.last_name = 'Himuro';


---2. 직종명이 'Accountant'인 사원의 이름과 부서명을 출력하라.
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





---3. 커미션을 받는 사람의 이름과 그가 속한 부서를 출력하라.

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



---4. 급여가 4000이하인 사원의 이름, 급여, 근무지를 출력하라.

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



---5. 'Chen'과 동일한 부서에서 근무하는 사원의 이름을 출력하라.

SELECT e.last_name, d.department_id
FROM employees e;



--- 퀴즈 hr> 'Chen' 사원보다 salary 를 많이 받는 사원의 목록을 출력해라.

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



-- 미션 HR >

-- 부서번호 30번 최대 급여자보다 급여가 높은 사원을 출력해라
SELECT employee_id, last_name
FROM employees
WHERE salary > ALL(SELECT salary from employees where department_id = 30);


-- 부서번호 30번 최대 급여자보다 급여가 작은 사원을 출력해라
SELECT employee_id, last_name
FROM employees
WHERE salary < ANY(SELECT salary from employees where department_id = 30);




--- 퀴즈 hr> 급여를 많이 받는 순서 3명의 사원정보를 출력해라

SELECT ROWNUM , salary, last_name
FROM (select employee_id, last_name, salary from employees order by salary desc)
WHERE ROWNUM <= 3;



--------------------------------------------------------------
-----------20230213 homweork 서브쿼리----------------------------------

--1. 문제) ‘Patel’가 속해있는 부서의 모든 사람의 사원번호, 이름, 입사일, 급여를 출력하라.

select department_id from employees where last_name = 'Patel';


SELECT e.employee_id, e.last_name, e.hire_date, e.salary
FROM employees e
WHERE e.department_id = (select department_id from employees where last_name = 'Patel' );


-- 2. 문제) ‘Austin'의 직무(job)와 같은 사람의 이름, 부서명, 급여, 직무를 출력하라.

select job_title from employees e, jobs j where e.job_id = j.job_id and last_name = 'Austin';


SELECT e.last_name, e.hire_date, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;


SELECT e.last_name, e.hire_date, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
and e.department_id = (select job_title from employees e, jobs j where e.job_id = j.job_id and last_name = 'Austin' );




-- 3. 문제) 'Seo'의 급여와 같은 사원의 사원번호, 이름, 급여를 출력하라.

select salary from employees where last_name = 'Seo';


SELECT employee_id, last_name, salary
FROM employees
WHERE salary = (select salary from employees where last_name = 'Seo');

-- 4. 문제) 급여가 30번 부서의 최고 급여보다 높은 사원의 사원번호, 이름, 급여를 출력하라.

SELECT MAX(salary) FROM employees WHERE department_id = 30;


SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE department_id = 30);

-- 5. 문제) 급여가 30번 부서의 최저 급여보다 높은 사원의 사원번호, 이름, 급여를 출력하라.

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT MIN(salary) FROM employees WHERE department_id = 30);


-- 6. 문제) 전체 사원의 평균 임금보다 많은 사원의 사원번호, 이름, 부서명, 입사일, 지역(city), 급여를 출력하라.

SELECT e.employee_id, e.last_name, d.department_name, e.hire_date, e.salary, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
and d.location_id = l.location_id
and salary > (SELECT AVG(salary) FROM employees);

--7. 문제) 100번 부서 중에서 30번 부서에는 없는 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일, 지역을 출력하라.
