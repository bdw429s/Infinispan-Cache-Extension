HELLO
<cfif structKeyExists(form,"sessionvalue")>
	<cfset session[form.sessionkey] = form.sessionvalue />
</cfif>
<form method="post" action="?">
SESSION:
Key<input type="text" name="sessionkey"/> = <input type="text" name="sessionvalue"/><input type="submit"/>
</form>
<form method="post" action="?">
	<cfparam name="unique" default="">
unique <input type="text" name="unique" size="10" value="<cfoutput>#unique#</cfoutput>"/>
Test put objects <input type="submit" name="objectsput"/>
Test get objects <input type="submit" name="objectsget"/>
</form>
<a href="?">REFRESH</a>
<cfscript>
	stItem = {name="elvis", location="usa"};
	arrItem = [1,3,5,6,7,6];
	qry = QueryNew("name,age", "string,int");
	for(i=0; i<10;i++){
		QueryAddRow(qry);
		QuerySetCell(qry,"name", "name_#i#");
		QuerySetCell(qry,"age", 30 + i);
	}

	stItem2 = Duplicate(stItem);
	stItem2.array = arrItem;

	cComp = CreateObject("component", "TestObject");
	cComp.setName("elvis");
	cComp.setAge(36);

if(structKeyExists(form,"objectsput")){
	CachePut("struct" & unique, stItem);
	CachePut("array" & unique, arrItem);
	CachePut("query" & unique, qry);
	CachePut("mixed" & unique, stItem2);
	CachePut("obj" & unique, cComp);
}

if(structKeyExists(form,"objectsput") || structKeyExists(form,"objectsget")){
	my.Struct = CacheGet("struct" & unique);
	my.Array = CacheGet("array" & unique);
	my.Query = CacheGet("query" & unique);
	my.Mixed = CacheGet("mixed" & unique);
	my.Obj = CacheGet("obj" & unique);
	dump(my);
}

</cfscript>

<cfdump var="#session#">