<cfinclude template="/fam/smoke/use.cfm">

<cfif structkeyexists(session,'msg_text')>
    <cfif session.msg_text NEQ ''>
        <cfset msg_text = '#session.msg_text#'>
        <cfset msg_status = '#session.msg_status#'>
        <cfset session.msg_text = ''>
        <cfset session.msg_status = ''>
    </cfif>
</cfif>

<cfinclude template="/fam/lo.cfm">

<cfif #cgi.query_string# NEQ '' AND #cgi.query_string# CONTAINS '&'>
        <cfset a = cgi.query_string.Split("&")>
        <cfset bpno = #a[1]#>
        <cfset brno = #a[2]#>
<cfelse>
    <cfset bpno = ''>
    <cfset brno = ''>
    <cflocation url="/fam/smoke/district/" addtoken='no'>
</cfif>

<cfset utc = #DateConvert("local2Utc",today)# >
<cfset pacific = #dateAdd("h",-8,utc)# >

<cfif #bpno# NEQ '' and #brno# NEQ '' and structkeyexists(form,"lock")>

<cfoutput>
<cfquery name='result_add' datasource="Washington_Smoke_Production" result="result">
INSERT into dbo.Post_Burn
(
R_Key,
District_Code,
Burn_Project_Name,
Burn_Permit_Number,
Date_Burned,
Ignition_time,
Ignition_Duration_in_Minutes,
Actual_Acres_Burned,
Estimated_Consumed_Total_tonnage,
Consumed_Landing_Tons,
Fuel_moisture_ten_hours,
Fuel_moisture_1000_Hour,
Thousand_Hour_method,
Duff_Fuel_Moisture,
Duff_Moisture_Method,
Weather_Collection_Method,
Raws,
On_site,
Fire_Weather_Station_Name,
NWS_Office,
Days_Since_Rain,
Wind_Speed,
Reason_for_No_Burn,
Reason_for_No_Burn_Code,
BLACK_SHRUB_PC,
BLACK_CANOPY_PC,
BLACK_PILE_PC,
Post_Burn_Comments,
Added_by,
date_added
)
VALUES
(
<cfqueryparam value = "#form.r_key#" cfsqltype="CF_SQL_CHAR" maxlength="20" null="no" >,
<cfqueryparam value = "#form.d_id#" cfsqltype="CF_SQL_CHAR" maxlength="9" null="no" >,
<cfqueryparam value = "#form.project_name#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#bpno#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.ignition_date#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.ignition_time#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.duration#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.acres#" cfsqltype="CF_SQL_INTEGER" maxlength="80" null="no" >,
<cfqueryparam value = "#form.tons#" cfsqltype="CF_SQL_INTEGER" maxlength="80" null="no" >,
<cfqueryparam value = "#form.landing_tons#" cfsqltype="CF_SQL_INTEGER" maxlength="80" null="no" >,
<cfqueryparam value = "#form.m10hr#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.m1000hr#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfif structkeyexists(form,'m1000hrmeth')><cfqueryparam value = "#form.m1000hrmeth#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" ><cfelse>NULL</cfif>,
<cfqueryparam value = "#form.duffmoist#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfif structkeyexists(form,'duffmeth')><cfqueryparam value = "#form.duffmeth#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" ><cfelse>NULL</cfif>,
<cfif structkeyexists(form,'collmeth')><cfqueryparam value = "#form.collmeth#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" ><cfelse>NULL</cfif>,
<cfif structkeyexists(form,'raws')><cfqueryparam value = "#form.raws#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" ><cfelse>NULL</cfif>,
<cfif structkeyexists(form,'onsite')><cfqueryparam value = "#form.onsite#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" ><cfelse>NULL</cfif>,
<cfqueryparam value = "#form.fwsname#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.nwsname#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.dsr#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.windspeed#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.noncomment#" cfsqltype="CF_SQL_CHAR" maxlength="250" null="no" >,
<cfif structkeyexists(form,'noncode')><cfqueryparam value = "#form.noncode#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" ><cfelse>NULL</cfif>,
<cfqueryparam value = "#form.BLACK_SHRUB_PC#" cfsqltype="cf_sql_smallint" maxlength="3" null="yes" >,
<cfqueryparam value = "#form.BLACK_CANOPY_PC#" cfsqltype="cf_sql_smallint" maxlength="3" null="yes" >,
<cfqueryparam value = "#form.BLACK_PILE_PC#" cfsqltype="cf_sql_smallint" maxlength="3" null="yes" >,
<cfqueryparam value = "#form.comments#" cfsqltype="CF_SQL_CHAR" maxlength="8000" null="yes" >,
<cfqueryparam value = "#session.user_webcaaf#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
#pacific#
)
</cfquery>
</cfoutput>

