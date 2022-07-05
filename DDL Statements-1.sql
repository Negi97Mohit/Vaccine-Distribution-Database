
-- =============================================
-- Author:    Team-8
-- Date:      08/07/2021   
-- =============================================

--Created Database on College Server and imported flat files in it.
Create Database Team8_Database;
use Team8_Database;

----------------------------------------------------------------------------
								--DDL : Table Creation 
----------------------------------------------------------------------------
--Table Structures 
--Creating the Customers Table
create table dbo.Customers(
	CustomerID int identity(1,1) not null primary key,
	CustomerFirstName varchar(50) not null ,
	CustomerLastName varchar(50) not null ,
	Age int not null ,
	StreetNumber int not null,
	City varchar(50) not null,
	State varchar(50) not null ,
	ZipCode int not null,
	FirstDoseDate datetime ,
	SecondDoseDate datetime ,
	FirstDoseDateFeedback varchar(50) not null ,
	SecondDoseDateFeedback varchar(50) not null ,
)

--Area Table
create table dbo.Area(
	AreaID int identity(1,1) not null primary key,
	AreaName varchar(50) not null,
	City varchar(50) not null,
	State varchar(50) not null,
	ZipCode int  not null,
	TotalVaccinated int not null,
	ActiveCases int not null
)

--AreaAdmin Table
create table dbo.AreaAdmin(
	AdminID int identity(1,1) not null primary key,
	AdminFirstName varchar(50) not null ,
	AdminLastName varchar(50) not null ,
	AdminUsername varchar(50) not null,
	AdminPassword varchar(50) not null,
	State varchar(50) not null ,
	AreaID int not null
		references Area(AreaID),
	CustomerID int not null
		references Customer(CustomerID),
)

/*Main LookUp table, which consists of all the Hospital,Pharmacy,VaccinationCenters,
  including Vaccine manufacturer ID */
create table dbo.AreaVaccineDistribution(
	LookupID int identity(1,1) not null primary key,
	HospitalID int not null
		references Hospital(HospitalID),
	PharmacyID int not null
			references Pharmacy(PharmacyID),	
	VacCenteryID int not null
			references VaccineCenter(VacCenterID),
	AreaID int not null
		references Area(AreaID),		
	VaccineManuID int not null
		references VaccineManufacturers(VacManuID)

)

--Vaccination Center
create table dbo.VaccineCenter(
	VacCenterID int identity(1,1) not null primary key,
	PharmacyName varchar(50) not null,
	StreetNumber int not null,
	AreaID int not null
		references Area(AreaID),
	PharmacyPDID int not null
			references VaccineCenterPurchaseDepartment(VacCenterPDID),
	PharmacyIID int not null
			references VaccineCenterInventoryDepartment(VacCenterIID)
)

--VacCenter Purchase Department
create table dbo.VaccineCenterPurchaseDepartment(
	VacCenterPDID int identity(1,1) not null primary key,
	PurchaseNo int not null,
	VaccineManuID int not null
		references VaccineManufacturers(VacManuID),
	HospitalPurchaseNoID int not null
		references VaccineCenterPurchaseOrder(VacCenterPurchaseNoID)
)

--VacCenter Purchase Order
create table dbo.VaccineCenterPurchaseOrder(
	VacCenterPurchaseNoID int identity(1,1) not null primary key,
	VacManuID int not null
		references VaccineManufacturers(VacManuID),
	PurchaseDate int not null,
	Quantity int not null,
	BatchNo int not null,
	TotalCost int not null,
	CostPerDose int not null,
	TransportID int not null
)

--VacCenter Inventory
create table dbo.VaccineCenterInventoryDepartment(
	VacCenterIID int identity(1,1) not null primary key,
	LstDelivery datetime not null,
	TotalVolumeInStock int ,
	VaccineCenterPruchaseNoID int not null
		references VaccineCenterPurchaseOrder(VacCenterPurchaseNoID)
)

