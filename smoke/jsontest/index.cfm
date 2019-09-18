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
<cfset unitq = ''>
<cfset qyyyy = ''>
<cfset qmm = ''>
<cfset qdd = ''>
<cfif #cgi.query_string# NEQ ''>
	<cfif #cgi.query_string# CONTAINS 'unit='>
		<cfset unitq = REReplaceNoCase( cgi.query_string,  "unit=", "") />
		<CFquery NAME="GPB" DATASOURCE="Washington_Smoke_Production">   
			SELECT	  *
			FROM		Pre_Burn 
			INNER JOIN
					  Burn_Request ON Pre_Burn.B_key = Burn_Request.Plan_Key
			INNER JOIN
					Post_Burn ON Post_Burn.R_Key = Burn_Request.R_Key
			WHERE Pre_Burn.Burn_Unit_ID_No = #unitq#
			AND Pre_Burn.date_deleted is null
		</cfquery>
		<cfdump var='#GPB#'>
	<cfelseif #cgi.query_string# CONTAINS 'date='>
		<cfset dateq = REReplaceNoCase( cgi.query_string,  "date=", "") />
		<cfset TestSTring = dateq>
		<cfset a = ListToArray(TestString, "-", false, true)>
		<cftry>
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
			<cfcatch>
			BAD, EVIL date entry.
			<cfabort>
			</cfcatch>
		</cftry>
	</cfif>
</cfif>

<cfif #cgi.query_string# NEQ '' and #dateq# EQ '' and #unitq# EQ ''>
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
<cfelse>
	<cfset lastyear = '#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"HH:mm:ss tt")#'>
	<cfset yyyy = '#DateFormat(now(),"yyyy")#'>
	<cfset mm = '#DateFormat(now(),"mm")#'>
	<cfset dd = '#DateFormat(now(),"dd")#'>
	<cfquery name="regs" datasource="Washington_Smoke_Production">
	SELECT *
	FROM Pre_Burn p
	<cfif #dateq# NEQ ''>
		<cfif #qyyyy# NEQ ''>
		WHERE year(date_Added) = #qyyyy#
		</cfif>
		<cfif #qmm# NEQ ''>
		AND month(date_Added) = #qmm#
		</cfif>
		<cfif #qdd# NEQ ''>
		AND day(date_Added) = #qdd#
		</cfif>
	<cfelse>
		WHERE year(date_Added) = #yyyy#
		AND month(date_Added) = #mm#
		AND day(date_Added) = #dd#
	</cfif>
	ORDER BY date_added DESC,district ASC,Burn_Project_Name
	</cfquery>
	<cfquery name="plans" datasource="Washington_Smoke_Production">
	SELECT r.*, p.*,uu.firstname,uu.lastname,uu.email
	FROM Burn_Request r, Pre_Burn p
	left outer join FAMDB.dbo.users uu on uu.username = p.added_by
	<cfif #dateq# NEQ ''>
		<cfif #qyyyy# NEQ ''>
		WHERE year(r.date_Added) = #qyyyy#
		</cfif>
		<cfif #qmm# NEQ ''>
		AND month(r.date_Added) = #qmm#
		</cfif>
		<cfif #qdd# NEQ ''>
		AND day(r.date_Added) = #qdd#
		</cfif>
	<cfelse>
		WHERE year(r.date_Added) = #yyyy#
		AND month(r.date_Added) = #mm#
		AND day(r.date_Added) = #dd#
	</cfif>
	AND p.b_key = r.plan_key
	AND r.Burn_Permit_Number = p.Burn_Unit_ID_No
	ORDER BY r.date_added DESC
	</cfquery>
	<cfquery name="results" datasource="Washington_Smoke_Production">
	SELECT u.*,r.*,p.*,uu.firstname,uu.lastname,uu.email
	FROM Post_Burn u, Burn_Request r,Pre_burn p
	left outer join FAMDB.dbo.users uu on uu.username = p.added_by
	<cfif #dateq# NEQ ''>
		<cfif #qyyyy# NEQ ''>
		WHERE year(u.date_Added) = #qyyyy#
		</cfif>
		<cfif #qmm# NEQ ''>
		AND month(u.date_Added) = #qmm#
		</cfif>
		<cfif #qdd# NEQ ''>
		AND day(u.date_Added) = #qdd#
		</cfif>
	<cfelse>
		WHERE year(u.date_Added) = #yyyy#
		AND month(u.date_Added) = #mm#
		AND day(u.date_Added) = #dd#
	</cfif>
	AND u.R_Key = r.R_Key
	AND p.b_key = r.plan_key
	AND r.Burn_Permit_Number = p.Burn_Unit_ID_No
	ORDER BY u.date_added DESC
	</cfquery>
