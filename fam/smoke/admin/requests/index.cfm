<cfinclude template="/fam/smoke/use.cfm">

<cfinclude template="/fam/lo.cfm">

<cfif #session.admin# EQ 1 and #cgi.query_string# CONTAINS 'restore=' >
<cfset brq = REReplaceNoCase(cgi.query_string, "restore=", "") />
<cfset brq = REReplace(brq,"%20"," ","all")>

<cfdump var='#session#'>

<cfset brq_key = #brq# >

<CFquery NAME="GTA" DATASOURCE="Washington_Smoke_Production">
	update Pre_burn
	set date_deleted = NULL,
	    deleted_by = NULL
	where B_key = #brq_key#
</cfquery>
<CFquery NAME="archive_requests" DATASOURCE="Washington_Smoke_Production">
SELECT *
FROM Burn_Request
WHERE Plan_Key = '#brq_key#'
</cfquery>
<cfdump var='#archive_requests#'>

<cfloop query="archive_requests">
<cfoutput>
<cfquery name="archive_requests_update" DATASOURCE="Washington_Smoke_Production">
UPDATE Burn_Request
SET archived = 'N'
WHERE Plan_Key = '#archive_requests.Plan_Key#'
</cfquery>
</cfoutput>
</cfloop>

<CFquery NAME="archive_post_burns" DATASOURCE="Washington_Smoke_Production">
SELECT *
FROM Post_Burn
WHERE R_key = '#archive_requests.R_key#'
AND archived = 'Y'
</cfquery>
<cfdump var='#archive_post_burns#'>

<cfloop query="archive_post_burns">
<cfoutput>
<cfquery name="archive_post_burns_update" DATASOURCE="Washington_Smoke_Production">
UPDATE Post_Burn
SET archived = 'N'
WHERE Post_Burn_Key = '#archive_post_burns.Post_Burn_Key#'
</cfquery>
</cfoutput>
</cfloop>


<cfabort>
</cfif>

<cfif #session.admin# EQ 1 and #cgi.query_string# EQ 'bounce' >

<cfquery name="requests_get" datasource="Washington_Smoke_Production">
SELECT *
FROM Burn_Request
</cfquery>

<cfquery name="drop_requests" datasource="FAMDB">
if exists (select * from information_schema.tables where table_name = 'smoke_requests')
    drop table smoke_requests;
</cfquery>

<cfquery name="make_requests" datasource="FAMDB">        
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE smoke_requests(
	[R_Key] [int] IDENTITY(1,1) NOT NULL,
	[Plan_Key] [int] NULL,
	[Burn_Project_Name] [varchar](35) NULL,
	[District_Code] [varchar](5) NULL,
	[Added_By] [varchar](60) NULL,
	[Burn_Permit_Number] [nvarchar](255) NULL,
	[Date_Added] [datetime] NULL,
	[Post_burn_updated] [datetime] NULL,
	[Burn_Date] [smalldatetime] NULL,
	[Burn_Duration_Hours] [varchar](3) NULL,
	[Burn_Duration_Min] [varchar](50) NULL,
	[Burn_Ignition_Time] [varchar](50) NULL,
	[Planned_Ignition_Duration_Min] [nvarchar](255) NULL,
	[Planned_Ignition_Time] [varchar](53) NULL,
	[Burn_Comments] [ntext] NULL,
	[Acreage_This_Burn] [float] NULL,
	[Tonnage_This_Burn] [float] NULL,
	[Post_Burn_report] [char](10) NULL,
	[Burn_Req_No] [int] NULL,
	[Rank] [char](10) NULL,
	[Multi_Day_Burn] [char](10) NULL,
	[archived] [char](1) NOT NULL CONSTRAINT [DF_Burn_Request_archived]  DEFAULT ('N'),
	[Total_tons] [real] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

</cfquery>

<cfoutput query="requests_get">
<cfquery name="requests_load" datasource="FAMDB">
set identity_insert smoke_requests on
insert into smoke_requests (
R_Key,
Plan_Key,
Burn_Project_Name,
District_Code,
Added_By,
Burn_Permit_Number,
Date_Added,
Post_burn_updated,
Burn_Date,
Burn_Duration_Hours,
Burn_Duration_Min,
Burn_Ignition_Time,
Planned_Ignition_Duration_Min,
Planned_Ignition_Time,
Burn_Comments,
Acreage_This_Burn,
Tonnage_This_Burn,
Post_Burn_report,
Burn_Req_No,
Rank,
Multi_Day_Burn,
archived,
Total_tons
)
VALUES
(
'#R_Key#',
'#Plan_Key#',
'#Burn_Project_Name#',
'#District_Code#',
'#Added_By#',
'#Burn_Permit_Number#',
'#Date_Added#',
'#Post_burn_updated#',
'#Burn_Date#',
'#Burn_Duration_Hours#',
'#Burn_Duration_Min#',
'#Burn_Ignition_Time#',
'#Planned_Ignition_Duration_Min#',
'#Planned_Ignition_Time#',
'#Burn_Comments#',
'#Acreage_This_Burn#',
'#Tonnage_This_Burn#',
'#Post_Burn_report#',
'#Burn_Req_No#',
'#Rank#',
'#Multi_Day_Burn#',
'#archived#',
'#Total_tons#'
)
set identity_insert smoke_requests off
</cfquery>
</cfoutput>

<cfabort>

</cfif>

<cfquery name="tada" datasource="FAMDB">
SELECT *
FROM smoke_requests
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
<cfoutput>#tada.recordcount#</cfoutput> <strong>Requests</strong>
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