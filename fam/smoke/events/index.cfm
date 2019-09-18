<cfinclude template="/fam/smoke/use.cfm">

<cfif #cgi.query_string# CONTAINS 'log-' or #cgi.query_string# CONTAINS 'logg-'><cfelse>
	<cfinclude template="/fam/lo.cfm">
</cfif>

<cfif #session.admin# EQ 1 and #cgi.query_string# EQ 'bounce' >

	<cfquery name="drop_smoke_events" datasource="FAMDB">
	if exists (select * from information_schema.tables where table_name = 'smoke_events')
	    drop table smoke_events;
	</cfquery>

	<cfquery name="make_smoke_events" datasource="FAMDB">
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	SET ANSI_PADDING ON
	CREATE TABLE smoke_events(
		[id] [int] IDENTITY(1,1) NOT NULL,
		[grid] [varchar](50) NULL,
		[object] [int] NULL,
		[message] [varchar](max) NULL,
		[status] [varchar](50) NULL,
		[created] [datetime] NULL,
		[username] [varchar](50) NULL
	 CONSTRAINT [PK_smoke_events] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	SET ANSI_PADDING OFF
	</cfquery>

	<cfset utc = #DateConvert("local2Utc",today)# >
	<cfset pacific = #dateAdd("h",-8,utc)# >
	<cfset pacific = #datetimeformat(pacific,'yyyy-mm-dd HH:nn')# >

	<cfset msg_text = "Table <cfoutput><a class='alert-link' href='/fam/smoke/events/'>smoke_events</a></cfoutput> bounced by <cfoutput><a class='alert-link' href='/fam/smoke/users/?#session.username#'>#session.user_firstname# #session.user_lastname# (#session.user_email#)</a> at #pacific# PST</cfoutput>.">
	<cfset msg_status = "success">

	<cfquery name="smoke_events_load" datasource="FAMDB">
	insert into smoke_events (
	grid,object,message,status,created,username
	)
	VALUES
	(
	'smoke_events',
	NULL,
	'#msg_text#',
	'#msg_status#',
	'#pacific#',
	'#session.username#'
	)
	</cfquery>

</cfif>

<cfset utc = #DateConvert("local2Utc",today)# >
<cfset pacific = #dateAdd("h",-8,utc)# >
<cfset pacific = #datetimeformat(pacific,'yyyy-mm-dd HH:nn')# >
<cfset pyyyy = #datetimeformat(pacific,'yyyy')# >
<cfset pmm = #datetimeformat(pacific,'mm')# >
<cfset pdd = #datetimeformat(pacific,'dd')# >

<cfset dateq = ''>
<cfset unitq = ''>
<cfset qyyyy = #pyyyy# >
<cfset qmm = #pmm# >
<cfset qdd = #pdd# >

<cfif #cgi.query_string# NEQ ''>
    <cfif #cgi.query_string# CONTAINS 'log-' or #cgi.query_string# CONTAINS 'logg-'>
	    <cfset dateq = REReplaceNoCase( cgi.query_string,  "log-", "") />
	    <cfset dateq = REReplaceNoCase( dateq,  "logg-", "") />
	    <cfset dateq = REReplaceNoCase( dateq,  ".csv", "") />
	    <cfset TestSTring = dateq>
	    <cfset a = ListToArray(TestString, "-", false, true)>
		<cftry>
		    <cfset ayyyy = a[1] />
		    <cfset amm = a[2] />
		    <cfset add = a[3] />
		    <cfset qyyyy = ayyyy>
	        <cfif isnumeric(amm)>
	        	<cfset qmm = #amm#>
	        <cfelse>
	        	<cfset qmm = ''>
	        </cfif>
	        <cfif isnumeric(add)>
	        	<cfset qdd = #add#>
	        <cfelse>
	        	<cfset qdd = ''>
	        </cfif>
			<cfcatch>
			BAD, EVIL date entry. Enter a date like '2016-05-31', a month like '2016-05-xx', or year like '2016-xx-xx'.
			<cfabort>
			</cfcatch>
		</cftry>
    <cfelseif #cgi.query_string# CONTAINS 'date='>
	    <cfset dateq = REReplaceNoCase( cgi.query_string,  "date=", "") />
	    <cfset TestSTring = dateq>
	    <cfset a = ListToArray(TestString, "-", false, true)>
		<cftry>
		    <cfset ayyyy = a[1] />
		    <cfset amm = a[2] />
		    <cfset add = a[3] />
		    <cfset qyyyy = ayyyy>
	        <cfif isnumeric(amm)>
	        	<cfset qmm = #amm#>
	        <cfelse>
	        	<cfset qmm = ''>
	        </cfif>
	        <cfif isnumeric(add)>
	        	<cfset qdd = #add#>
	        <cfelse>
	        	<cfset qdd = ''>
	        </cfif>
			<cfcatch>
			BAD, EVIL date entry. Enter a date like '2016-05-31', a month like '2016-05-xx', or year like '2016-xx-xx'.
			<cfabort>
			</cfcatch>
		</cftry>
    </cfif>
</cfif>

<cfif #dateq# NEQ ''>
	<cfquery name="tada" datasource="FAMDB">
	SELECT e.id,e.created,e.username,u.email,grid,object,message,status,DATEPART(Year, e.created) cyyyy, DATEPART(Month, e.created) cmm, DATEPART(Day, e.created) cdd
	FROM smoke_events e
    left outer join users u on e.username = u.username
    <cfif #qyyyy# NEQ ''>
    WHERE year(e.created) = #qyyyy#
    </cfif>
    <cfif #qmm# NEQ ''>
    AND month(e.created) = #qmm#
    </cfif>
    <cfif #qdd# NEQ ''>
    AND day(e.created) = #qdd#
    </cfif>
	ORDER BY id DESC
	</cfquery>

	<cfquery name="sada" datasource="tada" dbtype='query'>
	SELECT status,username,email,cyyyy,cmm,cdd,count(status) as c
	FROM tada
    GROUP BY status,username,email,cyyyy,cmm,cdd
	ORDER BY c DESC
	</cfquery>
<cfelse>
	<cfquery name="tada" datasource="FAMDB">
	SELECT e.id,e.created,e.username,u.email,grid,object,message,status,DATEPART(Year, e.created) cyyyy, DATEPART(Month, e.created) cmm, DATEPART(Day, e.created) cdd
	FROM smoke_events e
    left outer join users u on e.username = u.username
    <cfif #qyyyy# NEQ ''>
    WHERE year(e.created) = #qyyyy#
    </cfif>
    <cfif #qmm# NEQ ''>
    AND month(e.created) = #qmm#
    </cfif>
    <cfif #qdd# NEQ ''>
    AND day(e.created) = #qdd#
    </cfif>
	ORDER BY id DESC
	</cfquery>

	<cfquery name="sada" datasource="tada" dbtype='query'>
	SELECT status,username,email,cyyyy,cmm,cdd,count(status) as c
	FROM tada
    GROUP BY status,username,email,cyyyy,cmm,cdd
	ORDER BY c DESC
	</cfquery>
</cfif>

<cfset cols = 'id,created,username,email,grid,object,message,status,cyyyy,cmm,cdd'>
<cfset heads = '_,created,_,user,_,_,message,_,_,_,_'>
<cfset refs = 'id,created,username,username,grid,object,_,status,cyyyy,cmm,cdd'>
<cfset rebs = 'id,created,username,smoke/users,grid,object,message,status,cyyyy,cmm,cdd'>

<cfif #cgi.query_string# CONTAINS 'log-'>id,date,username,email,status,value
<cfoutput query="sada">
#cyyyy#-#cmm#-#cdd# #username# #status#,#cyyyy#-#cmm#-#cdd#,#username#,#email#,#status#,#c# #chr(13)##chr(10)#
</cfoutput><cfabort>
<cfelseif #cgi.query_string# CONTAINS 'logg-'>date,username,email,grid,status
<cfoutput query="tada">
#datetimeformat(created, 'yyyymmddHHnn')#,#username#,#email#,#grid#,#status# #chr(13)##chr(10)#
</cfoutput><cfabort>
</cfif>

<cfif isdefined('sada')>

<div class="panel panel-default" id="grap" style="">

<style>

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.axis text {
  font: 10px sans-serif;
}

.cells path {
  fill: none;
  pointer-events: all;
}

.cells :hover circle {
  fill: red;
}

</style>
<svg id="chart" 
  viewBox="0 0 960 160"
  preserveAspectRatio="xMidYMid meet">
</svg>
<script src="https://d3js.org/d3.v4.0.0-alpha.39.min.js"></script>
<script>

var svg = d3.select("svg"),
    margin = {top: 40, right: 40, bottom: 40, left: 40},
    width = 960 - margin.left - margin.right,
    height = 160 - margin.top - margin.bottom;

var formatValue = d3.format(",d");

var x = d3.scaleLog()
    .rangeRound([0, width]);

var g = svg.append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

d3.csv("?log<cfoutput><cfif #qyyyy# NEQ "">-#qyyyy#<cfelse>-xxxx</cfif><cfif #qmm# NEQ "">-#qmm#<cfelse>-xx</cfif><cfif #qdd# NEQ "">-#qdd#<cfelse>-xx</cfif></cfoutput>.csv", type, function(error, data) {
  if (error) throw error;

  x.domain(d3.extent(data, function(d) { return d.value; }));

  var simulation = d3.forceSimulation(data)
      .force("x", d3.forceX(function(d) { return x(d.value); }).strength(1))
      .force("y", d3.forceY(height / 2))
      .force("collide", d3.forceCollide(4))
      .stop();

  for (var i = 0; i < 120; ++i) simulation.tick();

  g.append("g")
      .attr("class", "axis axis--x")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x).ticks(20, ".0s"));

  var cell = g.append("g")
      .attr("class", "cells")
    .selectAll("g").data(d3.voronoi()
        .extent([[-margin.left, -margin.top], [width + margin.right, height + margin.top]])
        .x(function(d) { return d.x; })
        .y(function(d) { return d.y; })
      .polygons(data)).enter().append("g");

  cell.append("circle")
      .attr("r", 3)
      .attr("cx", function(d) { return d.data.x; })
      .attr("cy", function(d) { return d.data.y; });

  cell.append("path")
      .attr("d", function(d) { return "M" + d.join("L") + "Z"; });

  cell.append("title")
      .text(function(d) { return d.data.email + "\n" + d.data.date + "\n" + formatValue(d.data.value); });
});

