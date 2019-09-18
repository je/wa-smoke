<cfset hd = ''>

<cfset defd = 'B_key'>
<cfset emptys = 'Added_By,Reason_to_Burn,Phone,Estimated_unit_acres,Fuel_loading,Issue_date'>
<cfset metas = 'Date_modified,Modified_By,Date_Deleted,Deleted_By'>
<cfset locs = 'Township_1,N_S,Range_1,E_W,Section_No,Latitude,Longitude,Elevation,Slope'>
<cfset ums = 'Contact,email,address_1,City,County,State,Zip'>
<cfset tons = 'Diameter_1,Diameter_2,Diameter_3,Diameter_4,Diameter_5,Diameter_6,Total_tons,Landing_Tons,Pile_tons,Total_permit_Qty_tons,Loading_Method,Pile_Calculation_Method,Pile_type'>
<cfset specs = 'Predominant_species,Cut_DAte,Snow_Off_Date,Less_3_rotten,Litter_Depth,Duff_Depth,Shrub,Grass_Herb,Duff_Type'>

<cfset cols = 'Date_Added,Forest,District_Code,district,Burn_Unit_ID_No,Burn_Project_Name,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,Date_Deleted'>
<cfset heads = 'Date Added,Forest,none,District,Unit ID,Project Name,Unit Acres,Type,Reason,Forest Health Exempt,Ignition Method,Burn Requests,Date Deleted'>
<cfset refs = 'Date_Added,Forest,District_Code,District_Code,Burn_Unit_ID_No,Burn_Unit_ID_No,none,none,none,none,none,Burn_Unit_ID_No,none'>
<cfset rebs = 'smoke/date,smoke/forest,smoke/district,smoke/district,smoke,smoke,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,smoke,none'>

<cfset cv = "Date_Added,Forest,District_Code,district,Burn_Unit_ID_No,Burn_Project_Name,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,B_key,longitude,latitude">
<cfset vheads = "Date_Added,Forest,District_Code,district,Burn_Unit_ID_No,Burn_Project_Name,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,B_key,longitude,latitude">
<cfset vrefs = "Date_Added,Forest,District_Code,district,Burn_Unit_ID_No,Burn_Project_Name,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,B_key,longitude,latitude">
<cfset vrebs = "Date_Added,Forest,District_Code,district,Burn_Unit_ID_No,Burn_Project_Name,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,B_key,longitude,latitude">

<cfset adefd = 'R_Key,Plan_Key,Burn_Permit_Number,Burn_Project_Name,District_Code'>
<cfset aemptys = 'Added_By'>
<cfset ametas = ''>
<cfset ca = 'Burn_Req_No,Rank,Burn_Date,Planned_Ignition_Time,Planned_Ignition_Duration_Min,r.Date_Added,Burn_Ignition_Time,Burn_Duration_Hours,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,r.archived,Total_tons,Post_burn_updated,r.r_key,plan_key'>
<cfset aheads = 'Req No,Rank,Burn Date,Planned Time,Planned Min,Date Added,Ignition Time,Hours,Min,Comments,Acres,Tons,none,Multi Day,none,Total tons,Post Burn Updated,none,none'>
<cfset arefs = 'Burn_Req_No,none,Burn_Date,none,none,Date_Added,none,none,none,none,none,none,none,none,none,none,Post_burn_updated,r_key,plan_key'>
<cfset arebs = 'smoke/u,Rank,smoke/date,Planned_Ignition_Time,Planned_Ignition_Duration_Min,smoke/date,Burn_Ignition_Time,Burn_Duration_Hours,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,archived,Total_tons,smoke/date,r_key,plan_key'>

<cfset ra = 'Burn_Req_No,Rank,Burn_Date,Planned_Ignition_Time,Planned_Ignition_Duration_Min,r.Date_Added,Burn_Ignition_Time,Burn_Duration_Hours,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,archived,r.Total_tons,Post_burn_updated,r.r_key,plan_key'>
<cfset rheads = 'Req No,Rank,Burn Date,Planned Time,Planned Min,Date Added,Ignition Time,Hours,Min,Comments,Acres,Tons,none,Multi Day,none,Total tons,Post Burn Updated,none,none'>
<cfset rrefs = 'Burn_Req_No,none,Burn_Date,none,none,r.Date_Added,none,none,none,none,none,none,none,none,none,none,Post_burn_updated,r.r_key,plan_key'>
<cfset rrebs = 'smoke/u,Rank,smoke/date,Planned_Ignition_Time,Planned_Ignition_Duration_Min,smoke/date,Burn_Ignition_Time,Burn_Duration_Hours,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,archived,r.Total_tons,smoke/date,r.r_key,plan_key'>

