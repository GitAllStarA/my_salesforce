public with sharing class Contacts {
    public Contacts() {

    }

    public void updateContacts() {
    List<Contact> contacts = new List<Contact> {
        new Contact(FirstName='Joe1',LastName='Smith',Department='Finance'),
       new Contact(FirstName='Kathy1',LastName='Smith',Department='Technology'),
       new Contact(FirstName='Vikranth Reddy',LastName='Alti',Department='Technology'),
       new Contact(FirstName='Caroline1',LastName='Roth',Department='Finance'),
       new Contact(FirstName='Kim1',LastName='Shain',Department='Education'),
       new Contact(FirstName='Sales',LastName='Force',Department='CRM'),
       new Contact(FirstName='SalesForce',LastName='Apex',Department='Technology'),
       new Contact(FirstName='SalesForce',LastName='LWC',Department='Technology')
};

System.debug('contacts ->>>>> '+contacts);



//insert contacts;

//upsert contacts Contact.fields.id;

List<Contact> contactUpdate = new List<Contact>();

for(Contact c : contacts) {
   System.debug('updates');
   if(c.Department == 'Finance') {
       c.Title = 'Finance Analyst';
       System.debug(c.Title);
       contactUpdate.add(c);
   }
   if(c.Department == 'Technology') {
       c.Title = 'Software Engineer';
       System.debug(c.Title);
       contactUpdate.add(c);

   }
}

//update contactUpdate;

Contact[] listc = [select id, Title from contact];


Map<String, Contact> mapx = new Map<String, Contact>();

for (Contact con : listc) {
   mapx.put(con.title, con);
}

List<Contact> contactDeDuplicate = new List<Contact>(mapx.values());
System.debug(contactDeDuplicate);

try {
       System.debug('started');
   update contactDeDuplicate;
   System.debug('ended');
} catch(Exception ex){
       System.debug('error occured'+ ex.getMessage());

        }
    }

}