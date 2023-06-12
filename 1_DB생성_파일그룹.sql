-- 1-1 이름만 주고 데이터베이스 만들기
use master
go

create database FirstDB02
go

-- 1-2 요구사항에 맞는 데이터베이스 만들기
use master
go

create database SeconDB02
on primary(
	name = 'SeconDB02',
	filename = 'D:\SQLData\SeconDB02.mdf',
	size = 1024MB,
	maxsize = unlimited,
	filegrowth = 256MB
	)

log on (
	name = 'SeconDB_log',
	filename = 'D:\SQLLog\SeconDB02_log.ldf',
	size = 256MB,
	maxsize = unlimited,
	filegrowth = 128MB
	)
go

-- 쿼리문으로 파일 그룹, 파일 추가---------------
use master

-- UFG01 파일 그룹 추가
alter database FirstDB02
	add filegroup UFG01

-- UFG01 파일 그룹에 파일 추가
alter database FirstDB02
	add file (
		name = 'FirstDB02_02',
		filename = 'D:\SQLData\FirstDB02_02.ndf',
		size = 512MB,
		filegrowth = 128MB
		) to filegroup UFG01

-- UFG02 파일 그룹 추가
alter database FirstDB02
	add filegroup UFG02

-- UFG02 파일 그룹에 파일 추가
alter database FirstDB02
	add file (
		name = 'FirstDB02_03',
		filename = 'D:\SQLData\FirstDB02_03.ndf',
		size = 512MB,
		filegrowth = 128MB
		) to filegroup UFG02

use FirstDB02

-- UFG01 파일 그룹을 기본 파일 그룹으로 변경
alter database FirstDB02
	modify filegroup UFG01 default

------------------------------------------

-- 테이블 만들 때 파일 그룹 지정하기 on 절 사용, 생략 시 기본 파일 그룹에 테이블을 생성--------
use FirstDB02

-- PRIMARY 파일 그룹에 TA 테이블 만들기
create table TA(
	col1 int,
	col2 int
	) on [PRIMARY] -- PRIMARY는 키워드이므로 대괄호로 감싸야 한다.

-- UFG01 파일 그룹에 TB 테이블 만들기
create table TB(
	col1 int,
	col2 int
	) on UFG01

-- UFG02 파일 그룹에 TC 테이블 만들기
create table TC(
	col1 int,
	col2 int
	) on UFG02

-- 기본 파일 그룹에 TD 테이블 만들기 (FirstDB02 데이터베이스의 기본 파일 그룹을 UFG01로 지정했으므로 UFG01에 생성된다.)
create table TD(
	col1 int,
	col2 int
	) 

----------------------------------