<cfset ua = 'Post_key,Post_Burn_Key,u.R_Key,u.Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Actual_Acres_Burned,u.Date_Added,u.Added_by'>
<cfset uheads = 'none,Post_Burn_Key,R_Key,Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Actual_Acres_Burned,Date_Added,Added_by'>
<cfset urefs = 'Post_key,Post_Burn_Key,R_Key,Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Actual_Acres_Burned,Date_Added,Added_by'>
<cfset urebs = 'Post_key,Post_Burn_Key,R_Key,u.Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Actual_Acres_Burned,u.Date_Added,u.Added_by'>

<cfset dtest = '1'>
<cfset dateq = ''>
<cfset districtq = ''>
<cfset unitq = ''>
<cfset qyyyy = ''>
<cfset qmm = ''>
<cfset qdd = ''>
<cfif #cgi.query_string# NEQ ''>
	<cfif #cgi.query_string# CONTAINS 'district='>
		<cfset districtq = REReplaceNoCase( cgi.query_string,  "district=", "") />
	<cfelseif #cgi.query_string# CONTAINS 'date='>
		<cfset dateq = REReplaceNoCase( cgi.query_string,  "date=", "") />
		<cfset TestSTring = dateq>
		<cfset a = ListToArray(TestString, "-", false, true)>
		<cftry>
			<cfset ayyyy = a[1] />
			<cfset amm = a[2] />
			<cfset add = a[3] />
		    <cfif ayyyy EQ 'xxxx'>
                <cfset qyyyy = ''>
            <cfelse>
                <cfset qyyyy = ayyyy>
            </cfif>
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
			<cfcatch>
			BAD, EVIL date entry.
			<cfabort>
			</cfcatch>
		</cftry>
	<cfelseif #cgi.query_string# CONTAINS 'date_test='>
		<cfset dtest = '1'>
		<cfset dateq = REReplaceNoCase( cgi.query_string,  "date_test=", "") />
		<cfset TestSTring = dateq>
		<cfset a = ListToArray(TestString, "-", false, true)>
		<cftry>
			<cfset ayyyy = a[1] />
			<cfset amm = a[2] />
			<cfset add = a[3] />
            <cfif ayyyy EQ 'xxxx'>
                <cfset qyyyy = ''>
            <cfelse>
                <cfset qyyyy = ayyyy>
            </cfif>
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
			<cfcatch>
			BAD, EVIL date entry.
			<cfabort>
			</cfcatch>
		</cftry>
	</cfif>
</cfif>

<cfif #cgi.query_string# NEQ '' and #dateq# EQ '' and #districtq# EQ '' and #unitq# NEQ ''>
	<cfquery name="vada" datasource="Washington_Smoke_Production">
	SELECT DISTINCT #cv#
	FROM Pre_Burn p
	WHERE p.Burn_Unit_ID_No = '#cgi.query_string#'
	</cfquery>
	<cfquery name="oada" datasource="Washington_Smoke_Production">
	SELECT #ca#
	FROM Burn_Request r
	left outer join Post_Burn u on u.R_Key = r.R_Key
	WHERE r.Burn_Permit_Number = '#cgi.query_string#'
	</cfquery>
<cfelseif #cgi.query_string# NEQ '' and #dateq# EQ '' and #districtq# NEQ '' and #unitq# EQ ''>
	<cfquery name="regs" datasource="Washington_Smoke_Production">
	SELECT p.*, u.*, r.*
	FROM Pre_Burn p
    left outer join Burn_Request r on p.b_key = r.plan_key and r.Burn_Permit_Number = p.Burn_Unit_ID_No
    left outer join Post_Burn u on u.R_Key = r.R_Key
	WHERE p.B_key not in (
    SELECT pp.B_key
    FROM Burn_Request rr
    inner join Pre_Burn pp on pp.b_key = rr.plan_key and rr.Burn_Permit_Number = pp.Burn_Unit_ID_No
    )
    AND p.District_Code = <cfqueryparam value = "#districtq#"
