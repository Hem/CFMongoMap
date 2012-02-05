<cfscript>

import com.cfmongomap;


/**
 * Version 0.1 -- Created
 * Version 0.2 -- Added IdFieldName and CollectionName for Linked References
 **/
interface {
	
	// this is the unique key that is used to cache the map processor!
	// This is required since I do not know how to get the unique instance id of the cfc.. .Yet!
	String function getCacheKey();
	
	// will return cfc path
	String function getClassName();
	
	// will return component, java, etc...
	String function getClassType();
	
	// Not sure if I should expose this or force the framework to use Iterator!
	// NOTE: Expects an array of type 
	Array function getFields();	
	
	// do I provide this function?
	String function getIdFieldName();
	
	// The name of the collection in which the mapped objects are saved!
	String function getCollectionName();
	
	// returns an iterator for the fields collection.
	Any function iterator();
	
}
</cfscript>
