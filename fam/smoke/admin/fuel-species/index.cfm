<cfinclude template="/fam/smoke/use.cfm">

<cfinclude template="/fam/lo.cfm">

<cfif #session.admin# EQ 1 and #cgi.query_string# EQ 'bounce' >

<cfquery name="fuel_speciess_get" datasource="Washington_Smoke_Production">
SELECT *
FROM LU_Sms_Fuels_Species
</cfquery>

<cfquery name="drop_fuel_speciess" datasource="FAMDB">
if exists (select * from information_schema.tables where table_name = 'smoke_fuel_species') drop table smoke_fuel_species;
</cfquery>

<cfquery name="make_fuel_speciess" datasource="FAMDB">        
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE smoke_fuel_species(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](2) NULL,
	[Descr] [nvarchar](40) NULL,
	[State] [nvarchar](2) NULL
) ON [PRIMARY]
</cfquery>

<cfoutput query="fuel_speciess_get">
<cfquery name="fuel_speciess_load" datasource="FAMDB">
set identity_insert smoke_fuel_species on
insert into smoke_fuel_species (
id,
state,
code,
descr
)
VALUES
(
'#id#',
'#state#',
'#code#',
'#descr#'
)
set identity_insert smoke_fuel_species off
</cfquery>
</cfoutput>

<cfabort>

</cfif>

<cfquery name="tada" datasource="FAMDB">
SELECT *
FROM smoke_fuel_species
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
<cfoutput>#tada.recordcount#</cfoutput> <strong>Fuel Species</strong>
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