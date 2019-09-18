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

<cfif #cgi.query_string# NEQ ''>
    <cfset bpno = #cgi.query_string#>
 <cfelse>
    <cfset bpno = ''>
</cfif>

<cfset utc = #DateConvert("local2Utc",today)# >
<cfset pacific = #dateAdd("h",-8,utc)# >

<cfif #bpno# NEQ '' and structkeyexists(form,"lock")>

<CFquery NAME="GTBR" DATASOURCE="Washington_Smoke_Production">
Select * from dbo.Burn_Request_Numbers
</cfquery>

<cfset brno = #GTBR.burn_req_No#>

<cfoutput>
<cfquery name='request_add' datasource="Washington_Smoke_Production" result="result">
INSERT into dbo.Burn_request
(
District_Code,
Burn_Project_Name,
Burn_Permit_Number,
Acreage_This_Burn,  
Added_By, 
Rank, 
Burn_Comments,  
Burn_date,                  
Burn_Duration_Min,  
Planned_Ignition_Duration_Min,  
Planned_Ignition_Time,  
Date_Added,
Plan_key,  
Tonnage_This_Burn,
Post_burn_report,
Multi_Day_Burn,
Burn_Req_No
)
VALUES
(
<cfqueryparam value = "#form.d_id#" cfsqltype="CF_SQL_CHAR" maxlength="7" null="no" >,
<cfqueryparam value = "#form.project_name#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
#bpno#,
<cfqueryparam value = "#form.acres#" cfsqltype="CF_SQL_CHAR" maxlength="6" null="no" >,
<cfqueryparam value = "#session.user_webcaaf#" cfsqltype="CF_SQL_CHAR" maxlength="80" null="no" >,
<cfqueryparam value = "#form.rank#" cfsqltype="CF_SQL_CHAR" maxlength="2" null="no" >, 
<cfqueryparam value = "#form.comments#" cfsqltype="CF_SQL_CHAR" maxlength="2000" null="no" >,  
<cfqueryparam value = "#form.ignition_date#" cfsqltype="CF_SQL_CHAR" maxlength="40" null="no" >,
<cfqueryparam value = "#form.duration#" cfsqltype="CF_SQL_CHAR" maxlength="6" null="no" >,
<cfqueryparam value = "#form.duration#" cfsqltype="CF_SQL_CHAR" maxlength="6" null="no" >,
<cfqueryparam value = "#form.ignition_time#" cfsqltype="CF_SQL_CHAR" maxlength="6" null="no" >,
#pacific#,
<cfqueryparam value = "#form.b_key#" cfsqltype="CF_SQL_CHAR" maxlength="7" null="no" >,
<cfqueryparam value = "#form.tons#" cfsqltype="CF_SQL_CHAR" maxlength="6" null="no" >,
'N',
<cfqueryparam value = "#form.multiday#" cfsqltype="CF_SQL_CHAR" maxlength="1" null="no" >,
#brno#
)
</cfquery>
</cfoutput>

<cfoutput>
<CFquery NAME="PTBR" DATASOURCE='Washington_Smoke_Production'>
Update dbo.Burn_Request_Numbers
Set Burn_req_no = #BRNO# + 1
</cfquery>

<CFquery NAME="rca" DATASOURCE='Washington_Smoke_Production' maxrows=1>
select burn_requests from dbo.Pre_Burn
where Burn_Unit_ID_No = #bpno#
</cfquery>

<cfif #rca.burn_requests# EQ ''>
 <cfset burn_requests = '1'>
<cfelse>
 <cfset burn_requests = #rca.burn_requests# + 1>
</cfif>

<CFquery NAME="rcb" DATASOURCE='Washington_Smoke_Production'>
Update dbo.Pre_Burn
Set burn_requests = #burn_requests#
where Burn_Unit_ID_No = #bpno#
</cfquery>
</cfoutput>

<cfset epk = result.generatedkey>

<cfset pacific = #datetimeformat(pacific,'yyyy-mm-dd HH:nn')# >