--Pharmacy
create table dbo.Pharmacy(
	PharmacyID int identity(1,1) not null primary key,
	PharmacyName varchar(50) not null,
	StreetNumber int not null,
	AreaID int not null
		references Area(AreaID),
	PharmacyPDID int not null
			references PharmacyPurchaseDepartment(PharmacyPDID),
	PharmacyIID int not null
			references PharmacyInventoryDepartment(PharmacyIID)
)

--Pharmacy Purchase Department
create table dbo.PharmacyPurchaseDepartment(
	PharmacyPDID int identity(1,1) not null primary key,
	PurchaseNo int not null,
	VaccineManuID int not null
		references VaccineManufacturers(VacManuID),
	HospitalPurchaseNoID int not null
		references PharmacyPurchaseOrder(PharmacyPurchaseNoID)
)

--Pharmacy Purchase Order
create table dbo.PharmacyPurchaseOrder(
	PharmacyPurchaseNoID int identity(1,1) not null primary key,
	VacManuID int not null
		references VaccineManufacturers(VacManuID),
	PurchaseDate int not null,
	Quantity int not null,
	BatchNo int not null,
	TotalCost int not null,
	CostPerDose int not null,
	TransportID int not null
)

--Pharmacy Inventory Department
create table dbo.PharmacyInventoryDepartment(
	PharmacyIID int identity(1,1) not null primary key,
	LstDelivery datetime not null,
	TotalVolumeInStock int ,
	PharmacyPruchaseNoID int not null
		references PharmacyPurchaseOrder(PharmacyPurchaseNoID)
)

--Hospital
create table dbo.Hospital(
	HospitalID int identity(1,1) not null primary key,
	HospitalName varchar(50) not null,
	StreetNumber int not null,
	AreaID int not null
		references Area(AreaID),
	HospitalPDID int not null
			references HospitalPurchaseDepartment(HospitalPDID),
	HospitalIID int not null
			references HospitalInventoryDepartment(HospitalIID)

)

--Hospital Purchase Department
create table dbo.HospitalPurchaseDepartment(
	HospitalPDID int identity(1,1) not null primary key,
	PurchaseNo int not null,
	VaccineManuID int not null
		references VaccineManufacturers(VacManuID),
	HospitalPurchaseNoID int not null
		references HospitalPurchaseOrder(HospitalPurchaseNoID)
)

--Hospital Purchase Order
create table dbo.HospitalPurchaseOrder(
	HospitalPurchaseNoID int identity(1,1) not null primary key,
	VacManuID int not null
		references VaccineManufacturers(VacManuID),
	PurchaseDate int not null,
	Quantity int not null,
	BatchNo int not null,
	TotalCost int not null,
	CostPerDose int not null,
	TransportID int not null
)

--Hospital Inventory
create table dbo.HospitalInventoryDepartment(
	HospitalIID int identity(1,1) not null primary key,
	LstDelivery datetime not null,
	TotalVolumeInStock int ,
	HospitalPruchaseNoID int not null
		references HospitalPurchaseOrder(HospitalPurchaseNoID)
)

--Vaccine Manufacturer
	--Vaccine Manufacturer Table
	drop table VaccineManufacturer;
	create table dbo.VaccineManufacturer(
	VacManuID  varchar(50) ,
	Manu_Date datetime,
	ManufacturerName varchar(50),
	VacManuInventory int,
)

----------------------------------------------------------------------------
--List of tables\
select * from Area
select * from Customers;
select * from AreaAdmin;
select * from Hospital;
select * from Pharmacy;
select * from VaccinationCenter;

	--	Hospital Tables
Select * from HospitalPurchaseOrder;
Select * from HospitalPurchaseDepartment;
Select * from HospitalInventoryDepartment;
	--	Pharmacy Tables
Select * from PharmacyPurchaseOrder;
Select * from PharmacyPurchaseDepartment;
Select * from PharmacyInventoryDepartment;
	--	Vaccination Center Tables
