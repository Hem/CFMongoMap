<cfscript>
	
	include 'Maps.cfm'; // provides the map
		
	include 'MockCFData.cfm'; // provides an Array of people (ColdFusion Objects)!	
	
	
	// Name of the database to query!
	mongoDb = Application.mongo.getDB("MongoDemo");
	
	// name of the table 
	peopleCollection = mongoDb.getCollection("people");
	
	// CODE TO DROP AND RECREATE THE COLLECTION
	// peopleCollection.drop();
	// peopleCollection = mongoDb.getCollection("people");
	
	
	// NOTE: Map Processor is NOT a thread safe component
	// should be created atleast once per-request & map
	mapProcessor = new com.cfmongomap.MapProcessor(map).setData(people).setDirection('CF2DB');
	while(mapProcessor.hasNext()){
		item = mapProcessor.next();
		
		peopleCollection.save(item);
		
		WriteDump(var = item, Label='SAVED ' & item['_id'].toString(), expand=false );
	}
	
	
	
	
	dbCursor = peopleCollection.find();
	// ok this is the normal call most users will make after invoking the database find()
	mapProcessor = new com.cfmongomap.MapProcessor(map).setData(dbCursor).setDirection('DB2CF');
	
	// since I already have the mapProcessor created for this "REQUEST" and give "MAP" 
	// and will NOT need it to refrence the "CF_ARRAY_OF_OBJECTS" I can re-use it
	// mapProcessor.setData(dbCursor).setDirection('DB2CF');
	
	
	while(mapProcessor.hasNext()){
		item = mapProcessor.next();
		
		WriteDump(var = item, Label='Retreived ' & item.getId(), expand=false );
	}
	
	
	
</cfscript>