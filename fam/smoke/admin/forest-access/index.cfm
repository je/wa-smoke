<cfinclude template="/fam/smoke/use.cfm">

<cfinclude template="/fam/lo.cfm">

<cfif #session.admin# EQ 1 and #cgi.query_string# EQ 'bounce' >

<cfquery name="smoke_forest_access_get" datasource="Washington_Smoke_Production">
SELECT *
FROM Forest_Access
</cfquery>

<cfquery name="drop_smoke_forest_access" datasource="FAMDB">
if exists (select * from information_schema.tables where table_name = 'smoke_forest_access')
    drop table smoke_forest_access;
</cfquery>

<cfquery name="make_smoke_forest_access" datasource="FAMDB">        
CREATE TABLE smoke_forest_access(
	[Forest_Key] [int] IDENTITY(1,1) NOT NULL,
	[Login_ID] [varchar](5) NULL,
	[The_Forest_Name] [varchar](50) NULL,
	[District_Name] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Zip] [varchar](50) NULL,
	[Contact] [varchar](50) NULL,
	[Phone_area_code] [varchar](50) NULL,
	[Phone_prefix] [varchar](50) NULL,
	[Phone_number] [varchar](50) NULL,
	[Email] [varchar](50) NULL
) ON [PRIMARY]
</cfquery>


<cfoutput query="smoke_forest_access_get">

<cfquery name="smoke_forest_access_load" datasource="FAMDB">
set identity_insert smoke_forest_access on
insert into smoke_forest_access (
Forest_Key,
Login_ID,
The_Forest_Name,
District_Name,
Address,
City,
State,
Zip,
Contact,
Phone_area_code,
Phone_prefix,
Phone_number,
Email
)
VALUES
(
'#Forest_Key#',
'#Login_ID#',
'#The_Forest_Name#',
'#District_Name#',
'#Address#',
'#City#',
'#State#',
'#Zip#',
'#Contact#',
'#Phone_area_code#',
'#Phone_prefix#',
'#Phone_number#',
'#Email#'
)
set identity_insert smoke_forest_access off
</cfquery>
</cfoutput>

<cfabort>

</cfif>

<cfquery name="tada" datasource="FAMDB">
SELECT *
FROM smoke_forest_access
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
<cfoutput>#tada.recordcount#</cfoutput> <strong>Forest Access</strong>
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