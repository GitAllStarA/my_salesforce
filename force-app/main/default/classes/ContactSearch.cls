public with sharing class ContactSearch {
    public ContactSearch() {

    }

    public static Contact[] searchForContacts(String incomingLastName, String postalCode) {
        Contact[] x = [select ID, Name from Contact where LastName =:incomingLastName and MailingPostalCode =:postalCode];
        return x;
    }
}