public with sharing class QueryContact {
    public QueryContact() {

    }
    
    public static Id getContactID(String lastName, String title) {
        try {
          Contact myContact = Database.query(
            'SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1'
          );
          return myContact.Id;
        } catch (Exception ex) {
          return null;
        }
      }

    public static Id getContactIDWithBinds(Map<String, Object> bindVars) {
        String queryBind = 'select Id, Name from Contact where FirstName = :firstName and LastName = :lastName limit 1';
         
        return Database.queryWithBinds(queryBind, bindVars,AccessLevel.USER_MODE).Id;
    }
    
    public static void x(){
    
    String firstName = 'jim';
    String lastName = 'halpert';
    Map<String, Object> nameBindx = new Map<String, Object> {'firstName' => firstName, 'lastName'=> lastName};
    Id ct = getContactIDWithBinds(nameBindx);
    system.debug(ct);
    }

}