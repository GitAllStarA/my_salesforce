public with sharing class ContactAndLeadSearch {
    public ContactAndLeadSearch() {

    }
    public static List<List<sObject>> searchContactsAndLeads(String incomingStr) {
        List<List<sObject>> resultSOSL = [find :incomingStr in all fields returning Contact(FirstName,LastName), Lead(FirstName, LastName)];
        return resultSOSL;
    }


 /*   String srchStr = 'jim OR 737 or the or SFDC';
List<List<sObject>> resultsSOSL = [find :srchStr 	IN ALL FIELDS returning 
                                   		Account(name,description where industry = 'technology'), 
                                   		contact(lastname, firstname, description limit 1),
                                  		Lead(FirstName, LastName)];

Account[] acc = (Account[])resultsSOSL[0];
Contact[] cnt = (Contact[])resultsSOSL[1];
Lead[] l = (Lead[])resultsSOSL[2];


System.debug('found the following accounts.');
for(Account x : acc) {
    System.debug(x.Name+' - '+x.description);
}

System.debug('found the following contacts.');
for(contact x : cnt) {
    System.debug(x.firstname+' - '+x.lastname+' - '+x.description);
}

System.debug('found the following contacts.');
for(Lead x : l) {
    System.debug(x.firstname+' - '+x.lastname+' - '+x.description);
}*/

}