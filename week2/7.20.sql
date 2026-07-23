CREATE DATABASE emp;
EXIT;

USE emp;

SHOW TABLES;

SELECT * FROM channels;
SELECT * FROM employees;

select *
	,rank() over(partition by department_id
	order by salary desc) as rnk
from employees;

-- 부서별 연봉 가장 높은 직원 1명씩 조회

select *
	,rank() over(partition by department_id
	order by salary desc) as rnk
	from employees
    where department_id is not null 
where rnk =1;

-- 직원이름 급여 부서 평균급여,전체 평균급여

select emp_name
	,salary
	,avg(salary) over(partition by department_id) as 부서평균
    ,avg(salary) over() as 전체평균
from employees;

-- 부서별 급여 평균 순위를 출력하시오
select t1.department_id
	,rank() over(order by t1.부서평균 desc) as  순위
    ,round(t1.부서평균,2) as 평균
from(select department_id
	, avg(salary) as 부서평균
	from employees
	where department_id is not null
	group by department_id) t1
;

-- LAG 선행 행에 접근
-- LEAD 후행 행에 접근
select emp_name, department_id, salary
	,lag(emp_name, 1 ,'가장높음')
    over(partition by department_id
		order by salary desc) as lag_name
	,load(emp_name, 1 ,'가장낮음')
    over(partition by department_id
		order by salary desc) as lag_name
from employees
where department_id in (30,60);

-- 각 전공별 평점을 기준으로 한 단계
-- 높은 평점을 가진 학생과 평점차이를 출력하시오

use member_db;

select 이름, 전공, 평점
	,lag(이름,1,'1등') over(partition by 전공
							order by 평점 desc) as 비교학생
	,lag(평점,1,0) over(partition by 전공
							order by 평점 desc) as 비교학생평점
	,lag(이름,1,0) over(partition by 전공
							order by 평점 desc)-평점 as 차이
								
from 학생;

-- 대출 년월별 누적 합계를 출력하시오
use emp;

select period, sum(합계) over(order by period
											rows between unbounded preceding
											and current row) as 누적합계
from(select period , sum(loan_jan_amt) 합계
		
	from kor_loan_status

	group by period) t2;
    
    
-- 연습문제   

-- join

select*
from member a
left join cart b
on a.men_id = b.cart_memeber
left join prod c
on b.cart_prod = c.prod_id

-- 문제 :  2000년도 판매(금액)왕을 출력하시오 (sales 테이블 활용)

select*
from sales 

select*
from countries

select*
from customers

select *
from sales 
inner join customers
on sales.cust_id = customers.cust_id 

