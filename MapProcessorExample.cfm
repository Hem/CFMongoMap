<cfscript>
	
	include 'MapExample.cfm'; // provides the map
	
	include 'MockCFData.cfm'; // provides an Array of people (ColdFusion Objects)!	
	
	
	
	// set up your map processor with the map defination
	mapProcessor = new com.cfmongomap.MapProcessor(map);
	
	person = people[1]; // user the first person object in array.
	WriteDump(var = person, expand=false, showUdfs=false, label='CF PCOC object NOT parsed :: ' & person.getFirstName());
	
	// con
	dbObject = mapProcessor.toDbObject(person);
	WriteDump(var = dbObject, expand=false, showUdfs=false, label='MONGO OBJECT parsed :: ' & dbObject.get('firstName'));
	
	cfObject = mapProcessor.toCfObject(dbObject);
	WriteDump(var = cfObject, expand=false, showUdfs=false, label='CF OBJECT parsed BACK :: ' & cfObject.getFirstName());
	
	
	
	
	// NOTE: Map Processor is NOT a thread safe component
	// should be created atleast once per-request & map
	mapProcessor = new com.cfmongomap.MapProcessor(map).setData(people).setDirection('CF2DB');
	
	// using the array list instead of an Array (either call works fine.)
	// dbItems = [];
	dbItems = mapProcessor.getBasicDbList();
	
	while(mapProcessor.hasNext()){
		item = mapProcessor.next();
		ArrayAppend(dbItems, item);
	}
	
	WriteDump(var = dbItems, label = 'CF2DB :: PARSED', showUdfs=false, expand=false);
	
	
	
	// one the map is set, you can change update the data and change the direction.
	// Again.. This is NOT thread safe... Please create a new instance of MapProcessor for each request & Map
	mapProcessor.setData(dbItems).setDirection('DB2CF');
	cfItems = [];
	while(mapProcessor.hasNext()){
		item = mapProcessor.next();
		ArrayAppend(cfItems, item);
	}
	
	WriteDump(var = cfItems, label = 'DB2CF', showUdfs=false, expand=false);
	
</cfscript>