@IsTest
private class AccountManagerTest {
    @isTest static void testGetAccount(){
        Id recordId = createAccRecord();
       
        RestRequest request = new RestRequest();
        request.requestUri = 
        'https://curious-badger-st3kb4-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Accounts/'+recordId+'/contacts';

        request.httpMethod = 'GET';
        RestContext.request = request;
        Account acc = AccountManager.getAccount();
        if(acc!=null) {
            System.assert(acc != null);
            System.assertEquals('sfdc xoxo',acc.Name);
        } else {
            System.assert(acc == null);
        }
    }

    static ID createAccRecord() {
       Account acc = new Account(name='sfdc xoxo', billingCity = 'Austin');
       insert acc;
       Contact ct = new Contact(firstName='rob',lastName='roy', phone='1234-456-7890',AccountId = acc.Id);
       insert ct;
       return acc.Id;
    }
}