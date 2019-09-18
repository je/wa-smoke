<cfinclude template="/fam/smoke/use.cfm">

<cfinclude template="/fam/lo.cfm">


<cfif #session.admin# EQ 1 and #cgi.query_string# EQ 'cols-for-post' >
    <cfquery name="famdb_col_ovr" datasource="Washington_Smoke_Production">
    alter table dbo.Post_Burn add BLACK_SHRUB_PC smallint null;
    alter table dbo.Post_Burn add BLACK_CANOPY_PC smallint null;
    alter table dbo.Post_Burn add BLACK_PILE_PC smallint null;
    </cfquery>
    OK!
    <cfabort>

<cfelseif #session.admin# EQ 1 and #cgi.query_string# EQ 'bounce' >

<cfquery name="requests_get" datasource="Washington_Smoke_Production">
SELECT *
FROM Post_Burn
</cfquery>

<cfquery name="drop_requests" datasource="FAMDB">
if exists (select * from information_schema.tables where table_name = 'smoke_post_burns')
    drop table smoke_post_burns;
</cfquery>

<cfquery name="make_requests" datasource="FAMDB">        
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE smoke_post_burns(
	[Post_Burn_Key] [int] IDENTITY(1,1) NOT NULL,
	[R_key] [int] NOT NULL,
	[District_Code] [varchar](5) NULL,
	[Burn_Permit_Number] [nvarchar](255) NULL,
	[Burn_Project_Name] [varchar](35) NULL,
	[Date_Burned] [smalldatetime] NULL,
	[Ignition_time] [nvarchar](255) NULL,
	[Ignition_Duration_in_Minutes] [float] NULL,
	[Actual_Acres_Burned] [float] NULL,
	[Duff_Moisture_Method] [nvarchar](255) NULL,
	[Thousand_Hour_method] [nvarchar](255) NULL,
	[Fire_Weather_Station_Name] [nvarchar](255) NULL,
	[Wind_Speed] [float] NULL,
	[Days_Since_Rain] [float] NULL,
	[Fuel_moisture_ten_hours] [float] NULL,
	[Fuel_moisture_1000_Hour] [float] NULL,
	[Duff_Moist_Pc] [nvarchar](255) NULL,
	[Consumed_Landing_Tons] [float] NULL,
	[Post_Burn_Comments] [text] NULL,
	[Added_by] [char](30) NULL,
	[Date_added] [datetime] NULL,
	[Duff_Fuel_Moisture] [int] NULL,
	[Estimated_Consumed_Total_tonnage] [int] NULL,
	[NWS_Office] [varchar](50) NULL,
	[On_site] [varchar](50) NULL,
	[Post_Key] [int] NULL,
	[Raws] [varchar](50) NULL,
	[Weather_Collection_Method] [varchar](50) NULL,
	[Reason_for_No_Burn] [nvarchar](250) NULL,
	[Reason_for_No_Burn_Code] [varchar](50) NULL,
	[archived] [char](1) NOT NULL CONSTRAINT [DF_Post_Burn_delete]  DEFAULT ('N')
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

</cfquery>

<cfoutput query="requests_get">
<cfquery name="requests_load" datasource="FAMDB">
set identity_insert smoke_post_burns on
insert into smoke_post_burns (
Post_Burn_Key,
R_key,
District_Code,
Burn_Permit_Number,
Burn_Project_Name,
Date_Burned,
Ignition_time,
Ignition_Duration_in_Minutes,
Actual_Acres_Burned,
Duff_Moisture_Method,
Thousand_Hour_method,
Fire_Weather_Station_Name,
Wind_Speed,
Days_Since_Rain,
Fuel_moisture_ten_hours,
Fuel_moisture_1000_Hour,
Duff_Moist_Pc,
Consumed_Landing_Tons,
Post_Burn_Comments,
Added_by,
Date_added,
Duff_Fuel_Moisture,
Estimated_Consumed_Total_tonnage,
NWS_Office,
On_site,
Post_Key,
Raws,
Weather_Collection_Method,
Reason_for_No_Burn,
Reason_for_No_Burn_Code,
archived
)
VALUES
(
'#Post_Burn_Key#',
'#R_key#',
'#District_Code#',
'#Burn_Permit_Number#',
'#Burn_Project_Name#',
'#Date_Burned#',
'#Ignition_time#',
'#Ignition_Duration_in_Minutes#',
'#Actual_Acres_Burned#',
'#Duff_Moisture_Method#',
'#Thousand_Hour_method#',
'#Fire_Weather_Station_Name#',
'#Wind_Speed#',
'#Days_Since_Rain#',
'#Fuel_moisture_ten_hours#',
'#Fuel_moisture_1000_Hour#',
'#Duff_Moist_Pc#',
'#Consumed_Landing_Tons#',
'#Post_Burn_Comments#',
'#Added_by#',
'#Date_added#',
'#Duff_Fuel_Moisture#',
'#Estimated_Consumed_Total_tonnage#',
'#NWS_Office#',
'#On_site#',
'#Post_Key#',
'#Raws#',
'#Weather_Collection_Method#',
'#Reason_for_No_Burn#',
'#Reason_for_No_Burn_Code#',
'#archived#'
)
set identity_insert smoke_post_burns off
</cfquery>
</cfoutput>

<cfabort>

</cfif>

<cfquery name="tada" datasource="FAMDB">
SELECT *
FROM smoke_post_burns
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
<cfoutput>#tada.recordcount#</cfoutput> <strong>Post-Burns</strong>
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