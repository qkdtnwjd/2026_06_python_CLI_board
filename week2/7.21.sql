use member_db;

-- regexp_like : 검증, 필터링 
select mem_name, mem_comtel
from member
where regexp_like(mem_comtel,'^..-'); --  임의 글자2 + 패턴

select mem_name, mem_comtel
from member
where regexp_like(mem_comtel,'^[0-9]{2}-');

-- [0-9] [a-z] [A-Z] [가-힣]
-- [a-zA-Z] 

-- 주소에서 한글로 끝나는 패턴 찾기
select mem_name, mem_add2
from member
where  regexp_like(mem_add2,'[0-9]+[가-힣]$'); -- 숫자포함하고 한글로끝나는

--  *:0이상, +:1이상, {n}:n회반복, {n,m} n이상m이하 반복
-- mem_add2에 한글이 3-5회 출현하는 주소 검색

select mem_name, mem_add2
from member
where  regexp_like(mem_add2,'[가-힣]{3,5}');

-- 한글만 있는 주소 

select mem_name, mem_add2
from member
where  regexp_like(mem_add2,'^[가-힣]+$');

-- 한글만 없는 주소

select mem_name, mem_add2
from member
where  not regexp_like(mem_add2,'[가-힣]');

-- 이름이 '이'로 시작하고 끝이 이 or 영 으로 끝나는 회원 검색alter
select mem_name
from member
where  regexp_like(mem_name,'^이.(이|영)');

-- regexp_substr : 대상 문자열에서 정규식 패턴에 맞는 부분 추출(숫자,코드,토큰)
select regexp_substr('A-B-C', '[^-]+',1,1) as sub1
	  ,regexp_substr('A-B-C', '[^-]+',1,2) as sub2
	  ,regexp_substr('A-B-C', '[^-]+',1,3) as sub3
	  ,regexp_substr('A-B-C', '[^-]+',1,4) as sub4

-- mem_mail에서 @ 기준으로 나눔
select regexp_substr(mem_mail,'[^@]+',1,1) as 'id'
	 ,regexp_substr(mem_mail,'[^@]+',1,2) as 'domain'
		
from member

-- regexp_replace : 문자열, 패턴, 대체문자열, (삭제,마스킹)
select regexp_replace ('HELLO',' ', ' ') as re1,
		regexp_replace ('HELLO','[ ]{2,}', ' ') as re2
        
-- member mem_add2에서 한글은 제거하여 출력
select regexp_replace(mem_add2,'[가-힣]','' )as 한글주소삭제
from member



CREATE TABLE tb_regex_demo (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  email VARCHAR(100),
  phone VARCHAR(30),
  content VARCHAR(200)
);

INSERT INTO tb_regex_demo(name,email,phone,content) VALUES
('Kim','nick@gmail.com','010-1234-5678','hello world'),
('Lee','test@naver.com','01012345678','this is good'),
('Park','bad_email@','010-12-5678','바보 같은 실수'),
('Choi','user@domain.co.kr','011-2222-3333','normal text'),
('Han','aa.bb+cc@kakao.com','010-9999-8888','image: cat.png'),
('Jung','abc@abc','010-0000-0000','gif file: a.gif');

-- 문제1 email 컬럼이 gmail.com으로 끝나는 행만 조회

select *
from tb_regex_demo
where regexp_like(email,'(@gmail.com)$');

-- 문제2 컬럼이 010으로 시작하는 행만 조회

select *
from tb_regex_demo
where regexp_like(phone,'^(010)');

-- 문제3 컬럼에서 도메인 부분을 @***로 마스킹하여 조회
select*, regexp_replace(email,'[^@]+$','***') as masked_email
from tb_regex_demo

-- 문제4 

select*
from tb_regex_demo
where regexp_like(email,'[a-z]+@+[a-z]+(.com)')
and regexp_like(phone,'^(010)')
and regexp_like(content,'(png)$');


