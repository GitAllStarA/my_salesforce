public with sharing class AcctController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountsList(){
        try {
            return [Select id, name, phone from Account limit 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    } 

    @AuraEnabled
    public static List<Account> accountsList(String keyWord){
        String lExpression = '%'+keyWord+'%';
        try {
            return [select id,name,phone from Account where name like :lExpression limit 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}