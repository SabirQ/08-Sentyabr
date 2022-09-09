
--1ci versiya 

create procedure CheckAge
@Birth datetime
as
Declare @Current datetime
Declare @DiffYear int
Declare @DiffMonth int
set @Current=GETDATE()
set @Birth=dateadd(year,18,@Birth)
set @DiffYear=datediff(year,@Current,@Birth)
set @DiffMonth=datediff(month,@Current,@Birth)

IF(datediff(year,@Birth,@Current)>0)
print '18 yashina catib il'
ELSE IF(datediff(year,@Birth,@Current)=0)
 begin
 IF(datediff(month,@Birth,@Current)<0)
 print '18 yashina catib ay' 
 ELSE IF(datediff(month,@Birth,@Current)=0)
   begin
   IF(datediff(day,@Birth,@Current)<0)
   print '18 yashina catib'
   ELSE IF(datediff(day,@Birth,@Current)=0)
   print 'today is your 18th birth day, happy birthday :))'
   ELSE
   print '18 yashina catmaq ucun '+Cast(datediff(day,@Birth,@Current)as nvarchar)+'GUN qalib'
   end
 ELSE
 print '18 yashina catmaq ucun '+Cast(datediff(month,@Birth,@Current)as nvarchar)+' ay qalib' 
 end
ELSE
begin
IF(@DiffMonth-(@DiffYear*12)<0)
begin
set @DiffYear-=1
 set @DiffMonth=(@DiffMonth-(@DiffYear*12)-12)*-1
end
ELSE
begin
set @DiffMonth=@DiffMonth-(@DiffYear*12)
end
print '18 yashina catmaq ucun ' +Cast(@DiffYear as nvarchar)+' il ve '+
Cast(@DiffMonth as nvarchar)+' ay qalib'
 end

 exec CheckAge '2004-09-05'
 exec CheckAge '2004-06-30'
 exec CheckAge '2007-01-30'
 exec CheckAge '2000-06-30'
 go

--2ci versiya optimal

create procedure OptimalVersionCheck(@date smalldatetime)
    as
    begin
	Declare @date2 smalldatetime
	Declare @date3 smalldatetime
    Declare @month int
	Declare @year int
	Declare @day int
	set @date=Dateadd(year,18,@date)
	set @date2=GETDATE()

IF(datediff(year,@date,@date2)>0)
begin
print '18 yashina catib'
   RETURN
  end
ELSE IF(datediff(year,@date,@date2)=0)
 begin
 IF(datediff(month,@date,@date2)>0)
 begin
 print '18 yashina catib' 
  RETURN
 end
 ELSE IF(datediff(month,@date,@date2)=0)
   begin
   IF(datediff(day,@date,@date2)>0)
   begin
   print '18 yashina catib' 
    RETURN
   end
   ELSE IF(datediff(day,@date,@date2)=0)
   begin
   print 'today is your 18th birth day, happy birthday :))'
   RETURN
    end
   end
 end
 if @date>@date2
     begin
     set @date3=@date2
     set @date2=@date
     set @date=@date3
     end
    SELECT @month=datediff (MONTH,@date,@date2)

    if dateadd(month,@month,@date) >@date2
    begin
    set @month=@month-1
    end
    set @day=DATEDIFF(day,dateadd(month,@month,@date),@date2)
    set @year=@month/12
    set @month=@month % 12
    print (case when @year=0 then '' when @year=1 then convert(nvarchar(50),@year ) + ' year ' when @year>1 then convert(nvarchar(50),@year ) + ' years ' end)
    + (case when @month=0 then '' when @month=1 then convert(nvarchar(50),@month ) + ' month ' when @month>1 then convert(nvarchar(50),@month ) + ' months ' end)
    + (case when @day=0 then '' when @day=1 then convert(nvarchar(50),@day ) + ' day ' when @day>1 then convert(nvarchar(50),@day ) + ' days ' end)
    end

	go

 exec OptimalVersionCheck '2004-10-05'
 exec OptimalVersionCheck '2004-06-30'
 exec OptimalVersionCheck '2007-01-30'
 exec OptimalVersionCheck '2000-06-30'