<cfscript>

import com.cfmongomap.*;

/**
 * 	map = new Map('com.demo.poco.Person')
 *					.mapProperty("id")
 *						.toField('_id')
 *							.asPropertyType('ObjectId')
 *								// NOTE: Set this as 'ObjectID' if you wish to work with the DBObjectId object instead of "String"
 *								.asDataType('String')
 *					
 *					.mapProperty('firstName')
 *					.mapProperty('lastName')
 *					
 *					// A user can have multiple email id's
 *					.mapProperty('emails')
 *						.asPropertyType('Array')
 *							.asDataType('String')
 *					
 *					// A user can have multiple addresses!
 *					.mapProperty('addresses')
 *						.asPropertyType('Array')
 *						
 *						// NOTE: DataType 'Mapped' when you are working with NON-SIMPLE Object Types.. Struct, CFC, Java Objects
 *						.asDataType('Mapped')
 *						
 *						.usingMap( // NOTE: Embeding a map for array of addresses
 *							new Map('com.demo.poco.Address')
 *									.mapProperty('addressType')
 *									.mapProperty('address1')
 *									.mapProperty('address2')
 *									.mapProperty('city')
 *									.mapProperty('state')
 *									.mapProperty('zipcode')
 *										);
 **/


component extends=MapBase{
	
	
	// property is the container
	this.PROPERTY_TYPES = ['String','ObjectId','Array','Struct','Object']
	
	// this is the value, usually required for second level transformation
	this.DATA_TYPES 	= ['ObjectId','String','Int','Float','Date','TimeStamp','Any','Mapped','Linked'];
	
	
	
	Variables.__field = "";
 	
	//
	public Map function mapProperty(required string name){
		
		// set new view	
		Variables.__field = new MapField();
		Variables.__field.setPropertyName(name); 
		Variables.__field.setFieldName(name);
		
		//
		this.add(Variables.__field);
		
		return this;	
	}
	
	//
	public Map function toField(required string name){
			Variables.__field.setFieldName(name);
		return this;
	}
	
	
	public Map function asPropertyType(required string value){
		
		if(ArrayFindNoCase(this.PROPERTY_TYPES, value ) eq 0)
			throw(message='Invalid Property Type', detail='#value# is not a valid property type [#ArrayToList(this.PROPERTY_TYPES)#]' );	
		
			Variables.__field.setPropertyType(value);
		return this;
	}
	
	
	public Map function asDataType(required string value){
			Variables.__field.setDataType(value);
		return this;
	}
	
	
	// 
	public Map function usingMap(required IMap map){
		
			// ToDo: Validate DataType!
			Variables.__field.setDataMap(Arguments.map);
		
		return this;
	}
	
		
}

</cfscript>