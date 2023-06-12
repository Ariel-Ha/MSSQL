-- HRDB2 �����ͺ��̽� ����
use master

create database HRDB2

-- ���� ���̺� ����
use HRDB2

create table dbo.���� (
	�����ȣ char(5) not null,
	�̸� nchar(10) not null,
	���� char(1) not null,
	�Ի��� date not null,
	���ڿ��� varchar(60) not null,
	�μ��ڵ� char(3) not null
	)

-- �� �߰�
alter table dbo.����
	add �޿� int null

-- ���� ���̺� not null �Ӽ� �߰� (���� �����͵��� null���� �Ǿ�� �ϹǷ� ���� �߻�)
insert into dbo.����
	values('S0001', N'ȫ�浿', 'M', '2011-01-01', 'hong@dbnuri.com', 'SYS', 8500)
insert into dbo.����
	values('S0002', N'������', 'M', '2011-01-12', 'jimae@dbnuri.com', 'GEN', 8200)

alter table dbo.����
	add EngName varchar(20) not null
/*�޽��� 4901, ���� 16, ���� 1, �� 28
ALTER TABLE�� Null ���� �����ϰų� DEFAULT ���ǰ� ������ ���� �߰��� �� �ֽ��ϴ�. 
�Ǵ� �߰��Ǵ� ���� ID �Ǵ� Ÿ�ӽ����� ���̾�� �մϴ�. ���� ������ ��� �������� ���� ��� ���̺��� ��� �־�� �� ���� �߰��� �� �ֽ��ϴ�. 
�� 'EngName'��(��) �̷��� ������ �������� �����Ƿ� ��� ���� ���� ���̺� '����'�� �߰��� �� �����ϴ�.
*/


-- default ����, identity �Ӽ��� ����ϸ� ���� ���̺� not null �Ӽ��� �� �߰� ����
-- default ����
alter table dbo.����
	add EngName varchar(20) default('') not null

-- identity �Ӽ� (�ڵ� ���� �� ����)
alter table dbo.����
	add CheckID int IDENTITY(1,1) not null

select * from dbo.����

--------------------------------------------

-- �� ����
alter table dbo.����
	drop column �޿�

-- �� ����
alter table dbo.����
	alter column �̸� nvarchar(20) not null -- nvarchar(10)->nvarchar(20)

-- �� �̸� ���� (�ý��� ���� ���ν��� �̿� sp_rename) ���ڿ���->�̸���
exec sp_rename 'dbo.����.���ڿ���', '�̸���', 'COLUMN' -- exec(execute)�� ���� ���ν��� ȣ�� ����

-- ���̺� �̸� ���� ����->��������
exec sp_rename 'dbo.����', '��������', 'OBJECT'

-- ���̺� ���� 
drop table dbo.��������

-----------------------------------------------------------

-- ������ ���� ����X, HRDB2�����ͺ��̽��� ������ ������ ������ �ȴ�.
create table dbo.���� (
	�����ȣ char(5) not null,
	�̸� nchar(10) not null,
	���� char(1) not null,
	�Ի��� date not null,
	���ڿ��� varchar(60) not null,
	�μ��ڵ� char(3) not null
	)

-- ������ ���� ���� Ȯ��
-- SQL Server ������ ���� Ȯ��
select SERVERPROPERTY('collation')

-- sol1) HRDB2 �����ͺ��̽� ������ ���� Ȯ��
select DATABASEPROPERTYEX('HRDB2', 'collation')

-- sol2) HRDB2 �����ͺ��̽� ������ ���� Ȯ��
select collation_name
	from sys.databases
	where name = 'HRDB2'

/*���� 3�� ���� ��� : Korean_Wansung_CI_AS*/

--------------------------------------------

-- ���� ��� �����Ͽ� ���̺� �ٽ� �����
-- ���� ���̺� ����
drop table dbo.����

-- ���̺� �����
create table dbo.���� (
	�����ȣ char(5) COLLATE Korean_Wansung_CI_AS not null,
	�̸� nchar(10) COLLATE Korean_Wansung_CI_AS not null,
	���� char(1) COLLATE Korean_Wansung_CI_AS not null,
	�Ի��� date not null,
	���ڿ��� varchar(60) COLLATE Korean_Wansung_CI_AS not null,
	�μ��ڵ� char(3) COLLATE Korean_Wansung_CI_AS not null
	)

--------------------------------------------

-- ������ �߰�
insert into dbo.����
	values('S0001', N'ȫ�浿', 'M', '2011-01-01', 'hong@dbnuri.com', 'SYS')
insert into dbo.����
	values('S0002', N'������', 'm', '2011-01-12', 'jimae@dbnuri.com', 'GEN')
insert into dbo.����
	values('S0004', N'����', 'F', '2012-08-01', 'samsun@dbnuri.com', 'MKT')

-- ��ҹ��� ���� ���� Ȯ�� -> ����X
select �����ȣ, �̸�, ����, �Ի���, ���ڿ���, �μ��ڵ�
from dbo.����
where ����='M'

-- ���� ���� �ø� ������ ���� ��� ���� -> �빮�ڸ� ��ȸ
select �����ȣ, �̸�, ����, �Ի���, ���ڿ���, �μ��ڵ�
from dbo.����
where ����='M' COLLATE Korean_Wansung_CS_AS