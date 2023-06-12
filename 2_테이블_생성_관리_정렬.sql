-- HRDB2 데이터베이스 생성
use master

create database HRDB2

-- 직원 테이블 생성
use HRDB2

create table dbo.직원 (
	사원번호 char(5) not null,
	이름 nchar(10) not null,
	성별 char(1) not null,
	입사일 date not null,
	전자우편 varchar(60) not null,
	부서코드 char(3) not null
	)

-- 열 추가
alter table dbo.직원
	add 급여 int null

-- 기존 테이블에 not null 속성 추가 (기존 데이터들이 null값이 되어야 하므로 오류 발생)
insert into dbo.직원
	values('S0001', N'홍길동', 'M', '2011-01-01', 'hong@dbnuri.com', 'SYS', 8500)
insert into dbo.직원
	values('S0002', N'일지매', 'M', '2011-01-12', 'jimae@dbnuri.com', 'GEN', 8200)

alter table dbo.직원
	add EngName varchar(20) not null
/*메시지 4901, 수준 16, 상태 1, 줄 28
ALTER TABLE은 Null 값을 포함하거나 DEFAULT 정의가 지정된 열만 추가할 수 있습니다. 
또는 추가되는 열이 ID 또는 타임스탬프 열이어야 합니다. 앞의 조건이 모두 만족되지 않을 경우 테이블이 비어 있어야 이 열을 추가할 수 있습니다. 
열 'EngName'은(는) 이러한 조건을 만족하지 않으므로 비어 있지 않은 테이블 '직원'에 추가할 수 없습니다.
*/


-- default 제약, identity 속성을 사용하면 기존 테이블에 not null 속성의 열 추가 가능
-- default 제약
alter table dbo.직원
	add EngName varchar(20) default('') not null

-- identity 속성 (자동 증가 값 저장)
alter table dbo.직원
	add CheckID int IDENTITY(1,1) not null

select * from dbo.직원

--------------------------------------------

-- 열 삭제
alter table dbo.직원
	drop column 급여

-- 열 변경
alter table dbo.직원
	alter column 이름 nvarchar(20) not null -- nvarchar(10)->nvarchar(20)

-- 열 이름 변경 (시스템 저장 프로시저 이용 sp_rename) 전자우편->이메일
exec sp_rename 'dbo.직원.전자우편', '이메일', 'COLUMN' -- exec(execute)는 저장 프로시저 호출 구문

-- 테이블 이름 변경 직원->직원정보
exec sp_rename 'dbo.직원', '직원정보', 'OBJECT'

-- 테이블 삭제 
drop table dbo.직원정보

-----------------------------------------------------------

-- 데이터 정렬 설정X, HRDB2데이터베이스의 데이터 정렬을 따르게 된다.
create table dbo.직원 (
	사원번호 char(5) not null,
	이름 nchar(10) not null,
	성별 char(1) not null,
	입사일 date not null,
	전자우편 varchar(60) not null,
	부서코드 char(3) not null
	)

-- 데이터 정렬 정보 확인
-- SQL Server 데이터 정렬 확인
select SERVERPROPERTY('collation')

-- sol1) HRDB2 데이터베이스 데이터 정렬 확인
select DATABASEPROPERTYEX('HRDB2', 'collation')

-- sol2) HRDB2 데이터베이스 데이터 정렬 확인
select collation_name
	from sys.databases
	where name = 'HRDB2'

/*위의 3개 쿼리 결과 : Korean_Wansung_CI_AS*/

--------------------------------------------

-- 정렬 방식 지정하여 테이블 다시 만들기
-- 기존 테이블 삭제
drop table dbo.직원

-- 테이블 만들기
create table dbo.직원 (
	사원번호 char(5) COLLATE Korean_Wansung_CI_AS not null,
	이름 nchar(10) COLLATE Korean_Wansung_CI_AS not null,
	성별 char(1) COLLATE Korean_Wansung_CI_AS not null,
	입사일 date not null,
	전자우편 varchar(60) COLLATE Korean_Wansung_CI_AS not null,
	부서코드 char(3) COLLATE Korean_Wansung_CI_AS not null
	)

--------------------------------------------

-- 데이터 추가
insert into dbo.직원
	values('S0001', N'홍길동', 'M', '2011-01-01', 'hong@dbnuri.com', 'SYS')
insert into dbo.직원
	values('S0002', N'일지매', 'm', '2011-01-12', 'jimae@dbnuri.com', 'GEN')
insert into dbo.직원
	values('S0004', N'김삼순', 'F', '2012-08-01', 'samsun@dbnuri.com', 'MKT')

-- 대소문자 구분 여부 확인 -> 구분X
select 사원번호, 이름, 성별, 입사일, 전자우편, 부서코드
from dbo.직원
where 성별='M'

-- 쿼리 수행 시만 데이터 정렬 방식 변경 -> 대문자만 조회
select 사원번호, 이름, 성별, 입사일, 전자우편, 부서코드
from dbo.직원
where 성별='M' COLLATE Korean_Wansung_CS_AS