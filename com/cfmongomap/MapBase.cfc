<cfscript>

import com.cfmongomap.*;

/**
 * Version 0.1 -- Created
 * Version 0.2 -- Added IdFieldName and CollectionName for Linked References
 **/


component implements=IMap{
	
	// constructor !
	public Any function init(required string className, string classType='component'){
		Variables.className = Arguments.className;
		Variables.classType = Arguments.classType;
		Variables.CACHE_KEY = Replace(CreateUUID(),'-','_', 'ALL');
	
		return this;
	}
	
	
	public Any function add(required MapField field)
	{
		ArrayAppend(Variables.fields, field);
		return this;
	}
	
	
	// ---------------------------------------
	// implement interfaces
	// ---------------------------------------
	public string function getCacheKey(){
		return Variables.CACHE_KEY;
	}
	
	Variables.className = "";
	public string function getClassName(){
		return Variables.className;
	}
	
	Variables.classType = "";
	public string function getClassType(){
		return variables.classType;
	}
	
	Variables.fields = ArrayNew(1);
	public array function getFields(){
		return variables.fields;
	}
	
	Variables.idFieldName = "";
	public Any function setIdFieldName(required string name){
		Variables.idFieldName = Arguments.name;
		return this;
	}
	public String function getIdFieldName(){
		return Variables.idFieldName;
	}
	
	
	Variables.collectionName = "";
	public Any function setCollectionName(required string name){
		Variables.collectionName = Arguments.name;
		return this;
	}
	public String function getCollectionName(){
		return Variables.collectionName;
	}
	
	/*	*/
	
	
	public any function iterator(){
		return Variables.fields.iterator();
	}
	
	
	
	
	
	
	// -----------------------------------------
	// iterator interfaces
	// -----------------------------------------
	/*
	Variables.index = 0;
	Variables.lockName = CreateUUID();
	
	public void function reset(){
		Variables.index = 0;
	}
	public boolean function hasNext(){
		return ArrayLen(Variables.fields) GT Variables.index ? true : false;	
	}
	public any function next(){
		lock name='#Variables.lockName#' scope="request" timeout="2"
		{
			if(this.hasNext()){
				return Variables.fields[++Variables.index];
			}
		}
		// throw an exception if code reaches this point!
		throw (message="No more elements left");
	}*/
	
	
	
	
}


</cfscript>