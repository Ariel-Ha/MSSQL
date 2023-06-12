-- 1-1 �̸��� �ְ� �����ͺ��̽� �����
use master
go

create database FirstDB02
go

-- 1-2 �䱸���׿� �´� �����ͺ��̽� �����
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

-- ���������� ���� �׷�, ���� �߰�---------------
use master

-- UFG01 ���� �׷� �߰�
alter database FirstDB02
	add filegroup UFG01

-- UFG01 ���� �׷쿡 ���� �߰�
alter database FirstDB02
	add file (
		name = 'FirstDB02_02',
		filename = 'D:\SQLData\FirstDB02_02.ndf',
		size = 512MB,
		filegrowth = 128MB
		) to filegroup UFG01

-- UFG02 ���� �׷� �߰�
alter database FirstDB02
	add filegroup UFG02

-- UFG02 ���� �׷쿡 ���� �߰�
alter database FirstDB02
	add file (
		name = 'FirstDB02_03',
		filename = 'D:\SQLData\FirstDB02_03.ndf',
		size = 512MB,
		filegrowth = 128MB
		) to filegroup UFG02

use FirstDB02

-- UFG01 ���� �׷��� �⺻ ���� �׷����� ����
alter database FirstDB02
	modify filegroup UFG01 default

------------------------------------------

-- ���̺� ���� �� ���� �׷� �����ϱ� on �� ���, ���� �� �⺻ ���� �׷쿡 ���̺��� ����--------
use FirstDB02

-- PRIMARY ���� �׷쿡 TA ���̺� �����
create table TA(
	col1 int,
	col2 int
	) on [PRIMARY] -- PRIMARY�� Ű�����̹Ƿ� ���ȣ�� ���ξ� �Ѵ�.

-- UFG01 ���� �׷쿡 TB ���̺� �����
create table TB(
	col1 int,
	col2 int
	) on UFG01

-- UFG02 ���� �׷쿡 TC ���̺� �����
create table TC(
	col1 int,
	col2 int
	) on UFG02

-- �⺻ ���� �׷쿡 TD ���̺� ����� (FirstDB02 �����ͺ��̽��� �⺻ ���� �׷��� UFG01�� ���������Ƿ� UFG01�� �����ȴ�.)
create table TD(
	col1 int,
	col2 int
	) 

----------------------------------