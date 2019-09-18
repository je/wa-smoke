<cfset StructClear(session)>
<cfset session.user_webcaaf = getHttpRequestData().headers["usdaeauthid"]>
<cfset session.user_email = getHttpRequestData().headers["usdaemail"]>
<cfset session.user_lastname = getHttpRequestData().headers["usdalastname"]>
<cfset session.user_firstname = getHttpRequestData().headers["usdafirstname"]>

<cfquery name="FAMDB_user" datasource="FAMDB" maxrows=1>
select * from dbo.users where username = '#session.user_webcaaf#'
</cfquery>

<cfif #FAMDB_user.recordcount# EQ 1>
<cfset session.admin = '#FAMDB_user.admin#'>

<cfif FAMDB_user.admin EQ 1>
<cfset session.smoke_admin = '1'>
<cfset session.smoke_use = '1'>
<cfelseif FAMDB_user.smoke_use EQ 'Y'>
<cfset session.smoke_admin = ''>
<cfset session.smoke_use = '1'>
<cfelse>
<cfset session.smoke_admin = ''>
<cfset session.smoke_use = ''>
</cfif>

<cfelse>

<cfset session.admin = ''>
<cfset session.smoke_admin = ''>
<cfset session.smoke_use = ''>

</cfif>

<cfset today = '#DateFormat(now(),"mm/dd/yyyy")# #TimeFormat(now(),"hh:mm:ss tt")#'>

<cfset caw = "smoke">
<cfset barn = "<a href='/fam/smoke/' style='color:white;'>smoke</a>">
