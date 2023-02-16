select sno as �й�, sname as �̸�, avr as ���
from student;

select cno "�����ȣ", cname "�����̸�", st_num "������"
from course;

select pno "������ȣ", pname "�����̸�", orders "����"
from professor;

select eno "�����ȣ", ename "�̸�", sal*1.1 "����"
from emp;

select sno "�й�", sname "�л��̸�", avr * 4.5 / 4.0 "ȯ������"
from student;

select section, pname, hiredate from professor
order by section, hiredate;



select sname, major
from student
where sname like '��%' and major = 'ȭ��';

select pname, hiredate
from professor
where hiredate;





select sname, avr
from student 
where major = 'ȭ��' and avr / 4.5 > 3.5; 


--1. ȭ�а� �г⺰ ��� ������ �˻��϶�.
select syear, major, avg(avr)
from student
where major = 'ȭ��'
group by major, syear;


--2. �� �а��� �л����� �˻��϶�.
select major, count(*) "�л���"
from student
group by major;

--3. ȭ�а� �����а� �л��� 4.5 ȯ�� ������ ����� ���� �˻��϶�.
select major "�а�", avg(avr *4.5 / 4.0) "�������"
from student
where major in ('ȭ��','����')
group by major;


-- 1. ȭ�а��� ������ �л����� ���� ��������� �˻��϶�.
select major, avg(avr)
from student
group by major 
having major not in 'ȭ��';

--2. ȭ�а��� ������ �� �а��� ���� �߿� ������ 2.0 �̻� �а� ������ �˻��ض�.
select major, avg(avr)
from student 
group by major
having major not in 'ȭ��' and avg(avr) > 2.0;

--3. �ٹ����� ���� 3�� �̻��� �μ��� �˻��ض� (emp)
select dno, COUNT(*)
from emp
group by dno
having COUNT(*) >= 3;


select 'database',LOWER('DataBase') from dual;


select substr('abcdef', 2,4) from dual;


select cname, substr(cname, 1, length(cname)-1) 
from course;



------------------20230213---------------------------------


--����01> '�۰�' ������ �����ϴ� ������ �˻��ض�. 1. ������ȣ (pno) 2. �����̸� (pname) 3. �����(cname)

SELECT p.pno, p.pname, c.cname
FROM professor p, course c
WHERE p.pno = c.pno
AND pname = '�۰�';


---1. ������ 2������ ����� �̸� �����ϴ� ������ �˻��ض�.
---2. ȭ�а� 1�г� �л��� �⸻��� ������ �˻��ض�.
---3. ȭ�а� 1�г� �л��� �����ϴ� ������ �˻��ض�(3�� ���̺� ����)

SELECT c.cname, c.st_num, p.pname
FROM course c, professor p
WHERE c.pno = p.pno
AND c.st_num = 2;


SELECT s.syear, s.major, s.sname, ss.result
FROM student s, score ss
WHERE s.sno = ss.sno
AND s.major = 'ȭ��'
AND s.syear = 1;


SELECT s.syear, s.major, s.sname, c.cname
FROM student s, score ss, course c
WHERE s.sno = ss.sno
AND ss.cno = c.cno
AND s.major = 'ȭ��'
AND s.syear = 1; 




 -- ���� > kosa01 �л� �߿� ���������� �˻��ض�. 
 
 SELECT distinct A.sname, A.sno, B.sname, B.sno
 FROM student A, student B
 WHERE A.sname = B.sname
 AND A.sno != B.sno;
 
 
 
 -- ���� kosa1> ��ϵ� ���� ���� ��� ������ �˻��ض�(������� ���� ������ ���, ������ ������ ������)
 
 --36
 SELECT * FROM professor;

 
 --29
 SELECT p.pname, c.cname
 FROM professor p, course c
 WHERE p.pno = c.pno;
 
 
 -- OUTER JOIN <professor ����>
 
 SELECT p.pname, c.cname
 FROM professor p, course c
 WHERE p.pno = c.pno(+);
 
 
 SELECT p.pname, c.cname
 FROM professor p LEFT JOIN course c
 ON p.pno = c.pno;
 
 
  -- OUTER JOIN <course ����>
  
  --32 
 SELECT * FROM course;
 

 SELECT p.pname, c.cname
 FROM professor p, course c
 WHERE p.pno(+) = c.pno;
 
 
 SELECT p.pname, c.cname
 FROM professor p RIGHT JOIN course c
 ON p.pno = c.pno;
 
 
 -- ���� �� �������� ��� 
 SELECT p.pname, c.cname
 FROM professor p FULL JOIN course c
 ON p.pno = c.pno;
 
 
 
 -- mission kosa01 
