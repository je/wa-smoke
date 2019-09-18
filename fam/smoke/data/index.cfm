<cfinclude template="/fam/smoke/use.cfm">

<cfif structkeyexists(form,"delete")>
    <cfif #form.delete# EQ 'Y'>
        <cfquery name="Pre_Burn_delete" datasource="Washington_Smoke_Production">
        update dbo.Pre_Burn set
        Date_Deleted = '#today#'
        where burn_unit_id_no = '#form.burn_unit_id_no#'
        </cfquery>

        <cfset utc = #DateConvert("local2Utc",today)# >
        <cfset pacific = #dateAdd("h",-8,utc)# >
        <cfset pacific = #datetimeformat(pacific,'yyyy-mm-dd HH:nn')# >

        <cfset msg_text = "Pre-Burn record for <cfoutput><a class='alert-link' href='/fam/smoke/data/?#form.burn_unit_id_no#'>#form.Burn_Project_Name#</a></cfoutput> deleted by <cfoutput><a class='alert-link' href='/fam/smoke/users/?#FAMDB_user.username#'>#FAMDB_user.firstname# #FAMDB_user.lastname# (#FAMDB_user.email#)</a> at #pacific# PST</cfoutput>.">
        <cfset msg_status = "success">

        <cfquery name="smoke_events_load" datasource="FAMDB">
        insert into smoke_events (
        grid,object,message,status,created,username
        )
        VALUES
        (
        'smoke_preburns',
        '#form.burn_unit_id_no#',
        '#msg_text#',
        '#msg_status#',
        '#pacific#',
        '#FAMDB_user.username#'
        )
        </cfquery>
    </cfif>
<cfelseif structkeyexists(form,"undelete")>
    <cfif #form.undelete# EQ 'Y'>
        <cfquery name="Pre_Burn_undelete" datasource="Washington_Smoke_Production">
        update dbo.Pre_Burn set
        Date_Deleted = NULL
        where burn_unit_id_no = '#form.burn_unit_id_no#'
        </cfquery>

        <cfset utc = #DateConvert("local2Utc",today)# >
        <cfset pacific = #dateAdd("h",-8,utc)# >
        <cfset pacific = #datetimeformat(pacific,'yyyy-mm-dd HH:nn')# >

        <cfset msg_text = "Pre-Burn record for <cfoutput><a class='alert-link' href='/fam/smoke/data/?#form.burn_unit_id_no#'>#form.Burn_Project_Name#</a></cfoutput> restored by <cfoutput><a class='alert-link' href='/fam/smoke/users/?#FAMDB_user.username#'>#FAMDB_user.firstname# #FAMDB_user.lastname# (#FAMDB_user.email#)</a> at #pacific# PST</cfoutput>.">
        <cfset msg_status = "success">

        <cfquery name="smoke_events_load" datasource="FAMDB">
        insert into smoke_events (
        grid,object,message,status,created,username
        )
        VALUES
        (
        'smoke_preburns',
        '#form.burn_unit_id_no#',
        '#msg_text#',
        '#msg_status#',
        '#pacific#',
        '#FAMDB_user.username#'
        )
        </cfquery>
    </cfif>
</cfif>

<cfif structkeyexists(session,'msg_text')>
    <cfif session.msg_text NEQ ''>
        <cfset msg_text = '#session.msg_text#'>
        <cfset msg_status = '#session.msg_status#'>
        <cfset session.msg_text = ''>
        <cfset session.msg_status = ''>
    </cfif>
</cfif>

<cfinclude template="/fam/lo.cfm">

<cfif isdefined('q')>
 <cfelse>
    <cfset q = ''>
</cfif>

<cfif isdefined('d_id')>
 <cfelse>
    <cfset d_id = ''>
</cfif>

<cfif isdefined('dateq')>
 <cfelse>
    <cfset dateq = ''>
    <cfset qyyyy = ''>
    <cfset qdd = ''>
    <cfset qmm = ''>
</cfif>

<cfset unitq = ''>

<cfset hd = ''>

<cfset defd = 'B_key'>
<cfset emptys = 'Added_By,Reason_to_Burn,Phone,Estimated_unit_acres,Fuel_loading,Issue_date'>
<cfset metas = 'Date_modified,Modified_By,Date_Deleted,Deleted_By'>
<cfset locs = 'Township_1,N_S,Range_1,E_W,Section_No,Latitude,Longitude,Elevation,Slope'>
<cfset ums = 'Contact,email,address_1,City,County,State,Zip'>
<cfset tons = 'Diameter_1,Diameter_2,Diameter_3,Diameter_4,Diameter_5,Diameter_6,Total_tons,Landing_Tons,Pile_tons,Total_permit_Qty_tons,Loading_Method,Pile_Calculation_Method,Pile_type'>
<cfset specs = 'Predominant_species,Cut_Date,Snow_Off_Date,Less_3_rotten,Litter_Depth,Duff_Depth,Shrub,Grass_Herb,Duff_Type'>

<cfset cols = 'Date_Added,Forest,District_Code,district,Burn_Unit_ID_No,Burn_Project_Name,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,Date_Deleted'>
<cfset heads = 'date added,forest,_,district,unit id,project,unit acres,type,reason,forest health exempt,ignition method,burn requests,deleted'>
<cfset refs = 'Date_Added,_,District_Code,District_Code,Burn_Unit_ID_No,Burn_Unit_ID_No,_,_,_,_,_,Burn_Unit_ID_No,_'>
<cfset rebs = 'smoke/date,smoke/forest,smoke/district,smoke/district,smoke/data,smoke/data,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,smoke/data,_'>

