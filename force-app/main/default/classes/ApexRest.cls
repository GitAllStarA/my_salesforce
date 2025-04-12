@RestResource(urlMapping='/AccountLimit/*')
global with sharing class ApexRest {
    
    @HttpGet
    global static List<Account> getAccountsLimited() {
        return [select id,name,description from Account order by name limit 10];
    }

}