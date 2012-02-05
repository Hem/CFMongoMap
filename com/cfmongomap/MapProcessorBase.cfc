<cfscript>

import com.cfmongomap.*;
	
/**
 * This is an abstract class that you can extent to provide your own data conversion mechanism.
 * In case the default does not work for you.
 **/
component implements=IMapProcessor accessors='false' output=false{
	
	// Allowed directions!
	this.DB2CF = "DB2CF";
	this.CF2DB = "CF2DB";
	
	// in array to validate user input!
	Variables.AllowedDirections = [this.DB2CF,this.CF2DB];
	
	
	// store the map!
	property IMap map;
	
	
	property Any dataIterator;
	
	
	property String direction;
	
	
	// constructor!  
	public MapProcessorBase function init(required IMap map){
		Variables.map = Arguments.map;
		return this;
	}
	
	
	// -------------------------------------------------------------------
	//  IMapProcessor functions!
	// -------------------------------------------------------------------
	
	public IMap function getMap(){
		return variables.map;
	}
	
	
	public IMapProcessor function setDB(required any database){
		if(!IsMongoDb(Arguments.database))
			throw(message = 'Database should be of type com.mongodb.DB');
		
		Variables.database = Arguments.database;
		return this;		
	}
	
	public IMapProcessor function setData(required any data){
		Variables.dataIterator = getIteratorForItem(data);
		Variables.currentObject = JavaCast('null','');
		return this;
	}
	
	// Valid Values :: CF2DB || DB2CF -- this is required to use .Next();
	public IMapProcessor function setDirection(required any direction){
		Variables.direction = Arguments.direction;
		return this;
	}
	
	public String function getDirection(){
		return Variables.direction;
	}
	
	
	public Any function toCfObject(required any item){
		throw(message='Please overwrite toCFObject method');	
	}
	
	public Any function toDbObject(required any item){
		throw(message='Please overwrite toCFObject method');
	}
	
	
	
	// -------------------------------------------------------------------
	//  Iterator functions!
	// -------------------------------------------------------------------
	// ------------------------------------------------------------------------------------
	// Iterator Impl!
	// ------------------------------------------------------------------------------------
	public boolean function hasNext(){
		// returns hasNext();
		return Variables.dataIterator.hasNext();
	}
	
	public any function next(){
		
		// TODO: Add locking!	
		
		if(Variables.dataIterator.hasNext()){
			
			Variables.currentObj = ( Variables.direction == this.DB2CF  ? 
											this.toCfObject(Variables.dataIterator.next()) : 
											this.toDbObject(Variables.dataIterator.next())
															);
			return Variables.currentObj;
		}
		
	}
	public any function curr(){
		return Variables.currentObj;
	}
	
	
	
	
	
	
	
	
	
	// -------------------------------------------------------------------
	//  Helper functions
	// -------------------------------------------------------------------
	boolean function isArrayList(item)
	{
		return isNull(item) ? false : isInstanceOf(item, "java.util.ArrayList");
	}
	
	boolean function isObjectId(item){
		return isNull(item) ? false : IsInstanceOf(item, 'org.bson.types.ObjectId');	
	}
	
	public function getObjectId(any item){
		
		// if object is the instance of objectId
		if(!IsNull(item) && isObjectId(item))
				return item;
		
		// If it is of string... cast on object.
		return IsNull(item) ?	
			createObject("java","org.bson.types.ObjectId").init() :
			createObject("java","org.bson.types.ObjectId").init(item);
	}
	
	
	public function isDbRef(required any item){
		return isNull(item) ? false : IsInstanceOf(item, 'com.mongodb.DBRef');	
	}
	
	public function getDbRef(required string collectionName, required any Id){
		return CreateObject('java','com.mongodb.DBRef').init(Variables.database, collectionName, getObjectId(id));
	}
	
	
	public function getBasicDbObject(){
		return CreateObject("java", "com.mongodb.BasicDBObject").init();
	}
	
	public function getBasicDbList(){
		return createObject("java", "com.mongodb.BasicDBList").init();
	}
	
	public function isMongoDB(required any database){
		return IsInstanceOf(database, 'com.mongodb.DB');
	}
	
	
	
	
	
	// helper function returns an iterator!
	public any function getIteratorForItem(required any data){
	
		if( isInstanceOf(Arguments.data, "com.mongodb.DBCursor") ){
			
			return Arguments.data;
			
		}else if( isArray(Arguments.data) || isInstanceOf(Arguments.data, 'java.util.ArrayList')  ){
			
			return Arguments.data.iterator();
			
		}else{
			
			throw (message="known object type :: "  & Arguments.data.toString() ) ;	
		}
	
	}
	

}

	

</cfscript>