CFSQLType = "CF_SQL_VARCHAR"
list = "no"
maxLength = "9"
null = "no">
    ORDER BY p.Burn_Unit_ID_No, r.BURN_DATE DESC
	</cfquery>
	<cfquery name="plans" datasource="Washington_Smoke_Production">
	SELECT r.*, u.*, p.*
	FROM Burn_Request r
	inner join Pre_Burn p on p.b_key = r.plan_key and r.Burn_Permit_Number = p.Burn_Unit_ID_No
	left outer join Post_Burn u on u.R_Key = r.R_Key
    WHERE p.District_Code = <cfqueryparam value = "#districtq#"
CFSQLType = "CF_SQL_VARCHAR"
list = "no"
maxLength = "9"
null = "no">
	ORDER BY p.Burn_Unit_ID_No, r.BURN_DATE DESC
	</cfquery>
<cfelse>
	<cfset lastyear = '#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"HH:mm:ss tt")#'>
	<cfset yyyy = '#DateFormat(now(),"yyyy")#'>
	<cfset yyyx = yyyy - 1 >
	<cfset mm = '#DateFormat(now(),"mm")#'>
	<cfset dd = '#DateFormat(now(),"dd")#'>
	<cfquery name="regs" datasource="Washington_Smoke_Production" result='r1'>
	SELECT p.*, u.*, r.*
	FROM Pre_Burn p
    left outer join Burn_Request r on p.b_key = r.plan_key and r.Burn_Permit_Number = p.Burn_Unit_ID_No
    left outer join Post_Burn u on u.R_Key = r.R_Key
	WHERE p.B_key not in (
    SELECT pp.B_key
    FROM Burn_Request rr
    inner join Pre_Burn pp on pp.b_key = rr.plan_key and rr.Burn_Permit_Number = pp.Burn_Unit_ID_No
    )
    <cfif #districtq# NEQ ''>
    AND p.District_Code = <cfqueryparam value = "#districtq#"
CFSQLType = "CF_SQL_VARCHAR"
list = "no"
maxLength = "9"
null = "no">
	</cfif>
    <cfif #dateq# NEQ ''>
		<cfif #qyyyy# NEQ ''>
		AND year(p.date_Added) = <cfqueryparam value = "#qyyyy#"
CFSQLType = "INTEGER"
list = "no"
maxLength = "4"
null = "no">
		</cfif>
		<cfif #qmm# NEQ ''>
		AND month(p.date_Added) = <cfqueryparam value = "#qmm#"
CFSQLType = "INTEGER"
list = "no"
maxLength = "2"
null = "no">
		</cfif>
		<cfif #qdd# NEQ ''>
		AND day(p.date_Added) = <cfqueryparam value = "#qdd#"
CFSQLType = "INTEGER"
list = "no"
maxLength = "2"
null = "no">
		</cfif>
	<cfelse>
		AND year(p.date_Added) >= #yyyx#
		AND month(p.date_Added) >= #mm#
		AND day(p.date_Added) >= #dd#
	</cfif>
    ORDER BY p.Burn_Unit_ID_No, r.BURN_DATE DESC
	</cfquery>

	<cfquery name="plans" datasource="Washington_Smoke_Production" result='r2'>
	SELECT r.*, u.*, p.*
	FROM Burn_Request r
	inner join Pre_Burn p on p.b_key = r.plan_key and r.Burn_Permit_Number = p.Burn_Unit_ID_No
	left outer join Post_Burn u on u.R_Key = r.R_Key
	<cfif #dateq# NEQ ''>
		<cfif #qyyyy# NEQ ''>
		WHERE year(p.date_Added) = <cfqueryparam value = "#qyyyy#"
CFSQLType = "INTEGER"
list = "no"
maxLength = "4"
null = "no">
		</cfif>
		<cfif #qmm# NEQ ''>
		AND month(p.date_Added) = <cfqueryparam value = "#qmm#"
