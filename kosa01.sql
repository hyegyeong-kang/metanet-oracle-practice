select sno as 학번, sname as 이름, avr as 평균
from student;

select cno "과목번호", cname "과목이름", st_num "학점수"
from course;

select pno "교수번호", pname "교수이름", orders "직위"
from professor;

select eno "사원번호", ename "이름", sal*1.1 "연봉"
from emp;

select sno "학번", sname "학생이름", avr * 4.5 / 4.0 "환산학점"
from student;

select section, pname, hiredate from professor
order by section, hiredate;



select sname, major
from student
where sname like '관%' and major = '화학';

select pname, hiredate
from professor
where hiredate;





select sname, avr
from student 
where major = '화학' and avr / 4.5 > 3.5; 


--1. 화학과 학년별 평균 학점을 검색하라.
select syear, major, avg(avr)
from student
where major = '화학'
group by major, syear;


--2. 각 학과별 학생수를 검색하라.
select major, count(*) "학생수"
from student
group by major;

--3. 화학과 생물학과 학생을 4.5 환산 학점의 평균을 각각 검색하라.
select major "학과", avg(avr *4.5 / 4.0) "학점평균"
from student
where major in ('화학','생물')
group by major;


-- 1. 화학과를 제외한 학생들의 과별 평점평균을 검색하라.
select major, avg(avr)
from student
group by major 
having major not in '화학';

--2. 화학과를 제외한 각 학과별 평점 중에 평점이 2.0 이상 학과 정보를 검색해라.
select major, avg(avr)
from student 
group by major
having major not in '화학' and avg(avr) > 2.0;

--3. 근무중인 직원 3명 이상인 부서를 검색해라 (emp)
select dno, COUNT(*)
from emp
group by dno
having COUNT(*) >= 3;


select 'database',LOWER('DataBase') from dual;


select substr('abcdef', 2,4) from dual;


select cname, substr(cname, 1, length(cname)-1) 
from course;



------------------20230213---------------------------------


--퀴즈01> '송강' 교수가 강의하는 과목을 검색해라. 1. 교수번호 (pno) 2. 교수이름 (pname) 3. 과목명(cname)

SELECT p.pno, p.pname, c.cname
FROM professor p, course c
WHERE p.pno = c.pno
AND pname = '송강';


---1. 학점이 2학점인 과목과 이를 강의하는 교수를 검색해라.
---2. 화학과 1학년 학생의 기말고사 성적을 검색해라.
---3. 화학과 1학년 학생이 수강하는 과목을 검색해라(3개 테이블 조인)

SELECT c.cname, c.st_num, p.pname
FROM course c, professor p
WHERE c.pno = p.pno
AND c.st_num = 2;


SELECT s.syear, s.major, s.sname, ss.result
FROM student s, score ss
WHERE s.sno = ss.sno
AND s.major = '화학'
AND s.syear = 1;


SELECT s.syear, s.major, s.sname, c.cname
FROM student s, score ss, course c
WHERE s.sno = ss.sno
AND ss.cno = c.cno
AND s.major = '화학'
AND s.syear = 1; 




 -- 퀴즈 > kosa01 학생 중에 동명이인을 검색해라. 
 
 SELECT distinct A.sname, A.sno, B.sname, B.sno
 FROM student A, student B
 WHERE A.sname = B.sname
 AND A.sno != B.sno;
 
 
 
 -- 퀴즈 kosa1> 등록된 과목에 대한 모든 교수를 검색해라(등록하지 않은 교수도 출력, 누락된 교수가 없도록)
 
 --36
 SELECT * FROM professor;

 
 --29
 SELECT p.pname, c.cname
 FROM professor p, course c
 WHERE p.pno = c.pno;
 
 
 -- OUTER JOIN <professor 기준>
 
 SELECT p.pname, c.cname
 FROM professor p, course c
 WHERE p.pno = c.pno(+);
 
 
 SELECT p.pname, c.cname
 FROM professor p LEFT JOIN course c
 ON p.pno = c.pno;
 
 
  -- OUTER JOIN <course 기준>
  
  --32 
 SELECT * FROM course;
 

 SELECT p.pname, c.cname
 FROM professor p, course c
 WHERE p.pno(+) = c.pno;
 
 
 SELECT p.pname, c.cname
 FROM professor p RIGHT JOIN course c
 ON p.pno = c.pno;
 
 
 -- 양쪽 다 누락됐을 경우 
 SELECT p.pname, c.cname
 FROM professor p FULL JOIN course c
 ON p.pno = c.pno;
 
 
 
 -- mission kosa01 
-- '정의찬'과 부서(dept) 가 다르지만 동일한 업무(job)을 수행하는 사원 목록을 출력해라

SELECT ename, job, dno
FROM emp 
where dno != (select dno from emp where ename = '정의찬')
and job = (select job from emp where ename = '정의찬');