function type(d) {
  if (!d.value) return;
  d.value = +d.value;
  return d;
}

</script>
</div>

</cfif>

<cfif isdefined('tada')>
 <cfif #qmm# NEQ '' or #qdd# NEQ ''>
	<cfset cols = getMetadata(tada)>
	<cfset colList = "">
	<cfloop from="1" to="#arrayLen(cols)#" index="x"> <cfset colList = listAppend(colList, cols[x].name)> </cfloop>

	<div class="panel panel-default" style="">
	<div class="panel-heading">
	<h3 class="panel-title">
	<cfoutput>#tada.recordcount#</cfoutput> <strong>Events</strong>
	<small></small>
	<a class="pull-right" href="/fam/smoke/"><strong>Washington State Smoke Reporting</strong></a>
	</h3>
	</div>

	<table class="table table-bordered table-condensed">
	<thead>
	<cfoutput>
	<cfif len(heads)>
	<cfloop list="#heads#" index='head'>
	<cfif head NEQ '_'>
	<th>#head#</th>
	</cfif>
	</cfloop>
	<cfelse>
	<cfloop list="#collist#" index='head'>
	<th>#head#</th>
	</cfloop>
	</cfif>
	</cfoutput>
	</thead>

	<tbody>
	<cfoutput query="tada">
	<tr class='<cfif #tada['status'][currentRow]# NEQ ''>text-#tada['status'][currentRow]#<cfelse>text-info</cfif>'>
	<cfset n = 1>
	<cfloop index="col" list="#collist#">
	<cfif len(heads)>
		<cfset hd = #listgetat(heads,n)#>
		<cfif hd NEQ '_'>
			<cfset rf = #listgetat(refs,n)#>
			<td <cfif col EQ 'action_page'>style="max-width:440px;"</cfif>>
			<cfif col EQ 'message'><i class='glyphicon glyphicon-alert'></i> </cfif>
			<cfif rf NEQ '_'>
				<cfset rfx = rf>
				<cfset rbx = #listgetat(rebs,n)#>
				<a href='/fam/#rbx#/?#tada[rfx][currentRow]#'><cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#<cfelseif col EQ 'changed'>#tostring(tada[col][currentrow])#<cfelse>#tada[col][currentRow]#</cfif></a>
				<cfelse>
				<cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#<cfelseif col EQ 'changed'>#tostring(tada[col][currentrow])#<cfelse>#tada[col][currentRow]#</cfif>
			</cfif>
			</td>
		</cfif>
	<cfelse>
		<td><cfif isDate(tada[col][currentRow])>#dateformat(tada[col][currentRow], 'yyyy-mm-dd')#<cfelseif col EQ 'changed'>#tostring(tada[col][currentrow])#<cfelse>#tada[col][currentRow]#</cfif></td>
	</cfif>
	<cfset n = n + 1>
	</cfloop>
	</tr>
	</cfoutput>
	</tbody>
	</table>
	</div>
<cfelse>

<div class="panel panel-default" style="">
<div class="panel-heading">
<h3 class="panel-title">
<cfoutput>#sada.recordcount#</cfoutput> <strong>Points</strong>
<a class="pull-right" href="/fam/smoke/"><strong>Washington State Smoke Reporting</strong></a>
</h3>
</div>

<table class="table table-bordered table-condensed">
    <thead>
        <th>date</th>
        <th>user</th>
        <th>status</th>
        <th>count</th>
    </thead>
    <tbody>
    <cfoutput query="sada">
        <tr>
            <td>#cyyyy#-#cmm#-#cdd#</td>
            <td><a href="/fam/smoke/users/?#username#">#email#</a></td>
            <td>#status#</td>
            <td>#c#</td>
        </tr>
    </cfoutput>
    </tbody>
</table>

</div>

</cfif>
</cfif>

<cfinclude template="/fam/gutter.cfm">

</body>
</html>