Select * from VaccinationCenterPurchaseOrder;
Select * from VaccinationCenterPurchaseDepartment;
Select * from VaccinationCenterInventoryDepartment;


select datename(mm,date),sum(TotalInventory) from VaccinationCenterInventoryDepartment
group by datename(mm,date)
order by datename(mm,date)

	--VaccineManufacturer
select * from VaccineManufacturer
	
----------------------------------------------------------------------------
-----Total Vaccines to be maintained in the VaccineManufacturer Inventory
-----Creates a vaccination table for totaling the Vaccination
drop table vaccineReference
with prod as(
select vc.Date,vc.Covaxin_Qty[c1],
					ph.Covaxin_Qty[c2],
					h.Covaxin_Qty[c3],
					vc.CoviShield_Qty[cs1],
					ph.CoviShield_Qty[cs2],
					h.CoviShield_Qty[cs3],
					vc.Sputnik_V_Qty[sp1],
					ph.Sputnik_V_Qty[sp2],
					h.Sputnik_V_Qty[sp3]
from VaccinationCenterInventoryDepartment vc
join  PharmacyInventoryDepartment ph
on ph.Date=vc.Date
join HospitalInventoryDepartment h
on h.Date=ph.Date
where vc.Date=ph.Date and h.Date=vc.Date),
t as(
select  ROW_NUMBER() over(order by Date)as rows,Date,c1,c2,c3,cs1,cs2,cs3,sp1,sp2,sp3
from prod)
select * 
into vaccineReference                      --creating a table vaccineReference to store these values
from t 
order by Date

--VaccineManufacturer inventory Data
truncate table vaccineReference
select * from vaccineReference

truncate table VaccineManufacturer
select * from VaccineManufacturer;
--Iterating through the vaccineReference table and passing it to function vacManuInven
	alter table vaccineReference
	add CovaVax int, 
		CoviShield int,
		SputNik int;

	----------------------------------------------------------------------------
					--Functions : Table Populating and Computing Columns
	----------------------------------------------------------------------------

--Function to compute total vacciens in VaccineManufacturer Inventory per day
	drop function vacManuInven;
	create function dbo.vacManuInven
	(@row int,@v1 int,@v2 int,@v3 int)
	returns int
	as begin
			declare @total int;
			set @total=@v1+@v2+@v3;
			return @total
		end
		
		declare @test int;
		set @test=(select dbo.vacManuInven(1,1,1,1))
		print @test

--Populating CovaVax in vaccineReference
	declare @primeCounter int=1;
	declare @counter int =1;
	declare @v1 int;
	declare @v2 int;
	declare @v3 int;
	declare @row int;
	declare @total int;
	while @primeCounter=1
	begin
		while @counter<=182
		begin
			set @row=(select rows from vaccineReference where rows=@counter);
			set @v1=(select c1 from vaccineReference where rows=@counter);
			set @v2=(select c2 from vaccineReference where rows=@counter);
			set @v3=(select c3 from vaccineReference where rows=@counter);
			set @total=(select dbo.vacManuInven(@row,@v1,@v2,@v3));
				update vaccineReference
				set CovaVax=@total
				where rows=@row
				set @counter+=1;
		end
		if @counter=183
			break
	end

--Populating CoviShield in vaccineReference
	declare @primeCounter int=2;
		declare @counter int =1;
	declare @v1 int;
	declare @v2 int;
	declare @v3 int;
	declare @row int;
	declare @total int;
	while @primeCounter=2
	begin
		while @counter<=182
		begin
			set @row=(select rows from vaccineReference where rows=@counter);
			set @v1=(select cs1 from vaccineReference where rows=@counter);
			set @v2=(select cs2 from vaccineReference where rows=@counter);
			set @v3=(select cs3 from vaccineReference where rows=@counter);
			set @total=(select dbo.vacManuInven(@row,@v1,@v2,@v3));
				update vaccineReference
				set CoviShield=@total
				where rows=@row
				set @counter+=1;
		end
		if @counter=183
			break
	end