<cfset cv = "Date_Added,Added_By,Date_modified,Modified_By,Date_deleted,deleted_By,Forest,District_Code,district,Burn_Unit_ID_No,Burn_Project_Name,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,B_key,county,Township_1,N_S,Range_1,E_W,Section_No,longitude,latitude,Elevation,Slope,Predominant_species,Cut_Date,Snow_Off_Date,Less_3_rotten,Litter_Depth,Duff_Depth,Shrub,Grass_Herb,Duff_Type,Diameter_1,Diameter_2,Diameter_3,Diameter_4,Diameter_5,Diameter_6,Total_tons,Landing_Tons,Pile_tons,Total_permit_Qty_tons,Loading_Method,Pile_Calculation_Method,Pile_type">
<cfset vheads = "_,_,_,_,_,_,_,_,_,_,_,unit acres,type,reason,forest health exempt,ignition method,_,_,county,township,n/s,range,e/w,section,longitude,latitude,elevation,slope,Predominant_species,Cut_Date,Snow_Off_Date,Less_3_rotten,Litter_Depth,Duff_Depth,Shrub,Grass_Herb,Duff_Type,Diameter_1,Diameter_2,Diameter_3,Diameter_4,Diameter_5,Diameter_6,Total_tons,Landing_Tons,Pile_tons,Total_permit_Qty_tons,Loading_Method,Pile_Calculation_Method,Pile_type">
<cfset vrefs = "Date_Added,Added_By,Date_modified,Modified_By,Date_deleted,deleted_By,_,District_Code,district,Burn_Unit_ID_No,Burn_Project_Name,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,B_key,_,_,_,_,_,_,longitude,latitude,_,_,Predominant_species,Cut_Date,Snow_Off_Date,Less_3_rotten,Litter_Depth,Duff_Depth,Shrub,Grass_Herb,Duff_Type,Diameter_1,Diameter_2,Diameter_3,Diameter_4,Diameter_5,Diameter_6,Total_tons,Landing_Tons,Pile_tons,Total_permit_Qty_tons,Loading_Method,Pile_Calculation_Method,Pile_type">
<cfset vrebs = "Date_Added,Added_By,Date_modified,Modified_By,Date_deleted,deleted_By,Forest,District_Code,district,Burn_Unit_ID_No,Burn_Project_Name,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,B_key,county,Township_1,N_S,Range_1,E_W,Section_No,longitude,latitude,Elevation,Slope,Predominant_species,Cut_Date,Snow_Off_Date,Less_3_rotten,Litter_Depth,Duff_Depth,Shrub,Grass_Herb,Duff_Type,Diameter_1,Diameter_2,Diameter_3,Diameter_4,Diameter_5,Diameter_6,Total_tons,Landing_Tons,Pile_tons,Total_permit_Qty_tons,Loading_Method,Pile_Calculation_Method,Pile_type">

<cfset f ='
    [Issue_date] [smalldatetime] NULL,
    [Estimated_unit_acres] [float] NULL,
    [Total_permit_Qty_tons] [float] NULL,
    [Predominant_species] [nvarchar](255) NULL,
    [Elevation] [float] NULL,
    [Slope] [float] NULL,
    [Cut_DAte] [varchar](50) NULL,
    [Snow_Off_Date] [varchar](50) NULL,
    [Landing_Tons] [float] NULL,
    [Pile_tons] [float] NULL,
    [County] [nvarchar](255) NULL,
    [Township_1] [varchar](53) NULL,
    [N_S] [varchar](50) NULL,
    [Range_1] [float] NULL,
    [E_W] [nvarchar](255) NULL,
    [Section_No] [nvarchar](255) NULL,
    [Diameter_1] [float] NULL,
    [Diameter_2] [float] NULL,
    [Diameter_3] [float] NULL,
    [Diameter_4] [float] NULL,
    [Diameter_5] [float] NULL,
    [Diameter_6] [float] NULL,
    [Less_3_rotten] [float] NULL,
    [Litter_Depth] [float] NULL,
    [Duff_Depth] [float] NULL,
    [Shrub] [float] NULL,
    [Grass_Herb] [float] NULL,
    [Duff_Type] [nvarchar](255) NULL,
    [address_1] [varchar](50) NULL,
    [Burn_requests] [smallint] NULL,
    [City] [varchar](20) NULL,
    [Contact] [varchar](50) NULL,
    [Date_Deleted] [varchar](50) NULL,
    [Deleted_By] [varchar](30) NULL,
    [email] [varchar](60) NULL,
    [Fuel_loading] [int] NULL,
    [Loading_Method] [varchar](2) NULL,
    [Phone] [varchar](13) NULL,
    [Pile_Calculation_Method] [varchar](50) NULL,
    [Pile_type] [varchar](30) NULL,
    [Reason_to_Burn] [varchar](50) NULL,
    [State] [varchar](2) NULL,
    [Zip] [varchar](10) NULL,
    [Total_tons] [real] NULL
'>
<cfset adefd = 'R_Key,Plan_Key,Burn_Permit_Number,Burn_Project_Name,District_Code'>
<cfset aemptys = 'Added_By'>
<cfset ametas = ''>
<cfset ca = 'r.Date_Added,Burn_Req_No,Rank,Burn_Date,Planned_Ignition_Time,Planned_Ignition_Duration_Min,Burn_Ignition_Time,Burn_Duration_Hours,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,r.archived,Total_tons,Post_burn_updated,r.r_key,plan_key'>
<cfset aheads = 'Date Added,Req No,Rank,Burn Date,Planned Time,Planned Min,Ignition Time,Hours,Min,Comments,Acres,Tons,_,Multi Day,_,Total tons,Post Burn Updated,_,_'>
<cfset arefs = 'Date_Added,Burn_Req_No,_,Burn_Date,_,_,_,_,_,_,_,_,_,_,_,_,Post_burn_updated,r_key,plan_key'>
<cfset arebs = 'smoke/date,smoke/data,Rank,smoke/date,Planned_Ignition_Time,Planned_Ignition_Duration_Min,Burn_Ignition_Time,Burn_Duration_Hours,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,archived,Total_tons,smoke/date,r_key,plan_key'>

<cfset ca = 'r.Date_Added,Burn_Req_No,Rank,Burn_Date,Planned_Ignition_Time,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,r.Total_tons,Post_burn_updated,r.r_key,plan_key,u.Date_Added,u.Post_key,u.Post_Burn_Key,u.R_Key,u.Burn_Permit_Number,u.Date_Burned,u.Ignition_time,u.Ignition_Duration_in_Minutes,u.Actual_Acres_Burned,u.Added_by'>
<cfset aheads = 'request added,_,rank,planned ignition date,planned ignition time,duration,request comments,request acres,tons,_,multiday,_,_,_,_,_,_,_,_,_,actual ignition date,actual ignition time,actual duration,burned acres,_'>
<cfset arefs = 'Date_Added,Burn_Req_No,Rank,Burn_Date,Planned_Ignition_Time,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,Total_tons,Post_burn_updated,r_key,plan_key,Date_Added,Post_key,Post_Burn_Key,R_Key,Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Actual_Acres_Burned,Added_by'>
<cfset arebs = 'r.Date_Added,Burn_Req_No,Rank,Burn_Date,Planned_Ignition_Time,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,r.Total_tons,Post_burn_updated,r.r_key,plan_key,u.Date_Added,u.Post_key,u.Post_Burn_Key,u.R_Key,u.Burn_Permit_Number,u.Date_Burned,u.Ignition_time,u.Ignition_Duration_in_Minutes,u.Actual_Acres_Burned,u.Added_by'>

