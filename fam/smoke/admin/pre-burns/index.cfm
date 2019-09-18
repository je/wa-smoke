<cfinclude template="/fam/smoke/use.cfm">

<cfinclude template="/fam/lo.cfm">

<cfif #session.admin# EQ 1 and #cgi.query_string# EQ 'move' >

<cfquery name="move" datasource="Washington_Smoke_Production">
update dbo.Pre_Burn set latitude = 48
WHERE Pre_Burn.Burn_Unit_ID_No = 10002355
</cfquery>
OK!
<cfabort>

<cfelseif #session.admin# EQ 1 and #cgi.query_string# EQ 'bounce' >

<cfquery name="requests_get" datasource="Washington_Smoke_Production">
SELECT *
FROM Pre_Burn
</cfquery>

<cfquery name="drop_requests" datasource="FAMDB">
if exists (select * from information_schema.tables where table_name = 'smoke_pre_burns')
    drop table smoke_pre_burns;
</cfquery>

<cfquery name="make_requests" datasource="FAMDB">        
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE smoke_pre_burns(
	[B_key] [int] IDENTITY(1,1) NOT NULL,
	[District_Code] [varchar](50) NULL,
	[district] [nvarchar](255) NULL,
	[Burn_Unit_ID_No] [int] NULL,
	[Issue_date] [smalldatetime] NULL,
	[Size_of_Unit_acres] [float] NULL,
	[Estimated_unit_acres] [float] NULL,
	[Total_permit_Qty_tons] [float] NULL,
	[Forest_health_exempt] [nvarchar](255) NULL,
	[Burn_Project_Name] [varchar](35) NULL,
	[Burn_type] [nvarchar](255) NULL,
	[Burn_Reason] [nvarchar](255) NULL,
	[Ignition_Method] [nvarchar](255) NULL,
	[Predominant_species] [nvarchar](255) NULL,
	[Elevation] [float] NULL,
	[Slope] [float] NULL,
	[Cut_DAte] [varchar](50) NULL,
	[Snow_Off_Date] [varchar](50) NULL,
	[Landing_Tons] [float] NULL,
	[Pile_tons] [float] NULL,
	[Forest] [nvarchar](255) NULL,
	[County] [nvarchar](255) NULL,
	[Township_1] [varchar](53) NULL,
	[N_S] [varchar](50) NULL,
	[Range_1] [float] NULL,
	[E_W] [nvarchar](255) NULL,
	[Section_No] [nvarchar](255) NULL,
	[Diameter_1] [float] NULL,
	[Diameter_2] [float] NULL,
	[Diameter_3] [float] NULL,
	[Diameter_4] [float] NULL,
	[Diameter_5] [float] NULL,
	[Diameter_6] [float] NULL,
	[Less_3_rotten] [float] NULL,
	[Litter_Depth] [float] NULL,
	[Duff_Depth] [float] NULL,
	[Shrub] [float] NULL,
	[Grass_Herb] [float] NULL,
	[Duff_Type] [nvarchar](255) NULL,
	[Added_By] [varchar](30) NULL,
	[address_1] [varchar](50) NULL,
	[Burn_requests] [smallint] NULL,
	[City] [varchar](20) NULL,
	[Contact] [varchar](50) NULL,
	[Date_Added] [varchar](50) NULL,
	[Date_Deleted] [varchar](50) NULL,
	[Date_modified] [varchar](50) NULL,
	[Deleted_By] [varchar](30) NULL,
	[email] [varchar](60) NULL,
	[Fuel_loading] [int] NULL,
	[Latitude] [varchar](50) NULL,
	[Loading_Method] [varchar](2) NULL,
	[Longitude] [varchar](50) NULL,
	[Modified_By] [varchar](30) NULL,
	[Phone] [varchar](13) NULL,
	[Pile_Calculation_Method] [varchar](50) NULL,
	[Pile_type] [varchar](30) NULL,
	[Reason_to_Burn] [varchar](50) NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](10) NULL,
	[Total_tons] [real] NULL
) ON [PRIMARY]

</cfquery>