CFSQLType = "INTEGER"
list = "no"
maxLength = "2"
null = "no">
		</cfif>
		<cfif #qdd# NEQ ''>
		AND day(p.date_Added) = <cfqueryparam value = "#qdd#"
CFSQLType = "INTEGER"
list = "no"
maxLength = "2"
null = "no">
		</cfif>
	    <cfif #districtq# NEQ ''>
	    AND p.District_Code = <cfqueryparam value = "#districtq#"
CFSQLType = "CF_SQL_VARCHAR"
list = "no"
maxLength = "9"
null = "no">
		</cfif>
	<cfelse>
		AND year(p.date_Added) >= #yyyx#
		AND month(p.date_Added) >= #mm#
		AND day(p.date_Added) >= #dd#
	    <cfif #districtq# NEQ ''>
	    AND p.District_Code = <cfqueryparam value = "#districtq#"
CFSQLType = "CF_SQL_VARCHAR"
list = "no"
maxLength = "9"
null = "no">
		</cfif>
	</cfif>
	ORDER BY p.Burn_Unit_ID_No, r.BURN_DATE DESC
	</cfquery>
</cfif>

<cfif #districtq# NEQ ''>
<cfquery name="fdc" datasource="Washington_Smoke_Production">
	SELECT d.*
	FROM Forest_Access d
	WHERE d.Login_ID = <cfqueryparam value = "#districtq#" CFSQLType = "CF_SQL_VARCHAR" list = "no" maxLength = "9" null = "no">
	ORDER BY The_Forest_Name, District_Name
</cfquery>
</cfif>

<cfheader 
	statusCode = "200"
	statusText = "OK">
<cfheader 
	name="Content-Type" 
	value="application/json">
