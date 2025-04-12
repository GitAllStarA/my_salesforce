public with sharing class AccountHandler {
    public AccountHandler() {

    }

    public static Account insertNewAccount(String incomingStr) {
        Account a = new Account(Name = incomingStr);
        try { 
            System.debug(a);
            insert a;
            return a;
        } catch (DmlException ex) {
            System.debug('A DML Exception occured '+ex.getMessage());
            return null;
        }
        
    }

}