<cfset ra = 'r.Date_Added,Forest,p.District_Code,district,Burn_Unit_ID_No,p.Burn_Project_Name,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,Date_Deleted,Burn_Req_No,Rank,Burn_Date,Planned_Ignition_Time,Planned_Ignition_Duration_Min,Burn_Ignition_Time,Burn_Duration_Hours,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,archived,r.Total_tons,Post_burn_updated,r.r_key,plan_key'>
<cfset rheads = 'request added,forest,_,district,unit id,project,_,_,_,_,_,_,_,_,rank,ignition date,ignition time,_,_,_,duration,request comments,request acres,tons,_,multiday,_,_,_,_,_'>
<cfset rrefs = 'Date_Added,_,District_Code,District_Code,Burn_Unit_ID_No,Burn_Unit_ID_No,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,Date_Deleted,Burn_Req_No,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Post_burn_updated,r.r_key,plan_key'>
<cfset rrebs = 'smoke/date,Forest,p.smoke/district,smoke/district,smoke/data,smoke/data,Size_of_Unit_acres,Burn_type,Burn_Reason,Forest_health_exempt,Ignition_Method,Burn_requests,Date_Deleted,smoke/data,Rank,smoke/date,Planned_Ignition_Time,Planned_Ignition_Duration_Min,Burn_Ignition_Time,Burn_Duration_Hours,Burn_Duration_Min,Burn_Comments,Acreage_This_Burn,Tonnage_This_Burn,Post_Burn_report,Multi_Day_Burn,archived,r.Total_tons,smoke/date,r.r_key,plan_key'>

<cfset ua = 'u.Date_Added,Forest,p.District_Code,district,Burn_Unit_ID_No,p.Burn_Project_Name,Post_key,Post_Burn_Key,u.R_Key,u.Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Post_Burn_Comments,Reason_for_No_Burn_Code,Reason_for_No_Burn,Actual_Acres_Burned,Estimated_Consumed_Total_tonnage,Consumed_Landing_Tons,Duff_Fuel_Moisture,Duff_Moist_Pc,Duff_Moisture_Method,Fuel_moisture_ten_hours,Fuel_moisture_1000_Hour,Thousand_Hour_method,Days_Since_Rain,Wind_Speed,Weather_Collection_Method,On_site,Raws,Fire_Weather_Station_Name,NWS_Office,u.Added_by,Date_Deleted'>
<cfset uheads = 'postburn added,forest,_,district,unit id,project,_,_,_,_,ignition date,ignition time,duration,postburn comments,_,_,burned acres,total tons,_,duff moisture,_,duff moist method,10hr,1000hr,1000hr method,DSR,wind speed,weather method,onsite,RAWS,FWS name,NWS office,_,_'>
<cfset urefs = 'Date_Added,_,District_Code,District_Code,Burn_Unit_ID_No,Burn_Unit_ID_No,Post_key,Post_Burn_Key,R_Key,Burn_Permit_Number,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Added_by,Date_Deleted'>
<cfset urebs = 'smoke/date,Forest,smoke/district,smoke/district,smoke/data,smoke/data,Post_key,Post_Burn_Key,R_Key,u.Burn_Permit_Number,Date_Burned,Ignition_time,Ignition_Duration_in_Minutes,Post_Burn_Comments,Reason_for_No_Burn_Code,Reason_for_No_Burn,Actual_Acres_Burned,Estimated_Consumed_Total_tonnage,Consumed_Landing_Tons,Duff_Fuel_Moisture,Duff_Moist_Pc,Duff_Moisture_Method,Fuel_moisture_ten_hours,Fuel_moisture_1000_Hour,Thousand_Hour_method,Days_Since_Rain,Wind_Speed,Weather_Collection_Method,On_site,Raws,Fire_Weather_Station_Name,NWS_Office,u.Added_by,smoke/date'>

<cfif #cgi.query_string# NEQ '' and #d_id# EQ '' and #q# EQ '' and #dateq# EQ ''>
    <cfset qyyyy = ''>
    <cfset qmm = ''>
    <cfset qdd = ''>
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
    </cfif>
</cfif>

<cfif #cgi.query_string# NEQ '' and #dateq# EQ '' and #unitq# EQ '' and #d_id# EQ '' and #q# EQ ''>
    <cfquery name="vada" datasource="Washington_Smoke_Production">
    SELECT DISTINCT #cv#
    FROM Pre_Burn p
    WHERE p.Burn_Unit_ID_No = '#cgi.query_string#'
    </cfquery>

    <cfquery name="rada" datasource="Washington_Smoke_Production">
    SELECT #ra#
    FROM Burn_Request r, Pre_Burn p
    WHERE p.Burn_Unit_ID_No = '#cgi.query_string#'
    AND p.b_key = r.plan_key
    AND r.Burn_Permit_Number = p.Burn_Unit_ID_No
    ORDER BY r.date_added DESC
    </cfquery>

    <cfquery name="uada" datasource="Washington_Smoke_Production">
    SELECT #ua#
    FROM Post_Burn u, Burn_Request r, Pre_Burn p
    WHERE p.Burn_Unit_ID_No = '#cgi.query_string#'
    AND u.R_Key = r.R_Key
    AND p.b_key = r.plan_key
    AND r.Burn_Permit_Number = p.Burn_Unit_ID_No
    ORDER BY u.date_added DESC

    <cfset rheads = 'request added,_,_,_,_,_,_,_,_,_,_,_,_,_,rank,ignition date,ignition time,_,_,_,duration,request comments,request acres,tons,_,multiday,_,_,_,_,_'>
    <cfset uheads = 'postburn added,_,_,_,_,_,_,_,_,_,ignition date,ignition time,duration,postburn comments,_,_,acres burned,total tons,_,duff moisture,_,duff moist method,10hr,1000hr,1000hr method,DSR,wind speed,weather method,onsite,RAWS,FWS name,NWS office,_,_'>

    </cfquery>

<cfelseif #d_id# NEQ ''>
    <cfset heads = 'date added,_,_,_,unit id,project,unit acres,type,reason,forest health exempt,ignition method,burn requests,deleted'>

    <cfquery name="tada" datasource="Washington_Smoke_Production">
    SELECT DISTINCT #cols#
    FROM Pre_Burn p
    WHERE District_Code = '#d_id#'
    ORDER BY date_deleted, Burn_Project_Name ASC
    </cfquery>

<cfelseif #q# NEQ ''>
    <cfquery name="tada" datasource="Washington_Smoke_Production">
    SELECT DISTINCT #cols#
    FROM Pre_Burn p
    WHERE Burn_Project_Name like '%#q#%'
    ORDER BY Burn_Project_Name ASC
    </cfquery>

