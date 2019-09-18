<cfinclude template="/fam/smoke/use.cfm">

<cfif #session.admin# EQ 1>
<cfif #cgi.query_string# EQ '10002511'>
    <cfquery name='preburn_add' datasource="Washington_Smoke_Production" result="result">
        update dbo.pre_burn
        set Longitude ='-117.903483'
        where Burn_Unit_ID_No = '10002511'
    </cfquery>
    OK!
    <cfabort>
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

<cfif #cgi.query_string# NEQ ''>
    <cfset d_id = #cgi.query_string#>
 <cfelse>
    <cfset d_id = ''>
</cfif>

<cfset utc = #DateConvert("local2Utc",today)# >
<cfset pacific = #dateAdd("h",-8,utc)# >
<cfset pacific = #datetimeformat(pacific,'yyyy-mm-dd HH:nn')# >

<cfif #d_id# NEQ '' and structkeyexists(form,"lock")>

<cfif structkeyexists(form,"pile_type")>
<cfelse>
    <cfset form.pile_type = ''>
</cfif>
<cfif structkeyexists(form,"pile_calculation_method")>
<cfelse>
    <cfset form.pile_calculation_method = ''>
</cfif>
<cfif structkeyexists(form,"broadcast_loading_method")>
<cfelse>
    <cfset form.broadcast_loading_method = ''>
</cfif>
<cfif #isnumeric(form.pile_tons)#>
<cfelse>
    <cfset form.pile_tons = '0'>
</cfif>
<cfif #isnumeric(form.broadcast_tons)#>
<cfelse>
    <cfset form.broadcast_tons = '0'>
</cfif>
<cfif #isnumeric(form.Landing_Tons)#>
<cfelse>
    <cfset form.Landing_Tons = '0'>