-- '������'�� �μ�(dept) �� �ٸ����� ������ ����(job)�� �����ϴ� ��� ����� ����ض�

SELECT ename, job, dno
FROM emp 
where dno != (select dno from emp where ename = '������')
and job = (select job from emp where ename = '������');

-- '����'���� �Ϲ�ȭ�а����� ������ ���� �л��� ����� ����ض�

select c.st_num
    from course c, student s, score sc 
    where sc.cno = c.cno 
    and c.cname = '�Ϲ�ȭ��'
    and s.sname = '����'
    group by c.st_num;


select s.sno, sname, grade
from student s, course c, score r, scgrade g
where s.sno = r.sno
and c.cno = r.cno
and cname = '�Ϲ�ȭ��'
and result between loscore and hiscore
and grade > (select grade from student s, course c, score r, scgrade g
            where s.sno = r.sno
            and c.cno = r.cno
            and cname = '�Ϲ�ȭ��'
            and sname = '����'
            and result between loscore and hiscore);


SELECT s.sname, c.cname, c.st_num
FROM student s, course c
WHERE c.st_num  < 
    (select c.st_num
    from course c, student s, score sc 
    where sc.cno = c.cno 
    and c.cname = '�Ϲ�ȭ��'
    and s.sname = '����'
    group by c.st_num);
    
    
    
    
SELECT MAX(AVG(sal)) FROM emp
GROUP BY dno;
 
 
SELECT dno FROM emp
GROUP BY dno
HAVING AVG(sal) = (SELECT MAX(AVG(sal)) FROM emp
GROUP BY dno);

-- ���� KOSA01 > �л� �ο����� ���� ���� �а��� �˻��ض�.

SELECT major
FROM student
group by major
WHERE count(*) = (SELECT MAX(count(*))
FROM student
GROUP BY major);


-- 1. �л� �� �⸻��� ��� ������ ���� ���� �л��� ������ �˻��ض�


SELECT s.sno, s.sname
FROM student s, score r
WHERE s.sno = r.sno
GROUP BY s.sno, sname
HAVING AVG(result) = (SELECT MIN(AVG(result)) FROM score group by sno);



-- 2. ȭ�а� 1�г� �л� �߿� ������ ��� ������ �л��� �˻��ض�

SELECT * FROM student
WHERE major = 'ȭ��'
AND syear = 1
AND avr < (SELECT AVG(avr) from student where major = 'ȭ��' and syear = 1);




-- �̼� kosa01 > 

--1.'���ϴ�'�� ������ ������(mgr)�� ������ �����鼭 ������ ���� ����� �˻��ض�.

SELECT ename
FROM emp
WHERE (mgr, job) = (select mgr, job from emp where ename = '���ϴ�');


--2. ȭ�а� �л��� ������ ������ �л��� �˻��ض�.


select avr 
from student 
where major = 'ȭ��';

SELECT *
FROM student
WHERE avr IN (select avr from student where major = 'ȭ��');

--3. ȭ�а� �л��� ���� �г⿡�� ������ ������ �л��� �˻��ض�.


select avr, syear from student where major = 'ȭ��';

SELECT *
FROM student
WHERE (avr, syear) IN (select avr, syear from student where major = 'ȭ��');




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


-- 60�� �μ��� ������ ������ �Է�
INSERT INTO dept_tcl VALUES(60, 'Database', '����', 1111);

-- update => 40�� �μ��� loc �� '�뱸' �� �����غ���

UPDATE dept_tcl SET loc = '�뱸' WHERE dno = 40;


rollback; // commit �ϸ� rollback �ص� ���ư��� ����



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