--Populating SputNik in vaccineReference
		declare @primeCounter int=3;
		declare @counter int =1;
	declare @v1 int;
	declare @v2 int;
	declare @v3 int;
	declare @row int;
	declare @total int;
	while @primeCounter=3
	begin
		while @counter<=182
		begin
			set @row=(select rows from vaccineReference where rows=@counter);
			set @v1=(select sp1 from vaccineReference where rows=@counter);
			set @v2=(select sp2 from vaccineReference where rows=@counter);
			set @v3=(select sp3 from vaccineReference where rows=@counter);
			set @total=(select dbo.vacManuInven(@row,@v1,@v2,@v3));
				update vaccineReference
				set SputNik=@total
				where rows=@row
				set @counter+=1;
		end
		if @counter=183
			break
	end

----------------------------------------------------------------------------
--List of procedure used to populate VaccineManufacturer table
--Procedure used to take values from selectValues,selectValuesCovis,SputNik
drop proc InsetIntoVacManu;
create procedure InsetIntoVacManu
@Date date,
@qty int,
@id1 int,
@Name varchar(50)
	as
	begin
	declare @id varchar(50);
	declare @primeCounter varchar(50) =cast(@id1 as varchar(50));
	begin
			set @id ='VM' +@primeCounter;
			insert into dbo.VaccineManufacturer 
			values(@id,@date,@Name,@qty);
	end
end;

--sends value from vaccineReference table row-wise to the InsetIntoVacManu procedure
--insert covaVax
drop proc selectValues
create procedure selectValues
as
	begin
		declare @counter int=1;
		declare @date date;
		declare @qyt int;
		declare @name varchar(50)
		while @counter<=182
			begin
			set @date=(select Date 
						  from vaccineReference
						  where rows=@counter);
			set @qyt=(select CovaVax 
						  from vaccineReference
						  where rows=@counter)

			exec InsetIntoVacManu @date=@date,@id1=@counter,@qty=@qyt,@Name='CovaVax'
			set @counter+=1;
			end
	end

	exec selectValues

--Sends value from vaccineReference table row-wise to the InsetIntoVacManu procedure
--insert covishield
drop proc selectValuesCovis
create procedure selectValuesCovis
as
	begin
		declare @counter int=1;
		declare @counter1 int=182;
		declare @date date;
		declare @qyt int;
		declare @name varchar(50)
		while @counter<=182
			begin
			set @date=(select Date 
						  from vaccineReference
						  where rows=@counter);
			set @qyt=(select CoviShield 
						  from vaccineReference
						  where rows=@counter)
			exec InsetIntoVacManu @date=@date,@id1=@counter1,@qty=@qyt,@Name='CoviShield'
			set @counter+=1;
			set @counter1+=1;
			end
	end;

	exec selectValuesCovis


--Sends value from vaccineReference table row-wise to the InsetIntoVacManu procedure
--insert SputNik
drop proc selectValuesSput
create procedure selectValuesSput
as
	begin
		declare @counter int=1;
		declare @counter1 int=364;
		declare @date date;
		declare @qyt int;
		declare @name varchar(50)
		while @counter<=182
			begin
			set @date=(select Date 
						  from vaccineReference
						  where rows=@counter);
			set @qyt=(select SputNik 
						  from vaccineReference
						  where rows=@counter)
			exec InsetIntoVacManu @date=@date,@id1=@counter1,@qty=@qyt,@Name='SputNik'
			set @counter+=1;
			set @counter1+=1;
			end
	end

	exec selectValuesSput
	
----------------------------------------------------------------------------
--Computing the age in Customer table using date of birth
--Replicating the Customer table with age into a new table Age

select CustomerID,CustomerFirstName,CustomerLastName,DateofBirth,StreetNumber,City,State,FirstDoseDate,SecondDoseDate,FirstDoseBatch,SecondDoseBatch,
	     ( datediff(hour,Customer.DateofBirth ,getdate())/8766)[Age]
 into Customers
 from Customer;

 --The final Customers Table
 Select * from Customers