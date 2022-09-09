create database Task08_09

use Task08_09

create table Countries(
    Id int primary key identity,
    CountryName nvarchar(50) UNIQUE  not null,
    Code nvarchar(10) UNIQUE not null,
);

create table Cities(
    Id int primary key identity,
    CityName nvarchar(50) UNIQUE not null,
	CountyId int foreign key references Countries(Id) not null,
    Code nvarchar(10) UNIQUE,
);
create table Districts(
    Id int primary key identity,
    DistrictName nvarchar(50) UNIQUE not null,
	CountyId int foreign key references Countries(Id) not null,
	CityId int foreign key references Cities(Id) not null,
    Code nvarchar(10) UNIQUE,
);
create table Towns(
    Id int primary key identity,
    TownName nvarchar(50) UNIQUE not null,
	CountyId int foreign key references Countries(Id) not null,
	CityId int foreign key references Cities(Id) not null,
	DistrictId int foreign key references Districts(Id) not null,
    Code nvarchar(10) UNIQUE,
);
go
Create procedure StoreProcedure
@Country nvarchar(50),
@City nvarchar(50)=NULL,
@District nvarchar(50)=NULL,
@Town nvarchar(50)=NULL
AS
begin
IF(@City=NULL)
begin
 IF((select Count(CountryName) from Countries where CountryName=@Country)<1)
 insert into Countries values(@Country,(select substring(@Country,1,2)))
 ELSE
 print 'Country exists'
 end
ELSE IF(@District=NULL )
begin
 IF((select Count(CountryName) from Countries where CountryName=@Country)=0)
 insert into Countries values(@Country,(select substring(@Country,1,3)))
 ELSE
 print 'Country exists'
 IF((select Count(CityName) from Cities where CityName=@City)=0)
 insert into cities values(@City,(select Id from Countries where CountryName=@Country),(select substring(@City,1,3)))
 ELSE
 print 'City exists'
end
ELSE IF(@Town=NULL)
begin
 IF((select Count(CountryName) from Countries where CountryName=@Country)=0)
 insert into Countries values(@Country,(select substring(@Country,1,3)))
 ELSE
 print 'Country exists'
 IF((select Count(CityName) from Cities where CityName=@City)=0)
 insert into cities values(@City,(select Id from Countries where CountryName=@Country),(select substring(@City,1,3)))
 ELSE
 print 'City exists'
 IF((select Count(DistrictName) from Districts where DistrictName=@District)=0)
 insert into districts values(@District,(select Id from Countries where CountryName=@Country),(select Id from Cities where CityName=@City),(select substring(@District,1,3)))
 ELSE
 print 'District exists'
end
ELSE
begin
 IF((select Count(CountryName) from Countries where CountryName=@Country)=0)
 insert into Countries values(@Country,(select substring(@Country,1,3)))
 ELSE
 print 'Country exists'
 IF((select Count(CityName) from Cities where CityName=@City)=0)
 insert into cities values(@City,(select Id from Countries where CountryName=@Country),(select substring(@City,1,3)))
 ELSE
 print 'City exists'
 IF((select Count(DistrictName) from Districts where DistrictName=@District)=0)
 insert into districts values(@District,(select Id from Countries where CountryName=@Country),(select Id from Cities where CityName=@City),(select substring(@District,1,3)))
 ELSE
 print 'District exists'
 IF((select Count(TownName) from Towns where TownName=@Town)=0)
 insert into towns values(@Town,(select Id from Countries where CountryName=@Country),(select Id from Cities where CityName=@City),(select Id from Districts where DistrictName=@District),(select substring(@Town,1,3)))
 ELSE
 print 'Town exists'
end

end

go
exec dbo.StoreProcedure 'turkiye','istambul','beshiktash','cihannüma'
exec dbo.StoreProcedure 'turkiye','ankara','randomdistrict','randomtown'



select * from Countries
select * from Cities
select * from Districts
select * from Towns