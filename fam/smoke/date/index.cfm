<cfif #cgi.query_string# NEQ ''>
    <cfset dateq = REReplaceNoCase( cgi.query_string,  "date=", "") />
    <cfset TestSTring = dateq>
    <cfset a = ListToArray(TestString, "-", false, true)>
    <cfset ayyyy = a[1] />
    <cfset amm = a[2] />
    <cfset add = a[3] />
    <cfset qyyyy = ayyyy>
    <cfif amm EQ 'xx'>
        <cfset qmm = ''>
     <cfelse>
        <cfset qmm = amm>
    </cfif>
    <cfif add EQ 'xx'>
        <cfset qdd = ''>
     <cfelse>
        <cfset qdd = add>
    </cfif>

	<cfinclude template="/fam/smoke/data/index.cfm">
 <cfelse>

	<cfinclude template="/fam/smoke/use.cfm">

	<cfinclude template="/fam/lo.cfm">

	PUT DATE HERE, HUMAN

	<cfinclude template="/fam/gutter.cfm">

	</body>
	</html>

</cfif>
