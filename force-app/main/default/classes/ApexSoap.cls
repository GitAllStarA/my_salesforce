global with sharing class ApexSoap {
   webService static List<Contact> getContactsLimited() {
        return [select id, name, description from contact order by name limit 10];
   }
}