<cfelse>
    <cfif #qdd# NEQ ''>
        <cfset heads = '_,forest,_,district,unit id,project,unit acres,type,reason,forest health exempt,ignition method,burn requests,deleted'>
        <cfset rheads = '_,forest,_,district,unit id,project,_,_,_,_,_,_,_,_,rank,ignition date,ignition time,_,_,_,duration,request comments,request acres,tons,_,multiday,_,_,_,_,_'>
        <cfset uheads = '_,forest,_,district,unit id,project,_,_,_,_,ignition date,ignition time,duration,postburn comments,_,_,burned acres,total tons,_,duff moisture,_,duff moist method,10hr,1000hr,1000hr method,DSR,wind speed,weather method,onsite,RAWS,FWS name,NWS office,_,_'>
    </cfif>

    <cfset lastyear = '#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss tt")#'>
    <cfquery name="tada" datasource="Washington_Smoke_Production">
    SELECT #cols#
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
        WHERE year(date_Added) = 2017
    </cfif>
    ORDER BY date_added DESC,district ASC,Burn_Project_Name
    </cfquery>

    <cfquery name="rada" datasource="Washington_Smoke_Production">
    SELECT #ra#
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
        WHERE year(r.date_Added) = 2017
    </cfif>
    AND p.b_key = r.plan_key
    AND r.Burn_Permit_Number = p.Burn_Unit_ID_No
    ORDER BY r.date_added DESC
    </cfquery>

    <cfquery name="uada" datasource="Washington_Smoke_Production">
    SELECT #ua#
    FROM Post_Burn u, Burn_Request r, Pre_Burn p
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
    WHERE year(u.date_Added) = 2017
    </cfif>
    AND u.R_Key = r.R_Key
    AND p.b_key = r.plan_key
    AND r.Burn_Permit_Number = p.Burn_Unit_ID_No
    ORDER BY u.date_added DESC
    </cfquery>
</cfif>

<div style="padding-right:20px;">

<cfif isDefined('vada')>

    <cfset vols = getMetadata(vada)>
    <cfset volList = "">
    <cfloop from="1" to="#arrayLen(vols)#" index="x"> <cfset volList = listAppend(volList, vols[x].name)> </cfloop>

    <div class="panel panel-default" style="max-width:none;">
        <div class="panel-heading">
            <h3 class="panel-title">
            <strong><span style='color:SlateGray'>Pre-Burn</span></strong> <cfoutput><strong>#vada.burn_unit_id_no# #vada.Burn_Project_Name#</strong> at <strong><span style='color:SlateGray'>District</span></strong> <a href='/fam/smoke/district/?#vada.district_code#'><strong>#vada.forest#</strong> &sect <strong>#vada.district#</strong></a></cfoutput>
            <span class="pull-right">
            <div class="input-group input-group-sm">
                <a class="btn btn-default btn-xs" href="/fam/smoke/data/edit/?<cfoutput>#vada.burn_unit_id_no#</cfoutput>" disabled><i class='glyphicon glyphicon-pencil' style='font-size:80%'></i> you can't edit this pre-burn</a>
            </div>
            </span>
            </h3>
        </div>
        <div class="panel-body small">

            <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                <cfoutput query="vada">
                    <table class='table table-condensed table-bordered'>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>unit acres</strong></td>
                        <td style='padding-left:10px;'>#Size_of_Unit_acres#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>pile tons</strong></td>
                        <td style='padding-left:10px;'>#Pile_tons#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>pile type</strong></td>
                        <td style='padding-left:10px;'>#Pile_type#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>pile calculation method</strong></td>
                        <td style='padding-left:10px;'>#Pile_Calculation_Method#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>landing tons</strong></td>
                        <td style='padding-left:10px;'>#Landing_Tons#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>dia <0.25" tons/ac</strong></td>
                        <td style='padding-left:10px;'>#Diameter_1#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>dia 0.25"-1" tons/ac</strong></td>
                        <td style='padding-left:10px;'>#Diameter_2#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>dia 1"-3" tons/ac</strong></td>
                        <td style='padding-left:10px;'>#Diameter_3#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>dia 3"-9" tons/ac</strong></td>
                        <td style='padding-left:10px;'>#Diameter_4#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>dia 9"-20" tons/ac</strong></td>
                        <td style='padding-left:10px;'>#Diameter_5#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>dia 20"< tons/ac</strong></td>
                        <td style='padding-left:10px;'>#Diameter_6#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>total broadcast tons/ac</strong></td>
                        <td style='padding-left:10px;'>#Total_tons#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>broadcast loading method</strong></td>
                        <td style='padding-left:10px;'>#Loading_Method#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>total permit tons</strong></td>
                        <td style='padding-left:10px;'>#Total_permit_Qty_tons#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>cut date</strong></td>
                        <td style='padding-left:10px;'>#Cut_Date#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>snow off date</strong></td>
                        <td style='padding-left:10px;'>#Snow_Off_Date#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong><3 rotten tons/ac</strong></td>
                        <td style='padding-left:10px;'>#Less_3_rotten#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>shrub tons/ac</strong></td>
                        <td style='padding-left:10px;'>#Shrub#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>grass herb tons/ac</strong></td>
                        <td style='padding-left:10px;'>#Grass_Herb#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>litter depth in</strong></td>
                        <td style='padding-left:10px;'>#Litter_Depth#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>duff depth in</strong></td>
                        <td style='padding-left:10px;'>#Duff_Depth#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>duff type</strong></td>
                        <td style='padding-left:10px;'>#Duff_Type#</td>
                    </tr>
                    </table>
                </cfoutput>
            </div>

            <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                <cfoutput query="vada">
                    <table class='table table-condensed table-bordered'>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>burn type</strong></td>
                        <td style='padding-left:10px;'>#Burn_type#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>ignition method</strong></td>
                        <td style='padding-left:10px;'>#Ignition_Method#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>burn reason</strong></td>
                        <td style='padding-left:10px;'>#Burn_Reason#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>forest health exempt?</strong></td>
                        <td style='padding-left:10px;'>#Forest_health_exempt#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>predominant species</strong></td>
                        <td style='padding-left:10px;'>#Predominant_species#</td>
                    </tr>
                    </table>
                </cfoutput>
            </div>

            <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                <cfoutput query="vada">
                    <table class='table table-condensed table-bordered'>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>county</strong></td>
                        <td style='padding-left:10px;'>#county#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>PLSS</strong></td>
                        <td style='padding-left:10px;'>#Township_1##N_S# #Range_1##E_W# #Section_No#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>coordinates</strong></td>
                        <td style='padding-left:10px;'>#longitude# #latitude#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>elevation</strong></td>
                        <td style='padding-left:10px;'>#Elevation#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>slope</strong></td>
                        <td style='padding-left:10px;'>#Slope#</td>
                    </tr>
                    </table>
                </cfoutput>
            </div>

