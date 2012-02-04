<cfscript>
	
	import com.cfmongomap.*
	
	map = new Map('com.demo.poco.Person')
				.mapProperty("id")
					.toField('_id')
						.asPropertyType('ObjectId')
							// NOTE: Set this as 'ObjectID' if you wish to work with the DBObjectId object instead of "String"
							.asDataType('String')
				
				.mapProperty('firstName')
				.mapProperty('lastName')
				
				// A user can have multiple email id's
				.mapProperty('emails')
					.asPropertyType('Array')
						.asDataType('String')
				
				// A user can have multiple addresses!
				.mapProperty('addresses')
					.asPropertyType('Array')
					
					// NOTE: DataType 'Mapped' when you are working with NON-SIMPLE Object Types.. Struct, CFC, Java Objects
					.asDataType('Mapped')
					
					.usingMap( // NOTE: Embeding a map for array of addresses
						new Map('com.demo.poco.Address')
								.mapProperty('addressType')
								.mapProperty('address1')
								.mapProperty('address2')
								.mapProperty('city')
								.mapProperty('state')
								.mapProperty('zipcode')
									);

	
	//	WriteDump(var=map.getFields(), label='Map Definations' ,showUdfs=false, expand=false);
		
</cfscript>