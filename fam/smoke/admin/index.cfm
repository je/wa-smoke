<cfinclude template="/fam/smoke/use.cfm">

<cfinclude template="/fam/lo.cfm">

<cfif session.smoke_admin EQ '1' or session.admin EQ '1'>

    <div class="panel panel-default" style="max-width:880px;">
        <div class="panel-heading">
        <h3 class="panel-title">
        <strong>Washington State Smoke Reporting Database Tables</strong>
        <a class="pull-right" href="/fam/users/"><strong>System Operator</strong></a>
        </h3>
        </div>

        <div class="panel-body">
        Pages below are mostly FAMDB snapshots of Washington_Smoke_Production tables. Use the '+' to drop, recreate, and reload a FAMDB table from Washington_Smoke_Production.
        </div>

        <cfoutput>
        <table class="table table-bordered table-condensed">
        <tbody>
        <tr><td><a href="/fam/smoke/burn-reasons/">Burn Reasons</a>
                <a class="pull-right" href="/fam/smoke/burn-reasons/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/burn-types/">Burn Types</a>
                <a class="pull-right" href="/fam/smoke/burn-types/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/column-field-relations/">Column/Field Relations</a>
                <a class="pull-right" href="/fam/smoke/column-field-relations/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/counties/">Counties</a>
                <a class="pull-right" href="/fam/smoke/counties/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/duff-types/">Duff Type</a>
                <a class="pull-right" href="/fam/smoke/duff-types/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/field-definitions/">Field Definitions</a>
                <a class="pull-right" href="/fam/smoke/field-definitions/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/forest-access/">Forest Access</a>
                <a class="pull-right" href="/fam/smoke/forest-access/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/fuel-moisture-methods/">Fuel Moisture Methods</a>
                <a class="pull-right" href="/fam/smoke/fuel-moisture-methods/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/fuel-species/">Fuel Species</a>
                <a class="pull-right" href="/fam/smoke/fuel-species/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/ignition-methods/">Ignition Methods</a>
                <a class="pull-right" href="/fam/smoke/ignition-methods/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/permit-numbers/">Permit Numbers</a>
                <a class="pull-right" href="/fam/smoke/permit-numbers/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/post-burns/">Post-Burns</a>
                <a class="pull-right" href="/fam/smoke/post-burns/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'
            </td></tr>
        <tr><td><a href="/fam/smoke/pre-burns/">Pre-Burns</a>
                <a class="pull-right" href="/fam/smoke/pre-burns/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/raws/">RAWS</a>
                <a class="pull-right" href="/fam/smoke/raws/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/request-numbers/">Request Numbers</a>
                <a class="pull-right" href="/fam/smoke/request-numbers/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/requests/">Requests</a>
                <a class="pull-right" href="/fam/smoke/requests/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/weather-methods/">Weather Methods</a>
                <a class="pull-right" href="/fam/smoke/weather-methods/?bounce">+</a></td>
            <td>Static import from 'Washington_Smoke_Production'.
            </td></tr>
        <tr><td><a href="/fam/smoke/users-legacy/">Users-Legacy</a></td>
            <td>Live link to legacy database 'Region_6'.
            </td></tr></tbody>
        </table>
        </cfoutput>
    </div>
</cfif>

<cfinclude template="/fam/gutter.cfm">

</body>
</html>