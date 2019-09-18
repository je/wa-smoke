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

<cfset ua = 'Post_key,Post_Burn_Key,u.R_Key,u.Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Actual_Acres_Burned,Reason_for_No_Burn_Code,Reason_for_No_Burn,u.Date_Added,u.Added_by'>
<cfset uheads = 'none,Post_Burn_Key,R_Key,Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Actual_Acres_Burned,Reason_for_No_Burn_Code,Reason_for_No_Burn,Date_Added,Added_by'>
<cfset urefs = 'Post_key,Post_Burn_Key,R_Key,Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Actual_Acres_Burned,Reason_for_No_Burn_Code,Reason_for_No_Burn,Date_Added,Added_by'>
<cfset urebs = 'Post_key,Post_Burn_Key,R_Key,u.Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Actual_Acres_Burned,Reason_for_No_Burn_Code,Reason_for_No_Burn,u.Date_Added,u.Added_by'>

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
            SELECT      *
            FROM        Pre_Burn 
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
	SELECT r.*, p.*
	FROM Burn_Request r, Pre_Burn p
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
	SELECT u.*,r.*,p.*
	FROM Post_Burn u, Burn_Request r,Pre_burn p
	<cfif #dateq# NEQ ''>
	    <cfif #qyyyy# NEQ ''>
	    WHERE year(u.date_burned) = #qyyyy#
	    </cfif>
	    <cfif #qmm# NEQ ''>
	    AND month(u.date_burned) = #qmm#
	    </cfif>
	    <cfif #qdd# NEQ ''>
	    AND day(u.date_burned) = #qdd#
	    </cfif>
	<cfelse>
	    WHERE year(u.date_burned) = #yyyy#
	    AND month(u.date_burned) = #mm#
	    AND day(u.date_burned) = #dd#
	</cfif>
	AND u.R_Key = r.R_Key
	AND p.b_key = r.plan_key
	AND r.Burn_Permit_Number = p.Burn_Unit_ID_No
	ORDER BY u.date_added DESC
	</cfquery>
</cfif>

<!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" name="viewport">
<title>
Washington Smoke
</title>

<link rel="stylesheet" href="/bootstrap-3.3.5u/css/bootstrap.min.css">
<link rel="stylesheet" href="/bootstrap-3.3.5u/sticky-footer.css">


<style type="text/css">
    styled {
        color:#fff;
        text-color: #fff;
        text-decoration:none;
        focus:#fff;
    }
    .styled {
        color:#fff;
        text-color: #fff;
        text-decoration:none;
        focus:#fff;
    }
    .icon {
        text-align:center;
        vertical-align:middle;
        border-radius:10px;
        float:left;
        height:20px;
        width:20px;
    }
    .redorange {
        background:#FF4500; /* ro */
    }
    .vw{
        position: relative;
        padding-bottom: 56.25%; /* 16:9 */
        padding-top: 25px;
        height: 0;
    }
    .vw iframe {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
    }
</style>
</head>

<body style="">

    <nav class="navbar navbar-default navbar-static-top">
      <div class="navbar-inner">
            <span class="navbar-brand"><styled><strong><a href="/" style="color:black;"><cfoutput>#site_name#</cfoutput></a></strong></styled></span>
            <span class="navbar-brand pull-right">
                <styled></styled>
            </span>
      </div>
    </nav>

<div id="content" class="container-fluid">

