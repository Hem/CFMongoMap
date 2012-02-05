Welcome to CFMongoMap, this project is currently an ALPHA version.

The intent is to provide a simple mechanism to convert MongoDB objects to ColdFusion Components
and vice versa.

NOTE: Querying for objects and saving objects to Mongo are outside the scope of this project.

Please use CFMongoDB, MongoCFC, or plain old Mongo Java drivers to do so.


SAMPLE CODE :: [MapExample.cfm]
---------------------------------------------------------------
---------------------------------------------------------------
import com.cfmongomap.*;

// create the map.
map = new Map('com.demo.poco.Person')
	.mapProperty('id').toField('_id').asPropertyType('ObjectId').asDataType('String')
	.mapProperty('firstName')
	.mapProperty('lastName');


// get an instance of the cursor from the database.			
dbCursor = peopleCollection.find();

// get an instance of Map Processor Object (1 instance per request & map & data type)
mapProcessor = new com.cfmongomap.MapProcessor(map).setData(dbCursor).setDirection('DB2CF');

// ask map processor to convert data ...	
while(mapProcessor.hasNext()){
	item = mapProcessor.next();
	WriteDump(var = item, Label='Retrieved ' & item.getId(), expand=false );
}
				
			



GETTING STARTED with MongoDemo:
---------------------------------------------------------------
---------------------------------------------------------------

a. Set-up Mongo http://www.mongodb.org/

b. Copy the Mongo database drivers to coldfusions 'Lib' directory (restart services)
	Alternatively specify the path to the jar in the CreateObject call... 
	// Application.mongo = CreateObject("java", "com.mongodb.Mongo", ExpandPath("/MongoDemo/Lib/mongo-2.7.2.jar") );
		

c. Copy files in this directory to your <WebRoot>/MongoDemo


d. Examples
	
:: Maps.cfm tells you how to set-up your map object and embeded map object

:: MockCFData.cfm provides you with a sample data of people and multiple addresses per person
	
:: MapProcessor.cfm provides the calls to convert data from CF -> DB and vice versa

:: ReadAndWriteData.cfm  provides an example on how to well read and write data to Mongo.

:: LinkedMap.cfm map examples for retrieving linked code.







Using CFMongoMap in your application
---------------------------------------------------------------
---------------------------------------------------------------


a. Have Mongo up and running and the Mongo Drivers installed in the lib folder (or provide path in CreateObject call)

a. You only need com.cfmongomap.* files for CFMongoMap to work
	Option 1: Copy com.cfmongomap.* to your WEBROOT/com/cfmonogmap/
	Option 2: Copy com.cfmongomap.* to your WEBROOT/YOUR_PROJECT/com/cfmonogmap/ 
				and provide mappings example...
			this.mappings["/com/cfmongomap"] = ExpandPath('/MongoDemo/com/cfmongomap');



Read more on the Java Driver functionality at

http://www.mongodb.org/display/DOCS/Java+Language+Center

Enjoy!!!
-Hem
	

