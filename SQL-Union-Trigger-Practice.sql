

select [FullName] from Students
union
select [FullName] from Teachers

select [FullName] from Students
union all
select [FullName] from Teachers

select [FullName] from Students
intersect
select [FullName] from Teachers

select [FullName] from Students
except
select [FullName] from Teachers


create table Doctors(
	[Id] int primary key identity(1,1),
	[FullName] nvarchar(50),
	[Address] nvarchar(100),
)

delete from Doctors

truncate table Doctors

select Count(*) as 'Count',Age
from Students
group by Age
order by Age desc


DECLARE @Counter INT 
SET @Counter = 1
WHILE (@Counter <= 10)
BEGIN
    PRINT 'The counter value is = ' + CONVERT(VARCHAR, @Counter)
    SET @Counter = @Counter  + 1
END


select GETDATE()


create table StudentLogs(
	[Id] int primary key identity(1,1),
	[StudentId] int,
	[Operation] nvarchar(20),
	[Date] datetime
)


select * from StudentLogs


create trigger trg_writeLogAfterCreate on Students
after insert
as
begin
	insert into StudentLogs([StudentId],[Operation],[Date])
	select [Id],'Insert',GETDATE() from inserted
end


insert into Students([FullName],[Email],[Age],[Address],[CityId])
values('Omer Elesgerli','omer@code.edu.az',16,'Xetai',2)


select * from StudentLogs
select * from Students



create trigger trg_writeLogAfterEdit on Students
after update
as
begin
	insert into StudentLogs([StudentId],[Operation],[Date])
	select [Id],'Update',GETDATE() from deleted
end


update Students
set [Email] = 'test@gmail.com'
where [Id] = 1

update Students
set [Email] = 'test2@code.edu.az'
where [Id] = 2


select * from StudentLogs where [Operation] = 'Update'
order by [Date] desc


create table EmployeeUpdateLogs(
	[Id] int primary key identity(1,1),
	[EmployeeName] nvarchar(50),
	[OldEmail] nvarchar(100),
	[NewEmail] nvarchar(100),
	[Date] datetime 
)

create trigger trg_writeLogAfterEditEmail on Employees
after update 
as
begin
	declare @oldEmail nvarchar(50) = (select [Email] from deleted)
	declare @fullname nvarchar(50) = (select [Name] from deleted)
	declare @newEmail nvarchar(50) = (select [Email] from inserted)
	insert into EmployeeUpdateLogs([EmployeeName],[OldEmail],[NewEmail],[Date])
	values(@fullname,@oldEmail,@newEmail,GETDATE())
end


select * from Employees
select * from EmployeeUpdateLogs


update Employees
set [Email] = 'test3@gmail.com'
where [Id] = 13