<cfquery name="districts" datasource="Washington_Smoke_Production" result='r1'>
	SELECT d.*
	FROM Forest_Access d
	ORDER BY The_Forest_Name, District_Name
</cfquery>

<cfheader 
	statusCode = "200"
	statusText = "OK">
<cfheader 
	name="Content-Type" 
	value="application/json">
<cfset foo = structNew()>{
"type": "FeatureCollection",
"features": [<cfset gcount = 0><cfoutput query='districts'>
			<cfset gcount++>
{"type":"Feature","id":#gcount#,"geometry":{"type":"Point","coordinates":[]},"properties":{
"F":"#The_Forest_Name#","D":"#District_Name#","C":"#Login_ID#","REQUESTS":[]}}<cfif districts.recordcount GT gcount>,</cfif></cfoutput>]}