<cfscript>

import com.cfmongomap;


interface {
	
	// this is the unique key that is used to cache the map processor!
	// This is required since I do not know how to get the unique instance id of the cfc.. .Yet!
	string function getCacheKey();
	
	
	// will return cfc path
	string function getClassName();
	
	
	// will return component, java, etc...
	string function getClassType();
	
	
	
	// Not sure if I should expose this or force the framework to use Iterator!
	// NOTE: Expects an array of type 
	Array function getFields();	
	
	
	// returns an iterator for the fields collection.
	Any function iterator();
	
}
</cfscript>
