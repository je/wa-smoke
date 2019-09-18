<cfinclude template="/fam/smoke/use.cfm">

<cfif structKeyExists(form, 'districts')>
<cfset ser = ''>
<cfset serp = ''>
<cfoutput>
<cfloop list="#form.fieldnames#" index="i">
<cfset serp = "{#i#:#form[i]#}"
><cfset ser = ser & serp & '<br>'>
</cfloop>
</cfoutput>
</cfif>

<cfif structKeyExists(form, 'districts')>
<cfloop item="field" collection="#form#">
    <cfif findNoCase("district_", field)>
        <cfset Forest_Key = listLast(field, "_")>
        <cfset f = removeChars(field, 1,9)>
        <cfset fk = "_" & Forest_Key >
        <cfset f = replace(f, fk, "")>
        <cfoutput>#Forest_Key# : #f# : #form[field]#</cfoutput><br>
        <cfquery datasource="FAMDB">
        update dbo.smoke_forest_access set
        #f# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form[field]#">
        where Forest_Key = <cfqueryparam cfsqltype="cf_sql_integer" value="#Forest_Key#">
        </cfquery>
    </cfif>
</cfloop>
<cfabort>
</cfif>


<cfif structKeyExists(form, 'districts')>
<cfmail to="admin@example.com" from="admin@example.com" subject="district records edited - #session.user_email# ">
district records edited - #session.user_firstname# #session.user_lastname# (#session.user_webcaaf#, #session.user_email#).
</cfmail>
<cfset msg_text = "District records edited - <a class=""alert-link"" href=""/fam/users/?#session.user_webcaaf#"">#session.user_firstname# #session.user_lastname#</a> (<a class=""alert-link"" href=""/fam/users/?#session.user_webcaaf#"">#session.user_email#</a>).">
<cfset msg_status = "success">
</cfif>

<cfinclude template="/fam/lo.cfm">

<cfif isdefined('q')>
<cfset session.q = #q#>
<cfelse>
<cfset session.q = ''>
</cfif>

<cfif #cgi.query_string# NEQ ''>

query_string

<cfelseif #session.q# NEQ ''>

q

<cfelse>

<form name="districts" action="/fam/smoke/district/edit/" method="post" enctype="multipart/form-data">
<div class="panel panel-info" style="max-width:1880px;">

<div class="panel-heading">
<h3 class="panel-title">
<a href="/fam/smoke/districts/"><strong>Editing District Records</strong></a>
    <span class="pull-right"><input class="btn btn-primary btn-xs" type="submit" name="districts" value="Save">
</h3>
</div>

<div class="panel-body form-inline">

<cfquery name="ada" datasource="FAMDB">
SELECT *
FROM smoke_forest_access a
ORDER BY The_Forest_Name, District_Name

</cfquery>

<cfoutput query="FAMDB_user">
    <input class="hidden" type="hidden" name="user_webcaaf" value="#username#">
    <input class="hidden" type="hidden" name="user_firstname" value="#firstname#">
    <input class="hidden" type="hidden" name="user_lastname" value="#lastname#">
    <input class="hidden" type="hidden" name="user_email" value="#email#">
</cfoutput>

<table class='table table-bordered table-condensed'>
<thead>
<th>ID</th>
<th>Forest</th>
<th>District</th>
<th>Address City State Zip</th>
<th>Contact</th>
<th>Telephone</th>
<th>Email</th>
</thead>
<cfoutput query='ada'>
<tr>
<td>
    <div class="form-group form-group-sm">
     <span class='pull-right'><p class="form-control-static input-sm" name="Forest_Key_#Forest_Key#">#Forest_Key#</p>
     <input class="hidden" type="hidden" id="distirct_Forest_Key_#Forest_Key#" name="district_Forest_Key_#Forest_Key#" value="#Forest_Key#" disabled>
     </span>
    </div>
</td>
<td>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_The_Forest_Name_#Forest_Key#" value="#The_Forest_Name#" name="district_The_Forest_Name_#Forest_Key#" disabled></span>
    </div>
</td>
<td>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_District_Name_#Forest_Key#" value="#District_Name#" name="district_District_Name_#Forest_Key#"></span>
    </div>
</td>
<td>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_Address_#Forest_Key#" value="#Address#" name="district_Address_#Forest_Key#"></span>
    </div>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_City_#Forest_Key#" value="#City#" name="district_City_#Forest_Key#"></span>
    </div>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_State_#Forest_Key#" value="#State#" name="district_State_#Forest_Key#"></span>
    </div>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_Zip_#Forest_Key#" value="#Zip#" name="district_Zip_#Forest_Key#"></span>
    </div>
</td>
<td>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_Contact_#Forest_Key#" value="#Contact#" name="district_Contact_#Forest_Key#"></span>
    </div>