<cfoutput query="requests_get">
<cfquery name="requests_load" datasource="FAMDB">
set identity_insert smoke_pre_burns on
insert into smoke_pre_burns (
B_key,
District_Code,
district,
Burn_Unit_ID_No,
Issue_date,
Size_of_Unit_acres,
Estimated_unit_acres,
Total_permit_Qty_tons,
Forest_health_exempt,
Burn_Project_Name,
Burn_type,
Burn_Reason,
Ignition_Method,
Predominant_species,
Elevation,
Slope,
Cut_DAte,
Snow_Off_Date,
Landing_Tons,
Pile_tons,
Forest,
County,
Township_1,
N_S,
Range_1,
E_W,
Section_No,
Diameter_1,
Diameter_2,
Diameter_3,
Diameter_4,
Diameter_5,
Diameter_6,
Less_3_rotten,
Litter_Depth,
Duff_Depth,
Shrub,
Grass_Herb,
Duff_Type,
Added_By,
address_1,
Burn_requests,
City,
Contact,
Date_Added,
Date_Deleted,
Date_modified,
Deleted_By,
email,
Fuel_loading,
Latitude,
Loading_Method,
Longitude,
Modified_By,
Phone,
Pile_Calculation_Method,
Pile_type,
Reason_to_Burn,
State,
Zip,
Total_tons
)
VALUES
(
'#B_key#',
'#District_Code#',
'#district#',
'#Burn_Unit_ID_No#',
'#Issue_date#',
'#Size_of_Unit_acres#',
'#Estimated_unit_acres#',
'#Total_permit_Qty_tons#',
'#Forest_health_exempt#',
'#Burn_Project_Name#',
'#Burn_type#',
'#Burn_Reason#',
'#Ignition_Method#',
'#Predominant_species#',
'#Elevation#',
'#Slope#',
'#Cut_DAte#',
'#Snow_Off_Date#',
'#Landing_Tons#',
'#Pile_tons#',
'#Forest#',
'#County#',
'#Township_1#',
'#N_S#',
'#Range_1#',
'#E_W#',
'#Section_No#',
'#Diameter_1#',
'#Diameter_2#',
'#Diameter_3#',
'#Diameter_4#',
'#Diameter_5#',
'#Diameter_6#',
'#Less_3_rotten#',
'#Litter_Depth#',
'#Duff_Depth#',
'#Shrub#',
'#Grass_Herb#',
'#Duff_Type#',
'#Added_By#',
'#address_1#',
'#Burn_requests#',
'#City#',
'#Contact#',
'#Date_Added#',
'#Date_Deleted#',
'#Date_modified#',
'#Deleted_By#',
'#email#',
'#Fuel_loading#',
'#Latitude#',
'#Loading_Method#',
'#Longitude#',
'#Modified_By#',
'#Phone#',
'#Pile_Calculation_Method#',
'#Pile_type#',
'#Reason_to_Burn#',
'#State#',
'#Zip#',
'#Total_tons#'
)
set identity_insert smoke_pre_burns off
</cfquery>
</cfoutput>

<cfabort>

</cfif>

<cfquery name="tada" datasource="FAMDB">
SELECT *
FROM smoke_pre_burns
</cfquery>

<cfset cols = ''>
<cfset heads = ''>
<cfset refs = ''>
<cfset rebs = ''>

<cfset cols = getMetadata(tada)>
<cfset colList = "">
<cfloop from="1" to="#arrayLen(cols)#" index="x"> <cfset colList = listAppend(colList, cols[x].name)> </cfloop>

<div class="panel panel-default">
<div class="panel-heading">
<h3 class="panel-title">
<cfoutput>#tada.recordcount#</cfoutput> <strong>Pre-Burns</strong>
<small></small>
<a class="pull-right" href="/fam/smoke/"><strong>Smoke</strong></a>
</h3>
</div>

<table class="table table-bordered table-condensed">
<thead>
<cfoutput>
<cfif len(heads)>
<cfloop list="#heads#" index='head'>
<cfif head NEQ 'none'>
<th>#head#</th>
</cfif>
</cfloop>
<cfelse>
<cfloop list="#collist#" index='head'>
<th>#head#</th>
</cfloop>
</cfif>
</cfoutput>
</thead>

<tbody>
<cfoutput query="tada">
<tr>
<cfset n = 1>
<cfloop index="col" list="#collist#">
<cfif len(heads)>
<cfset hd = #listgetat(heads,n)#>
<cfif hd NEQ 'none'>
<cfset rf = #listgetat(refs,n)#>
<td>
<cfif rf NEQ 'none'>
<cfset rfx = rf>
<cfset rbx = #listgetat(rebs,n)#>
<a href='/fam/#rbx#/?#tada[rfx][currentRow]#'><cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#<cfelseif col EQ 'changed'>#tostring(tada[col][currentrow])#<cfelse>#tada[col][currentRow]#</cfif></a>
<cfelse>
<cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#<cfelseif col EQ 'changed'>#tostring(tada[col][currentrow])#<cfelse>#tada[col][currentRow]#</cfif>
</cfif>
</td>
</cfif>
<cfelse>
<td><cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#<cfelseif col EQ 'changed'>#tostring(tada[col][currentrow])#<cfelse>#tada[col][currentRow]#</cfif></td>
</cfif>
<cfset n = n + 1>
</cfloop>
</tr>
</cfoutput>
</tbody>
</table>
</div>

<cfinclude template="/fam/gutter.cfm">

</body>
</html>