<cfset pacific = #datetimeformat(pacific,'yyyy-mm-dd HH:nn')# >

<CFquery NAME="UPD8" DATASOURCE='Washington_Smoke_Production'>       
    Update dbo.Burn_request set 
    Post_Burn_report = 'Y',
    Post_burn_updated = '#pacific#'
    where R_key = #form.R_key#
</cfquery>

<cfset session.msg_text = "Post-burn for <cfoutput><a class='alert-link' href='/fam/smoke/data/?#bpno#'>#form.project_name#</a></cfoutput> added by <cfoutput><a class='alert-link' href='/fam/smoke/users/?#session.username#'>#session.user_firstname# #session.user_lastname# (#session.user_email#)</a> at #pacific# PST</cfoutput>.">
<cfset session.msg_status = "success">

    <cfquery name="smoke_events_load" datasource="FAMDB">
    insert into smoke_events (
    grid,object,message,status,created,username
    )
    VALUES
    (
    'smoke_results',
    '#brno#',
    '#session.msg_text#',
    '#session.msg_status#',
    '#pacific#',
    '#session.username#'
    )
    </cfquery>

<cflocation url='/fam/smoke/data/?#bpno#' addtoken='no' >

<cfelseif #bpno# NEQ ''>

<cfquery name='bp' datasource="Washington_Smoke_Production">
select * from pre_burn where Burn_Unit_ID_No = '#bpno#';
</cfquery>

<cfquery name='br' datasource="Washington_Smoke_Production">
select * from Burn_Request where Burn_Req_No = '#brno#';
</cfquery>

<cfif #br.post_burn_report# EQ 'Y'>

POSTBURN already filed.

<cfelse>

<div style="padding-right:20px;">

<form id="result_form" name="result_form" action="/fam/smoke/data/result/?<cfoutput>#bpno#&#brno#</cfoutput>" method="post" enctype="multipart/form-data">

