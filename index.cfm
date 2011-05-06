<cfparam name="url.a" default="Backtrack">
<cfparam name="url.w" default="10">
<cfparam name="url.h" default="10">
<cfparam name="url.s" default="10">

<cfflush />
<cfoutput>
<style>
##debug div div{padding:8px;border:1px solid silver;}
##debug h3 {line-height:35px;border:2px solid silver;width:100%;text-align:left;margin:0px;}
.different{color:green;border-color:green;background-color:mintcream;}
.sametree{color:red;border-color:red;background-color:ivory;}
</style>
<form name="mazeform" action="index.cfm" method="get">
<b>Algorithm:</b>
	<select name="a">
		<option value="Backtrack" <cfif url.a EQ "Backtrack">selected</cfif>>Backtrack/Depth-First Search</option>
		<option value="RecursiveBacktrack" <cfif url.a EQ "RecursiveBacktrack">selected</cfif>>Backtrack/Depth-First Search (recursively)</option>
		<option value="Kruskal" <cfif url.a EQ "Kruskal">selected</cfif>>Kruskal</option>
	</select>
	<br>
<b>Maze Width:</b>
	<input type="text" name="w" size="4" value="#val(url.w)#">
	<br>
<b>Maze Height:</b>
	<input type="text" name="h" size="4" value="#val(url.h)#">
	<br>
<b>Cell Size:</b>
	<input type="text" name="s" size="4" value="#val(url.s)#">
	<br>	
<input type="submit" value="build">	
</form>

<b>The Maze.</b><br>
<div id="maze"> Generating maze... </div>
<br>
</cfoutput>

<cfflush />
<div id="debug">
<cfset maze = createObject("component","Maze").init( "algo."& url.a )>
<cfset maze.create( val(url.w), val(url.h), val(url.s), expandPath("img/maze.jpg") )>
</div>

<script>
document.getElementById("maze").innerHTML = '<img src="img/maze.jpg" />';
</script>
