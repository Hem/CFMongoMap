<cfscript>
component output="false"{
	
	this.name = "CFMongoDemo";
	
	this.sessionManagement 	= true;
	this.sessionTimeout 	= CreateTimeSpan(0,0,30,0);
	this.applicationTimeout = CreateTimeSpan(0,1,0,0);
	
	
	this.localMode	 = "always";
	this.sessionType = "j2ee";
	
	
	// TODO: Update the path to CFMongoMap on your computer!
	this.mappings["/com/cfmongomap"] 	= ExpandPath('/MongoDemo/com/cfmongomap');
	this.mappings["/examples/demo"] 	= ExpandPath('/MongoDemo/examples/demo');
	
	
	
	
	// ---------------------------------------------------------------------
	// METHODS
	// ---------------------------------------------------------------------
	public void function onApplicationEnd(struct ApplicationScope){
		// close the connection to mongo!
		if(!isNull(ApplicationScope.mongo))
			ApplicationScope.mongo.close();
	}
	
	public boolean function onApplicationStart(){
		
		//New to CF9 you can initialize your Java Object by providing a fully qualified path to the jar...
		// Application.mongo = CreateObject("java", "com.mongodb.Mongo", ExpandPath("/MongoDemo/Lib/mongo-2.7.2.jar") );
		
		/**
		 * Only one instance of Mongo is required to run your entire application.
		 * 
		 **/
		Application.mongo = CreateObject("java", "com.mongodb.Mongo");
		Application.mongo.init("localhost", 27017);
		
		// initialize mongo!
		return true;
	}
	
	
	
	public void function onSessionEnd(required struct SessionScope, struct ApplicationScope){
		
	}
	public void function onSessionStart(){
		
	}
	
	
	public void function onRequestEnd(){
		return;
	}
	public void function onRequestStart(required string TargetPage){
	
		return;	
	}
	
	public void function onRequest(required string TargetPage){
			include targetPage;
		return;
	}
	public void function onCFCRequest(string cfcName, string method, struct args){
		
		return;
	}
	
}
</cfscript>