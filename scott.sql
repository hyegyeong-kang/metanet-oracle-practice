select empno, rpad(substr(empno, 1, 2), length(empno), '*') "MASKING_EMPNO"
, ename, rpad(substr(ename,1,2),length(ename), '*') "MASKING_ENAME"
from emp
where length(ename) between 5 and 6;


select empno, ename, sal, ROUND(sal / 21.5, 2) "DAY_PAY", ROUND(sal / 21.5 / 8, 1) "TIME_PAY"
from emp;


select empno, ename, hiredate, nvl(comm, '0')
from emp
;


select empno, ename, mgr, mgr "CHG_MGR"
from emp
;
-- , (SYSDATE - hiredate)/365/12 "R_JOB", nvl(comm)


select deptno, round(avg(sal)) "AVG_SAL", max(sal) "MAX_SAL", min(sal) "MIN_SAL", count(*) "CNT"
from emp
group by deptno;


select job, count(*)
from emp
group by job
having count(*) >= 3;


select substr(hiredate,1,2) "HIRE_YEAR", deptno, count(*) "CNT"
from emp
group by deptno, substr(hiredate,1,2);




create table member(
id VARCHAR2(20),
name VARCHAR2(20),
regno VARCHAR2(13),
hp VARCHAR2(13),
address VARCHAR2(20)	
);

alter table member
   -- add constraint member_pk primary key(id, regno, hp);
    modify (id, name, regno not null);

--
create table book(
code VARCHAR2(20),
title VARCHAR2(20),
count VARCHAR2(13),
price VARCHAR2(13),
publish VARCHAR2(20)	
);

alter table book
--add constraint book_pk primary key(code);
modify (count, price, publish not null);


create table order2(
no VARCHAR2(20),
id VARCHAR2(20),
code NUMBER,
count NUMBER,
dr_date DATE	
);

alter table order2
--add constraint order_pk primary key(no);
modify (count, dr_date not null);


---------------
----조인과제

---Q1
SELECT d.deptno, d.dname, e.empno, e.ename, e.sal
FROM dept d, emp e
WHERE d.deptno = e.deptno
AND e.sal > 2000;


---Q2
SELECT d.deptno, d.dname, AVG(e.sal), MAX(e.sal), MIN(e.sal)
FROM dept d, emp e
WHERE d.deptno = e.deptno
GROUP BY d.deptno, d.dname;

---Q3
SELECT d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
FROM dept d, emp e
WHERE d.deptno = e.deptno
ORDER BY d.deptno;


-- Q4
SELECT d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, d.deptno, s.losal, s.hisal, s.grade, e.empno, e.empname
FROM dept d, emp e1, emp e2, salgrade s
WHERE d.deptno = e.deptno
AND e1.empno = e2.empno
AND sal between losal and hisal
AND 









--서브쿼리 과제
-- Q1

SELECT e.job, e.empno, e.ename, e.sal,  d.deptno, d.dname
FROM dept d, emp e
WHERE d.deptno = e.deptno
and e.job = (select job from emp where ename = 'ALLEN');


--Q2

SELECT e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
FROM dept d, emp e, salgrade s
WHERE d.deptno = e.deptno 
AND sal between losal and hisal
AND sal > all (select AVG(sal) from emp)
ORDER BY sal DESC;


--Q3

SELECT e.empno, e.ename, e.job, d.deptno, d.dname, d.loc
FROM dept d, emp e
WHERE d.deptno = e.deptno 
and job not in(select job from emp where deptno = 30)
and d.deptno = 10;


--Q4

select MAX(sal) from emp where job = 'SALESMAN';


SELECT e.empno, e.ename, e.sal, s.grade
FROM dept d, emp e, salgrade s
WHERE d.deptno = e.deptno 
AND sal between losal and hisal
and sal > (select MAX(sal) from emp where job = 'SALESMAN');



