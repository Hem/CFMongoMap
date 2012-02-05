<cfscript>
	
	
	var people = [];
	
	
	for(i=1; i <= 5; i++){
	
	
		person = new examples.demo.poco.Person();
		person.setFirstName('Person #i#');
		person.setLastName('Smith');
		person.setEmails(['Person.#i#.Smith@gmail.com','Person#i#.Smith@yahoo.com']);
		
		address1 = new examples.demo.poco.Address();
			address1.setAddressType('Home');
			address1.setAddress1('#i# Place One');
			address1.setCity('Nashville');
			address1.setState('TN');
			address1.setZipcode('37215');
			
			
		address2 = new examples.demo.poco.Address();
			address2.setAddressType('Work');
			address2.setAddress1('#i# Place Two');
			address2.setCity('Nashville');
			address2.setState('TN');
			address2.setZipcode('37215');
			
		person.setAddresses([address1, address2]);
		
		
		ArrayAppend(people, person)	
		
	}	
	
	
	// WriteDump(var=people, label='People Collection', showUdfs=false, metainfo=false, expand=false);		

</cfscript>