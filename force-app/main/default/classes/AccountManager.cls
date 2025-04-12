@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
    
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        String accountId = 
                        request.requestURI.substring(
                            request.requestURI.indexOf('nts/')+4,
                            request.requestURI.lastIndexOf('/contacts')
                            );
        Account acc = [select id, name , (select Id, name from contacts) from account where Id = : accountId];
        return acc;
    }

}