<cfset locs =  ',,,,,,,,,,,,,,,,Diameter_1,Diameter_2,Diameter_3,Diameter_4,Diameter_5,Diameter_6,,,,,,,'>

<cfset locs = 'Township_1,N_S,Range_1,E_W,Section_No,Latitude,Longitude,Elevation,Slope'>
<cfset ums = 'Contact,email,address_1,City,County,State,Zip'>
<cfset tons = 'Diameter_1,Diameter_2,Diameter_3,Diameter_4,Diameter_5,Diameter_6,Total_tons,Landing_Tons,Pile_tons,Total_permit_Qty_tons,Loading_Method,Pile_Calculation_Method,Pile_type'>

            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/leaflet.css">

            <style>
                #map {
                    width: 100%;
                    height: 380px;
                }
                .info {
                    padding: 6px 8px;
                    font: 14px/16px Arial, Helvetica, sans-serif;
                    background: white;
                    background: rgba(255,255,255,0.8);
                    box-shadow: 0 0 15px rgba(0,0,0,0.2);
                    border-radius: 5px;
                }
                .info h4 {
                    margin: 0 0 5px;
                    color: #777;
                }
                .legend {
                    text-align: left;
                    line-height: 18px;
                    color: #555;
                }
                .legend i {
                    width: 18px;
                    height: 18px;
                    float: left;
                    margin-right: 8px;
                    opacity: 0.7;
                }
                .obsicon {
                background:OrangeRed;
                text-align:center;
                vertical-align:middle;
                border-radius:10px;
                }
            </style>

            <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
                <div id="map"></div>
            </div>