<cfif isDefined('bp') and isDefined('br')>

    <cfoutput>
    <input type="hidden" class="form-control" name="lock" size="" maxlength="1" value="Y" >
    <input type="hidden" class="form-control" name="contact" size="" maxlength="80" value="#session.user_firstname# #session.user_lastname#" >
    <input type="hidden" class="form-control" name="email" size="" maxlength="80" value="#session.user_email#" >
    <input type="hidden" class="form-control" name="d_id" size="" maxlength="80" value="#bp.district_code#" >
    <input type="hidden" class="form-control" name="bpno" size="" maxlength="80" value="#bpno#" >
    <input type="hidden" class="form-control" name="brno" size="" maxlength="80" value="#brno#" >
    <input type="hidden" class="form-control" name="r_key" size="" maxlength="80" value="#br.r_key#" >
    <input type="hidden" class="form-control" name="project_name" size="" maxlength="80" value="#bp.burn_project_name#" >
    <input type="hidden" class="form-control" name="b_key" size="" maxlength="80" value="#bp.b_key#" >
    </cfoutput>

    <cfset vols = getMetadata(bp)>
    <cfset volList = "">
    <cfloop from="1" to="#arrayLen(vols)#" index="x"> <cfset volList = listAppend(volList, vols[x].name)> </cfloop>

    <div class="panel panel-info" style="max-width:none;">
        <div class="panel-heading">
            <h3 class="panel-title">
            <strong>NEW <span style='color:SlateGray'>Post-Burn</span></strong> for <cfoutput><strong>#bp.burn_unit_id_no# #bp.Burn_Project_Name#</strong> at <strong><span style='color:SlateGray'>District</span></strong> <strong>#bp.forest#</strong> &sect <strong>#bp.district#</strong></cfoutput>
            <span class="pull-right">
            <div class="input-group input-group-sm">
                <button class="btn btn-primary btn-xs" type="submit" name="save_req"><i class='glyphicon glyphicon-ok' style='font-size:80%'></i> save</button>
                <a class="btn btn-default btn-xs" href="/fam/smoke/data/?<cfoutput>#bpno#</cfoutput>"><i class='glyphicon glyphicon-remove' style='font-size:80%'></i> cancel</a>
            </div>
            </span>
            </h3>
        </div>

        <div class="panel-body small">
            <cfset locs =  ',,,,,,,,,,,,,,,,Diameter_1,Diameter_2,Diameter_3,Diameter_4,Diameter_5,Diameter_6,,,,,,,'>
            <cfset locs = 'Township_1,N_S,Range_1,E_W,Section_No,Latitude,Longitude,Elevation,Slope'>
            <cfset ums = 'Contact,email,address_1,City,County,State,Zip'>
            <cfset tons = 'Diameter_1,Diameter_2,Diameter_3,Diameter_4,Diameter_5,Diameter_6,Total_tons,Landing_Tons,Pile_tons,Total_permit_Qty_tons,Loading_Method,Pile_Calculation_Method,Pile_type'>

            <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                <cfoutput query="bp">
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

                <cfoutput query="bp">
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

                <cfoutput query="bp">
                    <table class='table table-condensed table-bordered'>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>county</strong></td>
                        <td style='padding-left:10px;'>#county#</td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'><strong>PLSS</strong></td>
                        <td style='padding-left:10px;'>#Township_1# #N_S# #Range_1# #E_W# #Section_No#</td>
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

        <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8" style='padding-left:0px;padding-right:0px;'>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <cfoutput query="br">
                <table class='table table-condensed table-bordered'>
                    <thead>
                        <th style='background:Gainsboro;' colspan=2>Request</th>
                    </thead>
                    <tbody>
                   <tr>
                        <td style='max-width:90px;text-align:right;'><strong>ignition date</strong></td>
                        <td style='padding-left:10px;'>#dateformat(Burn_Date, 'yyyy-mm-dd')#</td>
                    </tr>
                   <tr>
                        <td style='max-width:90px;text-align:right;'><strong>ignition time</strong></td>
                        <td style='padding-left:10px;'>#Planned_Ignition_Time#</td>
                    </tr>
                   <tr>
                        <td style='max-width:90px;text-align:right;'><strong>duration</strong></td>
                        <td style='padding-left:10px;'>#Planned_Ignition_Duration_Min#</td>
                    </tr>
                   <tr>
                        <td style='max-width:90px;text-align:right;'><strong>multi-day?</strong></td>
                        <td style='padding-left:10px;'>#Multi_Day_Burn#</td>
                    </tr>
                   <tr>
                        <td style='max-width:90px;text-align:right;'><strong>acres</strong></td>
                        <td style='padding-left:10px;'>#Acreage_This_Burn#</td>
                    </tr>
                   <tr>
                        <td style='max-width:90px;text-align:right;'><strong>tons</strong></td>
                        <td style='padding-left:10px;'>#Tonnage_This_Burn#</td>
                    </tr>
                   <tr>
                        <td style='max-width:90px;text-align:right;'><strong>rank</strong></td>
                        <td style='padding-left:10px;'>#rank#</td>
                    </tr>
                   <tr>
                        <td style='max-width:90px;text-align:right;'><strong>comments</strong></td>
                        <td style='padding-left:10px;'>#Burn_Comments#</td>
                    </tr>
                    </tbody>
                </table>
                </cfoutput>
            </div>

            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <table class='table table-condensed table-bordered bg-info'>
                    <thead>
                        <th style='background:Gainsboro;' colspan=2>Post-Burn</th>
                    </thead>
                    <tbody>
                    <cfoutput>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">ignition date</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="ignition_date" value="" name="ignition_date" placeholder="#dateformat(br.burn_date, 'yyyy-mm-dd')#">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">ignition time</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="ignition_time" value="" name="ignition_time" maxlength="4" placeholder="#br.Planned_Ignition_Time#">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">duration</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="duration" value="" name="duration" maxlength="9" placeholder="#br.Planned_Ignition_Duration_Min#">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">acres</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="acres" value="" name="acres" maxlength="6" placeholder="#br.Acreage_This_Burn#">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">tons</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="tons" value="" name="tons" maxlength="4" placeholder="#br.Tonnage_This_Burn#">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">landing tons</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="landing_tons" value="" name="landing_tons" maxlength="6" placeholder="">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">comments</label>
                        </td>
                        <td>
                         <textarea type="text" class="form-control input-sm" id="comments" value="" name="comments" placeholder="" rows="2"></textarea>
                        </td>
                    </tr>

                    </tbody>
                </table>
                </cfoutput>
            </div>

        </div>

        <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8" style='padding-left:0px;padding-right:0px;'>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <cfoutput>
                <table class='table table-condensed table-bordered bg-info'>
                    <thead>
                        <th style='background:Gainsboro;' colspan=2>Weather</th>
                    </thead>
                    <tbody>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">collection method</label>
                        </td>
                        <td>
                            <select name="collmeth" class="form-control input-sm" >
                                <option value disabled selected></option>
                                <cfloop list="Local,On-Site Measured,Station Observation," index="a">
                                <cfoutput>
                                    <option value="#a#">#a#</option>
                                </cfoutput>
                                </cfloop>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <CFquery NAME="lurs" DATASOURCE='Washington_Smoke_Production'>
                            SELECT Stations
                            FROM LU_RAWS_Station
                        </cfquery>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">RAWS</label>
                        </td>
                        <td>
                            <select name="raws" class="form-control input-sm" >
                                <cfoutput>
                                <option value disabled selected></option>
                                <cfloop query="lurs">
                                    <option value="#stations#">#stations#</option>
                                </cfloop>
                                </cfoutput>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">fire weather station</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="fwsname" value="" name="fwsname" maxlength="80" placeholder="">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">NWS office station</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="nwsname" value="" name="nwsname" maxlength="80" placeholder="">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">on-site unit</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="onsite" value="" name="onsite" maxlength="80" placeholder="">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">days since rain</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="dsr" value="" name="dsr" maxlength="3" placeholder="">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">windspeed</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="windspeed" value="" name="windspeed" maxlength="3" placeholder="">
                        </td>
                    </tr>
                    </tbody>
                </table>
                </cfoutput>
            </div>

            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <cfoutput>
                <table class='table table-condensed table-bordered bg-info'>
                    <thead>
                        <th style='background:Gainsboro;' colspan=2>Moisture</th>
                    </thead>
                    <tbody>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">10hr moisture</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="m10hr" value="" name="m10hr" maxlength="3" placeholder="">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">1000hr moisture</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="m1000hr" value="" name="m1000hr" maxlength="3" placeholder="">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">1000hr moisture method</label>
                        </td>
                        <td>
                            <select name="m1000hrmeth" id="m1000hrmeth" class="form-control input-sm" >
                                <option value disabled selected></option>
                                <cfloop list="ADJ-TH,NFDR-TH,Measured," index="a">
                                <cfoutput>
                                    <option value="#a#">#a#</option>
                                </cfoutput>
                                </cfloop>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">duff moisture</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="duffmoist" value="" name="duffmoist" maxlength="3" placeholder="">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">duff moisture method</label>
                        </td>
                        <td>
                            <select name="duffmeth" class="form-control input-sm" >
                                <option value disabled selected></option>
                                <cfloop list="NFDRS,Adjusted,Measured," index="a">
                                <cfoutput>
                                    <option value="#a#">#a#</option>
                                </cfoutput>
                                </cfloop>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">BLACK_SHRUB_PC</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="BLACK_SHRUB_PC" value="" name="BLACK_SHRUB_PC" maxlength="3" placeholder="">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">BLACK_CANOPY_PC</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="BLACK_CANOPY_PC" value="" name="BLACK_CANOPY_PC" maxlength="3" placeholder="">
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">BLACK_PILE_PC</label>
                        </td>
                        <td>
                         <input type="text" class="form-control input-sm" id="BLACK_PILE_PC" value="" name="BLACK_PILE_PC" maxlength="3" placeholder="">
                        </td>
                    </tr>

                    </cfoutput>
                    </tbody>
                </table>

                <cfoutput>
                <table class='table table-condensed table-bordered bg-info'>
                    <tbody>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">accomp&lt;plan code</label>
                        </td>
                        <td>
                            <select id="noncode" name="noncode" class="form-control input-sm" >
                                <option value disabled selected></option>
                                <cfoutput>
                                    <option>Smoke Management Plan limitations</option>
                                    <option>Meteorology not in burn prescription</option>
                                    <option>Lack of available resources</option>
                                    <option>Resources reassigned to other priorities</option>
                                    <option>Shortened Rx burn season</option>
                                    <option>Other</option>
                                </cfoutput>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style='max-width:90px;text-align:right;'>
                            <label class="control-label">accomp&lt;plan comment</label>
                        </td>
                        <td>
                         <textarea type="text" class="form-control input-sm" id="noncomment" value="" name="noncomment" placeholder="Reason for accomplished acres less than planned acres" rows="2"></textarea>
                        </td>
                    </tr>
                    </tbody>
                </table>
                </cfoutput>


            </div>
        </div>