<div class="panel panel-info" style="max-width:none;">
    <div class="panel-heading">
        <h3 class="panel-title">
        <a href="/smoke/">Washington Smoke</a>
        <span class='pull-right'><cfif add NEQ 'XX'>
            <cfoutput>Accomplishment Summary for <a href="/smoke/#ayyyy#/">#ayyyy#</a>-<a href="/smoke/#ayyyy#/#amm#/">#amm#</a>-<a href="/smoke/#ayyyy#/#amm#/#add#/map/">#add#</a>.</cfoutput>
        <cfelseif amm NEQ 'XX'>
            <cfoutput>Accomplishment Summary for <a href="/smoke/#ayyyy#/">#ayyyy#</a>-#amm#.</cfoutput>
        <cfelse>
            <cfoutput>Accomplishment Summary for #ayyyy#.</cfoutput>
        </cfif></span>
        </h3>
        <style type="text/css">
            td {vertical-align:top;}
            th.number {text-align:right;}
            th.why {text-align:center;}
            td.number {text-align:right;}
            td.date {text-align:right;}
            td.why {width:100px;}
        </style>
    </div>
        <table class='table table-striped table-condensed table-bordered'>
        <thead>
        <th class='why'>tla</th>
        <th>district</th>
        <th>burn<br>type</th>
        <th>name</th>
        <th class='number'>acres</th>
        <th class='number'>ptons</th>
        <th class='number'>ltons</th>
        <th class='number'>btons/ac</th>
        <th class='number'>burn acres<br>(plan>actual)</th>
        <th class='number'>burn date<br>(plan>actual)</th>
        <th class='number'>no?</th>
        <th class='why'>why?</th>
        </thead>
        <tbody>
        <cfloop query='results'>
        <cfoutput>
        <tr>
        <td><a href="/smoke/district/{{ district.tla|lower }}/">#forest#</a></td>
        <td><a href="/smoke/district/{{ result.snid.sn.district.tla|lower }}/{{ result.snid.sn.district.slug }}/">#district#</a></td>
        <td>#burn_type#</td>
        <td><a href="/smoke/{{ result.snid.sn }}/">#burn_project_name#</a></td>
        <td class='number'>#Size_of_Unit_acres#</td>
        <td class='number'>#pile_tons#</td>
        <td class='number'>#landing_tons#</td>
        <td class='number'>#diameter_1 + diameter_2 + diameter_3 + diameter_4 + diameter_5 + diameter_6#</td>
        <td class='number'>#ACREAGE_THIS_BURN#<cfif ACREAGE_THIS_BURN GT ACTUAL_ACRES_BURNED> > #ACTUAL_ACRES_BURNED#</cfif></td>
        <td class='date'>#DateFormat(burn_date,'yyyy-mm-dd')#<cfif DateFormat(burn_date,'yyyy-mm-dd') NEQ DateFormat(date_burned,'yyyy-mm-dd')> > #DateFormat(date_burned,'yyyy-mm-dd')#</cfif></td>
        <td class='number'><cfif ACREAGE_THIS_BURN GT ACTUAL_ACRES_BURNED >#Reason_for_No_Burn_Code#</cfif></td>
        <td class='why'><cfif ACREAGE_THIS_BURN GT ACTUAL_ACRES_BURNED >#Reason_for_No_Burn#</cfif></td>
        </tr>
        </cfoutput>
        </cfloop>
        </tbody>
        </table>
    <div class="panel-footer">
        <cfif add NEQ 'XX'>
        <cfelseif amm NEQ 'XX'>
        <cfoutput>
        Summary as csv: <a href="/smoke/accomp/accomp-#ayyyy#-#amm#.csv">accomp-#ayyyy#-#amm#.csv</a>
        </cfoutput>
        <cfelse>
        <cfoutput>
        Summary as csv: <a href="/smoke/accomp/accomp-#ayyyy#-#amm#-fiscal.csv">accomp-#ayyyy#-fiscal.csv</a>
        </cfoutput>
        </cfif>
    </div>
</div>

<br>
    <footer class="footer">
        <div class="container-fluid">

            <p>
            <h4 class="panel-title"><small><i class='glyphicon glyphicon-question-sign'></i> <strong>Need Help?</strong> Questions regarding <a href="/"><strong>Washington Smoke</strong></a> may be directed to <strong><cfoutput>#site_admin_name#</cfoutput></strong>, USDA Forest Service, <a class="link" href="mailto:<cfoutput>#site_admin_email#</cfoutput>"><strong><cfoutput>#site_admin_email#</cfoutput></strong></a>.</small>
            </h4>
            </p>

        </div>
    </footer>

</body>
</html>

<!---
<cfdump var=#variables# >
--->