<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/leaflet.js"></script>
<script src="/fam/smoke/leaflet-providers.js"></script>
<script src="//maps.google.com/maps/api/js?v=3.2&sensor=false"></script>
<script src="/fam/smoke/google.js"></script>


            <script type="text/javascript" src="/fam/smoke/us-states.js"></script>
            <script type="text/javascript">

                //var map = L.map('map').setView([37.8, -96], 4);

                var mbAttr = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' + '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                        'Imagery <a href="http://mapbox.com">Mapbox</a>', mbUrl = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpandmbXliNDBjZWd2M2x6bDk3c2ZtOTkifQ._QA7i5Mpkd_m30IGElHziw';

                var grayscale   = L.tileLayer(mbUrl, {id: 'mapbox.light', attribution: mbAttr});

                var gmap_terrain = new L.Google('TERRAIN');
                var gmap_hybrid = new L.Google('HYBRID');

                var map = L.map('map', {
                    layers: [gmap_terrain]
                }).setView([47.7511, -120.7401], 4);;

                var baseLayers = {
                    "Terrain Basemap": gmap_terrain,
                    "Satellite Basemap": gmap_hybrid,
                    "Grayscale Basemap": grayscale
                };

                L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6IjZjNmRjNzk3ZmE2MTcwOTEwMGY0MzU3YjUzOWFmNWZhIn0.Y8bhBaUMqFiPrDRW9hieoQ', {
                    maxZoom: 18,
                    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
                        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                        'Imagery © <a href="http://mapbox.com">Mapbox</a>',
                    id: 'mapbox.light'
                });


                // control that shows state info on hover
                var info = L.control();

                info.onAdd = function (map) {
                    this._div = L.DomUtil.create('div', 'info');
                    this.update();
                    return this._div;
                };

                info.update = function (props) {
                    this._div.innerHTML = '<h4>US Population Density</h4>' +  (props ?
                        '<b>' + props.name + '</b><br />' + props.density + ' people / mi<sup>2</sup>'
                        : 'Hover over a state');
                };

                //info.addTo(map);


                // get color depending on population density value
                function getColor(d) {
                    return d > 1000 ? '#800026' :
                           d > 500  ? '#BD0026' :
                           d > 200  ? '#E31A1C' :
                           d > 100  ? '#FC4E2A' :
                           d > 50   ? '#FD8D3C' :
                           d > 20   ? '#FEB24C' :
                           d > 10   ? '#FED976' :
                                      '#FFEDA0';
                }

                function style(feature) {
                    return {
                        weight: 2,
                        opacity: 1,
                        color: 'white',
                        dashArray: '3',
                        fillOpacity: 0.7,
                        fillColor: getColor(feature.properties.density)
                    };
                }

                function highlightFeature(e) {
                    var layer = e.target;

                    layer.setStyle({
                        weight: 5,
                        color: '#666',
                        dashArray: '',
                        fillOpacity: 0.7
                    });

                    if (!L.Browser.ie && !L.Browser.opera) {
                        layer.bringToFront();
                    }

                    info.update(layer.feature.properties);
                }

                var geojson;

                function resetHighlight(e) {
                    geojson.resetStyle(e.target);
                    info.update();
                }

                function zoomToFeature(e) {
                    map.fitBounds(e.target.getBounds());
                }

                function onEachFeature(feature, layer) {
                    layer.on({
                        mouseover: highlightFeature,
                        mouseout: resetHighlight,
                        click: zoomToFeature
                    });
                }

                //geojson = L.geoJson(statesData, {
                //    style: style,
                //    onEachFeature: onEachFeature
                //});

                //map.attributionControl.addAttribution('Population data &copy; <a href="http://census.gov/">US Census Bureau</a>');


                var legend = L.control({position: 'bottomright'});

                legend.onAdd = function (map) {

                    var div = L.DomUtil.create('div', 'info legend'),
                        grades = [0, 10, 20, 50, 100, 200, 500, 1000],
                        labels = [],
                        from, to;

                    for (var i = 0; i < grades.length; i++) {
                        from = grades[i];
                        to = grades[i + 1];

                        labels.push(
                            '<i style="background:' + getColor(from + 1) + '"></i> ' +
                            from + (to ? '&ndash;' + to : '+'));
                    }

                    div.innerHTML = labels.join('<br>');
                    return div;
                };

                //legend.addTo(map);

                var obsIcon = L.divIcon({
                    className: 'obsicon',
                    iconSize: [10, 10]
                })

                var unit = {
                  "type": "Feature",
                  "geometry": {
                    "type": "Polygon",
                    "coordinates": [
                            [<cfset step=#vada.recordcount#><cfloop query='vada'><cfoutput><cfset step = step-1>[#longitude#, #latitude#]<cfif step GT 0>,<cfelse>,[#longitude#, #latitude#]</cfif></cfoutput></cfloop>]
                        ]
                  },
                  "properties": {
                    "name": "Linestring",
                    "style": {
                        color: "#019fde",
                        weight: 1,
                        opacity: 1,
                        fillColor: "#019fde",
                        fillOpacity: 0.4
                    }
                  }
                };

                var wa = {"type":"Feature","id":"53","properties":{"name":"Washington","density":102.6},                    "style": {
                        color: "#019fde",
                        weight: 1,
                        opacity: 1,
                        fillColor: "",
                        fillOpacity: 0.4
                    },
"geometry":{"type":"MultiPolygon","coordinates":[[[[-117.033359,49.000239],[-117.044313,47.762451],[-117.038836,46.426077],[-117.055267,46.343923],[-116.92382,46.168661],[-116.918344,45.993399],[-118.988627,45.998876],[-119.125551,45.933153],[-119.525367,45.911245],[-119.963522,45.823614],[-120.209985,45.725029],[-120.505739,45.697644],[-120.637186,45.746937],[-121.18488,45.604536],[-121.217742,45.670259],[-121.535404,45.725029],[-121.809251,45.708598],[-122.247407,45.549767],[-122.762239,45.659305],[-122.811531,45.960537],[-122.904639,46.08103],[-123.11824,46.185092],[-123.211348,46.174138],[-123.370179,46.146753],[-123.545441,46.261769],[-123.72618,46.300108],[-123.874058,46.239861],[-124.065751,46.327492],[-124.027412,46.464416],[-123.895966,46.535616],[-124.098612,46.74374],[-124.235536,47.285957],[-124.31769,47.357157],[-124.427229,47.740543],[-124.624399,47.88842],[-124.706553,48.184175],[-124.597014,48.381345],[-124.394367,48.288237],[-123.983597,48.162267],[-123.704273,48.167744],[-123.424949,48.118452],[-123.162056,48.167744],[-123.036086,48.080113],[-122.800578,48.08559],[-122.636269,47.866512],[-122.515777,47.882943],[-122.493869,47.587189],[-122.422669,47.318818],[-122.324084,47.346203],[-122.422669,47.576235],[-122.395284,47.800789],[-122.230976,48.030821],[-122.362422,48.123929],[-122.373376,48.288237],[-122.471961,48.468976],[-122.422669,48.600422],[-122.488392,48.753777],[-122.647223,48.775685],[-122.795101,48.8907],[-122.756762,49.000239],[-117.033359,49.000239]]],[[[-122.718423,48.310145],[-122.586977,48.35396],[-122.608885,48.151313],[-122.767716,48.227991],[-122.718423,48.310145]]],[[[-123.025132,48.583992],[-122.915593,48.715438],[-122.767716,48.556607],[-122.811531,48.419683],[-123.041563,48.458022],[-123.025132,48.583992]]]]}};

               mp = new L.GeoJSON(wa, {
                style: function(feature) {
                    return feature.properties.style
                }
              });

                var obslist = new L.LayerGroup();
                <cfloop query='vada'><cfoutput>
                var o#Burn_Unit_ID_No# = {
                  "type": "Feature",
                  "geometry": {
                    "type": "Point",
                    "coordinates": [
                            #longitude#, #latitude#
                        ]
                  },
                </cfoutput>
                  "properties": {
                    "name": "Point",
                    "style": {
                        color: "#019fde",
                        weight: 1,
                        opacity: 1,
                        fillColor: "#019fde",
                        fillOpacity: 0.4
                    }
                  }
                };

               <cfoutput>
               o#Burn_Unit_ID_No# = new L.GeoJSON(o#Burn_Unit_ID_No#, {
                style: function(feature) {
                    return feature.properties.style
                }
              });
              //o#Burn_Unit_ID_No#.addTo(map);
              </cfoutput></cfloop>

                <cfloop query='vada'>
                <cfoutput>
                var op#Burn_Unit_ID_No# = L.marker([ #latitude# , #longitude# ], {icon: obsIcon,});
                op#Burn_Unit_ID_No#.addTo(map);
                </cfoutput>
                </cfloop>
                map.whenReady(function () {
                    window.setTimeout(function () {
                        map.fitBounds(mp.getBounds());
                    }.bind(map), 200);
                }, this);
            </script>

        </div>
        <div class="panel-footer">
            <small>
            <cfoutput><cfif #vada.date_added# NEQ ''>Added on <a href="/fam/smoke/date/?#dateformat(vada.date_added, 'yyyy-mm-dd')#">#dateformat(vada.date_added, 'yyyy-mm-dd')#</a><cfif #vada.added_by# NEQ ''> by <a href="/fam/smoke/users/?#vada.added_by#">#vada.added_by#</a></cfif>.</cfif> <cfif #vada.Date_modified# NEQ ''>Updated on <a href='/fam/smoke/date/?#dateformat(vada.Date_modified, 'yyyy-mm-dd')#'>#dateformat(vada.Date_modified, 'yyyy-mm-dd')#</a><cfif #vada.modified_by# NEQ ''> by <a href="/fam/smoke/users/?#vada.modified_by#">#vada.modified_by#</a></cfif>.</cfif> <cfif #vada.Date_Deleted# NEQ ''>Deleted on <a href='/fam/smoke/date/?#dateformat(vada.Date_Deleted, 'yyyy-mm-dd')#'>#dateformat(vada.Date_Deleted, 'yyyy-mm-dd')#</a><cfif #vada.deleted_by# NEQ ''> by <a href="/fam/smoke/users/?#vada.deleted_by#">#vada.deleted_by#</a></cfif>.</cfif></cfoutput>
            </small>        

            <span class="form-inline pull-right">
            <span style=''>
            <cfif #vada.Date_Deleted# EQ ''>
                <form name="preburn_delete" class="form-horizontal" method="POST" enctype="multipart/form-data" action="/fam/smoke/data/?<cfoutput>#vada.burn_unit_id_no#</cfoutput>">
                <input type="hidden" class="form-control" name="burn_unit_id_no" size="" maxlength="" placeholder="" value="<cfoutput>#vada.burn_unit_id_no#</cfoutput>" >
                <input type="hidden" class="form-control" name="Burn_Project_Name" size="" maxlength="" placeholder="" value="<cfoutput>#vada.Burn_Project_Name#</cfoutput>" >
                <input type="hidden" class="form-control" name="delete" size="" maxlength="" placeholder="" value="Y" >
                <button name="Submit" class="btn btn-danger btn-xs" type="submit" id="Submit" value="Delete" onclick="return confirm('Are you sure you want to delete this pre-burn?');"><i class='glyphicon glyphicon-trash' style='font-size:80%'></i> delete pre-burn
                </button>
                </form>
            <cfelseif #vada.Date_Deleted# NEQ ''>
                <form name="preburn_undelete" class="form-horizontal" method="POST" enctype="multipart/form-data" action="/fam/smoke/data/?<cfoutput>#vada.burn_unit_id_no#</cfoutput>">
                <input type="hidden" class="form-control" name="burn_unit_id_no" size="" maxlength="" placeholder="" value="<cfoutput>#vada.burn_unit_id_no#</cfoutput>" >
                <input type="hidden" class="form-control" name="Burn_Project_Name" size="" maxlength="" placeholder="" value="<cfoutput>#vada.Burn_Project_Name#</cfoutput>" >
                <input type="hidden" class="form-control" name="undelete" size="" maxlength="" placeholder="" value="Y" >
                <button name="Submit" class="btn btn-success btn-xs" type="submit" id="Submit" value="Restore" onclick="return confirm('Are you sure you want to restore this pre-burn?');"><i class='glyphicon glyphicon-trash' style='font-size:80%'></i> restore pre-burn
                </button>
                </form>
            </cfif>
            </span>
            </span>

        </div>
    </div>