<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

        </div>
        <div class="panel-footer">
            <small>
            Enter your post-burn result data above and hit 'save' to save your edits. 
            <cfoutput>
            <cfif #br.Date_Added# NEQ ''>Request added on <a href="/fam/smoke/date/?#dateformat(br.date_added, 'yyyy-mm-dd')#">#dateformat(br.date_added, 'yyyy-mm-dd')#</a><cfif #br.added_by# NEQ ''> by <a href="/fam/smoke/users/?#br.added_by#">#br.added_by#</a></cfif>.</cfif>
            <cfif #bp.date_added# NEQ ''>Pre-burn added on <a href="/fam/smoke/date/?#dateformat(bp.date_added, 'yyyy-mm-dd')#">#dateformat(bp.date_added, 'yyyy-mm-dd')#</a><cfif #bp.added_by# NEQ ''> by <a href="/fam/smoke/users/?#bp.added_by#">#bp.added_by#</a></cfif>.</cfif> <cfif #bp.Date_modified# NEQ ''>Pre-burn updated on <a href='/fam/smoke/date/?#dateformat(bp.Date_modified, 'yyyy-mm-dd')#'>#dateformat(bp.Date_modified, 'yyyy-mm-dd')#</a><cfif #bp.modified_by# NEQ ''> by <a href="/fam/smoke/users/?#bp.modified_by#">#bp.modified_by#</a></cfif>.</cfif> <cfif #bp.Date_Deleted# NEQ ''>Pre-burn deleted on <a href='/fam/smoke/date/?#dateformat(bp.Date_Deleted, 'yyyy-mm-dd')#'>#dateformat(bp.Date_Deleted, 'yyyy-mm-dd')#</a><cfif #bp.deleted_by# NEQ ''> by <a href="/fam/smoke/users/?#bp.deleted_by#">#bp.deleted_by#</a></cfif>.</cfif></cfoutput>
            </small>        
        </div>
    </div>

