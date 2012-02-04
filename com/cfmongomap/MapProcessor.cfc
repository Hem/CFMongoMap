<cfscript>
	
	import com.cfmongomap.*
	
component extends=MapProcessorBase output=false {
	
	
	public Any function toCfObject(required any item){
		
		var itemMap = this.getMap();
		
		// we have the may!
		var cfc = CreateObject(itemMap.getClassType(), itemMap.getClassName());
		
		var mapIterator = itemMap.iterator();
		
		
		while(mapIterator.hasNext()){
			
			var mapping = mapIterator.next();
			
			var fieldName = mapping.getFieldName();
			
			// if the database object contains this field! 
			if( item.containsKey(fieldName) && !IsNull(item.get(fieldName)) ){
				
				var value = toPropertyValue( item.get(fieldName),  mapping );	

				var pName = mapping.getPropertyName();

				var mName = 'set' & pName; // NOTE: capatalize pName 
				
				IsNull(cfc[mName]) ? cfc[pName] = value : cfc[mName](value);
			}
			
		}
		
		//	
		return cfc;
	}
	
	// this.PROPERTY_TYPES = ['String','ObjectId','Array','Struct','Object']
	package any function toPropertyValue(required any value, required MapField field){
		
		if(IsNull(value))
			return;
		
		switch(field.getPropertyType())
		{
			
			case 'String':
				return value.toString();
			break;
			
			case 'ObjectId':
			case 'Object':
			case 'Struct':
				return parsePropertyValue(value, field); 
			break;
			
			case 'Array':
				var retVal = [];
				var valIterator = getIteratorForItem(value);
				while(valIterator.hasNext()){
					ArrayAppend(retVal, parsePropertyValue( valIterator.next(), field ));
				}
				return retVal;
			break;
				
			default:
				throw (message='Do not know how to handle property type [#field.getPropertyType()#]')	
			break;
		}
		
	}
	
	
	// this is the value, usually required for second level transformation
	// this.DATA_TYPES 	= ['ObjectId','String','Int','Float','Date','TimeStamp','Any','Mapped','Linked'];
	package Any function parsePropertyValue(required any value, required MapField field){
	
		if(IsNull(value))
			return ;
			
			
		switch(field.getDataType()){
				
			case 'String':
				return value.toString();
			break;
			
			case 'ObjectId':
				return getObjectId(value);
			break;
			
			case 'Int':
			case 'Float':
				return Val(value);
			break;
			
			case 'Mapped':
				return getMapProcessor(field.getDataMap()).toCfObject(value);
			break;
			
			default:
				throw(message='Not yet implemented: #field.getDataType()#');
			break;
		}
	}
	
	
	
	// will convert an object from cfc -> dbobject
	public Any function toDbObject(required any item){
		
		var dbObj = getBasicDbObject();
		
		var mapIterator = getMap().Iterator();
		
		while(mapIterator.hasNext()){
				
			var mapping = mapIterator.next();
			
			var fieldName = mapping.getFieldName();
			
			var pName = mapping.getPropertyName();

			var mName = 'get' & pName; // NOTE: capatalize pName 
			
			// set dbField
			dbObj[fieldName] = !IsNull( item[mName]) ?  toDbValue(item[mName](),mapping) :
									!IsNull( item[mName]) ? toDbValue(item[pName], mapping) :
											JavaCast('null','');		 	
				
		} 
		
		return dbObj;
	}
	
	
	package any function toDbValue(required any value, required MapField field){
		// not sure if I can return a null value!
		// if(IsNull(value)) return JavaCast('null','');
		
		switch(field.getPropertyType())
		{
			case 'String':
				return IsNull(value) ? JavaCast('null','') : JavaCast('string',value);
			break;
			
			case 'ObjectId':
				return IsNull(value) ? getObjectId() : getObjectId(value);
			break;
			
			case 'Array':
				var retVal = getBasicDbList();
				if(!IsNull(value)) 
				{
					var valIterator = getIteratorForItem(value);
					while(valIterator.hasNext()){
						ArrayAppend(retVal, parseFieldValue( valIterator.next(), field ));
					}
				}
				return retVal;
			break;
			
			case 'Struct':
			case 'Object':
					return getMapProcessor(field.getDataMap()).toDbObject(value);
			break;
			
			default:
				throw(message='Do not know how to handle #field.getPropertyType()#');
			break;
		}
	}
	
	
	
	// this is the value, usually required for second level transformation
	// this.DATA_TYPES 	= ['ObjectId','String','Int','Float','Date','TimeStamp','Any','Mapped','Linked'];
	package Any function parseFieldValue(required any value, required MapField field){
	
		switch(field.getDataType()){
				
			case 'String':
				return IsNull(value) ? JavaCast('null','') : JavaCast('string',value);
			break;
			case 'ObjectId':
				return getObjectId(value);
			break;
			case 'Int':
				return IsNull(value) ? JavaCast('null','') : JavaCast('int',value);
			break;
			case 'Float':
				return IsNull(value) ? JavaCast('null','') : JavaCast('float',value);
			break;
			case 'Float':
				return IsNull(value) ? JavaCast('null','') : JavaCast('long',value);
			break;
			
			case 'Mapped':
				return getMapProcessor(field.getDataMap()).toDbObject(value);
			break;
				
			case 'Date':
			case 'DateTime':
			break;
		}
	}
	
	
	Variables._mapProcessors = {};
	
	package function getMapProcessor(IMap map){
		
		var key = map.getCacheKey();
		
		if(!StructKeyExists(Variables._mapProcessors, key))
				Variables._mapProcessors[key] = new MapProcessor(map);
				
		return Variables._mapProcessors[key];
	}
	
}

</cfscript>