</td>
<td>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_Phone_area_code_#Forest_Key#" value="#Phone_area_code#" name="district_Phone_area_code_#Forest_Key#"></span>
    </div>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_Phone_prefix_#Forest_Key#" value="#Phone_prefix#" name="district_Phone_prefix_#Forest_Key#"></span>
    </div>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_Phone_number_#Forest_Key#" value="#Phone_number#" name="district_Phone_number_#Forest_Key#"></span>
    </div>
</td>
<td>
    <div class="form-group form-group-sm">
     <span class=''><input type="text" class="form-control input-sm" id="district_Email_#Forest_Key#" value="#Email#" name="district_Email_#Forest_Key#"></span>
    </div>
</td>
</tr>
</cfoutput>
</table>


</div>

</form>



</cfif>


</div>
</div>
</div>

<cfinclude template="/fam/gutter.cfm">

    <script src="/fam/jquery-validation-1.14.0/dist/jquery.validate.js"></script>
    <script src="/fam/jquery-validation-1.14.0/dist/additional-methods.min.js"></script>
    <script src="/fam/jquery-validation-1.14.0/lib/jquery.maskedinput.js"></script>
    <script>

    $().ready(function() {
        // validate the comment form when it is submitted
        //$("#commentForm").validate();
        $("#applicant_zip_code").mask("99999?-9999");


        // validate signup form on keyup and submit
        $("#app_fm").validate({
            errorClass: "has-error",
            highlight: function(element) {
                $(element).parent().parent().addClass("has-error");
            },
            unhighlight: function(element) {
                $(element).parent().parent().addClass("has-success").removeClass("has-error");
            },
            rules: {
                applicant_nameI: "required",
                applicant_nameIII: "required",
                applicant_city: "required",
                applicant_jet_port: "required",
                applicant_zip_code: "required",
                applicant_email_address: {
                    required: true,
                    email: true
                },
                applicant_work_phone: {
                  required: true,
                  phoneUS: true
                },
                applicant_home_phone: {
                  required: true,
                  phoneUS: true
                },
                applicant_cell_phone: {
                  required: true,
                  phoneUS: true
                },
                applicant_dispatch_phone: {
                  required: true,
                  phoneUS: true
                },
                applicant_fax_phone: {
                  required: true,
                  phoneUS: true
                },
                applicant_qualifications: {
                    required: true
                },
                applicant_retired: {
                    required: true
                },
                applicant_IQCS: "required",
                applicant_gaac_type: "required",
                applicant_area: "required",
                applicant_gaac_typeI: "required",
                applicant_agreement_holder_agency: { // <- NAME attribute of the input
                    required: {
                        depends: function () {
                            if ($("[name=applicant_gaac_typeI]").val() == "Other"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    }
                },
                applicant_fq_email_type: "required",
                applicant_agency: { // <- NAME attribute of the input
                    required: {
                        depends: function () {
                            if ($("[name=applicant_fq_email_type]").val() == "Other"){
                                return true;
                                }else{
                                return false;
                                }
                        }
                    }
                },
                applicant_agency_address: {
                    required: true,
                    email: true
                },
                applicant_ao_name: "required",
                applicant_ao_email: {
                    required: true,
                    email: true
                },
                applicant_aa_name: {
                    required: false,
                },
                applicant_aa_email: {
                    required: false,
                    email: true
                },
                applicant_fq_email: {
                    required: true,
                    email: true
                },
                agree: "required"
            },
            messages: {
                applicant_nameI: "Enter your firstname",
                applicant_nameIII: "Enter your lastname",
                applicant_city: "Enter your city of residence",
                applicant_jet_port: "Select your state of residence",
                applicant_zip_code: "Enter your zip code",
                applicant_email_address: "Enter a valid email address",
                applicant_work_phone: "Enter a valid work phone number",
                applicant_home_phone: "Enter a valid home phone number",
                applicant_cell_phone: "Enter a valid cell phone number",
                applicant_dispatch_phone: "Enter a valid dispatch phone number",
                applicant_fax_phone: "Enter a valid fax number",
                applicant_qualifications: "Enter your fire qualifications",
                applicant_retired: "Select a catagory",
                applicant_IQCS: "Enter your IQCS number or N/A",
                applicant_gaac_typeI: "Select your dispatch office",
                applicant_agreement_holder_agency: "Enter your dispatch office",
                applicant_agency: "Enter your agency",
                applicant_agency_address: "Enter a valid email address",
                applicant_ao_name: "Enter your supervisor's name",
                applicant_ao_email: "Enter a valid email address",
                applicant_aa_name: "Enter your agency rep's name",
                applicant_aa_email: "Enter a valid email address",
                applicant_fq_email: "Enter a valid email address",
                agree: "Please accept our policy"
            }
        });
    });
    </script>
</body>
</html>
