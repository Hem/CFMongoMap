<cfscript>

import com.cfmongomap.*;



/**
 * 
 * Copy the database scripts from the following URL 
 * [Javascript (mongo shell)]
 * http://www.mongodb.org/display/DOCS/Database+References
 **/


db = Application.mongo.getDB('test');


collection = db.getCollection('students');

dbCursor =collection.find();


courseMap = new Map('examples.demo.poco.Course')
				.setIdFieldName('id')			// Added for Linked Collections
				.setCollectionName('courses')	// Added for Linked Collections
				.mapProperty('id')
					.toField('_id')
						.asPropertyType('ObjectId')
							.asDataType('String')
				.mapProperty('name');

studentMap = new Map('examples.demo.poco.Student')
				.mapProperty('id')
					.toField('_id')
						.asPropertyType('ObjectID')
							.asDataType('String')
				.mapProperty('name')
				.mapProperty('classes')
						.asPropertyType('Array')
							.asDataType('Linked')
								.usingMap(courseMap)
				;



mapProcessor = new MapProcessor(studentMap)
						.setData(dbCursor)
							.setDirection('DB2CF')
								.setDb(db); /// setDb(db) added for Linked Collections


// get cf items from dbCursor.
items = [];
While(mapProcessor.hasNext()){
	ArrayAppend(items, mapProcessor.next());
}
WriteDump(var=items, showUdfs=false, label='DB2CF');


mapProcessor.setData(items).setDirection('CF2DB');
items = [];
While(mapProcessor.hasNext()){
	ArrayAppend(items, mapProcessor.next());
}

WriteDump(var=items, showUdfs=false, label='CF2DB');



mapProcessor.setData(items).setDirection('DB2CF');
items = [];
While(mapProcessor.hasNext()){
	ArrayAppend(items, mapProcessor.next());
}
WriteDump(var=items, showUdfs=false, label='DB2CF');


</cfscript>