</cfif>

<cfheader 
	statusCode = "303"
	statusText = "See Other">
<cfheader 
	name="Content-Type" 
	value="application/json">
<cfset foo = structNew()>{
	"BURN": [<cfset gcount = 0><cfoutput query='regs'>
			<cfset gcount++>
		<cfif #Trim(Burn_Reason)# CONTAINS "H">
			<cfset reason = 1>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "W">
			<cfset reason = 2>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "F">
			<cfset reason = 3>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "S">
			<cfset reason = 3>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "B">
			<cfset reason = 1>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "R">
			<cfset reason = 4>
		<cfelseif #trim(Burn_Reason)# CONTAINS "A">
			<cfset reason = 5>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "P">
			<cfset reason = 6>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "T">
			<cfset reason = 7>
		<cfelse>
			<cfset reason = 1>
		</cfif>
		<cfif #Ignition_Method# CONTAINS "Hand">
			<cfset method = 1>
		<cfelseif #Ignition_Method# CONTAINS "Helicopter">
			<cfset method = 2>
		<cfelse>
			<cfset method = 3>
		</cfif>
		<cfif #Burn_type# CONTAINS "Broadcast">
			<cfset type = 3>
		<cfelseif #Burn_type# CONTAINS "Natural">
			<cfset type = 2>
		<cfelse>
			<cfset type = 1>
		</cfif>
		<cfif #TRIM(Predominant_species)# EQ "Grass">
			<cfset fuel = 1> 40
			<cfset nuel = 40>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Grass/Lodgepole">
			<cfset fuel = 2>
			<cfset nuel = 25>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Grass/Ponderosa">
			<cfset fuel = 3>
			<cfset nuel = 39>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Lodgepole">
			<cfset fuel = 4>
			<cfset nuel = 24>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Mixed Conifer">
			<cfset fuel = 5>
			<cfset nuel = 27>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Mixed Conifer/Shrub">
			<cfset fuel = 6>
			<cfset nuel = 29>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Ponderosa">
			<cfset fuel = 7>
			<cfset nuel = 34>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Shrub">
			<cfset fuel = 8>
			<cfset nuel = 45>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Western Juniper">
			<cfset fuel = 9>
			<cfset nuel = ''>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Sagebrush">
			<cfset fuel = 10>
			<cfset nuel = 46>
		<cfelse>
			<cfset fuel = 0>
			<cfset nuel = 0>
		</cfif>
		<cfif #Duff_Type# CONTAINS "Red">
			<cfset dtc = 2>
		<cfelseif #Duff_Type# CONTAINS "Black">
			<cfset dtc = 3>
		<cfelse>
			<cfset dtc = 4>
		</cfif>  
		<cfif #Forest_health_exempt# Contains "Y">
			<cfset fhc = "Y">
		<cfelse>
			<cfset fhc = "N">
		</cfif>
		<cfif #isdate(cut_date)#>

			<cfset hdate = '#DateFormat(cut_date,"yyyy-mm-dd")#'>
		<cfelse>
			<cfset hdate = "1999-01-01">
		</cfif>
		{
			"USFS_UNIT_NO": "#BURN_UNIT_ID_NO#", 
			"FOREST": "#FOREST#",
			"DISTRICT": "#DISTRICT#",
			"CONTACT": "#CONTACT#",
			"EMAIL": "#EMAIL#",
			"LEGAL_DESC": "T#TOWNSHIP_1##N_S# R#RANGE_1##E_W# S#SECTION_NO#",
			"BURN_REASON": #reason#,
			"COUNTY": "#trim(COUNTY)#",
			"IGNITION_METHOD": #method#,
			"PERMIT_BURN_TYPE": #type#,
			"PERMIT_ACRES": #SIZE_OF_UNIT_ACRES#,
			"PERMIT_TONS": #TOTAL_PERMIT_QTY_TONS#,
			"PLAN_BLACK_ACRES": 0,
			"UNIT_NAME": "#BURN_PROJECT_NAME#",
			"FUEL": <cfif #dtest# EQ '1'>#NUEL#<cfelse>#FUEL#</cfif>,
			"PERMIT_ISSUE_DT": "#DateFormat(DATE_ADDED,"yyyy-mm-dd")# #TimeFormat(DATE_ADDED,"HH:mm:ss")#",
			"HARVEST_DT": "#hdate#",
			"SNOW_OFF_DT": "#DateFormat(SNOW_OFF_DATE,"yyyy-mm-dd")#",
			"SLOPE_PC": #SLOPE#,
			"EST_LANDING_PILE_TONS": #LANDING_TONS#,
			"EST_PILE_TONS": #PILE_TONS#,
			"WOOD_0_TO_25": #DIAMETER_1#,
			"WOOD_26_TO_1": #DIAMETER_2#,
			"WOOD_1_TO_3": #DIAMETER_3#,
			"WOOD_3_TO_9": #DIAMETER_4#,
			"WOOD_9_TO_20": #DIAMETER_5#,
			"WOOD_20_PLUS": #DIAMETER_6#,
			"PLUS_3_IN_ROTTEN": #LESS_3_ROTTEN#,
			"SHRUB": #SHRUB#,
			"GRASS_HERB": #GRASS_HERB#,
			"LITTER_DEPTH": #LITTER_DEPTH#,
			"DUFF_DEPTH": #DUFF_DEPTH#,
			"DUFF_TYPE": #dtc#,
			"ELEVATION": #ELEVATION#,
			"LATITUDE": #LATITUDE#,
			"LONGITUDE": #LONGITUDE#,
			"FOREST_HEALTH_EXEMPT_FLG": "#fhc#",
			"REQUEST": {
			},
			"POST_BURN": {
			}
		}<cfif regs.recordcount GT gcount>,<cfelseif plans.recordcount NEQ 0>,<cfelseif results.recordcount NEQ 0>,</cfif></cfoutput><cfset pcount = 0><cfoutput query='plans'>
			<cfset pcount++>
		<cfif #Trim(Burn_Reason)# CONTAINS "H">
			<cfset reason = 1>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "W">
			<cfset reason = 2>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "F">
			<cfset reason = 3>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "S">
			<cfset reason = 3>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "B">
			<cfset reason = 1>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "R">
			<cfset reason = 4>
		<cfelseif #trim(Burn_Reason)# CONTAINS "A">
			<cfset reason = 5>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "P">
			<cfset reason = 6>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "T">
			<cfset reason = 7>
		<cfelse>
			<cfset reason = 1>
		</cfif>
		<cfif #Ignition_Method# CONTAINS "Hand">
			<cfset method = 1>
		<cfelseif #Ignition_Method# CONTAINS "Helicopter">
			<cfset method = 2>
		<cfelse>
			<cfset method = 3>
		</cfif>
		<cfif #Burn_type# CONTAINS "Broadcast">
			<cfset type = 3>
		<cfelseif #Burn_type# CONTAINS "Natural">
			<cfset type = 2>
		<cfelse>
			<cfset type = 1>
		</cfif>
		<cfif #TRIM(Predominant_species)# EQ "Grass">
			<cfset fuel = 1> 40
			<cfset nuel = 40>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Grass/Lodgepole">
			<cfset fuel = 2>
			<cfset nuel = 25>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Grass/Ponderosa">
			<cfset fuel = 3>
			<cfset nuel = 39>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Lodgepole">
			<cfset fuel = 4>
			<cfset nuel = 24>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Mixed Conifer">
			<cfset fuel = 5>
			<cfset nuel = 27>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Mixed Conifer/Shrub">
			<cfset fuel = 6>
			<cfset nuel = 29>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Ponderosa">
			<cfset fuel = 7>
			<cfset nuel = 34>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Shrub">
			<cfset fuel = 8>
			<cfset nuel = 45>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Western Juniper">
			<cfset fuel = 9>
			<cfset nuel = ''>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Sagebrush">
			<cfset fuel = 10>
			<cfset nuel = 46>
		<cfelse>
			<cfset fuel = 0>
			<cfset nuel = 0>
		</cfif>
		<cfif #Duff_Type# CONTAINS "Red">
			<cfset dtc = 2>
		<cfelseif #Duff_Type# CONTAINS "Black">
			<cfset dtc = 3>
		<cfelse>
			<cfset dtc = 4>
		</cfif>  
		<cfif #Forest_health_exempt# Contains "Y">
			<cfset fhc = "Y">
		<cfelse>
			<cfset fhc = "N">
		</cfif>
		<cfif #isdate(cut_date)#>
			<cfset hdate = '#DateFormat(cut_date,"yyyy-mm-dd")#'>
		<cfelse>
			<cfset hdate = "1999-01-01">
		</cfif>
		{
			"USFS_UNIT_NO": "#BURN_UNIT_ID_NO#", 
			"FOREST": "#FOREST#",
			"DISTRICT": "#DISTRICT#",
			"CONTACT": "#CONTACT#",
			"EMAIL": "#EMAIL#",
			"LEGAL_DESC": "T#TOWNSHIP_1##N_S# R#RANGE_1##E_W# S#SECTION_NO#",
			"BURN_REASON": #reason#,
			"COUNTY": "#trim(COUNTY)#",
			"IGNITION_METHOD": #method#,
			"PERMIT_BURN_TYPE": #type#,
			"PERMIT_ACRES": #SIZE_OF_UNIT_ACRES#,
			"PERMIT_TONS": #TOTAL_PERMIT_QTY_TONS#,
			"PLAN_BLACK_ACRES": 0,
			"UNIT_NAME": "#BURN_PROJECT_NAME#",
			"FUEL": <cfif #dtest# EQ '1'>#NUEL#<cfelse>#FUEL#</cfif>,
			"PERMIT_ISSUE_DT": "#DateFormat(DATE_ADDED,"yyyy-mm-dd")# #TimeFormat(DATE_ADDED,"HH:mm:ss")#",
			"HARVEST_DT": "#hdate#",
			"SNOW_OFF_DT": "#DateFormat(SNOW_OFF_DATE,"yyyy-mm-dd")#",
			"SLOPE_PC": #SLOPE#,
			"EST_LANDING_PILE_TONS": #LANDING_TONS#,
			"EST_PILE_TONS": #PILE_TONS#,
			"WOOD_0_TO_25": #DIAMETER_1#,
			"WOOD_26_TO_1": #DIAMETER_2#,
			"WOOD_1_TO_3": #DIAMETER_3#,
			"WOOD_3_TO_9": #DIAMETER_4#,
			"WOOD_9_TO_20": #DIAMETER_5#,
			"WOOD_20_PLUS": #DIAMETER_6#,
			"PLUS_3_IN_ROTTEN": #LESS_3_ROTTEN#,
			"SHRUB": #SHRUB#,
			"GRASS_HERB": #GRASS_HERB#,
			"LITTER_DEPTH": #LITTER_DEPTH#,
			"DUFF_DEPTH": #DUFF_DEPTH#,
			"DUFF_TYPE": #dtc#,
			"ELEVATION": #ELEVATION#,
			"LATITUDE": #LATITUDE#,
			"LONGITUDE": #LONGITUDE#,
			"FOREST_HEALTH_EXEMPT_FLG": "#fhc#",
			"REQUEST": {
				"CONTACT": "#CONTACT#",
				"EMAIL": "#EMAIL#",
				"USFS_BURN_ACTIVITY_ID": "#BURN_REQ_NO#",
				"PLAN_BURN_DT": "#DateFormat(BURN_DATE,"yyyy-mm-dd")#",
				"PLAN_BURN_TIME": "#PLANNED_IGNITION_TIME#",
				"PLAN_BURN_ACRES": #ACREAGE_THIS_BURN#,
				"PLAN_BURN_TONS": #TONNAGE_THIS_BURN#,
				"PLAN_BURN_IGNITION_MIN": #BURN_DURATION_MIN#,
				"PLAN_BURN_MULTI_DAYS": "#trim(MULTI_DAY_BURN)#",
				"PLAN_BURN_COMMENTS": "#REReplace(BURN_COMMENTS, "\r\n|\n\r|\n|\r|['""]", " ", "all")#",
				"PLAN_BURN_PRIORITY": "#trim(RANK)#"
			},
			"POST_BURN": {
			}
		}<cfif plans.recordcount GT pcount or results.recordcount NEQ 0>,</cfif></cfoutput><cfset rcount = 0><cfoutput query='results'>
			<cfset rcount++>
		<cfif #Trim(Burn_Reason)# CONTAINS "H">
			<cfset reason = 1>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "W">
			<cfset reason = 2>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "F">
			<cfset reason = 3>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "S">
			<cfset reason = 3>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "B">
			<cfset reason = 1>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "R">
			<cfset reason = 4>
		<cfelseif #trim(Burn_Reason)# CONTAINS "A">
			<cfset reason = 5>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "P">
			<cfset reason = 6>
		<cfelseif #Trim(Burn_Reason)# CONTAINS "T">
			<cfset reason = 7>
		<cfelse>
			<cfset reason = 1>
		</cfif>
		<cfif #Ignition_Method# CONTAINS "Hand">
			<cfset method = 1>
		<cfelseif #Ignition_Method# CONTAINS "Helicopter">
			<cfset method = 2>
		<cfelse>
			<cfset method = 3>
		</cfif>
		<cfif #Burn_type# CONTAINS "Broadcast">
			<cfset type = 3>
		<cfelseif #Burn_type# CONTAINS "Natural">
			<cfset type = 2>
		<cfelse>
			<cfset type = 1>
		</cfif>
		<cfif #TRIM(Predominant_species)# EQ "Grass">
			<cfset fuel = 1> 40
			<cfset nuel = 40>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Grass/Lodgepole">
			<cfset fuel = 2>
			<cfset nuel = 25>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Grass/Ponderosa">
			<cfset fuel = 3>
			<cfset nuel = 39>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Lodgepole">
			<cfset fuel = 4>
			<cfset nuel = 24>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Mixed Conifer">
			<cfset fuel = 5>
			<cfset nuel = 27>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Mixed Conifer/Shrub">
			<cfset fuel = 6>
			<cfset nuel = 29>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Ponderosa">
			<cfset fuel = 7>
			<cfset nuel = 34>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Shrub">
			<cfset fuel = 8>
			<cfset nuel = 45>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Western Juniper">
			<cfset fuel = 9>
			<cfset nuel = ''>
		<cfelseif #TRIM(Predominant_species)# CONTAINS "Sagebrush">
			<cfset fuel = 10>
			<cfset nuel = 46>
		<cfelse>
			<cfset fuel = 0>
			<cfset nuel = 0>
		</cfif>
		<cfif #Duff_Type# CONTAINS "Red">
			<cfset dtc = 2>
		<cfelseif #Duff_Type# CONTAINS "Black">
			<cfset dtc = 3>
		<cfelse>
			<cfset dtc = 4>
		</cfif>  
		<cfif #Forest_health_exempt# Contains "Y">
			<cfset fhc = "Y">
		<cfelse>
			<cfset fhc = "N">
		</cfif>
		<cfif #Thousand_Hour_Method# CONTAINS "NFDR">
			<cfset fmc = 3>
		<cfelseif #Thousand_Hour_Method# CONTAINS "ADJ">	
			<cfset fmc = 2>
		<cfelse>
			<cfset fmc = 1>
		</cfif>
		<cfif #TRIM(On_site)# NEQ "">
			<cfset wcm = 1>
		<cfelse>
			<cfset wcm = 1>
		</cfif>
		<cfif #isdate(cut_date)#>
			<cfset hdate = '#DateFormat(cut_date,"yyyy-mm-dd")#'>
		<cfelse>
			<cfset hdate = "1999-01-01">
		</cfif>
		{
			"USFS_UNIT_NO": "#BURN_UNIT_ID_NO#", 
			"FOREST": "#FOREST#",
			"DISTRICT": "#DISTRICT#",
			"CONTACT": "#CONTACT#",
			"EMAIL": "#EMAIL#",
			"LEGAL_DESC": "T#TOWNSHIP_1##N_S# R#RANGE_1##E_W# S#SECTION_NO#",
			"BURN_REASON": #reason#,
			"COUNTY": "#trim(COUNTY)#",
			"IGNITION_METHOD": #method#,
			"PERMIT_BURN_TYPE": #type#,
			"PERMIT_ACRES": #SIZE_OF_UNIT_ACRES#,
			"PERMIT_TONS": #TOTAL_PERMIT_QTY_TONS#,
			"PLAN_BLACK_ACRES": 0,
			"UNIT_NAME": "#BURN_PROJECT_NAME#",
			"FUEL": <cfif #dtest# EQ '1'>#NUEL#<cfelse>#FUEL#</cfif>,
			"PERMIT_ISSUE_DT": "#DateFormat(DATE_ADDED,"yyyy-mm-dd")# #TimeFormat(DATE_ADDED,"HH:mm:ss")#",
			"HARVEST_DT": "#hdate#",
			"SNOW_OFF_DT": "#DateFormat(SNOW_OFF_DATE,"yyyy-mm-dd")#",
			"SLOPE_PC": #SLOPE#,
			"EST_LANDING_PILE_TONS": #LANDING_TONS#,
			"EST_PILE_TONS": #PILE_TONS#,
			"WOOD_0_TO_25": #DIAMETER_1#,
			"WOOD_26_TO_1": #DIAMETER_2#,
			"WOOD_1_TO_3": #DIAMETER_3#,
			"WOOD_3_TO_9": #DIAMETER_4#,
			"WOOD_9_TO_20": #DIAMETER_5#,
			"WOOD_20_PLUS": #DIAMETER_6#,
			"PLUS_3_IN_ROTTEN": #LESS_3_ROTTEN#,
			"SHRUB": #SHRUB#,
			"GRASS_HERB": #GRASS_HERB#,
			"LITTER_DEPTH": #LITTER_DEPTH#,
			"DUFF_DEPTH": #DUFF_DEPTH#,
			"DUFF_TYPE": #dtc#,
			"ELEVATION": #ELEVATION#,
			"LATITUDE": #LATITUDE#,
			"LONGITUDE": #LONGITUDE#,
			"FOREST_HEALTH_EXEMPT_FLG": "#fhc#",
			"REQUEST": {
				"CONTACT": "#CONTACT#",
				"EMAIL": "#EMAIL#",
				"USFS_BURN_ACTIVITY_ID": "#BURN_REQ_NO#",
				"PLAN_BURN_DT": "#DateFormat(BURN_DATE,"yyyy-mm-dd")#",
				"PLAN_BURN_TIME": "#PLANNED_IGNITION_TIME#",
				"PLAN_BURN_ACRES": #ACREAGE_THIS_BURN#,
				"PLAN_BURN_TONS": #TONNAGE_THIS_BURN#,
				"PLAN_BURN_IGNITION_MIN": #BURN_DURATION_MIN#,
				"PLAN_BURN_MULTI_DAYS": "#trim(MULTI_DAY_BURN)#",
				"PLAN_BURN_COMMENTS": "#REReplace(BURN_COMMENTS, "\r\n|\n\r|\n|\r|['""]", " ", "all")#",
				"PLAN_BURN_PRIORITY": "#trim(RANK)#"
			},
			"POST_BURN": {
				"CONTACT": "#CONTACT#",
				"EMAIL": "#EMAIL#",
				"ACTUAL_BURN_DT": "#DateFormat(DATE_BURNED,"yyyy-mm-dd")#",
				"ACTUAL_BURN_TIME": "#IGNITION_TIME#",
				"ACTUAL_BURN_ACRES": #ACTUAL_ACRES_BURNED#,
				"ACTUAL_BURN_TONS": <cfif #ESTIMATED_CONSUMED_TOTAL_TONNAGE# NEQ ''>#ESTIMATED_CONSUMED_TOTAL_TONNAGE#<cfelse>0</cfif>,
				"ACTUAL_IGNITION_MIN": <cfif #IGNITION_DURATION_IN_MINUTES# NEQ ''>#IGNITION_DURATION_IN_MINUTES#<cfelse>0</cfif>,
				"FUEL_MOISTURE_MEAS": #fmc#,
				"WEATHER_COLL_METHOD": #wcm#,
				"WEATHER_STN_NM": "#RAWS#",
				"WINDSPEED": <cfif #WIND_SPEED# NEQ ''>#WIND_SPEED#<cfelse>0</cfif>,
				"DAYS_SINCE_RAIN": <cfif #DAYS_SINCE_RAIN# NEQ ''>#DAYS_SINCE_RAIN#<cfelse>0</cfif>,
				"MOISTURE_10HR_PC": <cfif #FUEL_MOISTURE_TEN_HOURS# NEQ ''>#FUEL_MOISTURE_TEN_HOURS#<cfelse>0</cfif>,
				"MOISTURE_1000HR_PC": <cfif #FUEL_MOISTURE_1000_HOUR# NEQ ''>#FUEL_MOISTURE_1000_HOUR#<cfelse>0</cfif>,
				"MOISTURE_DUFF_PC": <cfif #Duff_Fuel_Moisture# NEQ ''>#Duff_Fuel_Moisture#<cfelse>0</cfif>,
				"BLACK_SHRUB_PC": <cfif #BLACK_SHRUB_PC# NEQ ''>#BLACK_SHRUB_PC#<cfelse>0</cfif>,
				"BLACK_CANOPY_PC": <cfif #BLACK_CANOPY_PC# NEQ ''>#BLACK_CANOPY_PC#<cfelse>0</cfif>,
				"BLACK_PILE_PC": <cfif #BLACK_PILE_PC# NEQ ''>#BLACK_PILE_PC#<cfelse>0</cfif>,
				"POST_BURN_COMMENTS": "#REReplace(Post_Burn_Comments, "\r\n|\n\r|\n|\r|['""]", " ", "all")#"
			}
		}<cfif results.recordcount GT rcount>,</cfif></cfoutput>
	]
}
