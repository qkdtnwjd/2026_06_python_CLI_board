use member_db;
DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS actor;
DROP TABLE IF EXISTS casting;

-- 1. 영화 테이블 (movie_id에 AUTO_INCREMENT 추가)
create table movie(
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    r_y INT,                  -- 연도만 입력되므로 DATE -> INT로 수정 (또나 YEAR 타입)
    revenue BIGINT,           -- 금액 단위를 고려해 INT -> BIGINT 변경
    a_c INT,
    rating INT
);

-- 2. 배우 테이블 (b_d 컬럼명 및 spouse_name NULL 허용 수정)
create table actor(
    actor_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    b_d DATE,                 -- insert의 birth_date 대신 테이블 정의된 b_d 사용
    height INT, 
    weight INT, 
    spouse_name VARCHAR(50) NULL  -- 배우자가 없을 수 있으므로 NOT NULL -> NULL 허용
);

-- 3. 캐스팅 테이블
create table casting(
    movie_id INT NOT NULL,
    actor_id INT NOT NULL,
    role_name VARCHAR(50) NOT NULL,
    primary key(movie_id, actor_id),
    constraint fk_casting_movie foreign key(movie_id) references movie(movie_id),
    constraint fk_casting_actor foreign key(actor_id) references actor(actor_id)
);

-- 데이터 삽입: 영화 (movie_id는 AUTO_INCREMENT로 자동 생성)
insert into movie (title, r_y, revenue, a_c, rating)
values ('범죄도시', 2017, 563000000, 688054, 8),
       ('극한직업', 2019, 13960000, 13874824, 8);

-- 데이터 삽입: 배우 (컬럼명 b_d 적용 및 AUTO_INCREMENT 활용)
insert into actor (`name`, b_d, height, weight, spouse_name)
values ('공유', '1979-07-10', 184, 74, null);

-- 데이터 삽입: 캐스팅
insert into casting (movie_id, actor_id, role_name)
values (1, 1, '마석도');

-- 조회
select * from movie;
select * from actor;
select * from casting;




-- 정규화


-- 1.문제 상황(비정규형) 테이블/데이터
DROP TABLE IF EXISTS Student_0;

CREATE TABLE Student_0 (
  student_id VARCHAR(10) NOT NULL,
  student_name VARCHAR(50) NOT NULL,
  course_list  VARCHAR(255) NOT NULL,
  PRIMARY KEY (student_id)
);

INSERT INTO Student_0 ( student_id, student_name, course_list) VALUES
('S01', '김민준', 'C01:DB'),
('S02', '김민준', 'C02:OS'),
('S03', '이서연', 'C01:DB'),
('S04', '박지훈', 'C03:AI'),
('S05', '박지훈', 'C02:OS');

select*
from Student_0

-- 2. 제2정규형

CREATE TABLE Enroll_1NF (
  student_id   VARCHAR(10) NOT NULL,
  course_code  VARCHAR(10) NOT NULL,
  student_name VARCHAR(50) NOT NULL,
  department   VARCHAR(50) NOT NULL,
  course_name  VARCHAR(50) NOT NULL,
  credit       INT NOT NULL,
  grade        CHAR(1) NOT NULL,
  PRIMARY KEY (student_id, course_code)
);

INSERT INTO Enroll_1NF (student_id, course_code, student_name, department, course_name, credit, grade) VALUES
('S01', 'C01', '김민준', '컴공', 'DB', 3, 'A'),
('S01', 'C02', '김민준', '컴공', 'OS', 3, 'B'),
('S02', 'C01', '이서연', '경영', 'DB', 3, 'A');

select*
from Enroll_1NF

-- 1. 학생 테이블 (student_id에 종속된 속성 분리)
CREATE TABLE Student (
  student_id   VARCHAR(10) NOT NULL,
  student_name VARCHAR(50) NOT NULL,
  department   VARCHAR(50) NOT NULL,
  PRIMARY KEY (student_id)
);

-- 2. 과목 테이블 (course_code에 종속된 속성 분리)
CREATE TABLE Course (
  course_code VARCHAR(10) NOT NULL,
  course_name VARCHAR(50) NOT NULL,
  credit      INT NOT NULL,
  PRIMARY KEY (course_code)
);

-- 3. 수강 테이블 (완전 함수 종속 속성인 grade만 유지)
CREATE TABLE Enrollment (
  student_id  VARCHAR(10) NOT NULL,
  course_code VARCHAR(10) NOT NULL,
  grade       CHAR(1) NOT NULL,
  PRIMARY KEY (student_id, course_code),
  FOREIGN KEY (student_id) REFERENCES Student(student_id),
  FOREIGN KEY (course_code) REFERENCES Course(course_code)
);

-- 학생 데이터
INSERT INTO Student (student_id, student_name, department) VALUES
('S01', '김민준', '컴공'),
('S02', '이서연', '경영');

-- 과목 데이터
INSERT INTO Course (course_code, course_name, credit) VALUES
('C01', 'DB', 3),
('C02', 'OS', 3);

-- 수강 데이터
INSERT INTO Enrollment (student_id, course_code, grade) VALUES
('S01', 'C01', 'A'),
('S01', 'C02', 'B'),
('S02', 'C01', 'A');

-- 3. 제 3정규형 문제

CREATE TABLE Order_2NF (
  order_id      VARCHAR(20) NOT NULL,
  customer_id   VARCHAR(20) NOT NULL,
  customer_name VARCHAR(50) NOT NULL,
  customer_grade VARCHAR(20) NOT NULL,
  grade_discount DECIMAL(5,2) NOT NULL,
  order_date    DATE NOT NULL,
  payment_method VARCHAR(20) NOT NULL,
  PRIMARY KEY (order_id)
);

INSERT INTO Order_2NF (order_id, customer_id, customer_name, customer_grade, grade_discount, order_date, payment_method) VALUES
('O100', 'U01', '홍길동', 'GOLD',   0.10, '2026-01-01', 'CARD'),
('O101', 'U02', '김영희', 'SILVER', 0.05, '2026-01-02', 'CASH');

create table customer(
  customer_id   VARCHAR(20) NOT NULL,
  customer_name VARCHAR(50) NOT NULL,
  customer_grade VARCHAR(20) NOT NULL,
  PRIMARY KEY (customer_id)
  );
	
create table `order`(
  order_id    VARCHAR(20) NOT NULL,
  customer_id   VARCHAR(20) NOT NULL,
  order_date    DATE NOT NULL,
  payment_method VARCHAR(20) NOT NULL,
  PRIMARY KEY (order_id)
  );
  
create table grade(
  customer_id 
  customer_grade VARCHAR(20) NOT NULL,
  grade_discount DECIMAL(5,2) NOT NULL
  );