</cfif>
<cfset form.Total_permit_Qty_tons =  ((#form.broadcast_tons# * #form.UNIT_ACRES#) + #form.Pile_tons# + #form.Landing_Tons#)>
<cfset form.Total_permit_Qty_tons =  #Fix(form.Total_permit_Qty_tons)#>

<CFquery NAME="GTBPN" DATASOURCE='Washington_Smoke_Production'>
Select * from dbo.Burn_Permit_Numbers
</cfquery>
<cfset bpno = #GTBPN.Permit_No#>

<cfoutput>
<cfquery name='preburn_add' datasource="Washington_Smoke_Production" result="result">
INSERT into dbo.pre_burn
(
District_Code,
Loading_Method,
Total_tons,
Burn_Reason,
Burn_type,
County,
Cut_Date,
Diameter_1,
Diameter_2,
Diameter_3,
Diameter_4,
Diameter_5,
Diameter_6,
Duff_Depth,
Duff_Type,
Elevation,
E_W,
Forest_health_exempt,
Grass_Herb,
Ignition_Method,
Landing_Tons,
Latitude,
Less_3_rotten,
Litter_Depth,
Longitude,
N_S,
Total_permit_Qty_tons,
Pile_Calculation_Method,
Pile_tons,
Pile_type,
predominant_species,
Range_1,
Section_No,
Shrub,
Slope,
Snow_Off_Date,
Township_1,
Size_of_Unit_acres,
Date_Added,
Added_by,
email,
Contact,
Phone,
Forest,
district,
address_1,
City,
State,
Zip,
Burn_Project_Name,
Burn_Unit_ID_No,
Burn_requests
)
VALUES
(
<cfqueryparam value = "#d_id#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.broadcast_loading_method#" cfsqltype="CF_SQL_CHAR" maxlength="200" null="no" >,
<cfqueryparam value = "#form.BROADCAST_TONS#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.BURN_REASON#" cfsqltype="CF_SQL_CHAR" maxlength="200" null="no" >,
<cfqueryparam value = "#form.BURN_TYPE#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.COUNTY#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.CUTDATE#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.DIA_1#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.DIA_2#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.DIA_3#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.DIA_4#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.DIA_5#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.DIA_6#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.DUFF_DEPTH#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.DUFF_TYPE#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.ELEVATION#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.EW#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.FH_EXEMPT#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.GRASS_HERB#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.IGNITION_METHOD#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.LANDING_TONS#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.LAT#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.LESS_3#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.LITTER_DEPTH#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.LON#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.NS#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.Total_permit_Qty_tons#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.PILE_CALCULATION_METHOD#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.PILE_TONS#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.PILE_TYPE#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.PREDOMINANT_SPECIES#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.RANGE#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.SECT#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.SHRUB#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.SLOPE#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.SNOWOFF#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.TOWN#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.UNIT_ACRES#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
'#pacific#',
<cfqueryparam value = "#session.user_webcaaf#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#session.user_email#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.contact#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.phone#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.forest#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.district#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.address#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.city#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.state#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.zip#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.Burn_Project_Name#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
#bpno#,
0
)
</cfquery>
</cfoutput>

<cfoutput>
<CFquery NAME="PTBPN" DATASOURCE='Washington_Smoke_Production'>
Update dbo.Burn_Permit_Numbers Set Permit_No = #bpno# + 1
</cfquery>
</cfoutput>

<cfset epk = result.generatedkey>

<cfset session.msg_text = "Pre-Burn <cfoutput><a class='alert-link' href='/fam/smoke/data/?#bpno#'>#form.Burn_Project_Name#</a></cfoutput> added by <cfoutput><a class='alert-link' href='/fam/smoke/users/?#session.username#'>#session.user_firstname# #session.user_lastname# (#session.user_email#)</a> at #pacific# PST</cfoutput>.">
<cfset session.msg_status = "success">

    <cfquery name="smoke_events_load" datasource="FAMDB">
    insert into smoke_events (
    grid,object,message,status,created,username
    )
    VALUES
    (
    'smoke_preburns',
    '#epk#',
    '#session.msg_text#',
    '#session.msg_status#',
    '#pacific#',
    '#session.username#'
    )
    </cfquery>

<cflocation url='/fam/smoke/data/?#bpno#' addtoken='no' >

<cfelseif #d_id# NEQ ''>

<cfquery name='d' datasource="Washington_Smoke_Production">
select * from forest_access where login_id = '#d_id#';
</cfquery>

<div style="padding-right:20px;">

<form id="preburn_form" name="preburn_form" action="/fam/smoke/district/preburn/?<cfoutput>#d_id#</cfoutput>" method="post" enctype="multipart/form-data">

    <cfoutput>
    <input type="hidden" class="form-control" name="lock" size="" maxlength="1" value="Y" >
    <input type="hidden" class="form-control" name="contact" size="" maxlength="80" value="#session.user_firstname# #session.user_lastname#" >
    <input type="hidden" class="form-control" name="email" size="" maxlength="80" value="#session.user_email#" >
    <input type="hidden" class="form-control" name="phone" size="" maxlength="20" value="#d.Phone_area_code# #d.Phone_prefix# #d.Phone_number#" >
    <input type="hidden" class="form-control" name="forest" size="" maxlength="80" value="#d.The_Forest_Name#" >
    <input type="hidden" class="form-control" name="district" size="" maxlength="80" value="#d.District_Name#" >
    <input type="hidden" class="form-control" name="address" size="" maxlength="200" value="#d.address#" >
    <input type="hidden" class="form-control" name="city" size="" maxlength="80" value="#d.city#" >
    <input type="hidden" class="form-control" name="state" size="" maxlength="20" value="#d.state#" >
    <input type="hidden" class="form-control" name="zip" size="" maxlength="20" value="#d.zip#" >
    </cfoutput>

<div class="panel panel-info" style="max-width:none;">
    <div class="panel-heading">
        <h3 class="panel-title">
        <strong>NEW <span style='color:SlateGray'>Pre-Burn</span></strong>
        <span><input class="form-control-inline" style="max-width:300px;" id="Burn_Project_Name" name="Burn_Project_Name" size="80" maxlength="80" placeholder=" name this project" value="" required="yes" message="Please enter project name." type="text"></span>

<cfoutput> at <strong><span style='color:SlateGray'>District</span></strong> <a href='/fam/smoke/district/?#d.Login_ID#'><strong>#d.The_Forest_Name#</strong> &sect <strong>#d.district_name#</strong></a></cfoutput>
        <span class="pull-right">
        <div class="input-group input-group-sm">
            <button class="btn btn-primary btn-xs" type="submit" name="save_pre"><i class='glyphicon glyphicon-ok' style='font-size:80%'></i> save</button>
            <a class="btn btn-default btn-xs" href="/fam/smoke/district/?<cfoutput>#d.Login_ID#</cfoutput>"><i class='glyphicon glyphicon-remove' style='font-size:80%'></i> cancel</a>
        </div>
        </span>
        </h3>
    </div>
    <div class="panel-body small">
        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                <table class='table table-condensed table-bordered bg-info'>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">unit acres</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="unit_acres" value="" name="unit_acres" maxlength="6" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">pile tons</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="pile_tons" value="" name="pile_tons" maxlength="5" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">pile type</label>
                    </td>
                    <td>
                        <select id="pile_type" name="pile_type" class="form-control input-sm" >
                            <option value disabled selected></option>
                            <cfloop list="Hand Piles,Tractor/Dozer/Machine Piles,Grapple/Crane/Shovel Piles," index="a">
                            <cfoutput>
                                <option value="#a#">#a#</option>
                            </cfoutput>
                            </cfloop>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">pile calculation method</label>
                    </td>
                    <td>
                        <select id="pile_calculation_method" name="pile_calculation_method" class="form-control input-sm" >
                            <option value disabled selected></option>
                            <cfloop list="Ocular,Aerial Photograph Interpretation,Statistical Sample of Piles," index="a">
                            <cfoutput>
                                <option value="#a#">#a#</option>
                            </cfoutput>
                            </cfloop>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">landing tons</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="landing_tons" value="" name="landing_tons" maxlength="5" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">dia <0.25" tons/ac</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="dia_1" value="" name="dia_1" maxlength="6" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">dia 0.25"-1" tons/ac</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="dia_2" value="" name="dia_2" maxlength="6" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">dia 1"-3" tons/ac</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="dia_3" value="" name="dia_3" maxlength="6" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">dia 3"-9" tons/ac</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="dia_4" value="" name="dia_4" maxlength="6" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">dia 9"-20" tons/ac</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="dia_5" value="" name="dia_5" maxlength="6" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">dia 20"< tons/ac</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="dia_6" value="" name="dia_6" maxlength="6" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">total broadcast tons/ac</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="broadcast_tons" value="" name="broadcast_tons" maxlength="5" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">broadcast loading method</label>
                    </td>
                    <td>
                        <select id="broadcast_loading_method" name="broadcast_loading_method" class="form-control input-sm" >
                            <option value disabled selected></option>
                            <cfoutput>
                                <option value="P1">PNWE51 (DNR Westside Photo Series)</option>
                                <option value="P2">PNW51 (DNR Eastside Photo Series)</option>
                                <option value="T">Transect</option>
                                <option value="M">Other Method (Incl. Other Photo Series)</option>
                            </cfoutput>
                        </select>
                    </td>
                </tr>
                </table>
        </div>

        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                <table class='table table-condensed table-bordered bg-info'>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">cut date</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="cutdate" value="" name="cutdate" placeholder="1783-12-25">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">snow off date</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="snowoff" value="" name="snowoff" placeholder="1783-12-25">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label"><3 rotten tons/ac</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="less_3" value="" name="less_3" maxlength="2" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">shrub tons/ac</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="shrub" value="" name="shrub" maxlength="2" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">grass herb tons/ac</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="grass_herb" value="" name="grass_herb" maxlength="2" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">litter depth in</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="litter_depth" value="" name="litter_depth" maxlength="2" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">duff depth in</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="duff_depth" value="" name="duff_depth" maxlength="5" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">duff type</label>
                    </td>
                    <td>
                        <select name="duff_type" class="form-control input-sm" >
                            <option value disabled selected></option>
                            <cfloop list="Black,Red,Moss/Lichen," index="a">
                            <cfoutput>
                                <option value="#a#">#a#</option>
                            </cfoutput>
                            </cfloop>
                        </select>
                    </td>
                </tr>
                </table>
        </div>

        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                <table class='table table-condensed table-bordered bg-info'>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">burn type</label>
                    </td>
                    <td>
                        <select name="burn_type" class="form-control input-sm" >
                            <option value disabled selected></option>
                            <cfloop list="Broadcast,Natural,Pile," index="a">
                            <cfoutput>
                                <option value="#a#">#a#</option>
                            </cfoutput>
                            </cfloop>
                        </select>
                    </td>
                </tr>
                <tr>
                    <cfquery name="gim" DATASOURCE='Washington_Smoke_Production'>
                        SELECT   Descr
                        FROM     LU_Ignition_Methods
                    </cfquery>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">ignition method</label>
                    </td>
                    <td>
                        <select name="ignition_method" class="form-control input-sm" >
                            <cfoutput>
                            <option value disabled selected></option>
                            <cfloop query="gim">
                                <option value="#Descr#">#Descr#</option>
                            </cfloop>
                            </cfoutput>
                        </select>
                    </td>
                </tr>
                <tr>
                    <cfquery name="gbr" DATASOURCE='Washington_Smoke_Production'>
                        SELECT   Code,Descr
                        FROM     LU_Sms_Burn_Reasons
                        WHERE code in ('S','H','W','R','A','P','T')
                    </cfquery>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">burn reason</label>
                    </td>
                    <td>
                        <select name="burn_reason" class="form-control input-sm" >
                            <cfoutput>
                            <option value disabled selected></option>
                            <cfloop query="gbr">
                                <option value="#code#">#Descr#</option>
                            </cfloop>
                            </cfoutput>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">forest health exempt?</label>
                    </td>
                    <td>
                        <select name="fh_exempt" class="form-control input-sm" >
                            <option value disabled selected></option>
                            <cfloop list="No,Yes," index="a">
                            <cfoutput>
                                <option value="#a#">#a#</option>
                            </cfoutput>
                            </cfloop>
                        </select>
                    </td>
                </tr>
                <tr>
                    <cfquery name="gps" DATASOURCE='Washington_Smoke_Production'>
                        SELECT   Descr
                        FROM     LU_Sms_Fuels_Species
                    </cfquery>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">predominant species</label>
                    </td>
                    <td>
                        <select name="predominant_species" class="form-control input-sm" >
                            <cfoutput>
                            <option value disabled selected></option>
                            <cfloop query="gps">
                                <option value="#descr#">#Descr#</option>
                            </cfloop>
                            </cfoutput>
                        </select>
                    </td>
                </tr>
                </table>
        </div>

        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                <table class='table table-condensed table-bordered bg-info'>
                <tr>
                     <CFquery NAME="gco" DATASOURCE='Washington_smoke_production'>
                        Select *
                        from dbo.Counties
                        order by state, county
                      </cfquery>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">county</label>
                    </td>
                    <td>
                        <select name="county" class="form-control input-sm" >
                            <option value disabled selected></option>
                            <cfloop query="gco">
                            <cfoutput>
                                <option value="#county#">#county#</option>
                            </cfoutput>
                            </cfloop>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">PLSS</label>
                    </td>
                    <td>
                        <input type="text" class="form-control input-sm" id="town" value="" name="town" placeholder="00">
                        <select name="ns" id="ns"class="form-control input-sm" >
                            <option value disabled selected></option>
                            <cfloop list="N,S," index="a">
                            <cfoutput>
                                <option value="#a#">#a#</option>
                            </cfoutput>
                            </cfloop>
                        </select>
                        <input type="text" class="form-control input-sm" id="range" value="" name="range" placeholder="00">
                        <select name="ew" id="ew" class="form-control input-sm" >
                            <option value disabled selected></option>
                            <cfloop list="E,W," index="a">
                            <cfoutput>
                                <option value="#a#">#a#</option>
                            </cfoutput>
                            </cfloop>
                        </select>
                        <input type="text" class="form-control input-sm" id="sect" value="" name="sect" placeholder="00">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">coordinates</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="lon" value="" name="lon" placeholder="-119">
                     <input type="text" class="form-control input-sm" id="lat" value="" name="lat" placeholder="45">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">elevation ft</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="elevation" value="" name="elevation" maxlength="5" placeholder="">
                    </td>
                </tr>
                <tr>
                    <td style='max-width:90px;text-align:right;'>
                        <label class="control-label">slope</label>
                    </td>
                    <td>
                     <input type="text" class="form-control input-sm" id="slope" value="" name="slope" maxlength="2" placeholder="">
                    </td>
                </tr>
                </table>
        </div>

    </div>
    <div class="panel-footer">
        <small>
        Enter your preburn data above and hit 'save' to save your edits.
        </small>        
    </div>
</div>
</form>

</div>

<cfelse>

<cflocation url="/fam/smoke/district/" addtoken='no'>

NO DISTRICT GOTO 'DISTRICTS'

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

        $("#preburn_form").validate({
            errorClass: "has-error",
            highlight: function(element) {
                $(element).parent().parent().addClass("has-error").removeClass("has-success");
            },
            unhighlight: function(element) {
                $(element).parent().parent().addClass("has-success").removeClass("has-error");
            },
            rules: {
                Burn_Project_Name: {
                    required: true,
                    maxlength:80
                },
                unit_acres: {
                    required: true,
                    number: true,
                    max: 999999
                },
                pile_tons: {
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    },
                    number: true,
                    max: 99999
                },
                pile_type: { 
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    }
                },
                pile_calculation_method: { 
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    }
                },
                landing_tons: {
                    required: true,
                    number: true,
                    max: 99999
                },
                dia_1: {
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return false;
                                }else{
                                return true;
                                }
                        }
                    },
                    number: true,
                    max: 999999
                },
                dia_2: {
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return false;
                                }else{
                                return true;
                                }
                        }
                    },
                    number: true,
                    max: 999999
                },
                dia_3: {
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return false;
                                }else{
                                return true;
                                }
                        }
                    },
                    number: true,
                    max: 999999
                },
                dia_4: {
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return false;
                                }else{
                                return true;
                                }
                        }
                    },
                    number: true,
                    max: 999999
                },
                dia_5: {
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return false;
                                }else{
                                return true;
                                }
                        }
                    },
                    number: true,
                    max: 999999
                },
                dia_6: {
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return false;
                                }else{
                                return true;
                                }
                        }
                    },
                    number: true,
                    max: 999999
                },
                broadcast_tons: {
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return false;
                                }else{
                                return true;
                                }
                        }
                    },
                    number: true,
                    max: 99999
                },
                broadcast_loading_method: { 
                    required: {
                        depends: function () {
                            if ($("[name=burn_type]").val() == "Pile"){
                                return false;
                                }else{
                                return true;
                                }
                        }
                    }
                },
                cutdate: {
                    required: false,
                    date: true
                },
                snowoff: {
                    required: false,
                    date: true
                },
                less_3: {
                    required: true,
                    number: true,
                    maxlength: 2
                },
                shrub: {
                    required: true,
                    number: true,
                    maxlength: 2
                },
                grass_herb: {
                    required: true,
                    number: true,
                    maxlength: 2
                },
                litter_depth: {
                    required: true,
                    number: true,
                    maxlength: 2
                },
                duff_depth: {
                    required: true,
                    number: true,
                    maxlength: 5
                },
                duff_type: {
                    required: true
                },
                burn_type: {
                    required: true
                },
                ignition_method: {
                    required: true
                },
                burn_reason: {
                    required: true
                },
                fh_exempt: {
                    required: true
                },
                predominant_species: {
                    required: true
                },
                county: {
                    required: true
                },
                town: {
                    required: true,
                    maxlength: 2,
                    max: 99
                },
                ns: {
                    required: true
                },
                range: {
                    required: true,
                    maxlength: 2,
                    max: 99
                },
                ew: {
                    required: true
                },
                sect: {
                    required: true,
                    maxlength: 2,
                    max: 99
                },
                lon: {
                    required: true,
                    min: -125,
                    max: -115
                },
                lat: {
                    required: true,
                    min: 45,
                    max: 50
                },
                elevation: {
                    required: true,
                    maxlength: 5,
                    min: -100,
                    max: 99999
                },
                slope: {
                    required: true,
                    maxlength: 2,
                    min: 0,
                    max: 99
                },
                agree: "required"
            },
            messages: {
                Burn_Project_Name: "",
                pile_tons: "Enter a number or 0.",
                pile_type: "Select a pile type.",
                pile_calculation_method: "Select a pile calculation method.",
                landing_tons: "Enter a number or 0.",
                dia_1: "Enter a number or 0.",
                dia_2: "Enter a number or 0.",
                dia_3: "Enter a number or 0.",
                dia_4: "Enter a number or 0.",
                dia_5: "Enter a number or 0.",
                dia_6: "Enter a number or 0.",
                broadcast_tons: "Enter a number or 0.",
                broadcast_loading_method: "Select a loading method.",
                cutdate: "Enter a date.",
                snowoff: "Enter a date.",
                less_3: "Enter a number or 0.",
                shrub: "Enter a number or 0.",
                grass_herb: "Enter a number or 0.",
                litter_depth: "Enter a number or 0.",
                duff_depth: "Enter a number or 0.",
                duff_type: "Select a duff type.",
                burn_type: "Select a burn type.",
                ignition_method: "Select an ignition method.",
                burn_reason: "Select a burn reason.",
                fh_exempt: "Select an exemption status.",
                predominant_species: "Select a species.",
                county: "Select a county.",
                town: "Enter a township.",
                ns: "Select a direction.",
                range: "Enter a range.",
                ew: "Select a direction.",
                sect: "Enter a section.",
                lon: "Enter a longitude between -125 and -115.",
                lat: "Enter a latitude between 45 and 50.",
                elevation: "Enter an elevation between 0 and 14411.",
                slope: "Enter a slope between 0 and 99.",
                agree: "Please accept our policy."
            }
        });
    });
    </script>
</body>
</html>

</cfif>
