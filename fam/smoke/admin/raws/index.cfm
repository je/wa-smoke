<cfinclude template="/fam/smoke/use.cfm">

<cfinclude template="/fam/lo.cfm">

<cfif #session.admin# EQ 1 and #cgi.query_string# EQ 'bounce' >

<cfquery name="raws_stations_get" datasource="Washington_Smoke_Production">
SELECT *
FROM LU_RAWS_Station
</cfquery>

<cfquery name="drop_raws_stations" datasource="FAMDB">
if exists (select * from information_schema.tables where table_name = 'smoke_raws_stations')
    drop table smoke_raws_stations;
</cfquery>

<cfquery name="make_raws_stations" datasource="FAMDB">        
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE smoke_raws_stations(
	[RAWS_Key] [int] IDENTITY(1,1) NOT NULL,
	[Stations] [nvarchar](255) NULL
) ON [PRIMARY]
</cfquery>

<cfoutput query="raws_stations_get">
<cfquery name="raws_stations_load" datasource="FAMDB">
set identity_insert smoke_raws_stations on
insert into smoke_raws_stations (
RAWS_Key,
Stations
)
VALUES
(
'#RAWS_Key#',
'#Stations#'
)
set identity_insert smoke_raws_stations off
</cfquery>
</cfoutput>

<cfabort>

</cfif>

<cfquery name="tada" datasource="FAMDB">
SELECT *
FROM smoke_raws_stations
</cfquery>

<cfset cols = ''>
<cfset heads = ''>
<cfset refs = ''>
<cfset rebs = ''>

<cfset cols = getMetadata(tada)>
<cfset colList = "">
<cfloop from="1" to="#arrayLen(cols)#" index="x"> <cfset colList = listAppend(colList, cols[x].name)> </cfloop>

<div class="panel panel-default" style="max-width:880px;">
<div class="panel-heading">
<h3 class="panel-title">
<cfoutput>#tada.recordcount#</cfoutput> <strong>RAWS Stations</strong>
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