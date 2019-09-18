<cfif isStruct("session")><cfset StructClear(session)></cfif>
<cfset session.user_webcaaf = ''>
<cfset session.user_email = ''>
<cfset session.user_lastname = ''>
<cfset session.user_firstname = ''>

<cfset session.admin = ''>
<cfset session.smoke_admin = ''>
<cfset session.smoke_use = ''>

<cfset today = '#DateFormat(now(),"mm/dd/yyyy")# #TimeFormat(now(),"hh:mm:ss tt")#'>

<cfset caw = "smoke">
<cfset barn = "<a href='/smoke/' style='color:white;'>smoke</a>">
