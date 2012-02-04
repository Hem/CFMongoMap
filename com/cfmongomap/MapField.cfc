<cfscript>

import com.cfmongomap.*
	
component accessors=true{
	//@CFC
	property name="propertyName" type="string";
	
	//@DB
	property name="fieldName" type="string";
	
	
	property name="propertyType" type="string" default="String";
	property name="dataType" type="string" default="String";
	
	
	// maps to a new database table if necessary!
	property name="dataMap" type="IMap";
	
	
}

 </cfscript>