</cfif>

<cfif isDefined('tada')>
    <cfset cols = getMetadata(tada)>
    <cfset colList = "">
    <cfloop from="1" to="#arrayLen(cols)#" index="x"> <cfset colList = listAppend(colList, cols[x].name)> </cfloop>

    <div class="panel panel-default" style="max-width:none;">
    <div class="panel-heading">
    <h3 class="panel-title">
    <cfoutput>#tada.recordcount#<strong> <span style='color:SlateGray'>Pre-Burns</span></strong><cfif #d_id# NEQ ''> at <strong><span style='color:SlateGray'>District</span> #tada.forest#</strong> &sect <strong>#tada.district#</strong></cfif><cfif #qyyyy# NEQ ''> on <strong>#qyyyy#<cfif #qmm# NEQ ''>-#qmm#</cfif><cfif #qdd# NEQ ''>-#qdd#</cfif></strong></cfif></cfoutput>
    <cfif isdefined('d_id')>
    <cfif #d_id# NEQ ''>
        <span class="pull-right">
        <div class="input-group input-group-sm">
            <a class="btn btn-default btn-xs" href="/fam/smoke/district/preburn/?<cfoutput>#d_id#</cfoutput>"><i class='glyphicon glyphicon-plus' style='font-size:80%'></i> add pre-burn at this district</a>
        </div>
        </span>
    </cfif>
    </cfif>
    </h3>
    </div>

    <table class="table table-bordered table-condensed">
    <thead>
    <cfoutput>
    <cfif len(heads)>
    <cfloop list="#heads#" index='head'>
    <cfif head NEQ '_'>
    <th><small>#head#</small></th>
    </cfif>
    </cfloop>
    <cfelse>
    <cfloop list="#collist#" index='head'>
    <th><small>#head#</small></th>
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
    <cfif hd NEQ '_'>
        <cfset rf = #listgetat(refs,n)#>
        <td <cfif isNumeric(tada[col][currentRow])>align='right'</cfif>>
        <small>
        <cfif rf NEQ '_'>
            <cfset rfx = rf>
            <cfset rbx = #listgetat(rebs,n)#>
            <cfif isDate(tada[col][currentRow])>
                <a <cfif #Date_deleted# NEQ "">class='text-warning'<cfelse>class='text-success'</cfif> href='/fam/#rbx#/?#dateformat(tada[rfx][currentRow], 'yyyy-mm-dd')#'>
                <cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#
                 <cfelse>#tada[col][currentRow]#
                </cfif>
                </a>
             <cfelse>
                <strong><a <cfif #Date_deleted# NEQ "">class='text-warning'<cfelse>class='text-success'</cfif> href='/fam/#rbx#/?#tada[rfx][currentRow]#'>
                <cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#
                 <cfelse>#tada[col][currentRow]#
                </cfif>
                </a></strong>
            </cfif>
         <cfelse>
            <cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#
             <cfelse>#tada[col][currentRow]#
            </cfif>
        </cfif>
        </small>
        </td>
    </cfif>
    <cfelse>
    <td><cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#<cfelse>#tada[col][currentRow]#</cfif></td>
    </cfif>
    <cfset n = n + 1>
    </cfloop>
    </tr>
    </cfoutput>
    </tbody>
    </table>
    </div>

</cfif>

