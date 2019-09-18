<cfif #cgi.query_string# NEQ ''>
	<cfset d_id = #cgi.query_string#>
	<cfinclude template="/fam/smoke/data/index.cfm">
 <cfelse>

	<cfinclude template="/fam/smoke/use.cfm">

	<cfinclude template="/fam/lo.cfm">

	<cfset cols = 'Login_ID,The_Forest_Name,District_Name,Address,City,State,Zip,Contact,Phone_area_code,Phone_prefix,Phone_number,Email'>
	<cfset heads = '_,forest,district,_,_,_,_,_,_,_,_,_'>
	<cfset refs = 'Login_ID,_,Login_ID,_,_,_,_,_,Phone_area_code,Phone_prefix,Phone_number,Email'>
	<cfset rebs = 'Login_ID,smoke/district,smoke/district,Address,City,State,Zip,Contact,Phone_area_code,Phone_prefix,Phone_number,Email'>

	<cfquery name="tada" datasource="FAMDB">
		SELECT #cols#
		FROM smoke_forest_access
		order by The_Forest_Name
	</cfquery>

	<cfset cols = getMetadata(tada)>
	<cfset colList = "">
	<cfloop from="1" to="#arrayLen(cols)#" index="x"> <cfset colList = listAppend(colList, cols[x].name)> </cfloop>

	<div class="panel panel-default">
	<div class="panel-heading">
	<h3 class="panel-title">
	<cfoutput>#tada.recordcount#</cfoutput> <strong>Districts</strong>
	<small></small>
	</h3>
	</div>

	<table class="table table-bordered table-condensed">
		<thead>
			<cfoutput>
			<cfif len(heads)>
				<cfloop list="#heads#" index='head'>
				<cfif head NEQ '_'>
					<th>#head#</th>
				</cfif>
				</cfloop>
			 <cfelse>
				<cfloop list="#collist#" index='head'>
				<th>#head#</th>
				</cfloop>
			</cfif>
			<th>address</th>
			</cfoutput>
		</thead>

	<tbody>
		<cfset line=''>
		<cfset odd='yes'>
		<cfset even='no'>
		<cfoutput query="tada">
		<cfif #tada.The_Forest_Name# EQ line><cfelse><cfset odd='#even#'></cfif>
		<cfif odd EQ 'yes'><cfset even='no'><cfelseif odd EQ 'no'><cfset even='yes'></cfif>
		<tr <cfif #even# EQ 'yes'>style="background-color: ##f9f9f9"</cfif>>
		<cfset n = 1>
		<cfloop index="col" list="#collist#">
			<cfset hd = #listgetat(heads,n)#>
			<cfif hd NEQ '_'>
				<cfset rf = #listgetat(refs,n)#>
				<td>
				<cfif rf NEQ '_'>
					<cfset rfx = rf>
					<cfset rbx = #listgetat(rebs,n)#>
					<a href='/fam/#rbx#/?#tada[rfx][currentRow]#'><strong><cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#<cfelseif col EQ 'changed'>#tostring(tada[col][currentrow])#<cfelse>#tada[col][currentRow]#</cfif></strong></a>
				 <cfelse>
					<cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#<cfelseif col EQ 'changed'>#tostring(tada[col][currentrow])#<cfelse>#tada[col][currentRow]#</cfif>
				</cfif>
				</td>
			</cfif>
		<cfset n = n + 1>
		</cfloop>
		<td>#tada.address# #tada.city# #tada.state# #tada.zip#</td>
		</tr>
		<cfset line='#tada.The_Forest_Name#'>
		</cfoutput>
	</tbody>
	</table>
	</div>

	<cfinclude template="/fam/gutter.cfm">

	</body>
	</html>

</cfif>
