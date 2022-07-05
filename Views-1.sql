
-- =============================================
-- Author:    Team-8
-- Date:      08/07/2021   
-- =============================================

--Created Database on College Server and imported flat files in it.
Create Database Team8_Database;
use Team8_Database;

	----------------------------------------------------------------------------
					--Views : Different Table Views {For report purposes}
	----------------------------------------------------------------------------

----------------------------------------------------------------------------
--Adding Views
	--View on Area admin to show total vaccinated in the State on Goa

	drop view [Covid Area] ;
	GO
	create view [Covid Area] as
	select *
	from Area
	where State='Goa'
	GO

	select * from [Covid Area]

	--View to show the list of Hospitals,Pharmacys and Vaccination Centers in each Area
	drop view [State Healthcare Directory];
	create view [State Healthcare Directory] as
	select State,vc.VacCenter_Name,ph.Pharmacy_Name,h.Hospital_Name 
	from Area aa
	inner join VaccinationCenter vc
	on vc.AreaID=aa.ID
	inner join Hospital h
	on h.AreaID=aa.ID
	inner join Pharmacy ph
	on ph.AreaID=aa.ID

	select * from [State Healthcare Directory]

	--View to show Area admin how well their areas are managed
		create view [Admin Area Performance] as
		select aa.AreaAdminFirstName+' '+aa.AreaAdminLastName[Full Name],aa.State,
		((aa.Total_Infected-aa.Total_Vaccinated)*100/aa.Total_Infected)[Performance]
		from AreaAdmin aa

		select * from
		[Admin Area Performance]

	----------------------------------------------------------------------------
					--Checks : Table checks based on Columns and Functions
	----------------------------------------------------------------------------
----------------------------------------------------------------------------
 --Adding table level checks 

	--Added this check based on the output value from a function to restrict or deny any incorrect values
	alter table vaccineReference
	add check (CovaVax<=Covavax+CoviShield+SputNik and CoviShield<=Covavax+CoviShield+SputNik and SputNik<=Covavax+CoviShield+SputNik );

	--Checks on Customers
	--column check on Age in Customers {Age>=18}
	Alter table Customers
	add check (Age>=18);

	--Table level check to restrict the qty of vaccine in all inventory {qty>=0}
	--Hospital Table
	alter table HospitalInventoryDepartment
	add check (Covaxin_Qty>=0 and CoviShield_Qty>=0 and Sputnik_V_Qty>=0 and TotalInventory>0);
	--	Pharmacy Table
	alter table PharmacyInventoryDepartment
	add check (Covaxin_Qty>=0 and CoviShield_Qty>=0 and Sputnik_V_Qty>=0 and TotalInventory>0);

	--	Vaccination Center Table
	alter table VaccinationCenterInventoryDepartment
	add check (Covaxin_Qty>=0 and CoviShield_Qty>=0 and Sputnik_V_Qty>=0 and TotalInventory>0);

	--VaccineManufacturer Table
	alter table VaccineManufacturer
	add check (VacManuInventory>0);

	