<cfset foo = structNew()>{
"type": "FeatureCollection",
<cfif #districtq# NEQ ''>
	"properties": {<cfoutput query='fdc'>
		"f": "#The_Forest_Name#",
		"d": "#District_Name#",
		"c": "#Login_ID#"</cfoutput>
	},</cfif>
	"features": [<cfset gcount = 0><cfoutput query='regs'>
			<cfset gcount++>
        <cfif #Trim(Burn_Reason)# CONTAINS "H">
            <cfset reason = "Hazard Reduction">
        <cfelseif #Trim(Burn_Reason)# CONTAINS "W">
            <cfset reason = "Wildlife Habitat">
        <cfelseif #Trim(Burn_Reason)# CONTAINS "F">
            <cfset reason = "">
        <cfelseif #Trim(Burn_Reason)# CONTAINS "S">
            <cfset reason = "Silviculture">
        <cfelseif #Trim(Burn_Reason)# CONTAINS "B">
            <cfset reason = "">
        <cfelseif #Trim(Burn_Reason)# CONTAINS "R">
            <cfset reason = "Rare & Endangered Species">
        <cfelseif #trim(Burn_Reason)# CONTAINS "A">
            <cfset reason = "Slash abatement">
        <cfelseif #Trim(Burn_Reason)# CONTAINS "P">
            <cfset reason = "Slash prevention">
        <cfelseif #Trim(Burn_Reason)# CONTAINS "T">
            <cfset reason = "Training">
        <cfelse>
            <cfset reason = "">
        </cfif>
        <cfif #Ignition_Method# CONTAINS "Hand">
            <cfset method = "Hand">
        <cfelseif #Ignition_Method# CONTAINS "Helicopter">
            <cfset method = "Helicopter">
        <cfelse>
            <cfset method = "Other">
        </cfif>
        <cfif #pile_type# CONTAINS "H">
            <cfset ptype = "Hand">
        <cfelseif #pile_type# CONTAINS "M">
            <cfset ptype = "Machine">
        <cfelseif #pile_type# CONTAINS "G">
            <cfset ptype = "Grapple">
        <cfelse>
            <cfset ptype = "">
        </cfif>
        <cfif #Burn_type# CONTAINS "Broadcast">
            <cfset type = "Broadcast">
        <cfelseif #Burn_type# CONTAINS "Natural">
            <cfset type = "Natural">
        <cfelse>
            <cfset type = "Pile">
        </cfif>
        <cfif #Duff_Type# CONTAINS "Red">
            <cfset dtc = "Red">
        <cfelseif #Duff_Type# CONTAINS "Black">
            <cfset dtc = "Black">
        <cfelse>
            <cfset dtc = "Moss/Lichen">
        </cfif>  
        <cfset tbta = #total_tons#>
        <cfif #TRIM(total_tons)# EQ "">
            <cfset tbta =  0>
        </cfif>
        <cfif #Forest_health_exempt# Contains "Y">
            <cfset fhc = "Y">
        <cfelse>
            <cfset fhc = "N">
        </cfif>
        <cfif #Thousand_Hour_Method# CONTAINS "NFDR">
            <cfset fmc = "NFDR">
        <cfelseif #Thousand_Hour_Method# CONTAINS "ADJ">    
            <cfset fmc = "ADJ">
        <cfelse>
            <cfset fmc = 1>
        </cfif>
        <cfif #TRIM(On_site)# NEQ "">
            <cfset wcm = "on site">
        <cfelse>
            <cfset wcm = "on site">
        </cfif>
        <cfif #isdate(cut_date)#>
            <cfset hdate = '#DateFormat(cut_date,"yyyy-mm-dd")#'>
        <cfelse>
            <cfset hdate = "NA">
</cfif>{"type":"Feature","id":#gcount#,"geometry":{"type":"Point","coordinates":[<cfif #isNumeric(LONGITUDE)#>#NumberFormat(LONGITUDE,999.0000)#<cfelse>1.0</cfif>,<cfif #isNumeric(LATITUDE)#>#NumberFormat(LATITUDE,99.0000)#<cfelse>1.0</cfif>]},"properties":{
"U":"#BURN_UNIT_ID_NO#","F":"#FOREST#","D":"#DISTRICT#","L":"T#TOWNSHIP_1##N_S# R#RANGE_1##E_W# S#SECTION_NO#","R":"#reason#","C":"#trim(COUNTY)#","M":"#method#","B":"#type#","A":#SIZE_OF_UNIT_ACRES#,"T":#TOTAL_PERMIT_QTY_TONS#,"N":"#BURN_PROJECT_NAME#","G":"#TRIM(Predominant_species)#","PD":"#DateFormat(DATE_ADDED,"yyyy-mm-dd")# #TimeFormat(DATE_ADDED,"HH:mm:ss")#","HD":"<cfif #isdate(cut_date)#>#DateFormat(cut_date,"yyyy-mm-dd")#<cfelse>NA</cfif>","SO":"<cfif #isdate(SNOW_OFF_DATE)#>#DateFormat(SNOW_OFF_DATE,"yyyy-mm-dd")#<cfelse>NA</cfif>","S":#SLOPE#,"LT":#LANDING_TONS#,"PT":#PILE_TONS#,"PCM":"#Pile_Calculation_Method#","PX":"#ptype#","W1":#DIAMETER_1#,"W1":#DIAMETER_2#,"W3":#DIAMETER_3#,"W4":#DIAMETER_4#,"W5":#DIAMETER_5#,"W6":#DIAMETER_6#,"TBTA":#tbta#,"BLM":"#Loading_Method#","P3":#LESS_3_ROTTEN#,"H":#SHRUB#,"GH":#GRASS_HERB#,"LD":#LITTER_DEPTH#,"DD":#DUFF_DEPTH#,"DT":"#dtc#","E":#ELEVATION#,"X":"#fhc#","REQUESTS":[]}}<cfif regs.recordcount GT gcount>,<cfelseif plans.recordcount NEQ 0>,</cfif></cfoutput><cfset pcount = 0><cfset first="Y"><cfset last="Y"><cfoutput query='plans'>
			<cfset pcount++>
		<cfif #Trim(Burn_Reason)# CONTAINS "H">
			<cfset reason = "Hazard Reduction">
		<cfelseif #Trim(Burn_Reason)# CONTAINS "W">
			<cfset reason = "Wildlife Habitat">
		<cfelseif #Trim(Burn_Reason)# CONTAINS "F">
			<cfset reason = "">
		<cfelseif #Trim(Burn_Reason)# CONTAINS "S">
			<cfset reason = "Silviculture">
		<cfelseif #Trim(Burn_Reason)# CONTAINS "B">
			<cfset reason = "">
		<cfelseif #Trim(Burn_Reason)# CONTAINS "R">
			<cfset reason = "Rare & Endangered Species">
		<cfelseif #trim(Burn_Reason)# CONTAINS "A">
			<cfset reason = "Slash abatement">
		<cfelseif #Trim(Burn_Reason)# CONTAINS "P">
			<cfset reason = "Slash prevention">
		<cfelseif #Trim(Burn_Reason)# CONTAINS "T">
			<cfset reason = "Training">
		<cfelse>
			<cfset reason = "">
		</cfif>
		<cfif #Ignition_Method# CONTAINS "Hand">
			<cfset method = "Hand">
		<cfelseif #Ignition_Method# CONTAINS "Helicopter">
			<cfset method = "Helicopter">
		<cfelse>
			<cfset method = "Other">
		</cfif>
        <cfif #pile_type# CONTAINS "H">
            <cfset ptype = "Hand">
        <cfelseif #pile_type# CONTAINS "M">
            <cfset ptype = "Machine">
        <cfelseif #pile_type# CONTAINS "G">
            <cfset ptype = "Grapple">
        <cfelse>
            <cfset ptype = "">
        </cfif>
		<cfif #Burn_type# CONTAINS "Broadcast">
			<cfset type = "Broadcast">
		<cfelseif #Burn_type# CONTAINS "Natural">
			<cfset type = "Natural">
		<cfelse>
			<cfset type = "Pile">
		</cfif>
		<cfif #Duff_Type# CONTAINS "Red">
			<cfset dtc = "Red">
		<cfelseif #Duff_Type# CONTAINS "Black">
			<cfset dtc = "Black">
		<cfelse>
			<cfset dtc = "Moss/Lichen">
		</cfif>  
        <cfset tbta = #total_tons#>
        <cfif #TRIM(total_tons)# EQ "">
            <cfset tbta =  0>
        </cfif>
		<cfif #Forest_health_exempt# Contains "Y">
			<cfset fhc = "Y">
		<cfelse>
			<cfset fhc = "N">
		</cfif>
		<cfif #Thousand_Hour_Method# CONTAINS "NFDR">
			<cfset fmc = "NFDR">
		<cfelseif #Thousand_Hour_Method# CONTAINS "ADJ">	
			<cfset fmc = "ADJ">
		<cfelse>
			<cfset fmc = 1>
		</cfif>
		<cfif #TRIM(On_site)# NEQ "">
			<cfset wcm = "on site">
		<cfelse>
			<cfset wcm = "on site">
		</cfif>
		<cfif #isdate(cut_date)#>
			<cfset hdate = '#DateFormat(cut_date,"yyyy-mm-dd")#'>
		<cfelse>
			<cfset hdate = "NA">
		</cfif>
        <cfif #BURN_UNIT_ID_NO# EQ #plans.BURN_UNIT_ID_NO[plans.currentRow + 1]# >
            <cfset last = "N">
        <cfelse>
            <cfset last = "Y">
        </cfif>
        <cfif #BURN_UNIT_ID_NO# EQ #plans.BURN_UNIT_ID_NO[plans.currentRow - 1]# >
            <cfset first = "N">
        <cfelse>
            <cfset first = "Y">
        </cfif>
<cfif first EQ 'Y'>{"type":"Feature","id":#pcount#,"geometry":{"type":"Point","coordinates":[<cfif #isNumeric(LONGITUDE)#>#NumberFormat(LONGITUDE,999.0000)#<cfelse>1.0</cfif>,<cfif #isNumeric(LATITUDE)#>#NumberFormat(LATITUDE,99.0000)#<cfelse>1.0</cfif>]},"properties":{"U":"#BURN_UNIT_ID_NO#","F":"#FOREST#","D":"#DISTRICT#","L":"T#TOWNSHIP_1##N_S# R#RANGE_1##E_W# S#SECTION_NO#","R":"#reason#","C":"#trim(COUNTY)#","M":"#method#","B":"#type#","A":#SIZE_OF_UNIT_ACRES#,"T":#TOTAL_PERMIT_QTY_TONS#,"N":"#BURN_PROJECT_NAME#","G":"#TRIM(Predominant_species)#","PD":"#DateFormat(DATE_ADDED,"yyyy-mm-dd")# #TimeFormat(DATE_ADDED,"HH:mm:ss")#","HD":"<cfif #isdate(cut_date)#>#DateFormat(cut_date,"yyyy-mm-dd")#<cfelse>NA</cfif>","SO":"<cfif #isdate(SNOW_OFF_DATE)#>#DateFormat(SNOW_OFF_DATE,"yyyy-mm-dd")#<cfelse>NA</cfif>","S":#SLOPE#,"LT":#LANDING_TONS#,"PT":#PILE_TONS#,"PCM":"#Pile_Calculation_Method#","PX":"#ptype#","W1":#DIAMETER_1#,"W1":#DIAMETER_2#,"W3":#DIAMETER_3#,"W4":#DIAMETER_4#,"W5":#DIAMETER_5#,"W6":#DIAMETER_6#,"TBTA":#tbta#,"BLM":"#Loading_Method#","P3":#LESS_3_ROTTEN#,"H":#SHRUB#,"GH":#GRASS_HERB#,"LD":#LITTER_DEPTH#,"DD":#DUFF_DEPTH#,"DT":"#dtc#","E":#ELEVATION#,"X":"#fhc#","REQUESTS":[</cfif>{
"R":"#BURN_REQ_NO#","PD":"#DateFormat(BURN_DATE,"yyyy-mm-dd")#","PH":"#PLANNED_IGNITION_TIME#","PA":#ACREAGE_THIS_BURN#,"PT":#TONNAGE_THIS_BURN#,"PI":#int(BURN_DURATION_MIN)#,"M":"#trim(MULTI_DAY_BURN)#","PC":"#JSStringFormat(REReplace(BURN_COMMENTS,"\r\n|\n\r|\n|\r|['""]"," ","all"))#","P":"#trim(RANK)#","AD":"#DateFormat(DATE_BURNED,"yyyy-mm-dd")#","AH":"#IGNITION_TIME#","AA":<cfif #ACTUAL_ACRES_BURNED# NEQ ''>#ACTUAL_ACRES_BURNED#<cfelse>0</cfif>,"AT":<cfif #ESTIMATED_CONSUMED_TOTAL_TONNAGE# NEQ ''>#ESTIMATED_CONSUMED_TOTAL_TONNAGE#<cfelse>0</cfif>,"AI":<cfif #IGNITION_DURATION_IN_MINUTES# NEQ ''>#int(IGNITION_DURATION_IN_MINUTES)#<cfelse>0</cfif>,"F":"#Thousand_Hour_Method#","C":"#wcm#","S":"#RAWS#","W":<cfif #WIND_SPEED# NEQ ''>#WIND_SPEED#<cfelse>0</cfif>,"R":<cfif #DAYS_SINCE_RAIN# NEQ ''>#DAYS_SINCE_RAIN#<cfelse>0</cfif>,"M1":<cfif #FUEL_MOISTURE_TEN_HOURS# NEQ ''>#FUEL_MOISTURE_TEN_HOURS#<cfelse>0</cfif>,"M2":<cfif #FUEL_MOISTURE_1000_HOUR# NEQ ''>#FUEL_MOISTURE_1000_HOUR#<cfelse>0</cfif>,"MD":<cfif #Duff_Fuel_Moisture# NEQ ''>#Duff_Fuel_Moisture#<cfelse>0</cfif>,"BS":<cfif #BLACK_SHRUB_PC# NEQ ''>#BLACK_SHRUB_PC#<cfelse>0</cfif>,"BC":<cfif #BLACK_CANOPY_PC# NEQ ''>#BLACK_CANOPY_PC#<cfelse>0</cfif>,"BP":<cfif #BLACK_PILE_PC# NEQ ''>#BLACK_PILE_PC#<cfelse>0</cfif>,"AC":"#JSStringFormat(REReplace(Post_Burn_Comments,"\r\n|\n\r|\n|\r|['""]"," ","all"))#"}<cfif last EQ "Y">]}}</cfif><cfif plans.recordcount GT pcount>,</cfif></cfoutput>]}