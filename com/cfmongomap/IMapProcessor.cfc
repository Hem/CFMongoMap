<cfscript>

import com.cfmongomap.*;

interface extends=Iterator{
	
	// get the map!
	IMap function getMap();
	
	// any data that has an iterator interface!
	// return the IMapProcessor so we can do some chaining when we init the object!
	IMapProcessor function setData(required any data);
	
	
	/**
	 * Valid Values :: CF2DB || DB2CF -- this is required to use .Next();
	 **/
	IMapProcessor function setDirection(required any direction);
	
	
	/**
	 * Required by the Java Driver for creating Linked REFs
	 **/
	IMapProcessor function setDB(required any database);
	
	
	
	/**
	 * Convert MongoDB Object to a ColdFusion Component
	 **/
	Any function toCfObject(required any item);
	
	/**
	 * Convert a ColdFusion Component to a Mongo DB Object
	 **/
	Any function toDbObject(required any item);
	
}

</cfscript>