-- '관우'보다 일반화학과목의 학점이 낮은 학생의 명단을 출력해라

select c.st_num
    from course c, student s, score sc 
    where sc.cno = c.cno 
    and c.cname = '일반화학'
    and s.sname = '관우'
    group by c.st_num;


select s.sno, sname, grade
from student s, course c, score r, scgrade g
where s.sno = r.sno
and c.cno = r.cno
and cname = '일반화학'
and result between loscore and hiscore
and grade > (select grade from student s, course c, score r, scgrade g
            where s.sno = r.sno
            and c.cno = r.cno
            and cname = '일반화학'
            and sname = '관우'
            and result between loscore and hiscore);


SELECT s.sname, c.cname, c.st_num
FROM student s, course c
WHERE c.st_num  < 
    (select c.st_num
    from course c, student s, score sc 
    where sc.cno = c.cno 
    and c.cname = '일반화학'
    and s.sname = '관우'
    group by c.st_num);
    
    
    
    
SELECT MAX(AVG(sal)) FROM emp
GROUP BY dno;
 
 
SELECT dno FROM emp
GROUP BY dno
HAVING AVG(sal) = (SELECT MAX(AVG(sal)) FROM emp
GROUP BY dno);

-- 퀴즈 KOSA01 > 학생 인원수가 가장 많은 학과를 검색해라.

SELECT major
FROM student
group by major
WHERE count(*) = (SELECT MAX(count(*))
FROM student
GROUP BY major);


-- 1. 학생 중 기말고사 평균 성적이 가장 낮은 학생의 정보를 검색해라


SELECT s.sno, s.sname
FROM student s, score r
WHERE s.sno = r.sno
GROUP BY s.sno, sname
HAVING AVG(result) = (SELECT MIN(AVG(result)) FROM score group by sno);



-- 2. 화학과 1학년 학생 중에 평점이 평균 이하인 학생을 검색해라

SELECT * FROM student
WHERE major = '화학'
AND syear = 1
AND avr < (SELECT AVG(avr) from student where major = '화학' and syear = 1);




-- 미션 kosa01 > 

--1.'손하늘'과 동일한 관리자(mgr)의 관리를 받으면서 업무도 같은 사원을 검색해라.

SELECT ename
FROM emp
WHERE (mgr, job) = (select mgr, job from emp where ename = '손하늘');


--2. 화학과 학생과 평점이 동일한 학생을 검색해라.


select avr 
from student 
where major = '화학';

SELECT *
FROM student
WHERE avr IN (select avr from student where major = '화학');

--3. 화학과 학생과 같은 학년에서 평점이 동일한 학생을 검색해라.


select avr, syear from student where major = '화학';

SELECT *
FROM student
WHERE (avr, syear) IN (select avr, syear from student where major = '화학');




CREATE TABLE board(
	seq NUMBER,
	title VARCHAR2(50),
	wirter VARCHAR2(50),
	contents VARCHAR2(200),
	regdate date, 
	gitcount number
)

INSERT INTO board VALUES(1, 'a1', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(6, 'a6', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(2, 'a2', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(3, 'a3', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(8, 'a8', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(4, 'a4', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(5, 'a5', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(10, 'a10', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(7, 'a7', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(9, 'a9', 'a', 'a', sysdate, 0);


SELECT * FROM board
ORDER BY seq;

SELECT ROWNUM, temp.*
    FROM(SELECT * FROM board ORDER BY seq) temp
    WHERE ROWNUM BETWEEN 6 AND 10;


SELECT * FROM(
		SELECT ROWNUM AS ROW_NUM, temp.*
		FROM (SELECT * FROM board
					ORDER BY seq) temp
		)
		WHERE ROW_NUM BETWEEN 6 AND 10;
        
        
        
        
        
------------------------20230214----------------------

CREATE TABLE dept_tcl
AS SELECT * FROM dept;


-- 60번 부서로 임의의 데이터 입력
INSERT INTO dept_tcl VALUES(60, 'Database', '서울', 1111);

-- update => 40번 부서의 loc 를 '대구' 로 수정해보자

UPDATE dept_tcl SET loc = '대구' WHERE dno = 40;


rollback; // commit 하면 rollback 해도 돌아가지 않음



delete from board;
commit;

CREATE SEQUENCE board_seq;

INSERT INTO board VALUES(board_seq.nextval, 'a1', 'a', 'a', sysdate, 0);

INSERT INTO board(seq, title, wirter, contents, regdate, gitcount)
    (select board_seq.nextval, title, wirter, contents, regdate, gitcount from board);
    


SELECT * FROM board
WHERE seq = 50001;

-- F10 

ALTER TABLE board
ADD CONSTRAINT board_seq_pk PRIMARY KEY(seq);


UPDATE board SET title = 'a10000' WHERE seq = 10000;

select * from board where title = 'a10000';

CREATE INDEX board_title_idx
ON board(title); 


ROLLBACK;

drop table board;



