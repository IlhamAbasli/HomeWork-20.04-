create database Course

use Course


create table Students(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50),
	[Surname] nvarchar(50),
	[Age] int,
	[Email] nvarchar(50),
	[Address] nvarchar(200)
)

select * from Students


create procedure usp_deleteStudent
@studentId int
as
begin 
	delete from Students where [Id] = @studentId
end


exec usp_deleteStudent 3

create table StudentArchives(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50),
	[Surname] nvarchar(50),
	[Age] int,
	[Email] nvarchar(50),
	[Address] nvarchar(200)
)


create trigger trg_addStudentToArchive on Students
after delete
as
begin
	insert into StudentArchives([Name],[Surname],[Age],[Email],[Address])
	select [Name],[Surname],[Age],[Email],[Address] from deleted
end

select * from StudentArchives