</cfif>

</form>

</div>
</cfif>

<cfelseif isDefined('bp')>

<cflocation url="/fam/smoke/data/?#bpno#" addtoken='no'>

NO Burn_Req_No GOTO PLAN

<cfelse>

<cflocation url="/fam/smoke/district/" addtoken='no'>

NO Burn_Unit_ID_No GOTO 'DISTRICTS'

</cfif>

<cfinclude template="/fam/gutter.cfm">

    <script src="/fam/jquery-validation-1.14.0/dist/jquery.validate.js"></script>
    <script src="/fam/jquery-validation-1.14.0/dist/additional-methods.min.js"></script>
    <script src="/fam/jquery-validation-1.14.0/lib/jquery.maskedinput.js"></script>
    <script>

    $().ready(function() {
        // validate the comment form when it is submitted
        //$("#commentForm").validate();
        //$("#zip").mask("99999?-9999");

        $("#result_form").validate({
            errorClass: "has-error",
            highlight: function(element) {
                $(element).parent().parent().addClass("has-error").removeClass("has-success");
            },
            unhighlight: function(element) {
                $(element).parent().parent().addClass("has-success").removeClass("has-error");
            },
            rules: {
                ignition_date: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    date: true
                },
                ignition_time: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    number: true,
                    max: 2400
                },
                duration: {
                    required: true,
                    number: true,
                    max: 999999
                },
                acres: {
                    required: true,
                    number: true,
                    max: <cfoutput>#bp.Size_of_Unit_acres#</cfoutput>
                },
                tons: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    number: true,
                    max: <cfoutput>#bp.Total_permit_Qty_tons#</cfoutput>
                },
                landing_tons: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    number: true,
                    max: <cfoutput>#bp.landing_tons#</cfoutput>
                },
                noncode: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() <= "#br.Acreage_This_Burn#<"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    }
                },
                m10hr: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    digits: true,
                    min: 1,
                    max: 999
                },
                m1000hr: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    digits: true,
                    min: 1,
                    max: 999
                },
                m1000hrmeth: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    }
                },
                duffmoist: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    number: true,
                    max: 100
                },
                BLACK_SHRUB_PC: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    number: true,
                    max: 100
                },
                BLACK_PILE_PC: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    number: true,
                    max: 100
                },
                BLACK_CANOPY_PC: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    number: true,
                    max: 100
                },
                collmeth: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    }
                },
                dsr: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    digits: true,
                    min: 0,
                    max: 365
                },
                windspeed: {
                    required: {
                        depends: function () {
                            if ($("[name=acres]").val() >= "1" && $("[name=duration]").val() >= "1"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    digits: true,
                    min: 0,
                    max: 999
                },
                noncomment: {
                    required: false
                },
                comments: {
                    required: false
                },
                agree: "required"
            },
            messages: {
                ignition_date: "Enter a date.",
                ignition_time: "Enter a time.",
                duration: "Enter a duration in minutes or 0 for no burn.",
                acres: "Enter a number less than the unit acres.",
                tons: "Enter a number less than the unit tons.",
                landing_tons: "Enter a number less than unit landing tons.",
                noncode: "Select one.",
                m10hr: "Enter a number.",
                m1000hr: "Enter a number.",
                m1000hrmeth: "Select one.",
                duffmoist: "Enter a number.",
                BLACK_CANOPY_PC: "Enter a number.",
                BLACK_PILE_PC: "Enter a number.",
                BLACK_SHRUB_PC: "Enter a number.",
                collmeth: "Select one.",
                duffmeth: "Select one.",
                dsr: "Enter a number.",
                windspeed: "Enter a number.",
                comments: "Enter some kind of comment less than 8000 characters.",
                agree: "Please accept our policy."
            }
        });
    });
    </script>
</body>
</html>
