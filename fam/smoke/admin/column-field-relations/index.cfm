<cfinclude template="/fam/smoke/use.cfm">

<cfinclude template="/fam/lo.cfm">

<cfif #session.admin# EQ 1 and #cgi.query_string# EQ 'bounce' >

<cfquery name="burn_column_field_relations_get" datasource="Washington_Smoke_Production">
SELECT "Table Name " as table_name, "Identity Key " as identity_key, "Column Name " as column_name, description, datatype, length, "link field name" as link_field_name, comments, "index" as ind
FROM Data_Dict_Column_Field_Relation
</cfquery>

<cfquery name="drop_burn_column_field_relations" datasource="FAMDB">
if exists (select * from information_schema.tables where table_name = 'smoke_column_field_relations')
    drop table smoke_column_field_relations;
</cfquery>

<cfquery name="make_burn_column_field_relations" datasource="FAMDB">        
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE smoke_column_field_relations(
	[Table_Name] [nvarchar](255) NULL,
	[Identity_Key] [nvarchar](255) NULL,
	[Column_Name] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Datatype] [nvarchar](255) NULL,
	[Length] [nvarchar](255) NULL,
	[Link_Field_name] [nvarchar](255) NULL,
	[Comments] [nvarchar](255) NULL,
	[ind] [int] NOT NULL
) ON [PRIMARY]
</cfquery>

<cfoutput query="burn_column_field_relations_get">
<cfquery name="burn_column_field_relations_load" datasource="FAMDB">

insert into smoke_column_field_relations (
Table_Name,
Identity_Key,
Column_Name,
Description,
Datatype,
Length,
Link_Field_name,
Comments,
ind
)
VALUES
(
'#Table_Name#',
'#Identity_Key#',
'#Column_Name#',
'#Description#',
'#Datatype#',
'#Length#',
'#Link_Field_name#',
'#Comments#',
'#ind#'
)

</cfquery>
</cfoutput>

<cfabort>

</cfif>

<cfquery name="tada" datasource="FAMDB">
SELECT *
FROM smoke_column_field_relations
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
<cfoutput>#tada.recordcount#</cfoutput> <strong>Column/Field Relations</strong>
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