<cfset session.msg_text = "Request for <cfoutput><a class='alert-link' href='/fam/smoke/data/?#bpno#'>#form.project_name#</a></cfoutput> added by <cfoutput><a class='alert-link' href='/fam/smoke/users/?#session.username#'>#session.user_firstname# #session.user_lastname# (#session.user_email#)</a> at #pacific# PST</cfoutput>.">
<cfset session.msg_status = "success">

    <cfquery name="smoke_events_load" datasource="FAMDB">
    insert into smoke_events (
    grid,object,message,status,created,username
    )
    VALUES
    (
    'smoke_requests',
    '#epk#',
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

<div style="padding-right:20px;">

<form id="request_form" name="request_form" action="/fam/smoke/data/request/?<cfoutput>#bpno#</cfoutput>" method="post" enctype="multipart/form-data">

<cfif isDefined('bp')>

    <cfoutput>
    <input type="hidden" class="form-control" name="lock" size="" maxlength="1" value="Y" >
    <input type="hidden" class="form-control" name="contact" size="" maxlength="80" value="#session.user_firstname# #session.user_lastname#" >
    <input type="hidden" class="form-control" name="email" size="" maxlength="80" value="#session.user_email#" >
    <input type="hidden" class="form-control" name="d_id" size="" maxlength="80" value="#bp.district_code#" >
    <input type="hidden" class="form-control" name="project_name" size="" maxlength="80" value="#bp.burn_project_name#" >
    <input type="hidden" class="form-control" name="b_key" size="" maxlength="80" value="#bp.b_key#" >
    </cfoutput>

    <cfset vols = getMetadata(bp)>
    <cfset volList = "">
    <cfloop from="1" to="#arrayLen(vols)#" index="x"> <cfset volList = listAppend(volList, vols[x].name)> </cfloop>

    <div class="panel panel-info" style="max-width:none;">
        <div class="panel-heading">
            <h3 class="panel-title">
            <strong>NEW <span style='color:SlateGray'>Request</span></strong> for <cfoutput><strong>#bp.burn_unit_id_no# #bp.Burn_Project_Name#</strong> at <strong><span style='color:SlateGray'>District</span></strong> <strong>#bp.forest#</strong> &sect <strong>#bp.district#</strong></cfoutput>
            <span class="pull-right">
            <div class="input-group input-group-sm">
                <button class="btn btn-primary btn-xs" type="submit" name="save_req"><i class='glyphicon glyphicon-ok' style='font-size:80%'></i> save</button>
                <a class="btn btn-default btn-xs" href="/fam/smoke/data/?<cfoutput>#bpno#</cfoutput>"><i class='glyphicon glyphicon-remove' style='font-size:80%'></i> cancel</a>
            </div>
            </span>
            </h3>
        </div>

        <div class="panel-body small">

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
            </div>

            <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
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
            </div>

            <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                <cfoutput query="bp">
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


            <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
                <div id="form">
                    <table class='table table-condensed table-bordered bg-info'>
                        <thead>
                            <th style='background:Gainsboro;' colspan=2>Request</th>
                        </thead>
                        <tbody>
                        <tr>
                            <td style='max-width:90px;text-align:right;'>
                                <label class="control-label">ignition date</label>
                            </td>
                            <td>
                             <input type="text" class="form-control input-sm" id="ignition_date" value="" name="ignition_date" placeholder="1783-12-25">
                            </td>
                        </tr>
                        <tr>
                            <td style='max-width:90px;text-align:right;'>
                                <label class="control-label">ignition time</label>
                            </td>
                            <td>
                             <input type="text" class="form-control input-sm" id="ignition_time" value="" name="ignition_time" maxlength="4" placeholder="0800">
                            </td>
                        </tr>
                        <tr>
                            <td style='max-width:90px;text-align:right;'>
                                <label class="control-label">duration</label>
                            </td>
                            <td>
                             <input type="text" class="form-control input-sm" id="duration" value="" name="duration" maxlength="6" placeholder="">
                            </td>
                        </tr>
                        <tr>
                            <td style='max-width:90px;text-align:right;'>
                                <label class="control-label">multi-day?</label>
                            </td>
                            <td>
                                <select id="multiday" name="multiday" class="form-control input-sm" >
                                    <option value disabled selected></option>
                                    <cfloop list="N,Y," index="a">
                                    <cfoutput>
                                        <option value="#a#">#a#</option>
                                    </cfoutput>
                                    </cfloop>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style='max-width:90px;text-align:right;'>
                                <label class="control-label">acres</label>
                            </td>
                            <td>
                             <input type="text" class="form-control input-sm" id="acres" value="" name="acres" maxlength="6" placeholder="">
                            </td>
                        </tr>
                        <tr>
                            <td style='max-width:90px;text-align:right;'>
                                <label class="control-label">tons</label>
                            </td>
                            <td>
                             <input type="text" class="form-control input-sm" id="tons" value="" name="tons" maxlength="5" placeholder="">
                            </td>
                        </tr>
                        <tr>
                            <td style='max-width:90px;text-align:right;'>
                                <label class="control-label">rank</label>
                            </td>
                            <td>
                             <input type="text" class="form-control input-sm" id="rank" value="" name="rank" maxlength="2" placeholder="">
                            </td>
                        </tr>
                        <tr>
                            <td style='max-width:90px;text-align:right;'>
                                <label class="control-label">comments</label>
                            </td>
                            <td>
                             <textarea type="text" class="form-control input-sm" id="comments" value="" name="comments" placeholder="" rows="5"></textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

        </div>
        <div class="panel-footer">
            <small>
            Enter your request data above and hit 'save' to save your edits. 
            <cfoutput><cfif #bp.date_added# NEQ ''>Pre-burn added on <a href="/fam/smoke/date/?#dateformat(bp.date_added, 'yyyy-mm-dd')#">#dateformat(bp.date_added, 'yyyy-mm-dd')#</a><cfif #bp.added_by# NEQ ''> by <a href="/fam/smoke/users/?#bp.added_by#">#bp.added_by#</a></cfif>.</cfif> <cfif #bp.Date_modified# NEQ ''>Pre-burn updated on <a href='/fam/smoke/date/?#dateformat(bp.Date_modified, 'yyyy-mm-dd')#'>#dateformat(bp.Date_modified, 'yyyy-mm-dd')#</a><cfif #bp.modified_by# NEQ ''> by <a href="/fam/smoke/users/?#bp.modified_by#">#bp.modified_by#</a></cfif>.</cfif> <cfif #bp.Date_Deleted# NEQ ''>Pre-burn deleted on <a href='/fam/smoke/date/?#dateformat(bp.Date_Deleted, 'yyyy-mm-dd')#'>#dateformat(bp.Date_Deleted, 'yyyy-mm-dd')#</a><cfif #bp.deleted_by# NEQ ''> by <a href="/fam/smoke/users/?#bp.deleted_by#">#bp.deleted_by#</a></cfif>.</cfif></cfoutput>
            </small>        
        </div>
    </div>

</cfif>

</form>

</div>

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

        $("#request_form").validate({
            errorClass: "has-error",
            highlight: function(element) {
                $(element).parent().parent().addClass("has-error").removeClass("has-success");
            },
            unhighlight: function(element) {
                $(element).parent().parent().addClass("has-success").removeClass("has-error");
            },
            rules: {
                ignition_date: {
                    required: true,
                    date: true
                },
                ignition_time: {
                    required: true,
                    number: true,
                    max: 2400
                },
                duration: {
                    required: true,
                    number: true,
                    max: 999999
                },
                multiday: {
                    required: true
                },
                acres: {
                    required: true,
                    number: true,
                    max: 999999
                },
                tons: {
                    required: true,
                    number: true,
                    max: 99999
                },
                rank: {
                    required: true,
                    digits: true,
                    min: 1,
                    max: 99
                },
                comments: {
                    required: false
                },
                agree: "required"
            },
            messages: {
                ignition_date: "Enter a date.",
                ignition_time: "Enter a time.",
                duration: "Enter the planned duration in minutes.",
                multiday: "Select one.",
                acres: "Enter a number.",
                tons: "Enter a number.",
                rank: "Enter a number between 1 and 99.",
                comments: "Enter some kind of comment.",
                agree: "Please accept our policy."
            }
        });
    });
    </script>
</body>
</html>