<cfif isDefined('rada')>
    <cfset ca = getMetadata(rada)>
    <cfset colList = "">
    <cfloop from="1" to="#arrayLen(ca)#" index="x"> <cfset colList = listAppend(colList, ca[x].name)> </cfloop>

    <div class="panel panel-default" style="max-width:none;">
    <div class="panel-heading">
    <h3 class="panel-title">
    <cfoutput>#rada.recordcount#<strong> <span style='color:SlateGray'>Burn Requests</span></strong><cfif isDefined('vada')> for <strong>#vada.burn_unit_id_no# #vada.Burn_Project_Name#</strong> at <strong><span style='color:SlateGray'>District</span></strong> <a href='/fam/smoke/district/?#vada.district_code#'><strong>#vada.forest#</strong> &sect <strong>#vada.district#</strong></a></cfif><cfif #qyyyy# NEQ ''> on <strong>#qyyyy#<cfif #qmm# NEQ ''>-#qmm#</cfif><cfif #qdd# NEQ ''>-#qdd#</cfif></strong></cfif></cfoutput>
      <cfif isdefined('vada')>
        <span class="pull-right">
        <div class="input-group input-group-sm">
            <a class="btn btn-default btn-xs" href="/fam/smoke/data/request/?<cfoutput>#vada.burn_unit_id_no#</cfoutput>"><i class='glyphicon glyphicon-plus' style='font-size:80%'></i> add request to this pre-burn</a>
        </div>
        </span>
    </cfif>
  </h3>
    </div>



    <table class="table table-bordered table-condensed">
    <thead>
    <cfoutput>
    <cfif len(rheads)>
    <cfloop list="#rheads#" index='head'>
    <cfif head NEQ '_'>
    <th><small>#head#</small></th>
    </cfif>
    </cfloop>
    <cfelse>
    <cfloop list="#collist#" index='head'>
    <th><small>#head#</small></th>
    </cfloop>
    </cfif>
    </cfoutput>
    <th><small>postburn added</small></th>
    </thead>

    <tbody>
    <cfoutput query="rada">
    <tr>
    <cfset n = 1>
    <cfloop index="ca" list="#collist#">
    <cfif len(rheads)>
        <cfset hd = #listgetat(rheads,n)#>
        <cfif hd NEQ '_'>
        <cfset rf = #listgetat(rrefs,n)#>

        <td <cfif isNumeric(rada[ca][currentRow])>align='right'</cfif>>
        <small>
        <cfif rf NEQ '_'>
            <cfset rfx = rf>
            <cfset rbx = #listgetat(rrebs,n)#>
            <cfif isDate(rada[ca][currentRow])>
                <a <cfif #Date_deleted# NEQ "">class='text-warning'<cfelse>class='text-success'</cfif> href='/fam/#rbx#/?#dateformat(rada[rfx][currentRow], 'yyyy-mm-dd')#'>
                <cfif isDate(rada[ca][currentRow])>#dateformat(rada[ca][currentRow], 'yyyy-mm-dd')#
                 <cfelse>#rada[ca][currentRow]#
                </cfif>
                </a>
             <cfelse>
                <strong><a <cfif #Date_deleted# NEQ "">class='text-warning'<cfelse>class='text-success'</cfif> href='/fam/#rbx#/?#rada[rfx][currentRow]#'>
                <cfif isDate(rada[ca][currentRow])>#dateformat(rada[ca][currentRow], 'yyyy-mm-dd')#
                 <cfelse>#rada[ca][currentRow]#
                </cfif>
                </a></strong>
            </cfif>
         <cfelse>
            <cfif isDate(rada[ca][currentRow])>#dateformat(rada[ca][currentRow], 'yyyy-mm-dd')#
             <cfelse>#rada[ca][currentRow]#
            </cfif>
        </cfif>
        </small>
        </td>


        </cfif>
      <cfelse>

    </cfif>
    <cfset n = n + 1>
    </cfloop>

        <td>
        <small>
        <cfif #Post_burn_updated# EQ ''>
            <div class="input-group input-group-sm">
                <a class="btn btn-default btn-xs" href="/fam/smoke/data/result/?#Burn_Unit_ID_No#&#Burn_Req_No#" ><i class='glyphicon glyphicon-plus' style='font-size:80%'></i> add post-burn</a>
            </div>            
        <cfelse>
              <a <cfif #Date_deleted# NEQ "">class='text-warning'<cfelse>class='text-success'</cfif> href='/fam/#rbx#/?#dateformat(Post_burn_updated, 'yyyy-mm-dd')#'>#dateformat(Post_burn_updated, 'yyyy-mm-dd')#</a>
        </cfif>
        </small>
        </td>
    </tr>
    </cfoutput>
    </tbody>
    </table>


    </div>
</cfif>

<cfif isDefined('uada')>
    <cfset ca = getMetadata(uada)>
    <cfset colList = "">
    <cfloop from="1" to="#arrayLen(ca)#" index="x"> <cfset colList = listAppend(colList, ca[x].name)> </cfloop>

    <div class="panel panel-default" style="max-width:none;">
    <div class="panel-heading">
    <h3 class="panel-title">
    <cfoutput>#uada.recordcount#<strong> <span style='color:SlateGray'>Post-Burn Results</span></strong><cfif isDefined('vada')> for <strong>#vada.burn_unit_id_no# #vada.Burn_Project_Name#</strong> at <strong><span style='color:SlateGray'>District</span></strong> <a href='/fam/smoke/district/?#vada.district_code#'><strong>#vada.forest#</strong> &sect <strong>#vada.district#</strong></a></cfif><cfif #qyyyy# NEQ ''> on <strong>#qyyyy#<cfif #qmm# NEQ ''>-#qmm#</cfif><cfif #qdd# NEQ ''>-#qdd#</cfif></strong></cfif></cfoutput>
    </h3>
    </div>

    <table class="table table-bordered table-condensed">
    <thead>
    <cfoutput>
    <cfif len(uheads)>
    <cfloop list="#uheads#" index='head'>
    <cfif head NEQ '_'>
    <th><small>#head#</small></th>
    </cfif>
    </cfloop>
    <cfelse>
    <cfloop list="#collist#" index='head'>
    <th><small>#head#</small></th>
    </cfloop>
    </cfif>
    </cfoutput>
    </thead>

    <tbody>
    <cfoutput query="uada">
    <tr>
    <cfset n = 1>
    <cfloop index="ca" list="#collist#">
    <cfif len(uheads)>
    <cfset hd = #listgetat(uheads,n)#>
    <cfif hd NEQ '_'>
    <cfset rf = #listgetat(urefs,n)#>

        <td <cfif isNumeric(uada[ca][currentRow])>align='right'</cfif>>
        <small>
         <cfif hd EQ 'postburn comments'>
                #uada.Post_Burn_Comments#
                <cfif #uada.Reason_for_No_Burn_Code# NEQ ''>
                #uada.Reason_for_No_Burn_Code# <cfif #uada.Reason_for_No_Burn# NEQ ''>: #Reason_for_No_Burn#</cfif></cfif>
        <cfelseif rf NEQ '_'>
            <cfset rfx = rf>
            <cfset rbx = #listgetat(urebs,n)#>
            <cfif isDate(uada[ca][currentRow])>
                <a <cfif #Date_deleted# NEQ "">class='text-warning'<cfelse>class='text-success'</cfif> href='/fam/#rbx#/?#dateformat(uada[rfx][currentRow], 'yyyy-mm-dd')#'>
                <cfif isDate(uada[ca][currentRow])>#dateformat(uada[ca][currentRow], 'yyyy-mm-dd')#
                 <cfelse>#uada[ca][currentRow]#
                </cfif>
                </a>
             <cfelse>
                <strong><a <cfif #Date_deleted# NEQ "">class='text-warning'<cfelse>class='text-success'</cfif> href='/fam/#rbx#/?#uada[rfx][currentRow]#'>
                <cfif isDate(uada[ca][currentRow])>#dateformat(uada[ca][currentRow], 'yyyy-mm-dd')#
                 <cfelse>#uada[ca][currentRow]#
                </cfif>
                </a></strong>
            </cfif>
         <cfelse>
            <cfif isDate(uada[ca][currentRow])>#dateformat(uada[ca][currentRow], 'yyyy-mm-dd')#
             <cfelse>#uada[ca][currentRow]#
            </cfif>
        </cfif>
        </small>
        </td>

        </cfif>
      <cfelse>

    </cfif>
    <cfset n = n + 1>
    </cfloop>

    </tr>
    </cfoutput>
    </tbody>
    </table>
    </div>
</cfif>

</div>

<cfinclude template="/fam/gutter.cfm">

</body>
</html>
