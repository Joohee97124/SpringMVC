SELECT USER
FROM DUAL;
--==>>SCOTT

--○ TBL_STUDENT 테이블 생성
CREATE TABLE TBL_STUDENT
( SID   NUMBER          PRIMARY KEY
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(30)
);
--==>> Table TBL_STUDENT이(가) 생성되었습니다.

--○ 시퀀스 추가
CREATE SEQUENCE STUDENTSEQ
NOCACHE;
--==>> Sequence STUDENTSEQ이(가) 생성되었습니다.

--○ 데이터 추가
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(STUDENTSEQ.NEXTVAL, '정주희', '010-1111-1111');
--==>>> 1 행 이(가) 삽입되었습니다.

--○ 데이터 조회문
SELECT SID, NAME, TEL
FROM TBL_STUDENT;
--==>> 1	정주희	010-1111-1111




--○ TBL_GRADE 테이블 생성
CREATE TABLE TBL_GRADE
( SID   NUMBER         REFERENCES TBL_STUDENT(SID)
, SUB1  NUMBER(3)
, SUB2  NUMBER(3)
, SUB3  NUMBER(3)
, CONSTRAINT GRADE_SID_PK PRIMARY KEY(SID)
);
--==>> Table TBL_GRADE이(가) 생성되었습니다.

--○ 데이터 추가
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3) VALUES(1, '90', '80', '90');
--==>> 1 행 이(가) 삽입되었습니다.

--○ 조회
SELECT SID, SUB1, SUB2, SUB3
FROM TBL_GRADE;
--==>> 1	90	80	90


--○ STUDENTVIEW 뷰 생성
CREATE OR REPLACE VIEW STUDENTVIEW
AS
SELECT SID, NAME, TEL, 
    (SELECT COUNT(*) 
    FROM TBL_GRADE 
    WHERE SID = S.SID) AS SUB
FROM TBL_STUDENT S;
--==>> View STUDENTVIEW이(가) 생성되었습니다.
-- SUB : STUDENT 데이터 삭제 가능여부 확인


--○ GRADEVIEW 뷰 생성 
CREATE OR REPLACE VIEW GRADEVIEW
AS
SELECT SID
    , (SELECT NAME
        FROM TBL_STUDENT
        WHERE SID = G.SID) AS NAME
    , SUB1, SUB2, SUB3
    , (SUB1 + SUB2 + SUB3) AS TOT
    , ((SUB1+SUB2+ SUB3)/3) AS AVG
    , CASE WHEN ((SUB1+SUB2+ SUB3)/3) >= 90 THEN '합격'
            WHEN ((SUB1+SUB2+ SUB3)/3) >= 60 THEN '과락'
            ELSE '탈락'
        END CH
FROM TBL_GRADE G;
--==>> View GRADEVIEW이(가) 생성되었습니다.

